Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52866 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389519AbgLJUeV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 15:34:21 -0500
Date: Thu, 10 Dec 2020 21:31:30 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [patch 12/30] s390/irq: Use irq_desc_kstat_cpu() in
 show_msi_interrupt()
Message-ID: <20201210203130.GB4250@osiris>
References: <20201210192536.118432146@linutronix.de>
 <20201210194043.769108348@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210194043.769108348@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci@vger.kernel.org, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Thu, Dec 10, 2020 at 08:25:48PM +0100, Thomas Gleixner wrote:
> The irq descriptor is already there, no need to look it up again.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/irq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
