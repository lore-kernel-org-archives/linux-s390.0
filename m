Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C163AC0C2;
	Mon, 15 Jun 2026 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549451; cv=none; b=nD1G8BRTeascawIM/pvRTVj2FidcXDXZ48/iIHYVt+xkHjmS4EpOIU4snRxbN8/uVl9g8Qqvzb69ByHuLZaieqpsGeu4d1apxlloEgpq7MP9VquWjbasX0CCmWvu30gnSy2jdON6zgXdT/K2bJwzbGfSUhMbq6XYwW4PAvtdPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549451; c=relaxed/simple;
	bh=ECRBd0yB/AOyNZ+Be3sTENwJlqWC/Y9GJqF0SiLvA8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UarIogDE1Qj3KLxr75gpsblnzM03cEpL7v68s4iA6ujcT/1ECl9N23uP7rVoAn/4w4spekCIeXbG4mhLG0ph/B1S8+kqxdq2dIHdN5tUytHuBWg1ZQzv72m9PIba1rvt0KvkrUG2SdwDHVKRLkdQVmF7W/bkipj1EVNlJNhPOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee4DIQ91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee4DIQ91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B161F000E9;
	Mon, 15 Jun 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549450;
	bh=jvRhRgJ4Eb8IELZRVbYsiQBNA9aMvBn4mITBhcx4cxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ee4DIQ91PkLWm0TDiYOPx4FEdBp5/6Ia0sffiM+HK5/Rr1P/RU5wofv28EaK4eOSM
	 PawVw4MHP47bVc8Ca+MGKxWj74tS4BThp2g6USfvZs2U7TkeRV3965g05rCNj3I9S9
	 xVlFDpKSL8hLzU7SehwJ/WQHjp2nsjxmCK9+er4z8aSNY0gouIsnsD1WDAD2PM7A8I
	 gxv2coUtj7cAEGeIB8myCq9DCg7qxqx/jmjhx6ef8H/2V+GttVSYyl6u6Eudnb36mz
	 fPEQ5X5FW9z8PiBOIqDP+iLx5O5deAsU7EmGWrugdDutvIwr12CMjDsKgmbuft1xgQ
	 bXxZXIyOoCW4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-pci@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260615183524.2880-2-alifm@linux.ibm.com>
References: <20260615183524.2880-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:50:49 +0000
Message-Id: <20260615185049.B1B161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Global enforcement of per_func_slot on S390 breaks standard generi=
c PCI hotplug (e.g., pciehp) slot matching.

Pre-existing issues:
- [High] Pre-existing Race Conditions and Use-After-Free in PCI slot lifecy=
cle and dev->slot management.
--

commit 39801ae4eb8c8847b623fb1ef810dd413b455ecc
Author: Farhan Ali <alifm@linux.ibm.com>
Subject: PCI: Allow per function PCI slots to fix slot reset on s390

This commit adds a per_func_slot flag to struct pci_slot to support
resetting individual PCI functions on s390 systems. It modifies the slot
matching and reset logic to account for this new flag, and adjusts the
slot number type to handle placeholder values.

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

[Severity: High]
This is a pre-existing issue, but does reading dev->slot->per_func_slot here
expose a use-after-free vulnerability?

In pci_dev_reset_slot_function(), dev->slot is dereferenced locklessly with=
out
holding pci_bus_sem. If a concurrent hotplug removal triggers
pci_slot_release(), the slot could be freed.

Furthermore, pci_slot_release() iterates over bus->devices to clear dev->sl=
ot,
but this can miss devices currently undergoing probing that haven't been ad=
ded
to the bus list yet, leaving a dangling pointer.

>  		return -ENOTTY;
> =20
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);

[ ... ]

> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 6d5cd37bfb1e7..894d6213ed306 100644
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

[Severity: High]
Does this logic break generic hotplug drivers like pciehp on s390 systems?

Because pci_slot_enabled_per_func() unconditionally returns true for
CONFIG_S390, per_func_slot is enabled globally. When generic hotplug drivers
create slots using PCI_SLOT_ALL_DEVICES (0xfeff), slot->number is 0xfeff.

If slot->per_func_slot is true, this evaluates dev->devfn =3D=3D 0xfeff bef=
ore
checking for the PCI_SLOT_ALL_DEVICES wildcard. Since devfn is an 8-bit val=
ue,
this always evaluates to false, preventing downstream devices from matching
their hotplug slots.

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183524.2880=
-1-alifm@linux.ibm.com?part=3D1
