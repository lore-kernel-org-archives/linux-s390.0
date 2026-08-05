Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384033537CD
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939140; cv=none; b=TZIhUAQ9IM0/PyzBkGtjcAnQgnnXmgnM53QJCgLfNqfF8zpvy09fqnkv3nKJ06ZHHHd0sx/7/ZJ8rHpl3h2jW0xI3J61okF84hZVDZpD0K8aiNhjaIM11qrIvnJ9XWxPdbGCHhlNHoVmEZvazTpHoZbcyoFuGz05YjYrh17gMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939140; c=relaxed/simple;
	bh=pdb/PYSf1ggJTt3a5V7PfeSBtGo3c9WU62f9j6WiN4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XiRZWq9CXXyGPctkRUP/ZC/wlTQP5u/haaJ3xr+H09pl19xWhpa9oNXxubqOlEoYyneENEBt11+S3ow9+WHBbDnXq77/Wz8W1dn6fyq0HOatCEH8YDRNNAg2kp6M9/bVJQqJ20ZZgUFp79KDXtCkWXx+prDsZisLLnUz/eMyGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK9wuliW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK9wuliW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382B01F000E9;
	Wed,  5 Aug 2026 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785939136;
	bh=eMZ0RNq3SWQhDW83ed/cI/U+LvtOr0ULQ4w64rRbJro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HK9wuliWlHpovxnvLaXW1m41DZZKDZS6q/tly/GtLTA2kiR1YXcYDWresDUVnTjxG
	 AQehHN5a+stwUeNvYNeQmWlWpPfpY9LpNQQCfAqA1FUM42Myr73e3GjzmXK+u+JLja
	 OXGWzOLHiudFADv9XivALbPu8VwUWZnHkVTJDYmr1tFsqqsbGBMH1tX6NpJPRTKtWV
	 /WlgYr6igJCdvo5UtBKslsP2k+DSQNKYKt9ndRJ69dJ2oDyED3JvL7NCIIYPfiGMjW
	 ATdP5+AcKZ2xnHqAEgZ6IKJM7KFmEjujhpqpXV1UNUSZn6ywUuvYk4R8CwRvYJW46o
	 fGSKOCo4VowFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] s390/pci: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805133627.1216607-4-hca@linux.ibm.com>
References: <20260805133627.1216607-1-hca@linux.ibm.com>
 <20260805133627.1216607-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:12:15 +0000
Message-Id: <20260805141216.382B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing lock acquisition in zpci_remove_reserved_devices() leading=
 to lockdep failure and state corruption.
- [High] Race condition in zpci_event_avail_new_device() exposing an unlock=
ed device to concurrent state changes.
--

--- Patch [3]: [PATCH v3 3/3] s390/pci: Enable CONTEXT_ANALYSIS ---
commit f14ecb575360924ecbbf3801f2b0b0e2ff3a2eeb
Author: Heiko Carstens <hca@linux.ibm.com>

s390/pci: Enable CONTEXT_ANALYSIS

This commit enables CONTEXT_ANALYSIS in the s390 PCI Makefile since the
code now compiles without warnings.

> diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
> index 1810e0944a4ed..b8be1316491b8 100644
> --- a/arch/s390/pci/Makefile
> +++ b/arch/s390/pci/Makefile
> @@ -3,6 +3,8 @@
>  # Makefile for the s390 PCI subsystem.
>  #
> =20
> +CONTEXT_ANALYSIS :=3D y
> +

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but since context analysis is being enabled to catch locking issues,
I noticed a missing lock acquisition that it might not be catching.

In arch/s390/pci/pci.c:zpci_remove_reserved_devices():

	list_for_each_entry_safe(zdev, tmp, &remove, entry)
		zpci_device_reserved(zdev);

The function zpci_device_reserved() unconditionally asserts
lockdep_assert_held(&zdev->state_lock). Will calling it here without
holding zdev->state_lock lead to a lockdep failure or state corruption
if accessed concurrently by sysfs or event handlers?


[Severity: High]
This is also a pre-existing issue not introduced by the patch under
review, but there might be a race condition exposed here as well.

In arch/s390/pci/pci_event.c:zpci_event_avail_new_device():

	if (zpci_add_device(zdev)) {
		kfree(zdev);
		break;
	}
	zpci_scan_configured_device(zdev, ccdf->fh);

Once zpci_add_device() publishes the device globally, can concurrent
threads acquire zdev->state_lock and deconfigure the device while
zpci_scan_configured_device() is still running unlocked?

>  obj-$(CONFIG_PCI)	+=3D pci.o pci_irq.o pci_clp.o \
>  			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
>  			   pci_bus.o pci_kvm_hook.o pci_report.o pci_fixup.o

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133627.1216=
607-1-hca@linux.ibm.com?part=3D3
