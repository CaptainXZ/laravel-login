<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class AddTwoEverySecond extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:add-two-every-second';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
		dd('Hello World');
        // $this->info('Adding two every second...');

		// $i = 0; // while (true) {
		// 	$i += 2;
		// 	$this->info($i);
		// 	sleep(1);`
		// }
    }
}
