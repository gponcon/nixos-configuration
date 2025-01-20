<?php

namespace Darkone\NixGenerator;

use Darkone\NixGenerator\Token\NixAttrSet;
use Darkone\NixGenerator\Token\NixItemInterface;
use Darkone\NixGenerator\Token\NixList;
use Darkone\NixGenerator\Token\NixValue;

class NixBuilder
{
    /**
     * Convert a PHP array (from yaml for example) to Nix structure
     * - string attributes = NixAttrSet
     * - int attributes = NixList
     * - both = error
     * - empty array = empty NixAttrSet
     * - non-array value = NixValue
     * @throws NixException
     */
    public static function arrayToNix(mixed $content): NixItemInterface
    {
        if (is_array($content)) {
            if (count($content) == 0) {
                return new NixAttrSet();
            }
            $firstKey = array_key_first($content);
            if (is_int($firstKey)) {
                $nixList = new NixList();
                foreach ($content as $key => $value) {
                    is_int($key) || throw new NixException("ArrayToNix: non-int key in a list is not permitted");
                    $nixList->add(self::arrayToNix($value));
                }
                return $nixList;
            }
            if (is_string($firstKey)) {
                $nixAttrSet = new NixAttrSet();
                foreach ($content as $key => $value) {
                    is_string($key) || throw new NixException("ArrayToNix: non-string key in an attrset is not permitted");
                    $nixAttrSet->set($key, self::arrayToNix($value));
                }
                return $nixAttrSet;
            }
            throw new NixException("Unknown array content type");
        }
        return new NixValue($content);
    }
}
