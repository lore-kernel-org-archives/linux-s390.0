From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
Date: Mon, 24 Oct 2016 09:52:31 +0200
Message-ID: <251574ff-13ba-c0df-76c3-cb7df30894cb@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
	<1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
	<20161021120536.GC3142@twins.programming.kicks-ass.net>
	<20161022110636.410f20bd@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161022110636.410f20bd@roar.ozlabs.ibm.com>
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
To: Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, kvm@vger.kernel.org, xen-devel-request@lists.xenproject.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Noam Camus <noamc@ezchip.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 10/22/2016 02:06 AM, Nicholas Piggin wrote:
> On Fri, 21 Oct 2016 14:05:36 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Fri, Oct 21, 2016 at 01:58:55PM +0200, Christian Borntraeger wrote:
>>> stop_machine can take a very long time if the hypervisor does
>>> overcommitment for guest CPUs. When waiting for "the one", lets
>>> give up our CPU by using the new cpu_relax_yield.  
>>
>> This seems something that would apply to most other virt stuff. Lets Cc
>> a few more lists for that.
>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  kernel/stop_machine.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>>> index ec9ab2f..1eb8266 100644
>>> --- a/kernel/stop_machine.c
>>> +++ b/kernel/stop_machine.c
>>> @@ -194,7 +194,7 @@ static int multi_cpu_stop(void *data)
>>>  	/* Simple state machine */
>>>  	do {
>>>  		/* Chill out and ensure we re-read multi_stop_state. */
>>> -		cpu_relax();
>>> +		cpu_relax_yield();
>>>  		if (msdata->state != curstate) {
>>>  			curstate = msdata->state;
>>>  			switch (curstate) {
>>> -- 
>>> 2.5.5
>>>   
> 
> This is the only caller of cpu_relax_yield()?

As of today yes. Right now the yielding (call to hypervisor) in 
cpu_relax is only done for s390. Some time ago Heiko did remove 
that also from s390 with commit 57f2ffe14fd125c2 ("s390: remove 
diag 44 calls from cpu_relax()")

As it turns out this make stop_machine run really slow on virtualized
systems. For example the kprobes test during bootup took several seconds 
instead of just running unnoticed with large guests. Therefore, we 
reintroduced that with commit 4d92f50249eb ("s390: reintroduce diag 44
calls for cpu_relax()"), but the only place where we noticed the missing
yield was in the stop_machine code.

I would assume that we might find some other places where this makes
sense in the future, but I expect that we have much less places for 
yield than we need for lowlatency.

PS: We do something similar for our arch implementation for spinlocks,
but there  we use the directed yield as we know which CPU holds the lock.


> 
> As a step to removing cpu_yield_lowlatency this series is nice so I
> have no objection. But "general" kernel coders still have basically
> no chance of using this properly.
> 
> I wonder what can be done about that. I've got that spin_do/while
> series I'll rebase on top of this, but a spin_yield variant of them
> is of no more help to the caller.
> 
> What makes this unique? Long latency and not performance critical?

I think what makes this unique is that ALL cpus spin and wait for one.
It was really the only place that I noticed a regression with Heikos
first patch.

> Most places where we spin and maybe yield have been moved to arch
> code, but I wonder whether we can make an easier to use architecture
> independent API?


Peter, I will fixup the patch set (I forgot to remove the lowlatency
in 2 places) and push it on my tree for linux-next. Lets see what happens.
Would the tip tree be the right place if things work out ok?
