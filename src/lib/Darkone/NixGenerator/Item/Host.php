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

    public function getHostname(): string
    {
        return $this->hostname;
    }

    public function setHostname(string $hostname): Host
    {
        $this->hostname = $hostname;
        return $this;
    }

    public function getUsers(): array
    {
        return $this->users;
    }

    public function addUser(User $user): Host
    {
        $this->users[] = $user;
        return $this;
    }

    public function getColmena(): array
    {
        return $this->colmena;
    }

    public function setColmena(array $colmena): Host
    {
        $this->colmena = $colmena;
        return $this;
    }
}