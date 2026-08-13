Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFF35C6A9;
	Thu, 13 Aug 2026 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663549; cv=none; b=YZkrGM1uL6ifojXM2SuTG8QVtizHdafDiMDsanRUguDPIen3R7RBM0u3dB2rRHJ/9E8R2r9w5rYzzdkH0a3WpKVioUJ+uUBIIFGvsi2O+rx2ditYhjvwnLxj2d0PaEJfJrjSv1tchqQxNFGY1xkjRjyLcxUOvpJilHnJn6hstKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663549; c=relaxed/simple;
	bh=k3SmUzYEm7L4H9U7UClwqfo+f6uzSy59CupZQeIWF0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mH23mQQz7d3xlbRSOEsYZqQiZHNS8rfdZu3JVRxrX2mIeEsESb9exopowCHlAb+FKppiq6Z8gszM0rMo51gGs9SIKMgkXzpXLgV9UsZztR2Lk9Vd+KbbBPmAW0grHbVJA07qG3OVPfcP2eG1MrqIroSSh0/rLEdoRf3ooE50b1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/15ibzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/15ibzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFC31F000E9;
	Thu, 13 Aug 2026 23:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786663548;
	bh=cxhdLg1CviX6u/QxyGC4JqWI+r3yRZBjgSqU5NJc4og=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=W/15ibzNfKTSgt9L0SGAF0O4ejevNnbvmReY+/xChnRqvkFpCCIhGWRFlf24L1AYu
	 okysD75oT6Yi+dg1TZWG7DHQTKI4W4QsSYafXWwu3BDdzNxfDaAgmhil6S0kh9NWLE
	 GVeJtwMI5Wj4W8jXd/DAVMRIVz1uOa8CF9cge46A6OW2LfXzoPgaHNri9BN/wYRs1d
	 Ps01/8pAXG6wqdlHng2rcZZNdwL1nVD2+CB3JHspsfeJbs9upWuAGR1sPELGWJYB6r
	 LGBG/rClHb0q7+k7zL+E9z5Fa29VyC0R95Q5LO9RRqxkp1vlPNttSLC50BpyotAri2
	 /aO5xdLepKbZg==
Date: Thu, 13 Aug 2026 18:25:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v23 2/5] PCI: Allow per function PCI slots to fix slot
 reset on s390
Message-ID: <20260813232546.GA1281281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805165518.794-3-alifm@linux.ibm.com>

On Wed, Aug 05, 2026 at 09:55:15AM -0700, Farhan Ali wrote:
> On s390 systems, which use a machine level hypervisor, PCI devices are
> always accessed through a form of PCI pass-through which fundamentally
> operates on a per PCI function granularity. This is also reflected in the
> s390 PCI hotplug driver which creates hotplug slots for individual PCI
> functions. Its reset_slot() function, which is a wrapper for
> zpci_hot_reset_device(), thus also resets individual functions.

Sorry to come back to this yet again.  I understand the issue with
the wrong pci_slot being assigned for these s390 functions.

What I don't understand is why we would use slot_reset() in the first
place.  I would expect FLR instead.

The hotplug slot_reset() path is used by pci_reset_bus_function().
But given the order in pci_reset_fn_methods[], we would typically try
pcie_reset_flr() first, and we would only get to
pci_reset_bus_function() if FLR and the other resets are not
available.

Since these are actually multi-function devices, I'm surprised that
they wouldn't advertise FLR support.

