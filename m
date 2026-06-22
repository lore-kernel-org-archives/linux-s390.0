Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A1219FC;
	Mon, 22 Jun 2026 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149541; cv=none; b=WiqCDRyA/HmELhJRE9rk3E9soPquVSY5P0yGF0vv0W0v3jbX521gGaup+0cAUQTHY1B3LRgVabtAdgVgAH/Q26K+tEMgvKnGtdRFRYuyCBz4+AYo/+S/6O2YyOvw64Tg7VIAuDm8wZ+RumYglzPGH+8SEqzyzYBF82wyGUvdKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149541; c=relaxed/simple;
	bh=0BSWAyc6pa9GbkHMYDwoTGFQmajzdHSeECKMfzvls2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMLcdAK1g01bzUpc+J8PZeBKBwIm47tFJ5vRUCVVJoXmssPhUEXUEVt6CrkSNsPxbAHERilYF8ZGhQBDo8/2sGODrlMjf8VzJqnN3LrGva/RZTLsv6h+LyuByHeQZNnYzIWtAouq1XeYujs1ZtDh40rU35BwzhtgN4tag6XN5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lP9UmMN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lP9UmMN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7E41F000E9;
	Mon, 22 Jun 2026 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149540;
	bh=pnYWBKOx8pEJrDT5Tto2F64RY0l/VnW6jvnY1fyKUgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lP9UmMN205yr6gjwsFNJM3T2CWhg2Wi5v4GikJfkB9Xs4lR5/+VNQWo83Z8Q83Kv2
	 UceXpiXYk9oUHP5975/hSv3vuRJbrL4bf82CQ1bPVP03szsanjj3klsScr+2OIdtCn
	 Mp0VpwPcVqcKOdHcfVHZah+ZyIpVSUOFNzpLH82LRxcFbXUPr1bz1WVYSdfWEM3WTu
	 9bTnjmpsDlHwbq70FpMgIcqcPj3P1BTWFsNjsUHeciJ7WdOGZkXw7/HAreDfLMSQoi
	 hNdBhSEmZyuhyCw/MKmTR/F5iVsc9qY6/H2h/g5VIMPBsj2pwrEDL56DX+74fDjVOd
	 nZMVSNt/AK37g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260622171840.1618-2-alifm@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 17:32:19 +0000
Message-Id: <20260622173220.2F7E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Unconditional `per_func_slot` on s390 breaks generic PCI hotplug d=
rivers and allows destructive cross-function link resets.
- [Medium] The sysfs `address` attribute outputs malformed PCI addresses fo=
r per-function slots.

Pre-existing issues:
- [High] `pci_slot_release` modifies the bus slots list without holding `pc=
i_slot_mutex` when released asynchronously via sysfs, causing list corrupti=
on.
- [High] Lockless access to `dev->slot` in `pci_dev_reset_slot_function` ca=
uses a Use-After-Free.
- [High] Data race on the `dev->slot` pointer assignment leads to dangling =
pointers and Use-After-Free.
--

commit 5ad46c8f890cdf7764a704f6e7d219e5cc4897bc
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Allow per function PCI slots to fix slot reset on s390

This commit adds a flag to struct pci_slot to allow per-function PCI slots
on s390 systems. This prevents the wrong function from being reset when
grouping multifunction devices in a shared domain, and modifies slot number
tracking to support special placeholder values.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..d0c9f0166af5c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4865,8 +4865,9 @@ static int pci_reset_hotplug_slot(struct hotplug_sl=
ot *hotplug, bool probe)
> =20
>  static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  {
> -	if (dev->multifunction || dev->subordinate || !dev->slot ||
> -	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> +	if (dev->subordinate || !dev->slot ||
> +	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> +	    (dev->multifunction && !dev->slot->per_func_slot))
>  		return -ENOTTY;

[Severity: High]
This is a pre-existing issue, but does lockless access to dev->slot in
pci_dev_reset_slot_function() risk a use-after-free?

If a concurrent asynchronous slot release happens via sysfs hotplug removal,
could pci_slot_release() set dev->slot to NULL and free the slot memory
exactly between the !dev->slot check and its subsequent dereference?

> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 6d5cd37bfb1e7..894d6213ed306 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops =3D {
> =20
>  static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>  {
> -	if (slot->number =3D=3D 0xff)
> +	if (slot->number =3D=3D (u16)PCI_SLOT_PLACEHOLDER)
>  		return sysfs_emit(buf, "%04x:%02x\n",
>  				  pci_domain_nr(slot->bus),
>  				  slot->bus->number);

[Severity: Medium]
Does this change cause address_read_file() to output malformed PCI addresses
in sysfs for per-function slots?=20

Since slot->number holds the full 8-bit devfn for per-function slots, will a
device with devfn 0x81 (Device 16, Function 1) be emitted into the third
field as 0000:00:81? Userspace tools expecting a standard 5-bit device
number might fail to parse this properly, violating the domain:bus:device
UAPI format.

> @@ -72,6 +72,23 @@ static ssize_t cur_speed_read_file(struct pci_slot *sl=
ot, char *buf)
>  	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>  }
> =20
> +static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *s=
lot)
> +{
> +	if (slot->per_func_slot)
> +		return dev->devfn =3D=3D slot->number;
> +
> +	return slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
> +		PCI_SLOT(dev->devfn) =3D=3D slot->number;
> +}
> +
> +static bool pci_slot_enabled_per_func(void)
> +{
> +	if (IS_ENABLED(CONFIG_S390))
> +		return true;
> +
> +	return false;
> +}

[Severity: High]
Will unconditionally enabling per_func_slot for all slots on s390 break
generic PCI hotplug drivers like pciehp?=20

Generic drivers create slots using PCI_SLOT_ALL_DEVICES. Because devfn can
never equal 0xfeff, will matches against PCI_SLOT_ALL_DEVICES always fail?

Additionally, if a match does occur, could this allow a destructive PCIe Hot
Reset of an entire multifunction device, since pci_dev_reset_slot_function()
now bypasses the dev->multifunction safeguard when per_func_slot is true?

>  static void pci_slot_release(struct kobject *kobj)
>  {
>  	struct pci_dev *dev;
> @@ -82,8 +99,7 @@ static void pci_slot_release(struct kobject *kobj)
> =20
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list)
> -		if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
> -		    PCI_SLOT(dev->devfn) =3D=3D slot->number)
> +		if (pci_dev_matches_slot(dev, slot))
>  			dev->slot =3D NULL;
>  	up_read(&pci_bus_sem);

[Severity: High]
This is a pre-existing issue, but does pci_slot_release() modify the
dev->bus->slots list without holding pci_slot_mutex?=20

If userspace holds an active reference to the slot via sysfs, this function
executes asynchronously when the sysfs file is closed. Calling
list_del(&slot->list) without the mutex might cause list corruption if other
paths like pci_dev_assign_slot() are concurrently iterating the list.

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of mutual
exclusion between pci_dev_assign_slot() and pci_slot_release() cause a data
race on dev->slot?

pci_dev_assign_slot() sets dev->slot =3D slot under pci_slot_mutex, while
pci_slot_release() sets dev->slot =3D NULL under a read lock on pci_bus_sem.
Could pci_dev_assign_slot() discover a slot that is mid-release and assign
it to dev->slot right before the memory is freed, creating a dangling
pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622171840.1618=
-1-alifm@linux.ibm.com?part=3D1
