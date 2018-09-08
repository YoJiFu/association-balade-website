<?php

namespace Drupal\ballade_core\Services;

class LimitContentTypeService {

    /**
     * Content type name.
     *
     * @var string
     */
    private $content_type_name;

    /**
     * Set content type limit.
     *
     * @var int
     */
    private $limit = 0;

    /**
     * Service result.
     *
     * @var boolean
     */
    private $result = FALSE;

    /**
     * Init service function.
     *
     * @param string $content_type_name
     * @param integer $limit
     * @return void
     */
    public function init(string $content_type_name, int $limit = 0) {
        $this->setContentTypeName($content_type_name);
        $this->setLimit($limit);
        $this->setResult();
    }
    
    /**
     * Set content type name.
     *
     * @param string $content_type_name
     * @return void
     */
    private function setContentTypeName(string $content_type_name) {
        return $this->content_type_name = $content_type_name;
    }

    /**
     * Set content type limit.
     *
     * @param integer $limit
     * @return void
     */
    private function setLimit(int $limit) {
        return $this->limit = $limit;
    }

    /**
     * Calculate content_type instance number.
     *
     * @return void
     */
    private function getContentTypeInstance() {
        $query = \Drupal::entityQuery('node');
        $query->condition('type', $this->content_type_name);
        $query->count();
        $result = $query->execute();
        return $result;
    }

    /**
     * Set service result.
     *
     * @return void
     */
    private function setResult() {
        if ($this->getContentTypeInstance() >= $this->limit) {
            $result = FALSE;
        }
        else {
            $result = TRUE;
        }

        return $this->result = $result;
    }

    /**
     * Main service output.
     *
     * @return void
     */
    public function result() {
        return $this->result;
    }
}