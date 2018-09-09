<?php

namespace Drupal\ballade_core\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Volunteer form.
 */
class VolunteerForm extends FormBase {
    
    /**
     * Volunteer purpose taxonomy terms.
     *
     * @var array
     */
    private $taxo_terms = [];

    /**
     * Useless fields in getUserInputs().
     *
     * @var array
     */
    private $useless_fields = [
        'op',
        'form_build_id',
        'form_token',
        'form_id'
    ];

    /**
     * Class constructor.
     */
    public function __construct() {
        $this->setReasonTaxo();
    }

    /**
     * {@inheritdoc}
     */
    public function getFormId() {
        return 'ballade_core_forms_voluteer_form';
    }

    /**
     * Set purpose taxonomy terms.
     *
     * @return void
     */
    private function setReasonTaxo() {
        $terms_ori = \Drupal::entityManager()->getStorage('taxonomy_term')->loadTree('volunteer_purpose');
        foreach ($terms_ori as $term) {
            $terms[$term->tid] = $term->name;
        }
        return $this->taxo_terms = $terms;
    }

    /**
     * {@inheritdoc}
     */
    public function buildForm(array $form, FormStateInterface $form_state) {
        
        $form['reason'] = [
            '#type' => 'select',
            '#options' => $this->taxo_terms,
            '#title' => $this->t('Purpose'),
        ];
        $form['first_name'] = [
            '#type' => 'textfield',
            '#title' => t('First name'),
            '#required' => TRUE,
        ];
        $form['last_name'] = [
            '#type' => 'textfield',
            '#title' => t('Last name'),
            '#required' => TRUE,
        ];
        $form['email'] = [
            '#type' => 'email',
            '#title' => t('Your email'),
            '#required' => TRUE,
        ];
        $form['phone'] = [
            '#type' => 'tel',
            '#title' => t('Phone number'),
            '#required' => FALSE,
        ];
        $form['title'] = [
            '#type' => 'textfield',
            '#title' => t('Title'),
            '#required' => TRUE,
        ];
        $form['description'] = [
            '#type' => 'textarea',
            '#title' => t('Description'),
            '#required' => TRUE,
        ];
        $form['submit'] = [
            '#type' => 'submit',
            '#value' => t('Send'),
        ];
        return $form;
    }

    /**
     * {@inheritdoc}
     */
    public function validateForm(array &$form, FormStateInterface $form_state) {

    }

    /**
     * Prepare email options.
     *
     * @param array $form
     * @param FormStateInterface $form_state
     * @return void
     */
    private function emailParameters(array &$form, FormStateInterface $form_state) {

        $inputs = $form_state->getUserInput();

        $params['message'] = t('Request to become a volunteer');
        $params['subject'] = t('Volunteer');

        foreach ($inputs as $key => $value) {
            if ('reason' === $key) {
                $params['options'][$key] = $this->taxo_terms[$value];
            }
            elseif (! in_array($key, $this->useless_fields)) {
                $params['options'][$key] = !empty($value) ? $value : 'not communicate';
            }
        }
        return $params;
    }

    /**
     * {@inheritdoc}
     */
    public function submitForm(array &$form, FormStateInterface $form_state) {
       
        $langcode = \Drupal::config('system.site')->get('langcode');
        $module = 'ballade_core';
        $key = 'volunteer_contact';
        $reply = NULL;
        $send = TRUE;

        $params = $this->emailParameters($form, $form_state);

        $mailManager = \Drupal::service('plugin.manager.mail');
        $mailManager->mail($module, $key, $to, $langcode, $params, NULL, TRUE);
    }
}