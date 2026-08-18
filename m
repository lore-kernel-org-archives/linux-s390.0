Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E715364052
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081809; cv=none; b=um60UIe29GcTcTI+BDm4v0pQ0Hl8mbE1ISKt8k7DnuGECkbHwjhVOtgIHSbygoDSSf4pw24Zdw6EcLW2ZryVPOyWlKPdt+qatxlNdXlIaBTSqVo0vT7UUSVCQpGmcEUw4n6BK0gkOC2HJBsofkWx+DFWblIAOv19h2iCRxf4TWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081809; c=relaxed/simple;
	bh=A+Jhwt6pVT6bhc/fdxdwdJa9l8LdGZKIyZgxdNDwS2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qTDHixBIzaHOBMovGPml3bBWJSVZgiGQNryj67hzYbITROzWyTU3dt6PH/YBsGrI1cCeYLfWdjthT+VphEwzWG9AUZvCaQqbdoJMkKMgRHAKwYCSreozTD0dpnzuPcylSFnbTLVA8cgsYxTixXPHEv+KsMjo7gaqapedWBeI9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMmjVDSy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMmjVDSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F246E1F000E9;
	Tue, 18 Aug 2026 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787081808;
	bh=YWqJFoXl+9J9zRUtHMjJe4BPRLuZJvi6sWkJmirerOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMmjVDSygWvAxcKfAjGsnFnysDbCoPiRlRuiqsgPXp9rCO6ea7tkU5pjrxi+MbhDd
	 +yuB6NGol27VatlzaarT7HLbGYAGOCZ2e1T8LlOpbEi9KdlPDU4zXlnIrIWn8TXBd6
	 orsu3nNJx6uONkDs9IO+gUGyn/3j6+zmh5uXz+KqtM5/GIuOFwbqQwsiGzxY51uL3w
	 7bs0ZU+g3MC8EXClfu64qJ+cAGxUbpi+OL1PiKMxDHLWT7njSL5iG3QDYqzB+h8Mjv
	 M4T70Y4bCXCffYzQ482Hxmu+ubbCrAAa6BN83Du4NA6L8waIiDHp10BbfXw2Aultm5
	 lL4+F7EywUTRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/pci: Fix missing pci_dev_put() in
 zpci_report_status()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818-fix_zpci_report_status_pdev_leak-v1-1-576520f4d068@linux.ibm.com>
References: <20260818-fix_zpci_report_status_pdev_leak-v1-1-576520f4d068@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 19:36:47 +0000
Message-Id: <20260818193647.F246E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `pdev->dev.driver` and double-fetch (TOCTOU) le=
ading to a kernel panic or use-after-free
--

--- Patch [1]: [PATCH] s390/pci: Fix missing pci_dev_put() in zpci_report_s=
tatus() ---
commit 22a605e88c1bebfc9551790e5d42753aee881365
Author: Niklas Schnelle <schnelle@linux.ibm.com>

s390/pci: Fix missing pci_dev_put() in zpci_report_status()

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
This isn't a bug introduced by this patch, but is there a potential race
condition earlier in this function when accessing the driver name?

In zpci_report_status(), pdev->dev.driver is read locklessly:

	if (pdev)
		driver =3D to_pci_driver(pdev->dev.driver);

The to_pci_driver() macro evaluates its argument twice. If a concurrent
driver unbind clears pdev->dev.driver between these evaluations, it could
pass NULL to container_of_const(), yielding a bogus negative pointer offset.

This pointer is then dereferenced later in the function:

	buf +=3D scnprintf(buf, end - buf, "driver: %s\n",
			 (driver) ? driver->name : "n/a");

Because the negative pointer offset is non-zero, this check would falsely
evaluate to true and dereference the invalid pointer, which could cause a
page fault.

Even if the macro evaluates safely, pci_get_slot() does not pin the driver
module. Could this result in a use-after-free when reading driver->name
if the module is unloaded concurrently?

It appears the caller explicitly drops the device lock before calling this
function:

arch/s390/pci/pci_event.c:zpci_event_attempt_error_recovery()
	...
out_unlock:
	device_unlock(&pdev->dev);
	zpci_report_status(zdev, "recovery", status_str);

Would it be safer to protect this access to prevent concurrent unbinds?

>  	free_page((unsigned long)report);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-fix_zpci_r=
eport_status_pdev_leak-v1-1-576520f4d068@linux.ibm.com?part=3D1
