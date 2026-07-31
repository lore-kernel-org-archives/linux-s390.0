Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D939259CB9;
	Fri, 31 Jul 2026 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785457336; cv=none; b=IcmUG3MzLo14RAOv7mPxS0iFCjhJTbZx0Hmf8BuwPsZLkHCp6umwV9Axw1cuuMFUtUN5yYgUV8/CX7Q3gSfuCYCPY4ZIX07jQntbNCYgYy+qCr0ftwvwBwoNOssKbSrZg5FCXxV0uaUo8hSCrGXT0nBd4vqLeCHOaPhpX+/UlYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785457336; c=relaxed/simple;
	bh=YdIE3wlED2OhvA0jgroX+J+1/uaQ5A9fw6A/Dk6oXHs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YqpGWlpL8Ol7qP8ozzLtyul1j795cLKGQNzV8BkvXVQAUFWD4rAHdxOffTrpzKNlVzkb6Gg5FE2OxgpoHJVaoOXbK50jx6IxbFnYRMU7TjVu9S8QkjhA0Hk9MI8DyWPlEvHsz/Nvi4ckPeMdb28RN87i0CGvS+cG7QBeT2M3Mbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEbaFOuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEbaFOuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C261F000E9;
	Fri, 31 Jul 2026 00:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785457332;
	bh=qgkXjBENhFn9vb1IdWCg8ZDbvvvGKBUfyjMOSz13aIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NEbaFOuw5AU5DBR0utlF5G9KZ/5gDa60wgTHsq6lRIQtV/r+zjBfbkk2/um2UnfRj
	 xn7GOg1IylRUP18+KEbeAy52FehgGWrb6Mz7LJPLnvSH4TmCFX6rhG8HjaGoxdSXDV
	 1H0HydD7c8hPQU9s/25supg6AIDbrEva0rOHo7nxXfAsV4kesLGzg2s623uNHNaU9E
	 duxzjeg5GgciCVCk/JAZoS3fHSUuisHKcljNIAN33nesoN9JRUfoEDsgpiuRkh4zz3
	 ugLeOqZGI33Zqk66dd/49NhKKmSgH0fJjmCeuQ4LL/bafaEYThBqP2BNRTuDcJcDHL
	 8dav0kn2NsSFw==
Date: Thu, 30 Jul 2026 19:22:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v22 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
Message-ID: <20260731002210.GA1521769@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720192505.2957-2-alifm@linux.ibm.com>

[+cc Keith, just fyi since this is slightly related to 102c8b26b54e
("PCI: Allow all bus devices to use the same slot")]

On Mon, Jul 20, 2026 at 12:25:02PM -0700, Farhan Ali wrote:
> On s390 systems, which use a machine level hypervisor, PCI devices are
> always accessed through a form of PCI pass-through which fundamentally
> operates on a per PCI function granularity. This is also reflected in the
> s390 PCI hotplug driver which creates hotplug slots for individual PCI
> functions. Its reset_slot() function, which is a wrapper for
> zpci_hot_reset_device(), thus also resets individual functions.

I guess we must be talking about rpaphp?

> Currently, the pci_create_slot() assigns the same pci_slot object to
> multifunction devices.

Can we say something about exactly where and why this reuse happens?
Is this because most callers have stripped off the function number by
using PCI_SLOT() before they pass it to pci_create_slot() as @slot_nr?

If so, it seems like more a property of the *callers*, not of
pci_create_slot() itself.

> This approach worked fine on s390 systems that only
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
> special values -1 and PCI_SLOT_ALL_DEVICES.

Sorry for the delay in reviewing this.  I always struggle to find
my way through the PCI slot code, which has grown into a bit of a
maze.  I keep hoping we can simplify it somehow.  I don't think that
time is now, but the complexity does make changes messy.

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

I think it might be worth splitting the PCI_SLOT_PLACEHOLDER addition
and the relevant kernel-doc updates, which are mostly unrelated to
this patch, to a separate no-functional-changes patch to simplify this
patch.

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

Update pci_create_slot() kernel-doc to mention PCI_SLOT_PLACEHOLDER
instead of "-1" (several instances).

In addition to PCI_SLOT_PLACEHOLDER or PCI_SLOT_ALL_DEVICES, and a
0-31 PCI_SLOT(devfn) value, I think @slot_nr can already be a 0-255
value (e.g., from cpci module parameters or s390
zpci_bus_add_device()).

It seems like this patch also needs pci_slot.number to end up with a
complete devfn in it so pci_dev_matches_slot() can use it, but I'm
confused about how that happens, since it looks like
rpaphp_register_slot() will pass either PCI_SLOT_PLACEHOLDER or a
PCI_SLOT(...) value to pci_hp_register().

> @@ -267,7 +282,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  
>  	mutex_lock(&pci_slot_mutex);
>  
> -	if (slot_nr == -1)
> +	if (slot_nr == PCI_SLOT_PLACEHOLDER)

No action for you here, but one thing that complicates this is the
overloading of slot_nr for different purposes:

  - Sentinel flags:

    * PCI_SLOT_ALL_DEVICES (0xfe or 0xfeff) used by pciehp init_slot()

    * PCI_SLOT_PLACEHOLDER (-1), used by rpaphp_register_slot()

    * -1 may also be used by pnv_php_alloc_slot(); I don't know
      exactly what it means

  - Traditional (mostly) PCI device numbers:

    * 0-31 derived by PCI_SLOT() in hv_pci_assign_slots(),
      octep_hp_register_slot(), pnv_php_alloc_slot(),
      rpaphp_register_slot()

    * 0-255 from cpci (module parameters)

    * 0-15 from cpq ((u8 from readb(SLOT_MASK) >> 4))

    * 0 from ibmphp_ebda

    * 0-255 from s390 zpci_bus_add_device()
      (zdev->rid & ZPCI_RID_MASK_DEVFN), where ZPCI_RID_MASK_DEVFN is
      0xff

    * 0-255 for s390 per-function slots (this series)

  - Arbitrary values:

    * Sparc pcie_bus_slot_names() path uses unvalidated
      'physical-slot#' DT property as slot_nr

    * acpiphp uses the value of _ADR as slot_nr (per spec it should be
      device number in bits 16-31, but not validated)

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
> index 64b308b6e61c..6141787f7417 100644
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

Since this is eventually assigned to a u16, and you use "0xfeff" for
PCI_SLOT_ALL_DEVICES, it seems like "0xffff" would be appropriate.

I suppose you used -1 because the arguments to pci_hp_register() all
the way down to pci_create_slot() are "int" and it's only inside
pci_create_slot() where it gets chopped to u16 when it's stored in
pci_slot.number.  But the mix of int/u16 and 0xfeff (a valid u16) and
-1 (which needs to be int) seems like unnecessary complexity.

AFAICT the only values we need to *store* in pci_slot are 0-255 and 
the "ALL_DEVICES" indication.

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