> Currently, the pci_create_slot() assigns the same pci_slot object to
> multifunction devices. This approach worked fine on s390 systems that only
> exposed virtual functions as individual PCI domains to the operating
> system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
> s390 supports exposing the topology of multifunction PCI devices by
> grouping them in a shared PCI domain. This creates a problem when resetting
> a function through the hotplug driver's slot_reset() interface.
> 
> When attempting to reset a function through the hotplug driver, the shared
> slot assignment causes the wrong function to be reset instead of the
> intended one. It also leaks memory as we do create a pci_slot object for
> the function, but don't correctly free it in pci_slot_release().
> 
> Add a flag for struct pci_slot to allow per function PCI slots for
> functions managed through a hypervisor, which exposes individual PCI
> functions while retaining the topology. Since we can use all 8 bits for
> slot 'number' (for ARI devices), change slot 'number' u16 to account for
> special values PCI_SLOT_PLACEHOLDER and PCI_SLOT_ALL_DEVICES.
> 
> Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
> Cc: stable@vger.kernel.org
> Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/pci.c   |  5 +++--
>  drivers/pci/slot.c  | 29 +++++++++++++++++++++++------
>  include/linux/pci.h |  7 ++++---
>  3 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee61..350bae907ebf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4897,8 +4897,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
>  
>  static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  {
> -	if (dev->multifunction || dev->subordinate || !dev->slot ||
> -	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> +	if (dev->subordinate || !dev->slot ||
> +	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> +	    (dev->multifunction && !dev->slot->per_func_slot))
>  		return -ENOTTY;
>  
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 42ff66461f74..897223f01f6a 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -72,6 +72,23 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
>  	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>  }
>  
> +static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *slot)
> +{
> +	if (slot->per_func_slot)
> +		return dev->devfn == slot->number;
> +
> +	return slot->number == PCI_SLOT_ALL_DEVICES ||
> +		PCI_SLOT(dev->devfn) == slot->number;
> +}
> +
> +static bool pci_slot_enabled_per_func(void)
> +{
> +	if (IS_ENABLED(CONFIG_S390))
> +		return true;
> +
> +	return false;
> +}
> +
>  static void pci_slot_release(struct kobject *kobj)
>  {
>  	struct pci_dev *dev;
> @@ -82,8 +99,7 @@ static void pci_slot_release(struct kobject *kobj)
>  
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list)
> -		if (slot->number == PCI_SLOT_ALL_DEVICES ||
> -		    PCI_SLOT(dev->devfn) == slot->number)
> +		if (pci_dev_matches_slot(dev, slot))
>  			dev->slot = NULL;
>  	up_read(&pci_bus_sem);
>  
> @@ -187,8 +203,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
>  
>  	mutex_lock(&pci_slot_mutex);
>  	list_for_each_entry(slot, &dev->bus->slots, list)
> -		if (slot->number == PCI_SLOT_ALL_DEVICES ||
> -		    PCI_SLOT(dev->devfn) == slot->number)
> +		if (pci_dev_matches_slot(dev, slot))
>  			dev->slot = slot;
>  	mutex_unlock(&pci_slot_mutex);
>  }
> @@ -299,6 +314,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	slot->bus = pci_bus_get(parent);
>  	slot->number = slot_nr;
>  
> +	if (pci_slot_enabled_per_func())
> +		slot->per_func_slot = 1;
> +
>  	slot->kobj.kset = pci_slots_kset;
>  
>  	slot_name = make_slot_name(name);
> @@ -319,8 +337,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &parent->devices, bus_list)
> -		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
> -		    PCI_SLOT(dev->devfn) == slot_nr)
> +		if (pci_dev_matches_slot(dev, slot))
>  			dev->slot = slot;
>  	up_read(&pci_bus_sem);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b628787e9485..43f80d6189a7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -79,17 +79,18 @@
>   * and, if ARI Forwarding is enabled, functions may appear to be on multiple
>   * devices.
>   */
> -#define PCI_SLOT_ALL_DEVICES	0xfe
> +#define PCI_SLOT_ALL_DEVICES	0xfeff
>  
>  /* Used to identify a slot as a placeholder */
> -#define PCI_SLOT_PLACEHOLDER	0xff
> +#define PCI_SLOT_PLACEHOLDER	0xffff
>  
>  /* pci_slot represents a physical slot */
>  struct pci_slot {
>  	struct pci_bus		*bus;		/* Bus this slot is on */
>  	struct list_head	list;		/* Node in list of slots */
>  	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
> -	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
> +	u16			number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
> +	unsigned int		per_func_slot:1; /* Allow per function slot */
>  	struct kobject		kobj;
>  };
>  
> -- 
> 2.43.0
> 
