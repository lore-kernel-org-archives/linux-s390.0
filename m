Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB830DED1;
	Wed, 25 Mar 2026 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439920; cv=none; b=UAPTgjCET4YPLhq/UEDZw1EHDqQDrZdYxqw2vWqiDLRlnmqMvg2QaDvYSvKaWnxUfmceMNvU51nODzIRJh3hEAxU/4vtomPd0rf3gPQ2xAdPRi1DDu0GMy6nWo6DuyHGAnjH3uJptcj6ceeoeTPR1NWSzAHry5C2TL1GzkfHYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439920; c=relaxed/simple;
	bh=UAUxvHk33ET8fFMVzE0Lu0h6czNMoJdojwa93qgED3w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oQBeFPn66sbpGpE8SV/kIUcpTB4cOGzjz5S/VlmKMN2TaZDgHjFk5/iD+5YikgJYj9kri6/D7R3FZdOxVcQ52LD7FtQsxUpZJIoBASbKSOgih43wSEzuLqnVNkMfACxyvcxw4csVIugyD7dsTIm0SVSD8Fsb1cLuKpCGGBXSBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOSpeSGE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOSpeSGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774439919; x=1805975919;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UAUxvHk33ET8fFMVzE0Lu0h6czNMoJdojwa93qgED3w=;
  b=kOSpeSGE3t4jLqOOJobMp1nKEJFRLQ8pGOnuKApO2xMsQxwFwUjGv+Ih
   Y/nEJrsPcQ9X4x2LQuZsQyTPESzgwwzxDJOmFxKDrBWfIV/bTXbNoPSby
   h3lk+kYyfCKgtKaEG5rVZZN3BdVQVjp/I4oGmMASMdd5+zveH5SkE91Um
   HIV3Zfcn5At28+4KHNFQbz2en3J9Xod3zXmRvCA2UYYcKwOKpN6fEr9/Y
   hcHCDPXT3lIlvrpks//3LPbkb+e5GjcdSHIV0jztCYPL11VK+AzmTsfgv
   wmXP8iAVo8IF78c8m+0tFo43O5ukYcpkJLa0zWq4NzBgm1xgSgcP9bSRf
   A==;
X-CSE-ConnectionGUID: iuU+Wu3uQbCiUbFcOA2TdQ==
X-CSE-MsgGUID: eizVfLNpT+aO9Ktz66hB+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="85783692"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="85783692"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:58:38 -0700
X-CSE-ConnectionGUID: e9x9KLkLRCGMb+/0WVwbRA==
X-CSE-MsgGUID: Fvf5VaN5To+tsiDq3wlImA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="223866279"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:58:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 25 Mar 2026 13:58:26 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    Lukas Wunner <lukas@wunner.de>, alex@shazbot.org, kbusch@kernel.org, 
    clg@redhat.com, stable@vger.kernel.org, schnelle@linux.ibm.com, 
    mjrosato@linux.ibm.com
Subject: Re: [PATCH v11 2/9] s390/pci: Add architecture specific resource/bus
 address translation
In-Reply-To: <20260324230641.GA1162880@bhelgaas>
Message-ID: <328a79ef-7b73-582f-f36b-5139ff04e24d@linux.intel.com>
References: <20260324230641.GA1162880@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Mar 2026, Bjorn Helgaas wrote:

> [+cc Ilpo just for awareness; I assume there's nothing Linux can
> actually *do* with s390 PCI resources?]

I'm somewhat aware they've this speciality (and besides that, I'm 
waiting for this change in order to proceed with the series to detect 
which resources are properly setup when we enumerate them which got 
reverted earlier).

An additional thought related to this, there's IORESOURCE_PCI_FIXED 
results in skipping most of the resource fitting and assignment code, so 
if nothing really should touch these resources, perhaps that flag might be 
of some help.

-- 
 i.

