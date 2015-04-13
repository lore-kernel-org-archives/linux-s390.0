Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20150413210035.099736663@linutronix.de>
Date: Mon, 13 Apr 2015 21:02:20 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 2/5] s390: crypto: Protect poll timeout update
References: <20150413210009.682000343@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=s390-crypto-protect-hrtimer-update.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The poll timeout update via sysfs runs completely unprotected against
other usage sites of the timer. Take the proper lock before fiddling
with the timer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---

P.S: I have serious doubts about the following snippets in that code:

@@ -1174,11 +1174,13 @@ static ssize_t poll_timeout_store(struct
       poll_timeout = time;
       hr_time = ktime_set(0, poll_timeout);

       spin_lock_bh(&ap_poll_timer_lock);
       if (!hrtimer_is_queued(&ap_poll_timer) ||
-->        !hrtimer_forward(&ap_poll_timer, hrtimer_get_expires(&ap_poll_timer), hr_time)) {

Why does it check, whether the forwarding resulted in an overrun?

If the timer is not queued, then it is either expired or has never
been started. So if the poll timeout gets written, then the timer is
started when

	timer->expires + hr_time < now

This results in random behaviour at best.

                hrtimer_set_expires(&ap_poll_timer, hr_time);
                hrtimer_start_expires(&ap_poll_timer, HRTIMER_MODE_ABS);
        }
@@ -1552,11 +1553,16 @@ static inline void __ap_schedule_poll_timeout
       spin_lock_bh(&ap_poll_timer_lock);
       if (hrtimer_is_queued(&ap_poll_timer) || ap_suspend_flag)
                goto out;
--->   if (ktime_to_ns(hrtimer_expires_remaining(&ap_poll_timer)) <= 0) {

The check above does not make any sense either. Again, if the timer is
not queued then it is either expired or was never started. As the
timer is never canceled except on module unload the condition is
always true.

               hr_time = ktime_set(0, poll_timeout);
               hrtimer_forward_now(&ap_poll_timer, hr_time);
               hrtimer_restart(&ap_poll_timer);
       }

But that's not scope of that patch and I leave this to the s390
wizards to digest.

---

 drivers/s390/crypto/ap_bus.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/drivers/s390/crypto/ap_bus.c
===================================================================
--- linux.orig/drivers/s390/crypto/ap_bus.c
+++ linux/drivers/s390/crypto/ap_bus.c
@@ -1174,11 +1174,13 @@ static ssize_t poll_timeout_store(struct
 	poll_timeout = time;
 	hr_time = ktime_set(0, poll_timeout);
 
+	spin_lock_bh(&ap_poll_timer_lock);
 	if (!hrtimer_is_queued(&ap_poll_timer) ||
 	    !hrtimer_forward(&ap_poll_timer, hrtimer_get_expires(&ap_poll_timer), hr_time)) {
 		hrtimer_set_expires(&ap_poll_timer, hr_time);
 		hrtimer_start_expires(&ap_poll_timer, HRTIMER_MODE_ABS);
 	}
+	spin_unlock_bh(&ap_poll_timer_lock);
 	return count;
 }
 
