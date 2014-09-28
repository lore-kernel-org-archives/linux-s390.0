From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
Date: Sun, 28 Sep 2014 10:35:09 +0800
Message-ID: <542773DD.8020105@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <1411614872-4009-7-git-send-email-wangyijing@huawei.com> <alpine.DEB.2.10.1409251220570.4604@nanos> <5424D30A.6040900@huawei.com> <alpine.DEB.2.11.1409261236160.4567@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1409261236160.4567@nanos>
Sender: linux-ia64-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera>
List-ID: <linux-s390.vger.kernel.org>

>> MSI chip in this series is to setup MSI irq, including IRQ allocation, Map,
>> compose MSI msg ..., in different platform, many arch specific MSI irq details in it.
>> It's difficult to extract the common data and code.
>>
>> I have a plan to rework MSI related irq_chips in kernel, PCI and Non-PCI, currently,
>> HPET, DMAR and PCI have their own irq_chip and MSI related functions, write_msi_msg(),
>> mask_msi_irq(), etc... I want to extract the common data set for that, so we can
>> remove lots of unnecessary MSI code.
> 
> That makes sense. Can you please make sure that this does not conflict
> with the ongoing work Jiang is doing in the x86 irq area with
> hierarchical irqdomains to distangle layered levels like MSI from the
> underlying vector/irqremap mechanics.

Yes, I'm reviewing Jiang hierarchical irqdomains series, I'm interested in that changes.

Thanks!
Yijing.

> 
> Thanks,
> 
> 	tglx
> 
> .
> 


-- 
Thanks!
Yijing
