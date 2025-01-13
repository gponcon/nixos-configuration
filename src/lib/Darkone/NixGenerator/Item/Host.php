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

    public function getUsers(): array
    {
        return $this->users;
    }

    public function addUser(User $user): Host
    {
        $this->users[] = $user;
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