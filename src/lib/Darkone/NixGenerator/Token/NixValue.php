<?php

namespace Darkone\NixGenerator\Token;

/**
 * Nix elementary value
 */
class NixValue implements NixItemInterface
{
    public function __construct(private int|float|string $value)
    {
    }

    public function forceInt(): self
    {
        $this->value = (int) $this->value;
        return $this;
    }

    public function forceFloat(): self
    {
        $this->value = (float) $this->value;
        return $this;
    }

    public function forceString(): self
    {
        $this->value = (float) $this->value;
        return $this;
    }

    public function forceBool(): self
    {
        $this->value = (bool) $this->value;
        return $this;
    }

    public function __toString(): string
    {
        return match (true) {
            is_string($this->value) => '"' . str_replace('"', '\"', $this->value) . '"',
            is_bool($this->value) => $this->value ? 'true' : 'false',
            default => $this->value,
        };
    }
}
