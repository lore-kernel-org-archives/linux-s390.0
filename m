Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 May 2016 09:23:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v2] s390/cpum_cf: Remove superfluous SMP function call
Message-ID: <20160503092334.13565c49@mschwide>
In-Reply-To: <20160502104305.GA3974@osiris>
References: <1462179572-54920-1-git-send-email-anna-maria@linutronix.de>
	<20160502104305.GA3974@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org, rt@linutronix.de, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2 May 2016 12:43:05 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Mon, May 02, 2016 at 10:59:32AM +0200, Anna-Maria Gleixner wrote:
> > Since commit 3b9d6da67e11 ("cpu/hotplug: Fix rollback during error-out
> > in __cpu_disable()") it is ensured that callbacks of CPU_ONLINE and
> > CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this SMP
> > function calls are no longer required.
> > 
> > Replace smp_call_function_single() with a direct call of
> > setup_pmc_cpu(). To keep the calling convention, interrupts are
> > explicitly disabled around the call.
> > 
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > ---
> > Changes in v2:
> > 	- Adapt referenced commit in commit message
> > 
> >  arch/s390/kernel/perf_cpum_cf.c |    9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Martin, can you pick this patch up?

Applied, thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
