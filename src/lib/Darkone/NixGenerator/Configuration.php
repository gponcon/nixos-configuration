<?php

namespace Darkone\NixGenerator;

use Darkone\NixGenerator\Item\Host;
use Darkone\NixGenerator\Token\NixAttrSet;
use Darkone\NixGenerator\NixException;
use Symfony\Component\Yaml\Yaml;

class Configuration extends NixAttrSet
{
    const TYPE_STRING = 'string';
    const TYPE_BOOL = 'bool';
    const TYPE_ARRAY = 'array';
    const TYPE_INT = 'int';

    const REGEX_HOSTNAME = '/^[a-zA-Z][a-zA-Z0-9_-]{2,59}$/';

    private string $formatter = 'nixfmt';
    private array|null $lldapConfig = null;

    /**
     * @var Host[]
     */
    private array $hosts = [];

    /**
     * Load nix configuration
     * @throws NixException
     */
    public function loadYamlFile(string $configFile): Configuration
    {
        $config = Yaml::parseFile($configFile);
        $this->loadFormatter($config);
        $this->loadLldapProvider($config);
        $this->loadHosts($config);
        return $this;
    }

    /**
     * @throws NixException
     */
    public function loadFormatter(array $config): void
    {
        if (isset($config['formatter'])) {
            $this->assert(self::TYPE_STRING, $config['formatter'], 'Bad formatter type');
            $this->formatter = $config['formatter'];
        }
    }

    public function getFormatter(): string
    {
        return $this->formatter;
    }

    /**
     * @throws NixException
     */
    public function loadLldapProvider(array $config): void
    {
        if (isset($config['hostProvider']['lldap'])) {
            $lldapConfig = $config['hostProvider']['lldap'];
            $this->assert(self::TYPE_ARRAY, $lldapConfig, "Bad LLDAP configuration root type");
            $this->assert(self::TYPE_STRING, $lldapConfig['url'] ?? null, "A valid lldap url is required", '#^ldap://.+$#');
            $this->assert(self::TYPE_STRING, $lldapConfig['bind']['user'] ?? null, "A valid lldap bind user is required", '#^[a-zA-Z][a-zA-Z0-9_-]+$#');
            $this->assert(self::TYPE_STRING, $lldapConfig['bind']['passwordFile'] ?? null, "A valid lldap password file is required");
            $pwdFile = (NIX_PROJECT_ROOT ? NIX_PROJECT_ROOT . '/' : '') . $lldapConfig['bind']['passwordFile'];
            if (!file_exists($pwdFile)) {
                throw new NixException('Lldap password file "' . $pwdFile . '" not found.');
            }
            $this->formatter = $config['formatter'];
        }
    }

    /**
     * @throws NixException
     */
    public function getLldapConfig(): array
    {
        $this->assert(self::TYPE_ARRAY, $this->lldapConfig, "No lldap configuration loaded");
        return $this->lldapConfig;
    }

    /**
     * @throws NixException
     */
    private function loadHosts(array $config): void
    {
        if (!isset($config['hosts'])) {
            return;
        }
        $this->assert(self::TYPE_ARRAY, $config['hosts'], "Bad hosts root value");
        $this->loadStaticHosts($config['hosts']['static'] ?? []);
        $this->loadRangeHosts($config['hosts']['range'] ?? []);
        $this->loadListHosts($config['hosts']['list'] ?? []);
    }

    /**
     * @throws NixException
     */
    private function loadStaticHosts(array $staticHosts): void
    {
        array_map(function (array $host) {
            $this->assertHostCommonParams($host);
            $this->assertHostName($host['hostname']);
            $host = new Host();
            }, $staticHosts);
    }

    private function loadRangeHosts(array $staticHosts): void
    {
    }

    private function loadListHosts(array $staticHosts): void
    {
    }

    /**
     * @throws NixException
     */
    public function assertHostName(string $hostName): void
    {
        if (array_key_exists($hostName, $this->hosts)) {
            throw new NixException('Host name collision "' . $hostName . '" (value already exists)');
        }
        if (!preg_match(self::REGEX_HOSTNAME, $hostName)) {
            throw new NixException('Invalid host name "' . $hostName . '" (must match ' . self::REGEX_HOSTNAME . ')');
        }
    }

    /**
     * @throws NixException
     */
    public function assertHostCommonParams(array $host): void
    {
        $this->assert(self::TYPE_STRING, $host['hostname'] ?? null, "A hostname is required");
        $this->assert(self::TYPE_STRING, $host['name'] ?? null, "A name (description) is required");
        $this->assert(self::TYPE_ARRAY, $host['users'] ?? null, "A list of users is required");
        $this->assert(self::TYPE_ARRAY, $host['colmena'] ?? null, "A colmena configuration is required");
        $this->assert(self::TYPE_ARRAY, $host['colmena']['deployment']['tags'] ?? null, "A colmena deployment tags is required");
    }

    /**
     * @throws NixException
     */
    public function assert(string $type, mixed $value, string $errMessage, ?string $regex = null): void
    {
        if ($type !== gettype($value)) {
            throw new NixException($errMessage);
        }
        if (!is_null($regex)) {
            if (!is_string($value)) {
                throw new NixException('Cannot check regex with non-string value');
            }
            if (!preg_match($regex, $value)) {
                throw new NixException('Syntax Error: ' . $errMessage);
            }
        }
    }
}
