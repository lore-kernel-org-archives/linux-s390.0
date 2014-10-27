From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v3 16/27] Mips/MSI: Save msi chip in pci sysdata
Date: Mon, 27 Oct 2014 09:06:22 +0800
Message-ID: <544D9A8E.6030607@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com> <1413342435-7876-17-git-send-email-wangyijing@huawei.com> <20141025130428.GD16738@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20141025130428.GD16738@linux-mips.org>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.ke
List-ID: <linux-s390.vger.kernel.org>

On 2014/10/25 21:04, Ralf Baechle wrote:
> On Wed, Oct 15, 2014 at 11:07:04AM +0800, Yijing Wang wrote:
> 
>> +static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
>> +{
>> +	struct pci_controller *control = (struct pci_controller *)bus->sysdata;
> 
> bus->sysdata is void * so this cast is unnecessary.

Yes, will update it, thanks!

> 
>   Ralf
> 
> .
> 


-- 
Thanks!
Yijing
