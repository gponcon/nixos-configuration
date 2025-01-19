<?php

namespace Darkone;

use Darkone\NixGenerator\Configuration;
use Darkone\NixGenerator\Item\Host;
use Darkone\NixGenerator\NixException;
use Darkone\NixGenerator\Token\NixAttrSet;
use Darkone\NixGenerator\Token\NixList;

class Generator
{
    private Configuration $config;

    private ?string $localHost = null;

    /**
     * @throws NixException
     */
    public function __construct(string $tomlConfigFile)
    {
        if (!defined('NIX_PROJECT_ROOT')) {
            throw new NixException('NIX_PROJECT_ROOT must be defined');
        }
        $this->config = (new Configuration())->loadYamlFile($tomlConfigFile);
    }

    /**
     * @throws NixException
     */
    public function generate(string $what): string
    {
        $what = ucfirst(strtolower($what));
        if (!preg_match('/^[A-Z][a-z]+$/', $what)) {
            throw new NixException('A valid generator item is required');
        }
        $method = 'generate' . $what;
        if (!method_exists($this, $method)) {
            throw new NixException('Unknown generator item "' . strtolower($what) . '"');
        }

        return $this->$method();
    }

    /**
     * Generate the hosts.nix file loaded by flake.nix
     * @throws NixException
     */
    private function generateHosts(): string
    {
        $hosts = new NixList();
        foreach ($this->config->getHosts() as $host) {
            $users = (new NixList())->populate(array_map(function (string $login) {
                $user = $this->config->getUser($login);
                return (new NixAttrSet())
                    ->setString('login', $user->getLogin())
                    ->setString('email', $user->getEmail())
                    ->setString('name', $user->getName())
                    ->setString('profile', $user->getProfile());
                }, $host->getUsers()));
            $newHost = (new NixAttrSet())
                ->setString('hostname', $host->getHostname())
                ->setString('name', $host->getName())
                ->setString('profile', $host->getProfile())
                ->set('users', $users);
            $hosts->add($newHost);
        }

        return $hosts;
    }

    /**
     * @throws NixException
     */
    private function generateColmena(): string
    {
        $hosts = new NixAttrSet();
        foreach ($this->config->getHosts() as $host) {
            $deployment = (new NixAttrSet())
                ->set('tags', (new NixList())->populateStrings($this->extractTags($host)));
            $this->setLocal($host, $deployment);
            $colmena = (new NixAttrSet())->set('deployment', $deployment);
            $hosts->set($host->getHostname(), $colmena);
        }

        return $hosts;
    }

    /**
     * @param Host $host
     * @param NixAttrSet $newHost
     * @return void
     * @throws NixException
     */
    public function setLocal(Host $host, NixAttrSet $newHost): void
    {
        if ($host->isLocal()) {
            if ($this->localHost !== null) {
                $msg = 'Only one host can be local. ';
                $msg .= 'Conflit between "' . $this->localHost . '" and "' . $host->getHostname() . '".';
                throw new NixException($msg);
            }
            $newHost->setBool('allowLocalDeployment', true);
            $this->localHost = $host->getHostname();
        }
    }

    private function extractTags(Host $host): array
    {
        return array_merge(
            $host->getTags(),
            array_map(fn (string $group): string => 'group-' . $group, $host->getGroups()),
            array_map(fn (string $group): string => 'user-' . $group, $host->getUsers())
        );
    }
}
