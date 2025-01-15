<?php

namespace Darkone\NixGenerator\Item;

use Darkone\NixGenerator\NixException;

class Host
{
    use ItemTrait;

    private const PROFILE_PATHS = [
        'usr/hosts/%s.nix',
        'lib/hosts/%s.nix',
    ];

    private string $hostname;
    private string $name;
    private string $profile;
    private bool $local = false;

    /**
     * @var array of string (logins)
     */
    private array $users = [];

    /**
     * Host groups (for link with users)
     */
    private array $groups = [];

    /**
     * Host tags (for colmena deployments)
     */
    private array $tags = [];

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

    /**
     * @throws NixException
     */
    public function setProfile(string $profile): Host
    {
        $this->assertProfileExists($profile, 'host');
        $this->profile = $profile;
        return $this;
    }

    public function getProfile(): string
    {
        return $this->profile;
    }

    public function setTags(array $tags): Host
    {
        // TODO: array_map(fn (string $tag): if ($tag), $tags);
        $this->tags = $tags;
        return $this;
    }

    public function getTags(): array
    {
        return $this->tags;
    }

    public function setLocal(bool $local): Host
    {
        $this->local = $local;
        return $this;
    }

    public function isLocal(): bool
    {
        return $this->local;
    }
}