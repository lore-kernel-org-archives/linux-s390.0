From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 16 Nov 2016 14:11:09 +0000
Subject: [bug report] s390/time: steer clocksource on STP sync events
Message-Id: <20161116132428.GA4282@mwanda>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Martin Schwidefsky,

The patch 75c7b6f3f6ba: "s390/time: steer clocksource on STP sync
events" from Oct 11, 2016, leads to the following static checker
warning:

	arch/s390/kernel/time.c:422 clock_sync_global()
	warn: unsigned 'tod_steering_delta' is never less than zero.

arch/s390/kernel/time.c
   402  static void clock_sync_global(unsigned long long delta)
   403  {
   404          unsigned long now, adj;
   405          struct ptff_qto qto;
   406  
   407          /* Fixup the monotonic sched clock. */
   408          sched_clock_base_cc += delta;
   409          /* Adjust TOD steering parameters. */
   410          vdso_data->tb_update_count++;
   411          now = get_tod_clock();
   412          adj = tod_steering_end - now;
   413          if (unlikely((s64) adj >= 0))
   414                  /* Calculate how much of the old adjustment is left. */
   415                  tod_steering_delta = ((s64) tod_steering_delta < 0) ?
   416                          -(adj >> 15) : (adj >> 15);
   417          tod_steering_delta += delta;
   418          if ((abs(tod_steering_delta) >> 48) != 0)
                     ^^^
Pointless on ULL.

   419                  panic("TOD clock sync offset %lli is too large to drift\n",
   420                        tod_steering_delta);
   421          tod_steering_end = now + (abs(tod_steering_delta) << 15);
                                          ^^^^^^^^^^^^^^^^^^^^^^^
   422          vdso_data->ts_dir = (tod_steering_delta < 0) ? 0 : 1;
                                     ^^^^^^^^^^^^^^^^^^^^^^

Maybe just make it s64 and remove the other casting?

   423          vdso_data->ts_end = tod_steering_end;
   424          vdso_data->tb_update_count++;
   425          /* Update LPAR offset. */
   426          if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
   427                  lpar_offset = qto.tod_epoch_difference;
   428          /* Call the TOD clock change notifier. */
   429          atomic_notifier_call_chain(&s390_epoch_delta_notifier, 0, &delta);
   430  }

regards,
dan carpenter
