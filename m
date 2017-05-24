Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 24 May 2017 12:57:14 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch V3 15/32] s390/kernel: Use stop_machine_cpuslocked()
References: <20170524081511.203800767@linutronix.de>
 <20170524081548.250203087@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524081548.250203087@linutronix.de>
Message-Id: <20170524105714.GD5427@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior <bigeasy@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 24, 2017 at 10:15:26AM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> stp_work_fn() holds get_online_cpus() while invoking stop_machine().
> 
> stop_machine() invokes get_online_cpus() as well. This is correct, but
> prevents the conversion of the hotplug locking to a percpu rwsem.
> 
> Use stop_machine_cpuslocked() to avoid the nested call. Convert
> *_online_cpus() to the new interfaces while at it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-s390@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> ---
>  arch/s390/kernel/time.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
