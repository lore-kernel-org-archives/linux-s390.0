Return-Path: <travis@sgi.com>
Message-ID: <48FDCAFB.3070802@sgi.com>
Date: Tue, 21 Oct 2008 05:28:43 -0700
From: Mike Travis <travis@sgi.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/35] x86: clean up speedctep-centrino and reduce
	cpumask_t usage
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>	<20081020170319.730428000@polaris-admin.engr.sgi.com>
	<20081021110925.853227d6.sfr@canb.auug.org.au>
In-Reply-To: <20081021110925.853227d6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: davej@codemonkey.org.uk, Jeremy Fitzhardinge <jeremy@goop.org>, Jes Sorensen <jes@sgi.com>, IA64 <linux-ia64@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, S390 <linux-s390@vger.kernel.org>, peterz@infradead.org, David Miller <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Eric Dumazet <dada1@cosmosbay.com>, PowerPC <linuxppc-dev@ozlabs.org>, Andi Kleen <andi@firstfloor.org>, Yinghai Lu <yhlu.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, SPARC <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Jack Steiner <steiner@sgi.com>
List-ID: <linux-s390.vger.kernel.org>

Stephen Rothwell wrote:
> Hi Mike,
> 
> Just a first small thing:
> 
> On Mon, 20 Oct 2008 10:03:20 -0700 Mike Travis <travis@sgi.com> wrote:
>> 1) The #ifdef CONFIG_HOTPLUG_CPU seems unnecessary these days.
>> 2) The loop can simply skip over offline cpus, rather than creating a tmp mask.
>> 3) set_mask is set to either a single cpu or all online cpus in a policy.
>>    Since it's just used for set_cpus_allowed(), any offline cpus in a policy
>>    don't matter, so we can just use cpumask_of_cpu() or the policy->cpus.
>>
>> From: Rusty Russell <rusty@rustcorp.com.au>
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>> Signed-off-by: Mike Travis <travis@sgi.com>
> 
> The From: line should be the first nonempty line in the mail to get the
> attribution correct.
> 

Ahh, ok, thanks!
