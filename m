Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E37377A91;
	Wed, 15 Jul 2026 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784158451; cv=none; b=W95Shi3ULDEjhFx5qoHeuEEC6Ptcy4vJHJsdXB8b8I+MW5I8GRjasqTZiQLrtha0A8kA99D1YXJJTfRoWWFU0x4xUszz58rajRLFvzIS2KgR5uQlreaeLEMq65FaqPrKFLzuaSKtYfLqQd0OdMsDIc08kBuLwtAgruzueuOLswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784158451; c=relaxed/simple;
	bh=pH8F5UGT9+IdC3oKIzzOSQfEgtEphC5O/midW2/D99U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rkoc1SxLObtpJvuSAvqRenOJyRfbqeK0mDpDUCrV6x0EZoQtmkevL+JYaDb+mtit18bdXnE/i+JRU6rhyOgRXMFs8HxGX8S7pLsN9oJlHbbJ2tJGc/jiZkFJ0N/aDEgjnwr9GSLmckVi0VTBnvDltLvLw0R6k8iV6MpUxtwRjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9GhMDmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9GhMDmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9941F000E9;
	Wed, 15 Jul 2026 23:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784158450;
	bh=OpP+uwcYv5bpmQu1ogpSKpC+BhFXw0j7AREQxpNPVZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=l9GhMDmugVihR/0TMBYro0l+NcdUjmP8JSlnh89oSR4yz3uDxCfrNyoNkfrPD8+jz
	 Kc/dw7iKlJJ3JowLAJ0TjIBsTg4XdG/O/8EKL7NPh1fRKiMoQiaaYrfRXD8Gs4z9rI
	 Tkx2MJVDH0tAXk3//OTNUQQ8ZXXXTOOxr82JEi4m3d62e2tUF4B9jSRSHgsFB9Hahx
	 /9gd7nO03kMo4yA1HqsA7x6fgq3QLPt612dng9fhe+4gRH7NHlkPW01TLIRfE0arHa
	 60HYAmX/eHtOFw45Ka0qWheMuYbsYyDy1wRnN/VOYV2icwk9+M/apaY2A2gyR5yqus
	 iSYjCEbCiMqhQ==
Date: Wed, 15 Jul 2026 18:34:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v21 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
Message-ID: <20260715233408.GA271741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630164807.643-2-alifm@linux.ibm.com>

On Tue, Jun 30, 2026 at 09:48:04AM -0700, Farhan Ali wrote:
> On s390 systems, which use a machine level hypervisor, PCI devices are
> always accessed through a form of PCI pass-through which fundamentally
> operates on a per PCI function granularity. This is also reflected in the
> s390 PCI hotplug driver which creates hotplug slots for individual PCI
> functions. Its reset_slot() function, which is a wrapper for
> zpci_hot_reset_device(), thus also resets individual functions.
> 
> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
> to multifunction devices.

PCI_SLOT() doesn't assign pci_slot objects; I guess they're assigned
by some code that *uses* PCI_SLOT().  Since this says "currently," I
assume you're changing that code, so we should mention where it is to
help readers out.

I see some Sashiko comments; those also need to be addressed or
explained away.

> This approach worked fine on s390 systems that
> only exposed virtual functions as individual PCI domains to the operating
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
> functions while retaining the topology. Since we can use all 8 bits
> for slot 'number' (for ARI devices), change slot 'number' u16 to
> account for special values -1 and PCI_SLOT_ALL_DEVICES.
> 
> Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
> Cc: stable@vger.kernel.org
> Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/hotplug/rpaphp_slot.c |  2 +-
>  drivers/pci/pci.c                 |  5 +++--
>  drivers/pci/slot.c                | 33 +++++++++++++++++++++++--------
>  include/linux/pci.h               |  8 ++++++--
>  4 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
> index 67362e5b9971..92eabf5f61b9 100644
> --- a/drivers/pci/hotplug/rpaphp_slot.c
> +++ b/drivers/pci/hotplug/rpaphp_slot.c
> @@ -84,7 +84,7 @@ int rpaphp_register_slot(struct slot *slot)
>  	struct hotplug_slot *php_slot = &slot->hotplug_slot;
>  	u32 my_index;
>  	int retval;
> -	int slotno = -1;
> +	int slotno = PCI_SLOT_PLACEHOLDER;
>  
>  	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
>  		__func__, slot->dn, slot->index, slot->name,
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
> index 6d5cd37bfb1e..894d6213ed30 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
>  
>  static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>  {
> -	if (slot->number == 0xff)
> +	if (slot->number == (u16)PCI_SLOT_PLACEHOLDER)
>  		return sysfs_emit(buf, "%04x:%02x\n",
>  				  pci_domain_nr(slot->bus),
>  				  slot->bus->number);
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
> @@ -267,7 +282,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  
>  	mutex_lock(&pci_slot_mutex);
>  
> -	if (slot_nr == -1)
> +	if (slot_nr == PCI_SLOT_PLACEHOLDER)
>  		goto placeholder;
>  
>  	/*
> @@ -298,6 +313,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	slot->bus = pci_bus_get(parent);
>  	slot->number = slot_nr;
>  
> +	if (pci_slot_enabled_per_func())
> +		slot->per_func_slot = 1;
> +
>  	slot->kobj.kset = pci_slots_kset;
>  
>  	slot_name = make_slot_name(name);
> @@ -318,8 +336,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
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
> index ebb5b9d76360..b6e20616e17f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -79,14 +79,18 @@
>   * and, if ARI Forwarding is enabled, functions may appear to be on multiple
>   * devices.
>   */
> -#define PCI_SLOT_ALL_DEVICES	0xfe
> +#define PCI_SLOT_ALL_DEVICES	0xfeff
> +
> +/* Used to identify a slot as a placeholder */
> +#define PCI_SLOT_PLACEHOLDER	-1
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
