Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 30 Jan 2019 13:01:02 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Handle early deadlock return correctly
In-Reply-To: <alpine.DEB.2.21.1901292311410.1950@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1901301259520.5537@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris> <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de> <20181129112321.GB3449@osiris> <20190128134410.GA28485@hirez.programming.kicks-ass.net> <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de> <20190129084904.GB28485@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1901292311410.1950@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>, Sebastian Sewior <bigeasy@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 29 Jan 2019, Thomas Gleixner wrote:
>  int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
>  			      struct rt_mutex_waiter *waiter,
>  			      struct task_struct *task)
>  {
>  	int ret;
>  
> +	lockdep_asssert_held(&lock->wait_lock);

I'm a moron. I fixed that on the test box and wrote the changelog on the
laptop. Syncing the two together was too much for my futex wreckaged brain
...