> On Mon, Mar 16, 2026 at 12:15:37PM -0700, Farhan Ali wrote:
> > On s390 today we overwrite the PCI BAR resource address to either an
> > artificial cookie address or MIO address. However this address is different
> > from the bus address of the BARs programmed by firmware. The artificial
> > cookie address was created to index into an array of function handles
> > (zpci_iomap_start). The MIO (mapped I/O) addresses are provided by firmware
> > but maybe different from the bus addresses. This creates an issue when
> > trying to convert the BAR resource address to bus address using the generic
> > pcibios_resource_to_bus().
> > 
> > Implement an architecture specific pcibios_resource_to_bus() function to
> > correctly translate PCI BAR resource addresses to bus addresses for s390.
> > Similarly add architecture specific pcibios_bus_to_resource function to do
> > the reverse translation.
> 
> 1) It's not clear to me *why* we need these arch-specific versions.
> We went to a lot of trouble to make these interfaces generic, and I'll
> be really sad if they have to be arch-specific again.  I don't see any
> direct uses of these in the series.  In any case, some reference to
> the user and the actual problem this solves would help.
> 
> 2) I'm kind of concerned that the "unusual" s390 PCI resources will be
> unintelligible to people who are used to reading lspci or dmesg logs
> from non-s390 systems, and they might confuse the PCI core resource
> assignment code.  I guess there's not really a concept of a PCI host
> bridge on s390, there's no bus hierarchy, and no visible PCI-to-PCI
> bridges, so no windows?  Can you use PCIe switches at all?
>
> 3) Maybe this patch should be reordered to be closer to the patch that
> needs these?  I don't think it's related to the "PCI: Avoid saving
> config space state if inaccessible" and PCI: Add additional checks for
> flr reset" patches.
> 
> > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > ---
> >  arch/s390/pci/pci.c       | 74 +++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/host-bridge.c |  8 ++---
> >  2 files changed, 78 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index 2a430722cbe4..87077e510266 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
> > @@ -272,6 +272,80 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >  	return 0;
> >  }
> >  
> > +void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
> > +			     struct resource *res)
> > +{
> > +	struct zpci_bus *zbus = bus->sysdata;
> > +	struct zpci_bar_struct *zbar;
> > +	struct zpci_dev *zdev;
> > +
> > +	region->start = res->start;
> > +	region->end = res->end;
> > +
> > +	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
> > +		int j = 0;
> > +
> > +		zbar = NULL;
> > +		zdev = zbus->function[i];
> > +		if (!zdev)
> > +			continue;
> > +
> > +		for (j = 0; j < PCI_STD_NUM_BARS; j++) {
> > +			if (zdev->bars[j].res->start == res->start &&
> > +			    zdev->bars[j].res->end == res->end &&
> > +			    res->flags & IORESOURCE_MEM) {
> > +				zbar = &zdev->bars[j];
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (zbar) {
> > +			/* only MMIO is supported */
> > +			region->start = zbar->val & PCI_BASE_ADDRESS_MEM_MASK;
> > +			if (zbar->val & PCI_BASE_ADDRESS_MEM_TYPE_64)
> > +				region->start |= (u64)zdev->bars[j + 1].val << 32;
> > +
> > +			region->end = region->start + (1UL << zbar->size) - 1;
> > +			return;
> > +		}
> > +	}
> > +}
> > +
> > +void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> > +			     struct pci_bus_region *region)
> > +{
> > +	struct zpci_bus *zbus = bus->sysdata;
> > +	struct zpci_dev *zdev;
> > +	resource_size_t start, end;
> > +
> > +	res->start = region->start;
> > +	res->end = region->end;
> > +
> > +	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
> > +		zdev = zbus->function[i];
> > +		if (!zdev || !zdev->has_resources)
> > +			continue;
> > +
> > +		for (int j = 0; j < PCI_STD_NUM_BARS; j++) {
> > +			if (!zdev->bars[j].size)
> > +				continue;
> > +
> > +			/* only MMIO is supported */
> > +			start = zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_MASK;
> > +			if (zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_TYPE_64)
> > +				start |= (u64)zdev->bars[j + 1].val << 32;
> > +
> > +			end = start + (1UL << zdev->bars[j].size) - 1;
> > +
> > +			if (start == region->start && end == region->end) {
> > +				res->start = zdev->bars[j].res->start;
> > +				res->end = zdev->bars[j].res->end;
> > +				return;
> > +			}
> > +		}
> > +	}
> > +}
> > +
> >  void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> >  			   pgprot_t prot)
> >  {
> > diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> > index be5ef6516cff..aed031b8a9f3 100644
> > --- a/drivers/pci/host-bridge.c
> > +++ b/drivers/pci/host-bridge.c
> > @@ -49,8 +49,8 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_set_host_bridge_release);
> >  
> > -void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
> > -			     struct resource *res)
> > +void __weak pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
> > +				    struct resource *res)
> >  {
> >  	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> >  	struct resource_entry *window;
> > @@ -74,8 +74,8 @@ static bool region_contains(struct pci_bus_region *region1,
> >  	return region1->start <= region2->start && region1->end >= region2->end;
> >  }
> >  
> > -void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> > -			     struct pci_bus_region *region)
> > +void __weak pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> > +				    struct pci_bus_region *region)
> >  {
> >  	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> >  	struct resource_entry *window;
> > -- 
> > 2.43.0
> > 
> 
