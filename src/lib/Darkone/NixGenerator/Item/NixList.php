<?php

namespace Darkone\NixGenerator\Item;

use Iterator;

/**
 * Nix List
 */
class NixList implements NixItemInterface, Iterator
{
    /**
     * @var $list array
     */
    private array $list = [];
    private int $index = 0;

    public function __construct()
    {
    }

    public function add(NixItemInterface $value): NixList
    {
        $this->list[] = $value;
        return $this;
    }

    public function addInt(int|string|float $value): NixList
    {
        return $this->add((new NixValue($value))->forceInt());
    }

    public function addFloat(int|string|float $value): NixList
    {
        return $this->add((new NixValue($value))->forceFloat());
    }

    public function addString(int|string|float $value): NixList
    {
        return $this->add((new NixValue($value))->forceString());
    }

    public function __toString(): string
    {
        return '[' . implode(' ', $this->list) . ']';
    }

    /**
     * Return the current element
     * @link https://php.net/manual/en/iterator.current.php
     * @return NixItemInterface Can return any type.
     * @throws NixException
     */
    public function current(): NixItemInterface
    {
        if (!isset($this->list[$this->index])) {
            throw new NixException("No item found");
        }

        return $this->list[$this->index];
    }

    /**
     * Move forward to next element
     * @link https://php.net/manual/en/iterator.next.php
     * @return void Any returned value is ignored.
     */
    public function next(): void
    {
        $this->index += isset($this->list[$this->index + 1]) ? 1 : 0;
    }

    /**
     * Return the key of the current element
     * @link https://php.net/manual/en/iterator.key.php
     * @return int TKey on success, or null on failure.
     */
    public function key(): int
    {
        return $this->index;
    }

    /**
     * Checks if current position is valid
     * @link https://php.net/manual/en/iterator.valid.php
     * @return bool The return value will be casted to boolean and then evaluated.
     * Returns true on success or false on failure.
     */
    public function valid(): bool
    {
        return isset($this->list[$this->index]);
    }

    /**
     * Rewind the Iterator to the first element
     * @link https://php.net/manual/en/iterator.rewind.php
     * @return void Any returned value is ignored.
     */
    public function rewind(): void
    {
        $this->index = 0;
    }
}
