<?php

namespace Darkone\NixGenerator\Token;

interface NixItemInterface
{
    /**
     * Nix lang generation
     */
    public function __toString(): string;
}