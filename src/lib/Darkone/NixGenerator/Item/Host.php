<?php

namespace Darkone\NixGenerator\Item;

class Host
{
    private string $hostname;
    private string $name;

    /**
     * @var array of string (logins)
     */
    private array $users = [];

    /**
     * Host groups
     */
    private array $groups = [];

    public function getHostname(): string
    {
        return $this->hostname;
    }

    public function setHostname(string $hostname): Host
    {
        $this->hostname = $hostname;
        return $this;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function setName(string $name): Host
    {
        $this->name = $name;
        return $this;
    }

    public function getUsers(): array
    {
        return $this->users;
    }

    public function setUsers(array $users): Host
    {
        $this->users = $users;
        return $this;
    }

    public function getGroups(): array
    {
        return $this->groups;
    }

    public function setGroups(array $groups): Host
    {
        $this->groups = $groups;
        return $this;
    }
}