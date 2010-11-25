Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Nov 2010 14:26:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 4/4] taskstats: Export "cdata_acct" with taskstats
Message-ID: <20101125132639.GB25836@redhat.com>
References: <20101119201108.269346583@linux.vnet.ibm.com> <20101119201144.871656307@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101119201144.871656307@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/19, Michael Holzheu wrote:
>
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>
> With this patch the (full) cumulative CPU time is added to "struct taskstats".
> The CPU time is only returned for the thread group leader.
>
> ...
>
> +	if (tsk->tgid == tsk->pid

thread_group_leader() ?

> && lock_task_sighand(tsk, &flags)) {

Do you really need ->siglock? Starting from 2.6.35 it is always
safe to access ->signal.

Oleg.
