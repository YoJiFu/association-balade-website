<?php

namespace Drupal\ballade_core\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Form\FormInterface;


/**
 * Provides a 'copyrightBlock' block.
 *
 * @Block(
 *   id = "volunteer_form_block",
 *   admin_label = @Translation("Copyright block"),
 *   category = @Translation("Blocks")
 * )
 */
class CopyrightBlock extends BlockBase {
    
    /**
     * {@inheritdoc}
     */
    public function build() {
        $build['welcome'] = ['#type' => 'container'];
        $build['welcome']['data'] = [
          '#theme' => 'block__copyright_block',
          '#data' => [
            'start_date' => '2018',
            'current_year' => date("Y"),
          ],
        ];
        $build['#cache']['max-age'] = 0;
        return $build;
     }
  }