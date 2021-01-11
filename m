Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAKKPU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jan 2021 05:15:20 -0500
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 02/30] genirq: Move status flag checks to core
In-Reply-To: <20201227192049.GA195845@roeck-us.net>
References: <20201210192536.118432146@linutronix.de> <20201210194042.703779349@linutronix.de> <20201227192049.GA195845@roeck-us.net>
Date: Mon, 11 Jan 2021 11:14:38 +0100
Message-ID: <87im837pbl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, Will Deacon <will@kernel.org>, Michal Simek <michal.simek@xilinx.com>, linux-s390@vger.kernel.org, afzal mohammed <afzal.mohd.ma@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Jiang <dave.jiang@intel.com>, xen-devel@lists.xenproject.org, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-pci@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Wambui Karuga <wambui.karugax@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Juergen Gross <jgross@suse.com>, David Airlie <airlied@linux.ie>, linux-gpio@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-parisc@vger.kernel.org, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, intel-gfx@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>

On Sun, Dec 27 2020 at 11:20, Guenter Roeck wrote:
> On Thu, Dec 10, 2020 at 08:25:38PM +0100, Thomas Gleixner wrote:
> Yes, but that means that irq_check_status_bit() may be called from modules,
> but it is not exported, resulting in build errors such as the following.
>
> arm64:allmodconfig:
>
> ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!

Duh. Yes, that lacks an export obviously.

Thanks,

        tglx
