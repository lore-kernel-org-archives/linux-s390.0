From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
Date: Mon, 29 Sep 2014 18:12:26 +0800
Message-ID: <5429308A.7030201@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk> <20140925164937.GB30382@ulmo> <5424E09F.50701@huawei.com> <20140926085030.GE31157@bart.dudau.co.uk> <54276F6C.5010705@huawei.com> <20140928112144.GA4671@bart.dudau.co.uk> <5428B971.50101@huawei.com> <20140929092600.GA15854@bart.dudau.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20140929092600.GA15854@bart.dudau.co.uk>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, David
List-ID: <linux-s390.vger.kernel.org>

>>> Not necessarily. What I have in mind is something like this:
>>
>> This is a good idea, what I'm worried is this series is already large, so I think we need to post
>> another series to do it.
> 
> I wasn't asking to do it here, I was just offering a suggestion (and sharing some experience) when
> it comes to handling msi chip in an arch independent way.

It's a good suggestion, thanks! :)

> 
>>
>>
