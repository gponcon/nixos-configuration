<?php

namespace Darkone\NixGenerator\Item;

interface NixItemInterface
{
    /**
     * Nix lang generation
     */
    public function __toString(): string;
}