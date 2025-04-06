<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class HealthCheckServiceProvider extends ServiceProvider
{
    public function register()
    {
        //
    }

    /**
     * Register healthcheck API endpoint.
     *
     * @return void
     */
    public function boot()
    {
        add_action('rest_api_init', function () {
            register_rest_route('sage/v1', '/healthcheck', [
                'methods'  => 'GET',
                'callback' => [$this, 'handleHealthCheck'],
                'permission_callback' => '__return_true',
            ]);
        });
    }

    /**
     *
     *
     * @return array
     */
    public function handleHealthCheck(\WP_REST_Request $request)
    {
        return new \WP_REST_Response([
            'status' => 'ok',
            'timestamp' => current_time('mysql'),
            'theme' => wp_get_theme()->get('Name'),
        ], 200);
    }
}
