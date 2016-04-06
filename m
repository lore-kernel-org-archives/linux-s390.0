Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 Apr 2016 21:51:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] cpu/hotplug: fix rollback during error-out in
 __cpu_disable()
Message-ID: <20160406195133.GB3485@osiris>
References: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
 <20160405104912.GC3937@osiris>
 <57039DC2.6090907@linutronix.de>
 <20160405112336.GB6890@osiris>
 <20160405113637.GC6890@osiris>
 <20160405115129.GE30124@linutronix.de>
 <5703A836.7030708@linutronix.de>
 <20160405121155.GF6890@osiris>
 <20160405155904.GA19022@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160405155904.GA19022@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 05, 2016 at 05:59:04PM +0200, Sebastian Andrzej Siewior wrote:
> If we error out in __cpu_disable() (via takedown_cpu() which is
> currently the last one that can fail) we don't rollback entirely to
> CPUHP_ONLINE (where we started) but to CPUHP_AP_ONLINE_IDLE. This
> happens because the former states were on the target CPU (the AP states)
> and during the rollback we go back until the first BP state we started.
> During the next cpu_down attempt (on the same failed CPU) will take
> forever because the cpuhp thread is still down.
> 
> The fix this I rollback to where we started in _cpu_down() via a workqueue
> to ensure that those callback will be run on the target CPU in
> non-atomic context (as in normal cpu_up()).
> The workqueues should be working again because the CPU_DOWN_FAILED were
> already invoked.
> 
> notify_online() has been marked as ->skip_onerr because otherwise we
> will see the CPU_ONLINE notifier in addition to the CPU_DOWN_FAILED.
> However with ->skip_onerr we neither see CPU_ONLINE nor CPU_DOWN_FAILED
> if something in between (CPU_DOWN_FAILED … CPUHP_TEARDOWN_CPU).
> Currently there is nothing.
> 
> This regression got probably introduce in the rework while we introduced
> the hotplug thread to offload the work to the target CPU.
> 
> Fixes: 4cb28ced23c4 ("cpu/hotplug: Create hotplug threads")
> Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/cpu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

This fixes the issue that a second cpu_down() will take forever, if
__cpu_disable() fails.

However it does not fix the issue that CPU_DOWN_FAILED will be seen on a
different cpu than the cpu that was supposed to be taken offline.
