Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 14 Oct 2014 22:36:41 -0400 (EDT)
Message-ID: <20141014.223641.1750858832286185881.davem@davemloft.net>
Subject: Re: [PATCH v3 25/27] Sparc/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
From: David Miller <davem@davemloft.net>
In-Reply-To: <1413342435-7876-26-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
	<1413342435-7876-26-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20141015023641.ml7O0UOM-LymA0FZYPp3udTiZSm-mn9jOXEouT4CxLQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: wangyijing@huawei.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, huxinwei@huawei.com, wuyun.wu@huawei.com, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, arnd@arndb.de, tglx@linutronix.de, konrad.wilk@oracle.com, xen-devel@lists.xenproject.org, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sebott@linux.vnet.ibm.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, sparclinux@vger.kernel.org, cmetcalf@tilera.com, ralf@linux-mips.org, l.stach@pengutronix.de, david.vrabel@citrix.com, sergei.shtylyov@cogentembedded.com, mpe@ellerman.id.au, thierry.reding@gmail.com, thomas.petazzoni@free-electrons.com, liviu@dudau.co.uk
List-ID: <linux-s390.vger.kernel.org>

From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 15 Oct 2014 11:07:13 +0800

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
