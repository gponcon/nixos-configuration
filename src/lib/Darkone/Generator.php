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
        $this->config = (new Configuration())->loadYamlFile($tomlConfigFile);
    }

    /**
     * Generate the hosts.nix file loaded by flake.nix
     * @throws NixException
     */
    public function generate(): string
    {
        $hosts = new NixList();
        foreach ($this->config->getHosts() as $host) {
            $users = (new NixList())->populate(array_map(function (string $login) {
                $user = $this->config->getUser($login);
                return (new NixAttrSet())
                    ->setString('login', $user->getLogin())
                    ->setString('email', $user->getEmail())
                    ->setString('profile', $user->getProfile());
                }, $host->getUsers()));
            $deployment = (new NixAttrSet())
                ->set('tags', (new NixList())->populateStrings($host->getGroups()));
            $newHost = (new NixAttrSet())
                ->setString('hostname', $host->getHostname())
                ->setString('name', $host->getName())
                ->set('users', $users)
                ->set('deployment', $deployment);
            $this->setLocal($host, $newHost);
            $hosts->add($newHost);
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
        if (in_array('local', $host->getGroups())) {
            if ($this->localHost !== null) {
                $msg = 'Only one host can be local. ';
                $msg .= 'Conflit between "' . $this->localHost . '" and "' . $host->getHostname() . '".';
                throw new NixException($msg);
            }
            $newHost->setBool('allowLocalDeployment', true);
            $this->localHost = $host->getHostname();
        }
    }
}
