Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 24 May 2017 12:57:37 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch V3 28/32] s390: Prevent hotplug rwsem recursion
References: <20170524081511.203800767@linutronix.de>
 <20170524081549.354513406@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524081549.354513406@linutronix.de>
Message-Id: <20170524105737.GE5427@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior <bigeasy@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 24, 2017 at 10:15:39AM +0200, Thomas Gleixner wrote:
> The text patching functions which are invoked from jump_label and kprobes
> code are protected against cpu hotplug at the call sites.
> 
> Use stop_machine_cpuslocked() to avoid recursion on the cpu hotplug
> rwsem. stop_machine_cpuslocked() contains a lockdep assertion to catch any
> unprotected callers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/jump_label.c |    2 +-
>  arch/s390/kernel/kprobes.c    |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
