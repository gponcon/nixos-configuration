<?php

namespace Darkone\NixGenerator\Item;

use Darkone\NixGenerator\NixException;

class User
{
    use ItemTrait;

    private const PROFILE_PATHS = [
        'usr/homes/%s',
        'lib/homes/%s',
    ];

    private string $login;
    private string $name;
    private string $email;
    private string $profile;
    private array $groups = [];

    public function setLogin(string $login): User
    {
        $this->login = $login;
        return $this;
    }

    public function setName(string $name): User
    {
        $this->name = $name;
        return $this;
    }

    public function setEmail(string $email): User
    {
        $this->email = $email;
        return $this;
    }

    /**
     * @throws NixException
     */
    public function setProfile(string $profile): User
    {
        $this->profile = $this->filterProfile($profile, 'user');
        return $this;
    }

    public function setGroups(array $groups): User
    {
        $this->groups = $groups;
        return $this;
    }

    public function getLogin(): string
    {
        return $this->login;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function getEmail(): string
    {
        return $this->email;
    }

    public function getProfile(): string
    {
        return $this->profile;
    }

    public function getGroups(): array
    {
        return $this->groups;
    }

    public function hasGroup(string $groupName): bool
    {
        return in_array($groupName, $this->groups);
    }
}
