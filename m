From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch: s390: kernel: scan all present cpu forcely.
Date: Thu, 27 Jun 2013 17:22:55 +0800
Message-ID: <51CC046F.2050009@asianux.com>
References: <51C8F685.6000209@asianux.com> <20130625064832.GA4999@osiris> <51C94599.1020707@asianux.com> <20130625090928.GA8981@osiris> <51CBA6B6.1010809@asianux.com> <20130627081845.GA3824@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20130627081845.GA3824@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Chen Gang <gang.chen@asianux.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06/27/2013 04:18 PM, Heiko Carstens wrote:
> On Thu, Jun 27, 2013 at 10:43:02AM +0800, Chen Gang wrote:
>> > The architectures which may support 'hotpluggable', can scan all cpus
>> > during subsys_initcall().  the upper caller will skip the return value.
>> > 
>> > It also can initialize hotpluggable flag of all cpus in time, no matter
>> > whether any cpus fail or not.
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > ---
>> >  arch/s390/kernel/smp.c |    5 +++--
>> >  1 files changed, 3 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
>> > index d386c4e..75a118f 100644
>> > --- a/arch/s390/kernel/smp.c
>> > +++ b/arch/s390/kernel/smp.c
>> > @@ -1064,8 +1064,9 @@ static int __init s390_smp_init(void)
>> >  #endif
>> >  	for_each_present_cpu(cpu) {
>> >  		rc = smp_add_present_cpu(cpu);
>> > -		if (rc)
>> > -			return rc;
>> > +		if (unlikely(rc))
>> > +			printk(KERN_WARNING "%s: add cpu %d failed (%d)\n",
>> > +			       __func__, cpu, rc);
> I have no idea how the patch description is supposed to correlate with
> your patch.

Pardon, excuse me, my English is not quite well.

> However your patch doesn't make sense anyway.

At least it will continue to try to "add present cpu" as much as possible.

And also make sure of all 'hotpluggable' set.

> We have initcall_debug for .. initcall debugging, which your patch would
> break in addition, since this function would now return 0 instead of the
> return code.

I have searched all another architectures, most of them are only return
0 in subsys_initcall().

Do you means we do not like them ?


Thanks
-- 
Chen Gang
