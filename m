Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAB3002CF;
	Tue, 24 Mar 2026 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393602; cv=none; b=YdIPPoYydjLtTpn1OlVCR87k0Pv2FUGUU34D1ObtzFcinxYTDcRSq64C4Dhz9V2ynVXgOLTZpZM3F+hBfJrDEQOZIjrXZWh986Tm81hPINSYDF7NN1B66V14t2GFywy0EMj/KXa84RSWqwHAG8yyMGPU9e/HGNYurvnIFnj+FmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393602; c=relaxed/simple;
	bh=ImMxwL+/C5JFsIQXHXTtKkGAR2bfQr7Mbo2LOR5M/zA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o2wgKmUPUYIKpEagOfpBmleihLc742cxshYKieumX6OiBdVy2B35B7DhnBRFy9WPi/D7h2yZzn0t3srH3mxBgKghND5131cERFsePJvSFJnD/TlKM8RWGpHCAw7xb46fxO/ThGc+kT6S8AlpZGD2ZzkGLWEjMwUjNJLY9dyHHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=halXFbFx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="halXFbFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A90AC19424;
	Tue, 24 Mar 2026 23:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774393602;
	bh=ImMxwL+/C5JFsIQXHXTtKkGAR2bfQr7Mbo2LOR5M/zA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=halXFbFxBu4PCn83WoseAUksN2en1Uyhql0xEboCkTCLe5KTZyWHYRd8HD0ZcuE4l
	 NbkanEQ5qDF0/B8aRNCxJHrN7C2D6IHWgP1KrD8Rj/pB8D682t3WtC8JSKaIOYGOoA
	 Tbt8WcD/ocUS0n8j7X4SQUxp7FYWJZSALH12t2grbo1Sat+CXow3HgHdXRhR7ddVbY
	 g82nlEfGlXGY6F0F+JfsbqPgoCsNfqUW9n6QpYrsOwq4uHqSYHClqdBZcmikqB8qFM
	 9iX1Lq0w4X2hcrk/bxzdjnnk0JRhdIyiQdGisFL8hS1+Ioi29019TXySEStJfv9hE1
	 Q961IJVvagaog==
Date: Tue, 24 Mar 2026 18:06:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v11 2/9] s390/pci: Add architecture specific resource/bus
 address translation
Message-ID: <20260324230641.GA1162880@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316191544.2279-3-alifm@linux.ibm.com>

[+cc Ilpo just for awareness; I assume there's nothing Linux can
actually *do* with s390 PCI resources?]

On Mon, Mar 16, 2026 at 12:15:37PM -0700, Farhan Ali wrote:
> On s390 today we overwrite the PCI BAR resource address to either an
> artificial cookie address or MIO address. However this address is different
> from the bus address of the BARs programmed by firmware. The artificial
> cookie address was created to index into an array of function handles
> (zpci_iomap_start). The MIO (mapped I/O) addresses are provided by firmware
> but maybe different from the bus addresses. This creates an issue when
> trying to convert the BAR resource address to bus address using the generic
> pcibios_resource_to_bus().
> 
> Implement an architecture specific pcibios_resource_to_bus() function to
> correctly translate PCI BAR resource addresses to bus addresses for s390.
> Similarly add architecture specific pcibios_bus_to_resource function to do
> the reverse translation.

1) It's not clear to me *why* we need these arch-specific versions.
We went to a lot of trouble to make these interfaces generic, and I'll
be really sad if they have to be arch-specific again.  I don't see any
direct uses of these in the series.  In any case, some reference to
the user and the actual problem this solves would help.

2) I'm kind of concerned that the "unusual" s390 PCI resources will be
unintelligible to people who are used to reading lspci or dmesg logs
from non-s390 systems, and they might confuse the PCI core resource
assignment code.  I guess there's not really a concept of a PCI host
bridge on s390, there's no bus hierarchy, and no visible PCI-to-PCI
bridges, so no windows?  Can you use PCIe switches at all?

3) Maybe this patch should be reordered to be closer to the patch that
needs these?  I don't think it's related to the "PCI: Avoid saving
config space state if inaccessible" and PCI: Add additional checks for
flr reset" patches.

> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/pci/pci.c       | 74 +++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host-bridge.c |  8 ++---
>  2 files changed, 78 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 2a430722cbe4..87077e510266 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -272,6 +272,80 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  	return 0;
>  }
>  
> +void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
> +			     struct resource *res)
> +{
> +	struct zpci_bus *zbus = bus->sysdata;
> +	struct zpci_bar_struct *zbar;
> +	struct zpci_dev *zdev;
> +
> +	region->start = res->start;
> +	region->end = res->end;
> +
> +	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
> +		int j = 0;
> +
> +		zbar = NULL;
> +		zdev = zbus->function[i];
> +		if (!zdev)
> +			continue;
> +
> +		for (j = 0; j < PCI_STD_NUM_BARS; j++) {
> +			if (zdev->bars[j].res->start == res->start &&
> +			    zdev->bars[j].res->end == res->end &&
> +			    res->flags & IORESOURCE_MEM) {
> +				zbar = &zdev->bars[j];
> +				break;
> +			}
> +		}
> +
> +		if (zbar) {
> +			/* only MMIO is supported */
> +			region->start = zbar->val & PCI_BASE_ADDRESS_MEM_MASK;
> +			if (zbar->val & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +				region->start |= (u64)zdev->bars[j + 1].val << 32;
> +
> +			region->end = region->start + (1UL << zbar->size) - 1;
> +			return;
> +		}
> +	}
> +}
> +
> +void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> +			     struct pci_bus_region *region)
> +{
> +	struct zpci_bus *zbus = bus->sysdata;
> +	struct zpci_dev *zdev;
> +	resource_size_t start, end;
> +
> +	res->start = region->start;
> +	res->end = region->end;
> +
> +	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
> +		zdev = zbus->function[i];
> +		if (!zdev || !zdev->has_resources)
> +			continue;
> +
> +		for (int j = 0; j < PCI_STD_NUM_BARS; j++) {
> +			if (!zdev->bars[j].size)
> +				continue;
> +
> +			/* only MMIO is supported */
> +			start = zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_MASK;
> +			if (zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +				start |= (u64)zdev->bars[j + 1].val << 32;
> +
> +			end = start + (1UL << zdev->bars[j].size) - 1;
> +
> +			if (start == region->start && end == region->end) {
> +				res->start = zdev->bars[j].res->start;
> +				res->end = zdev->bars[j].res->end;
> +				return;
> +			}
> +		}
> +	}
> +}
> +
>  void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  			   pgprot_t prot)
>  {
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index be5ef6516cff..aed031b8a9f3 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -49,8 +49,8 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>  }
>  EXPORT_SYMBOL_GPL(pci_set_host_bridge_release);
>  
> -void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
> -			     struct resource *res)
> +void __weak pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
> +				    struct resource *res)
>  {
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>  	struct resource_entry *window;
> @@ -74,8 +74,8 @@ static bool region_contains(struct pci_bus_region *region1,
>  	return region1->start <= region2->start && region1->end >= region2->end;
>  }
>  
> -void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> -			     struct pci_bus_region *region)
> +void __weak pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> +				    struct pci_bus_region *region)
>  {
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>  	struct resource_entry *window;
> -- 
> 2.43.0
> 
