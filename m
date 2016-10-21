From: Juergen Gross <lists@pfupf.net>
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
Date: Fri, 21 Oct 2016 14:41:41 +0200
Message-ID: <d7caed29-9c7a-6324-9da8-6a9a28bda98a@pfupf.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
 <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
 <20161021120536.GC3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021120536.GC3142@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org, Noam Camus <noamc@ezchip.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 21/10/16 14:05, Peter Zijlstra wrote:
> On Fri, Oct 21, 2016 at 01:58:55PM +0200, Christian Borntraeger wrote:
>> stop_machine can take a very long time if the hypervisor does
>> overcommitment for guest CPUs. When waiting for "the one", lets
>> give up our CPU by using the new cpu_relax_yield.
> 
> This seems something that would apply to most other virt stuff. Lets Cc
> a few more lists for that.

Corrected xen-devel mail address.


Juergen

> 
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  kernel/stop_machine.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>> index ec9ab2f..1eb8266 100644
>> --- a/kernel/stop_machine.c
>> +++ b/kernel/stop_machine.c
>> @@ -194,7 +194,7 @@ static int multi_cpu_stop(void *data)
>>  	/* Simple state machine */
>>  	do {
>>  		/* Chill out and ensure we re-read multi_stop_state. */
>> -		cpu_relax();
>> +		cpu_relax_yield();
>>  		if (msdata->state != curstate) {
>>  			curstate = msdata->state;
>>  			switch (curstate) {
>> -- 
>> 2.5.5
>>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 
