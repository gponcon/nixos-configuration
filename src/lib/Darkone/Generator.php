<?php

namespace Darkone;

use Darkone\NixGenerator\Configuration;
use Darkone\NixGenerator\Item\Host;
use Darkone\NixGenerator\Item\User;
use Darkone\NixGenerator\NixException;
use Darkone\NixGenerator\Token\NixAttrSet;
use Darkone\NixGenerator\Token\NixList;

class Generator
{
    private Configuration $config;

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
            if (in_array('local', $host->getGroups())) {
                $newHost->setBool('allowLocalDeployment', true);
            }
            $hosts->add($newHost);
        }

        return $hosts;
    }
}
