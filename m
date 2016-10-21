From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
Date: Fri, 21 Oct 2016 14:05:36 +0200
Message-ID: <20161021120536.GC3142@twins.programming.kicks-ass.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
	<1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, kvm@vger.kernel.org, xen-devel-request@lists.xenproject.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org, Noam Camus <noamc@ezchip.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 21, 2016 at 01:58:55PM +0200, Christian Borntraeger wrote:
> stop_machine can take a very long time if the hypervisor does
> overcommitment for guest CPUs. When waiting for "the one", lets
> give up our CPU by using the new cpu_relax_yield.

This seems something that would apply to most other virt stuff. Lets Cc
a few more lists for that.

> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  kernel/stop_machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index ec9ab2f..1eb8266 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -194,7 +194,7 @@ static int multi_cpu_stop(void *data)
>  	/* Simple state machine */
>  	do {
>  		/* Chill out and ensure we re-read multi_stop_state. */
> -		cpu_relax();
> +		cpu_relax_yield();
>  		if (msdata->state != curstate) {
>  			curstate = msdata->state;
>  			switch (curstate) {
> -- 
> 2.5.5
> 
