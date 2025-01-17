<?php

namespace Darkone\NixGenerator\Item;

use Darkone\NixGenerator\NixException;

trait ItemTrait
{
    /**
     * @throws NixException
     */
    public function filterProfile(string $profile, string $context): string
    {
        static $validProfiles = [];

        $found = false;
        foreach (self::PROFILE_PATHS as $path) {
            $profilePath = sprintf($path, $profile);
            if (in_array($profilePath, $validProfiles[$context] ?? [])) {
                $found = true;
                break;
            }
            if (file_exists(NIX_PROJECT_ROOT . '/' . $profilePath)) {
                $validProfiles[$context][] = $profilePath;
                $found = true;
                break;
            }
        }
        $found || throw new NixException(
            'No ' . $context . ' profile path found for profile "' . $profile . '" in usr and lib declarations.'
        );
        isset($profilePath) || throw new NixException('Profile path is not set');

        return $profilePath;
    }
}
