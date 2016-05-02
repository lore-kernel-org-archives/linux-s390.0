Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 2 May 2016 12:43:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] s390/cpum_cf: Remove superfluous SMP function call
Message-ID: <20160502104305.GA3974@osiris>
References: <1462179572-54920-1-git-send-email-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462179572-54920-1-git-send-email-anna-maria@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 02, 2016 at 10:59:32AM +0200, Anna-Maria Gleixner wrote:
> Since commit 3b9d6da67e11 ("cpu/hotplug: Fix rollback during error-out
> in __cpu_disable()") it is ensured that callbacks of CPU_ONLINE and
> CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this SMP
> function calls are no longer required.
> 
> Replace smp_call_function_single() with a direct call of
> setup_pmc_cpu(). To keep the calling convention, interrupts are
> explicitly disabled around the call.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
> Changes in v2:
> 	- Adapt referenced commit in commit message
> 
>  arch/s390/kernel/perf_cpum_cf.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Martin, can you pick this patch up?
