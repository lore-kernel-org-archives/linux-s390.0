Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH] s390/time: set ->min_delta_ticks and ->max_delta_ticks
Date: Thu, 30 Mar 2017 21:54:55 +0200
Message-Id: <20170330195455.7393-1-nicstange@gmail.com>
In-Reply-To: <20170326134403.16226-1-nicstange@gmail.com>
References: <20170326134403.16226-1-nicstange@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Nicolai Stange <nicstange@gmail.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In preparation for making the clockevents core NTP correction aware,
all clockevent device drivers must set ->min_delta_ticks and
->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
clockevent device's rate is going to change dynamically and thus, the
ratio of ns to ticks ceases to stay invariant.

Currently, the s390's CPU timer clockevent device is initialized as
follows:

  cd->min_delta_ns    = 1;
  cd->max_delta_ns    = LONG_MAX;

Note that the device's time to cycle conversion factor, i.e.
cd->mult / (2^cd->shift), is approx. equal to 4.

Hence, this would translate to

  cd->min_delta_ticks = 4;
  cd->max_delta_ticks = 4 * LONG_MAX;

However, a minimum value of 1ns is in the range of noise anyway and the
clockevent core will take care of this by increasing it to 1us or so.
Furthermore, 4*LONG_MAX would overflow the unsigned long argument the
clockevent devices gets programmed with.

Thus, initialize ->min_delta_ticks with 1 and ->max_delta_ticks with
ULONG_MAX.

This patch alone doesn't introduce any change in functionality as the
clockevents core still looks exclusively at the (untouched) ->min_delta_ns
and ->max_delta_ns. As soon as this has changed, a followup patch will
purge the initialization of ->min_delta_ns and ->max_delta_ns from this
driver.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---

Notes:
    This prerequisite patch is part of a larger effort to feed NTP
    corrections into the clockevent devices' frequencies and thus
    avoiding their notion of time to diverge from the system's
    one. If you're interested, the current state of the whole series
    can be found at [1].
    
    If you haven't got any objections and these prerequisites get
    merged by 4.12 everywhere, I'll proceed with the remainder of
    this series in 4.13.
    
    Applicable to next-20170324 as well as to John' Stultz tree [2].
    
    [1]
      git://nicst.de/linux.git cev-freq-adj.v10.fortglx-4.12-time
      https://nicst.de/git/?p=linux.git;a=shortlog;h=refs/heads/cev-freq-adj.v10.fortglx-4.12-time
    
    [2]
      https://git.linaro.org/people/john.stultz/linux.git fortglx/4.12/time

 arch/s390/kernel/time.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index c31da46bc037..c3a52f9a69a0 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -158,7 +158,9 @@ void init_cpu_timer(void)
 	cd->mult		= 16777;
 	cd->shift		= 12;
 	cd->min_delta_ns	= 1;
+	cd->min_delta_ticks	= 1;
 	cd->max_delta_ns	= LONG_MAX;
+	cd->max_delta_ticks	= ULONG_MAX;
 	cd->rating		= 400;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= s390_next_event;
-- 
2.12.0
