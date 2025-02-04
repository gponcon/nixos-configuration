<?php

namespace Darkone;

use Darkone\NixGenerator\Configuration;
use Darkone\NixGenerator\Item\Host;
use Darkone\NixGenerator\NixBuilder;
use Darkone\NixGenerator\NixException;
use Darkone\NixGenerator\Token\NixAttrSet;
use Darkone\NixGenerator\Token\NixList;
use UnhandledMatchError;

class Generate
{
    private Configuration $config;

    /**
     * @throws NixException
     */
    public function __construct(string $yamlConfigFile)
    {
        if (!defined('NIX_PROJECT_ROOT')) {
            throw new NixException('NIX_PROJECT_ROOT must be defined');
        }
        $this->config = (new Configuration())->loadYamlFile($yamlConfigFile);
    }

    /**
     * @throws NixException
     */
    public function generate(string $what): string
    {
        try {
            return match ($what) {
                'hosts' => $this->generateHosts(),
                'users' => $this->generateUsers(),
                'networks' => $this->generateNetworksConfig()
            };
        } catch (UnhandledMatchError) {
            throw new NixException('Unknown item "' . $what . '", unable to generate');
        }
    }

    /**
     * Generate the hosts.nix file loaded by flake.nix
     * @throws NixException
     */
    private function generateHosts(): string
    {
        $hosts = new NixList();
        foreach ($this->config->getHosts() as $host) {
            $deployment = (new NixAttrSet())
                ->set('tags', (new NixList())->populateStrings($this->extractTags($host)));
            $colmena = (new NixAttrSet())->set('deployment', $deployment);
            $newHost = (new NixAttrSet())
                ->setString('hostname', $host->getHostname())
                ->setString('name', $host->getName())
                ->setString('profile', $host->getProfile())
                ->set('groups', (new NixList())->populateStrings($host->getGroups()))
                ->set('networks', (new NixList())->populateStrings($host->getNetworks()))
                ->set('users', (new NixList())->populateStrings($host->getUsers()))
                ->set('colmena', $colmena);
            $hosts->add($newHost);
        }

        return $hosts;
    }

    /**
     * Generate the hosts.nix file loaded by flake.nix
     * @throws NixException
     */
    private function generateUsers(): string
    {
        $users = new NixAttrSet();
        foreach ($this->config->getUsers() as $user) {
            $users->set($user->getLogin(), (new NixAttrSet())
                ->setInt('uid', $user->getUid())
                ->setString('email', $user->getEmail())
                ->setString('name', $user->getName())
                ->setString('profile', $user->getProfile())
                ->set('groups', (new NixList())->populateStrings($user->getGroups())));
        }

        return $users;
    }

    private function extractTags(Host $host): array
    {
        return array_merge(
            $host->getTags(),
            array_map(fn (string $group): string => 'group-' . $group, $host->getGroups()),
            array_map(fn (string $group): string => 'user-' . $group, $host->getUsers()),
            array_map(fn (string $group): string => 'network-' . $group, $host->getNetworks())
        );
    }

    /**
     * Generate the hosts.nix file loaded by flake.nix
     * @throws NixException
     */
    private function generateNetworksConfig(): string
    {
        return (string) NixBuilder::arrayToNix($this->config->getNetworksConfig());
    }
}
