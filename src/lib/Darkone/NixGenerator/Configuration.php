<?php

namespace Darkone\NixGenerator;

use Darkone\NixGenerator\Item\Host;
use Darkone\NixGenerator\Token\NixAttrSet;
use Darkone\NixGenerator\Token\NixList;
use Darkone\NixGenerator\NixException;
use Symfony\Component\Yaml\Yaml;

class Configuration extends NixAttrSet
{
    const TYPE_STRING = 'string';
    const TYPE_BOOL = 'bool';
    const TYPE_ARRAY = 'array';
    const TYPE_INT = 'int';

    private string $formatter = 'nixfmt';
    private array|null $lldapConfig = null;

    /**
     * @var Host[]
     */
    private array $hosts;

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
        $this->hosts = [];

        // TODO
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
