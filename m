Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9903B3EFFC4;
	Wed,  5 Aug 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949983; cv=none; b=JiRO2BaYJ6qD4tNa1CbIqCyjp2THnxHOQv11eOx/CO9DyDif2MkETaUJcpo1lMJXcd5fJBzxOKfjEtP3XNtIjv2kDqmGcfFKbwM+XEeLdHrWqWdfc4Z/EDNzjq/eu5XCdo/QM0Ks3sGmU+QgMZlPAZYsDHoES6iWpn0N/hrK0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949983; c=relaxed/simple;
	bh=XMiiEV2qO9APBrkUw7FkYeRSlJcchtR1yRuXLLnN6T8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0ulspoztwpWxV9G1uYFtjucHLdwkgBxXMcbcIKvc6hFA02nbmA6Yq0HU5SWI2lMVYcexn1uoCxbaEf65IvXc38aPMoQb29sCQ80d/m6Ln1fkOjSlnv68zao5z8QbeS9xj0U7VwT9TeiqrK28k+8Z1v/9ZCxZ4vSYMNVf10aWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDM74lTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDM74lTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68561F000E9;
	Wed,  5 Aug 2026 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785949977;
	bh=SKXWU1fFqhRJpMm/Y+nvvfH6MERrE3YMNRo4mQryhAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDM74lTutDP+buX08qcLaOFaVMHTbCFJevOR5Val7iFr4fBGp2e0ngsvnowDMTMkP
	 xpVa2xR84EVDtxZfNVVCmzaex1VY+YpLmf/gaxVhp3LUkqN23e5gGiAI8h+0WAmUsS
	 oK8UsgOdQsh+zIo2X/K5OuzCDIxYlJz/YD8k5QIeTBGVT/YQT3aqpAe0iWQ3XWAs6j
	 pnfMo78XL7h9Bm8HvVUnAlAZ1EUzp1g0ywHzJjzcm1IWXWAKBROK/B7fVtahvTR+rt
	 ukynVScVFOZ5PRMw01biHCEKojxNnzqxHIXCTe7FAFD6MHj2s2XLW4yp8fNzPR7AKS
	 q3J2p5UeX9d6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 2/5] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260805165518.794-3-alifm@linux.ibm.com>
References: <20260805165518.794-1-alifm@linux.ibm.com>
 <20260805165518.794-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 17:12:56 +0000
Message-Id: <20260805171256.A68561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditionally enabling per_func_slot on S390 breaks standard PCI=
e hotplug (e.g., pciehp), PCI_SLOT_ALL_DEVICES assignment, and physical slo=
t matching.

Pre-existing issues:
- [High] Lockless access to `dev->slot` allows a Use-After-Free if a hotplu=
g slot is concurrently destroyed.
--

--- Patch [2]: [PATCH v23 2/5] PCI: Allow per function PCI slots to fix slo=
t reset on s390 ---
commit 5800507f8f4f03803f3a4540f211363e22c66b48
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Allow per function PCI slots to fix slot reset on s390

This patch introduces a per_func_slot flag for struct pci_slot to allow
per-function PCI slots on s390. It modifies slot matching logic and changes
the slot number field to a u16 to accommodate special values.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..350bae907ebf8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4897,8 +4897,9 @@ static int pci_reset_hotplug_slot(struct hotplug_sl=
ot *hotplug, bool probe)
> =20
>  static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  {
> -	if (dev->multifunction || dev->subordinate || !dev->slot ||
> -	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> +	if (dev->subordinate || !dev->slot ||
> +	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> +	    (dev->multifunction && !dev->slot->per_func_slot))

[Severity: High]
This is a pre-existing issue, but does reading dev->slot here and accessing
dev->slot->per_func_slot allow a use-after-free?

__pci_reset_function_locked() acquires device_lock(&dev->dev) but calls
pci_dev_reset_slot_function(), which reads dev->slot locklessly.

Concurrently, if a hotplug driver is removed, pci_destroy_slot() drops
the kobject refcount and triggers pci_slot_release().

pci_slot_release() frees the slot and sets dev->slot =3D NULL:

pci_slot_release() {
	...
	list_for_each_entry(dev, &slot->bus->devices, bus_list)
		if (pci_dev_matches_slot(dev, slot))
			dev->slot =3D NULL;
	...
	kfree(slot);
}

If the reset thread is preempted after checking dev->slot but before
dereferencing dev->slot->per_func_slot, could it dereference the freed
pointer?

>  		return -ENOTTY;
> =20
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 42ff66461f74a..897223f01f6ac 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
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
> +

[ ... ]

> @@ -299,6 +314,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *pare=
nt, int slot_nr,
>  	slot->bus =3D pci_bus_get(parent);
>  	slot->number =3D slot_nr;
> =20
> +	if (pci_slot_enabled_per_func())
> +		slot->per_func_slot =3D 1;
> +

[Severity: High]
Does unconditionally setting per_func_slot for all slots on S390 break
standard PCIe hotplug topologies?

When generic PCIe hotplug drivers like pciehp create a bus-wide slot, they
pass PCI_SLOT_ALL_DEVICES (now 0xfeff). Because pci_slot_enabled_per_func()
globally forces per_func_slot =3D 1 on S390, pci_dev_matches_slot() will
evaluate:

	dev->devfn =3D=3D 0xfeff

Since devfn is an 8-bit value (0-255), this will never match, leaving
dev->slot unassigned for all devices on those buses.

Similarly, if a generic driver specifies a physical slot number (like 2),
it will evaluate dev->devfn =3D=3D 2, which incorrectly matches Function 2 =
of
Device 0 rather than matching all functions of Device 2.

Will this cause generic hotplug slots to fail matching on S390, breaking
sysfs linkages and PCI resets?

>  	slot->kobj.kset =3D pci_slots_kset;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805165518.794-=
1-alifm@linux.ibm.com?part=3D2
