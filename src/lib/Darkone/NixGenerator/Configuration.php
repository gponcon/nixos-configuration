<?php

namespace Darkone\NixGenerator;

class Configuration
{
    public function __construct()
    {
    }

    public function loadToml(string $configFile): self
    {
        return $this;
    }
}