<?php

namespace Darkone\NixGenerator\Item;

class Host
{
    private string $hostname;

    /**
     * @var User[]
     */
    private array $users = [];

    /**
     * Colmena host configuration
     */
    private array $colmena = [];
}