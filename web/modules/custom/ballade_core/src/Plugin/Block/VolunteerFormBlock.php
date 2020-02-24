<?php

namespace Drupal\ballade_core\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Form\FormInterface;


/**
 * Provides a 'volunteerFormBlock' block.
 *
 * @Block(
 *   id = "volunteer_form_block",
 *   admin_label = @Translation("Volunteer form block"),
 *   category = @Translation("Forms")
 * )
 */
class VolunteerFormBlock extends BlockBase {
    
    /**
     * {@inheritdoc}
     */
    public function build() {
      $form = \Drupal::formBuilder()->getForm('\Drupal\ballade_core\Form\VolunteerForm');
      return $form;
     }
  }