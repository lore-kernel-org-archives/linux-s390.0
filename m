From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
Date: Fri, 26 Sep 2014 11:42:23 +0800
Message-ID: <5424E09F.50701@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk> <20140925164937.GB30382@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20140925164937.GB30382@ulmo>
Sender: linux-ia64-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Liviu Dudau <liviu@dudau.co.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.ke
List-ID: <linux-s390.vger.kernel.org>

>> I am actually in disagreement with you, Thierry. I don't like the general direction
>> of the patches, or at least I don't like the fact that we don't have a portable
>> way of setting up the msi_chip without having to rely on weak architectural hooks.
> 
> Oh, good. That's actually one of the things I said I wasn't happy with
> either. =)

Hm, I decide to drop weak arch_find_msi_chip(), no one likes it.
Let's find a better solution :)

> 
>> I'm surprised no one considers the case of a platform having more than one host
>> bridge and possibly more than one MSI unit. With the current proposed patchset I
>> can't see how that would work.
> 
> The PCI core can already deal with that. An MSI chip can be set per bus
> and the weak pcibios_add_bus() can be used to set that. Often it might
> not even be necessary to do it via pcibios_add_bus() if you create the
> root bus directly, since you can attach the MSI chip at that time.

Yes, PCI hostbridge driver find the matched msi chip during its initialization,
and assign the msi chip to PCI bus in pcibios_add_bus().

> 
>> What I would like to see is a way of creating the pci_host_bridge structure outside
>> the pci_create_root_bus(). That would then allow us to pass this sort of platform
>> details like associated msi_chip into the host bridge and the child busses will
>> have an easy way of finding the information needed by finding the root bus and then
>> the host bridge structure. Then the generic pci_scan_root_bus() can be used by (mostly)
>> everyone and the drivers can remove their kludges that try to work around the
>> current limitations.

So I think maybe save msi chip in PCI arch sysdata is a good candidate.

> 
> I think both issues are orthogonal. Last time I checked a lot of work
> was still necessary to unify host bridges enough so that it could be
> shared across architectures. But perhaps some of that work has
> happened in the meantime.
> 
> But like I said, when you create the root bus, you can easily attach the
> MSI chip to it.
> 
> Thierry
> 


-- 
Thanks!
Yijing
