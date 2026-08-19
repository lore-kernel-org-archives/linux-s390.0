Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C234252C
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130191; cv=none; b=ZWi6hFuILv+Su829DXlNfoBxTb5lgItEf9FcLXoHvYiaNoGL2iawtZkb8N3YyhKJMEUm70KwBeqF6IAHPvWN8x2aBcuw6XYKkTcTqFse6VC7Ew5D16o3DPecgfFeC+jYuz5FPMDaQO6V+rvga0LzbvvkqiCF2E2IkUJLw3meEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130191; c=relaxed/simple;
	bh=KOG0MhSDfQr0huSros1vBVPsKT2O/CR7qing/MXVEbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6tWNbF87fO4WV+Jx21OxWKWglMFLd9+3johzYikRGO3O7iOjukq4gzc7rKH492HXvQbaUqPiReTtOKIDKOPFrdDVj7RPN01PpAa2EiHrX4PfpA3b8Xr5Wvt3GAaHK5YtKmUMHGsEdvgEGd9nVM237LN02mih3IKMqL9/w08iQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS2B9mQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS2B9mQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A2C1F00A3A;
	Wed, 19 Aug 2026 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130188;
	bh=O+UH/9bTRSEnS7S4fqtG8RZYOEFP8IbyaAUus7EI7qE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WS2B9mQHZ/5WHgKJ4crNj+KYzjsO8x+2pTkHJxC5smQGprQs3nGpZyM39JZiujeIC
	 s6xNf9sf1dDlbnqNj+C7C4+pRsjqWokM5y9pRBpVzenU+Al3Fb2wjOO8An5Dbuij5F
	 CafkQpgtIlS7c4Tz3GhE+A7uZ9Rlgv+ddLsPIKJ3mZrvWBkCt1kXMM7NxEWyqvWm91
	 dTVj6e1v/9R910W9WioQDJLkhNFaIlsArv/ts5JtNoPIrxLvhZbG6wDyFPK5xIEgNr
	 s5bMKsyx6K7kJB9EhHJPG/udg6w6X45N+sXpr6HA7r4bI+TP6YMMB7fipf3vy+6xk6
	 GIgx0Uvt9NGwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] s390/pci: fix double-free in zpci MSI cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-1-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-1-826ff27b6e97@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:03:08 +0000
Message-Id: <20260819090308.A0A2C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Pre-existing memory leak of `struct resource_entry` in `zbus->re=
sources` when PCI root bus creation fails.
--

--- Patch [1]: [PATCH 1/7] s390/pci: fix double-free in zpci MSI cleanup ---
commit d582c0ae794fba4fb3a5cf7c09155cbe33bdffb9
Author: Tobias Schumacher <ts@linux.ibm.com>

s390/pci: fix double-free in zpci MSI cleanup

zpci_remove_parent_msi_domain() can be called multiple times on the
same zbus, causing a double-free. This occurs when pci_create_root_bus()
fails after successful MSI domain creation in zpci_bus_create_pci_bus():
the error path calls zpci_remove_parent_msi_domain() to clean up, but
doesn't NULL the pointer. Later, when zpci_bus_release() is called via
kref_put(), it calls zpci_remove_parent_msi_domain() again, attempting
to free the already-freed domain and fwnode.

Add NULL check at function entry and NULL the pointer after cleanup to
make the function idempotent and safe for multiple calls.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 9c9ed3d8d9597..c9520a16ca753 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c

[Severity: Medium]
This is a pre-existing issue, but while reviewing the error path discussed =
in
the commit message (when pci_create_root_bus() fails), does zpci_bus_releas=
e()
leak zbus->resources?

In arch/s390/pci/pci_bus.c:zpci_bus_alloc(), a resource is added to the lis=
t:

    INIT_LIST_HEAD(&zbus->resources);
    zbus->bus_resource.start =3D 0;
    zbus->bus_resource.end =3D ZPCI_BUS_NR;
    zbus->bus_resource.flags =3D IORESOURCE_BUS;
    pci_add_resource(&zbus->resources, &zbus->bus_resource);

But in the error path where pci_create_root_bus() fails, zbus->bus is not s=
et.
Later in zpci_bus_release(), pci_free_resource_list() is only called if
zbus->bus is true:

    if (zbus->bus) {
        pci_lock_rescan_remove();
        pci_stop_root_bus(zbus->bus);

        zpci_free_domain(zbus->domain_nr);
        pci_free_resource_list(&zbus->resources);

        pci_remove_root_bus(zbus->bus);
        pci_unlock_rescan_remove();
    }

Can this leak the struct resource_entry on this initialization error path?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-s390_irq_d=
omain_fixes-v1-0-826ff27b6e97@linux.ibm.com?part=3D1
