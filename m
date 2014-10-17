From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v3 21/27] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Date: Fri, 17 Oct 2014 15:42:06 +0800
Message-ID: <5440C84E.6050408@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>	 <1413342435-7876-22-git-send-email-wangyijing@huawei.com> <1413530600.21650.5.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1413530600.21650.5.camel@concordia>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.ke
List-ID: <linux-s390.vger.kernel.org>

On 2014/10/17 15:23, Michael Ellerman wrote:
> On Wed, 2014-10-15 at 11:07 +0800, Yijing Wang wrote:
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>> Hi Michael,
>>    I dropped the Acked-by , because this version has a
>> lot changes compared to last. So, I guess you may want to check it again.
> 
> OK thanks.
> 
> Still looks OK and boots on one of my test systems that uses MSI.

Good!

> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (for powerpc)

Thanks very much!

Thanks!
Yijing.

> 
> 
> cheers
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing
