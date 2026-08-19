Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25F43B492
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134131; cv=none; b=W1yLSTP1edCv6lFP0SUYtHVQXS5wLTtt5fwDVyNJr8Hc+XLRaBwzA8JYNZfjpvLLwWmCOzFrtOug308+Wl6h0CRMqD0QPdaMKYPerwgZQVeLN1v7kYetU0Z48Ri2wIsw+uUiyg517awayq0efdJI4gRJCRtPmFs8xyl+6HYBz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134131; c=relaxed/simple;
	bh=3Uq4GPF+C8ej0oqCuVA7HjZLwj3PeGI4lk3HJOQCAbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cX0qfs4axp8RjggmUGHfAapAMesvY3KR4oQWydOM3icIFqO29ryiLYqNTDBlmGKxxn76EvWjhm+Vh7rfVTxLEnIzXpxAXlS4WKI81JIdWRT9+Crn9yKoM0mEZFd+fSIM+s9764A5kEdYO8vzjKsFEV2f82LQRPAf/oErGI6smUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4WKgPCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4WKgPCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868DB1F000E9;
	Wed, 19 Aug 2026 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787134129;
	bh=oqnD8cBINZNU5fi/l4HvdUkJMArY1lmIgXlObSc62ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4WKgPCzMpSMpWyG5CpWwOfGQngOqxNM24A9/rLoqYty4ASDdpOXtH7CvQUCBepRk
	 SiaXR/kTJrYCrsGPHvcggBBG3tM1QjXKUeT2b/L7KsIf8km6JXEhaEHtQjVOdzr2KB
	 YMPnH7/Ww9DRdq9MhhKYjeuH8bmBI2cWkXkBaMEHImRrPD+bFrrY/MBRKPmu/qKMyc
	 rZvEk3e+V/O7WgtpL5YYsLLg8C8v6R5G5bcM3YCDDUH3b7fvnfh8OWgvSn2CIwNcoj
	 Zpvf+3yowCOQbZeUJGgZtS2IWnKvGrF1XZvfPyGn4NswgUY7WLIl4SiHg2BbTJ9rgl
	 TZOLkRg+TBcWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] s390/pci: Fix missing pci_dev_put() in
 zpci_report_status()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260819-fix_zpci_report_status_pdev_leak-v2-1-da0c4aa7c0ca@linux.ibm.com>
References: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
 <20260819-fix_zpci_report_status_pdev_leak-v2-1-da0c4aa7c0ca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:08:49 +0000
Message-Id: <20260819100849.868DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless TOCTOU and Use-After-Free when accessing `pdev->dev.drive=
r` and `driver->name`.
--

--- Patch [1]: [PATCH v2 1/2] s390/pci: Fix missing pci_dev_put() in zpci_r=
eport_status() ---
commit 81196a1544a6f30ec9381d6aeaf28e9992efad5f
Author: Niklas Schnelle <schnelle@linux.ibm.com>

    s390/pci: Fix missing pci_dev_put() in zpci_report_status()
   =20
    In zpci_report_status() a reference to the struct pci_dev associated
    with the struct zpci_dev being reported about is acquired using
    pci_get_slot(). This reference needs to be dropped with pci_dev_put()
    but this call is missing thus leaking the reference. On subsequent hot
    unplug this will cause the struct pci_dev to not be released leaking
    memory and potentially prevent reattach.

> diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
> index 7030f7052926a..76b8afc146fea 100644
> --- a/arch/s390/pci/pci_report.c
> +++ b/arch/s390/pci/pci_report.c
> @@ -151,6 +151,7 @@ int zpci_report_status(struct zpci_dev *zdev, const c=
har *operation, const char
>  	else
>  		pr_info("Reported PCI device status\n");
> =20
> +	pci_dev_put(pdev);

[Severity: High]
This isn't a bug introduced by this patch, but while we are working with
pdev in zpci_report_status(), is it safe that earlier in this function
we access pdev->dev.driver locklessly?

arch/s390/pci/pci_report.c:zpci_report_status() {
...
	if (pdev)
		driver =3D to_pci_driver(pdev->dev.driver);
...
	buf +=3D scnprintf(buf, end - buf, "driver: %s\n", (driver) ? driver->name=
 : "n/a");
...
}

If a concurrent driver unbind (e.g., via sysfs) clears pdev->dev.driver whi=
le
zpci_report_status() is executing, the to_pci_driver() macro could read
it during a race. The to_pci_driver() macro evaluates its argument twice.
If pdev->dev.driver becomes NULL between these evaluations, it subtracts
the offset from NULL, yielding a large negative pointer.

Can this dereference crash the kernel if driver is a negative pointer from
the race?

Additionally, even if the macro evaluates safely, accessing driver->name
without holding the device lock or preventing module unload could result
in a use-after-free if the driver module is concurrently unloaded.

Could this be triggered by an administrator unbinding a PCI driver
concurrently with a PCI error recovery event?

>  	free_page((unsigned long)report);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-fix_zpci_r=
eport_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com?part=3D1
