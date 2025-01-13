<?php

namespace Darkone;

use Darkone\NixGenerator\Configuration;
use Darkone\NixGenerator\NixException;

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
     */
    public function generate(): self
    {
        return $this;
    }
}
