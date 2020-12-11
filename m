Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:34578 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392131AbgLKMhx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Dec 2020 07:37:53 -0500
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 27/30] xen/events: Only force affinity mask for percpu interrupts
In-Reply-To: <2164a0ce-0e0d-c7dc-ac97-87c8f384ad82@suse.com>
References: <20201210192536.118432146@linutronix.de> <20201210194045.250321315@linutronix.de> <7f7af60f-567f-cdef-f8db-8062a44758ce@oracle.com> <2164a0ce-0e0d-c7dc-ac97-87c8f384ad82@suse.com>
Date: Fri, 11 Dec 2020 13:37:10 +0100
Message-ID: <871rfwiknd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, boris.ostrovsky@oracle.com, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci@vger.kernel.org, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>

On Fri, Dec 11 2020 at 13:10, J=C3=BCrgen Gro=C3=9F wrote:
> On 11.12.20 00:20, boris.ostrovsky@oracle.com wrote:
>>=20
>> On 12/10/20 2:26 PM, Thomas Gleixner wrote:
>>> All event channel setups bind the interrupt on CPU0 or the target CPU f=
or
>>> percpu interrupts and overwrite the affinity mask with the corresponding
>>> cpumask. That does not make sense.
>>>
>>> The XEN implementation of irqchip::irq_set_affinity() already picks a
>>> single target CPU out of the affinity mask and the actual target is sto=
red
>>> in the effective CPU mask, so destroying the user chosen affinity mask
>>> which might contain more than one CPU is wrong.
>>>
>>> Change the implementation so that the channel is bound to CPU0 at the X=
EN
>>> level and leave the affinity mask alone. At startup of the interrupt
>>> affinity will be assigned out of the affinity mask and the XEN binding =
will
>>> be updated.
>>=20
>>=20
>> If that's the case then I wonder whether we need this call at all and in=
stead bind at startup time.
>
> After some discussion with Thomas on IRC and xen-devel archaeology the
> result is: this will be needed especially for systems running on a
> single vcpu (e.g. small guests), as the .irq_set_affinity() callback
> won't be called in this case when starting the irq.

That's right, but not limited to ARM. The same problem exists on x86 UP.
So yes, the call makes sense, but the changelog is not really useful.
Let me add a comment to this.

Thanks,

        tglx
