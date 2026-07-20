Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C492C236B;
	Mon, 20 Jul 2026 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576354; cv=none; b=QaVya8c9Kg6tSlv4foiLmsvQAVQmjq1AcE+3TxLLPn1y7TpZZoosIkSWY3MdMpnRGQeQzmYF1rdJ0LfXCJARvrVvF6XDrxtbNuKGSYdhnOdG+n25/pgAW7yhAk6iJJcc1e0eT1debJHyp7n/GMFQVlYchXm99lxZNoTfqLAj5cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576354; c=relaxed/simple;
	bh=NJW5YsHnNYm6FN0/D40cYI2OD5FjZDoIxWKb0lI10RE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IHQMwEWS37eDMPwmB3W4Yf8t3dsLQsBnPmTqL+s1hF6/rREh9eLI4FK9jiRKf3YDT8z1w8Kp5JKB07cvQEX9xTfnFLWp2mCmpzgPxLBwe5RfGMkaoB3u/gtve0CPXWjJvzDmBcP11VWmGPKFGHHCT/nUHNvRQGb29bMsqudAKo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck0Q94St; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck0Q94St"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD91F000E9;
	Mon, 20 Jul 2026 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784576353;
	bh=g1WOTHLaKK9cdFY5P3ufcqfMSCTC2OznsS31KeI/Z10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ck0Q94StkArOPZHe3PMQYpHc/6UJSFn/HKJMm+4uZrGtk0/cRFe0qgcOlbryLYZ3i
	 riS7RXd7+cQLyohGcb25HEODchfYaPAtrgV5rPx4Wgka1BtWhMOR0v1BTlORqFKlP5
	 DI8YtrPN8rYi4migC0p1gIIR6DjBZ6Xw8R/yrVrylnXIjeok0kNjfkoMvBnPs16ZPH
	 vZTuumQdlP56Y9AFQkFiGYkGYxq9C6ctU6fGzPd9q3qN3ZAPho5l9PirmJpcHdhQZK
	 z7b49C2ODbjGwv7a7Q8wmYTselxd9G2oVvY/fdpbh1FS1PEfQulW325ibAfMeQ4+cN
	 sQTmi1378EQVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260720192505.2957-2-alifm@linux.ibm.com>
References: <20260720192505.2957-1-alifm@linux.ibm.com>
 <20260720192505.2957-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 19:39:12 +0000
Message-Id: <20260720193912.C1FD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional `per_func_slot =3D 1` assignment on s390 globally re=
defines PCI slot matching semantics, breaking standard PCI hotplug and slot=
 topologies.

Pre-existing issues:
- [High] Lockless access to `dev->slot` in `pci_dev_reset_slot_function` al=
lows a TOCTOU NULL pointer dereference and Use-After-Free if the slot is co=
ncurrently destroyed.
--

--- Patch [1]: [PATCH v22 1/4] PCI: Allow per function PCI slots to fix slo=
t reset on s390 ---
commit 9361e1530ed79c09b88218431e8f5dd3bd89d63a
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Allow per function PCI slots to fix slot reset on s390

This patch introduces a per_func_slot flag for pci_slot to support per-func=
tion
PCI slots on s390 systems managed by a hypervisor. It updates the slot
assignment and hotplug reset logic to account for these per-function slots.

Cc: stable@vger.kernel.org
Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

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
This is a pre-existing issue, but does adding dev->slot->per_func_slot here
exacerbate a race condition?

Looking at pci_dev_reset_slot_function(), dev->slot is accessed locklessly
and without READ_ONCE(). If a hotplug driver module is unloaded concurrentl=
y,
it can call pci_destroy_slot() which triggers pci_slot_release().

Since pci_slot_release() takes pci_bus_sem for reading and sets
dev->slot =3D NULL before freeing the slot, an interleaving execution could
pass the !dev->slot check, and then attempt to dereference the freed pointer
when evaluating dev->slot->per_func_slot or dev->slot->hotplug.

>  		return -ENOTTY;
> =20
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);

[ ... ]

> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c

[ ... ]

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

[Severity: High]
Could this unconditional check cause issues for standard PCI hotplug drivers
on s390?

Because pci_slot_enabled_per_func() returns true globally when CONFIG_S390
is enabled, every slot created via pci_create_slot() on s390 will have
per_func_slot set to 1.

When generic hotplug drivers (like pciehp) attempt to match devices
using the PCI_SLOT_ALL_DEVICES (0xfeff) wildcard, pci_dev_matches_slot()
will take the early return:

drivers/pci/slot.c:pci_dev_matches_slot() {
    if (slot->per_func_slot)
        return dev->devfn =3D=3D slot->number;
    ...
}

Since dev->devfn is an 8-bit value, it will never match 0xfeff. Would this
break device matching for standard hotplug slots (like KVM guests) on s390
by bypassing the wildcard check entirely?

> +
> +	return false;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720192505.2957=
-1-alifm@linux.ibm.com?part=3D1
