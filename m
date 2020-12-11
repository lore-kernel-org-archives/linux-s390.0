Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:44700 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406261AbgLKOcd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Dec 2020 09:32:33 -0500
Subject: Re: [patch 27/30] xen/events: Only force affinity mask for percpu
 interrupts
References: <20201210192536.118432146@linutronix.de>
 <20201210194045.250321315@linutronix.de>
 <7f7af60f-567f-cdef-f8db-8062a44758ce@oracle.com>
 <2164a0ce-0e0d-c7dc-ac97-87c8f384ad82@suse.com>
 <871rfwiknd.fsf@nanos.tec.linutronix.de>
From: boris.ostrovsky@oracle.com
Message-ID: <9806692f-24a3-4b6f-ae55-86bd66481271@oracle.com>
Date: Fri, 11 Dec 2020 09:29:09 -0500
MIME-Version: 1.0
In-Reply-To: <871rfwiknd.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci@vger.kernel.org, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>


On 12/11/20 7:37 AM, Thomas Gleixner wrote:
> On Fri, Dec 11 2020 at 13:10, Jürgen Groß wrote:
>> On 11.12.20 00:20, boris.ostrovsky@oracle.com wrote:
>>> On 12/10/20 2:26 PM, Thomas Gleixner wrote:
>>>> All event channel setups bind the interrupt on CPU0 or the target CPU for
>>>> percpu interrupts and overwrite the affinity mask with the corresponding
>>>> cpumask. That does not make sense.
>>>>
>>>> The XEN implementation of irqchip::irq_set_affinity() already picks a
>>>> single target CPU out of the affinity mask and the actual target is stored
>>>> in the effective CPU mask, so destroying the user chosen affinity mask
>>>> which might contain more than one CPU is wrong.
>>>>
>>>> Change the implementation so that the channel is bound to CPU0 at the XEN
>>>> level and leave the affinity mask alone. At startup of the interrupt
>>>> affinity will be assigned out of the affinity mask and the XEN binding will
>>>> be updated.
>>>
>>> If that's the case then I wonder whether we need this call at all and instead bind at startup time.
>> After some discussion with Thomas on IRC and xen-devel archaeology the
>> result is: this will be needed especially for systems running on a
>> single vcpu (e.g. small guests), as the .irq_set_affinity() callback
>> won't be called in this case when starting the irq.


On UP are we not then going to end up with an empty affinity mask? Or are we guaranteed to have it set to 1 by interrupt generic code?


This is actually why I brought this up in the first place --- a potential mismatch between the affinity mask and Xen-specific data (e.g. info->cpu and then protocol-specific data in event channel code). Even if they are re-synchronized later, at startup time (for SMP).


I don't see anything that would cause a problem right now but I worry that this inconsistency may come up at some point.


-boris


> That's right, but not limited to ARM. The same problem exists on x86 UP.
> So yes, the call makes sense, but the changelog is not really useful.
> Let me add a comment to this.
>
> Thanks,
>
>         tglx
>
