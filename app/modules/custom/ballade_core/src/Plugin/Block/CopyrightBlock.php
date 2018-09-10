<?php

namespace Drupal\ballade_core\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Form\FormInterface;


/**
 * Provides a 'copyrightBlock' block.
 *
 * @Block(
 *   id = "copyright_block",
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
          '#attributes' => [
            'class' => [
              'col-sm-12'
            ]
          ],
          '#data' => [
            'start_date' => '2018',
            'current_year' => date("Y"),
          ],
        ];
        $build['#cache']['max-age'] = 0;
        return $build;
     }
  }