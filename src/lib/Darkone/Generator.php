<?php

namespace Darkone;

class Generator
{
    private string $tomlConfigFile;

    public function __construct(string $tomlConfigFile)
    {
        $this->tomlConfigFile = $tomlConfigFile;
    }

    public function generate(string $nixConfigFile): self
    {
        echo $this->tomlConfigFile;
        return $this;
    }
}