From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 01/22] PCI/MSI: Clean up struct msi_chip argument
Date: Fri, 26 Sep 2014 10:15:48 +0800
Message-ID: <5424CC54.1040507@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <1411614872-4009-2-git-send-email-wangyijing@huawei.com> <20140925071536.GG12423@ulmo> <alpine.DEB.2.10.1409251208420.4604@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1409251208420.4604@nanos>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera>
List-ID: <linux-s390.vger.kernel.org>

On 2014/9/25 18:20, Thomas Gleixner wrote:
> On Thu, 25 Sep 2014, Thierry Reding wrote:
> 
>> On Thu, Sep 25, 2014 at 11:14:11AM +0800, Yijing Wang wrote:
>>> Msi_chip functions setup_irq/teardown_irq rarely use msi_chip
>>> argument.
>>
>> That's not true. Out of the four drivers that you modify two use the
>> parameter. And the two that don't probably should be using it too.
>>
>> 50% is not "rarely". =)
>>
>>>           We can look up msi_chip pointer by the device pointer
>>> or irq number, so clean up msi_chip argument.
>>
>> I don't like this particular change. The idea was to keep the API object
>> oriented so that drivers wouldn't have to know where to get the MSI chip
>> from. It also makes it more resilient against code reorganizations since
>> the core code is the only place that needs to know where to get the chip
>> from.
> 
> Right. We have the same thing in the irq_chip callbacks. All of them
> take "struct irq_data", because it's already available in the core
> code and it gives easy access to all information (chip, chipdata ...)
> which is necessary for the callback implementations.

OK, I will drop this change, tglx, thanks for your review and comments!

Thanks!
Yijing.


> 
> Thanks,
> 
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing
