Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4834F27F;
	Sun,  6 Sep 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683843; cv=none; b=YbEUFcB8lJ5D9kggG1pCqulH+j4laoKWtOUtaB7UP2aq7zs00PLIwQidVOgzM156RdvCt5jhxgZaKrjVaMq9OPbcpzRjDrT1ERseI8wDJYglSK/xp/oJE11jkYD2L9UBxFjIvYr3UDK6SacCABklpP5rm6BeRWHk449t3BSrxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683843; c=relaxed/simple;
	bh=rgGFPavW/nymHSFpw3YP+r7EVsIM84TOOR6FIbM75Ws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S63/6rSolwH4ijjdWCCQ7Q0rXCfqHLVz+02wVAb3tIMEmYP44zxH5IqoQy3/5FhHg/ODEuCXQcG0BNj7fl/wHHJLD2jOKMM/UEqjpDtrZH3Zehnb5RsZemCo/OudtENlWmzwlE3qn8s8snLE1rJ45i+Gd2pLyjsqzf0bXgivkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWkqrdcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWkqrdcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D531F00A3A;
	Sun,  6 Sep 2026 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788683842;
	bh=sLctfuOzV1ScQJYQxYKUiuhYs2ssWw07E+lWpvbiOGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mWkqrdclIZNFFPIO6Yph9PF0FzF9fvWVYcFtPvww75AyZCxrTkBcYUNrxYB7xCYHJ
	 cMol3tsMiQI21WYNd2+Rd9VVuHWrmGd9CWeJOViXWEQk64C96dt0N4RJBdMFvX2uXN
	 OQ+K7877DneQalIMbFE827LMduHKRWPRF01SQ3V++9REG+PMyBBHiahjRMi9efJ+FW
	 Z4OPLhE0GUaOZqEgdPEpyULYDqormEI8IPEFBV3HeFGCAlJG+OJv8lbm9n1EMZytvN
	 sSflwgAetnpC7PtMjRQqdUZoWO2WIHLv4/v+9IvYeqWozenEYwBY/3MOSZJLSD2oj9
	 u0hf6/px5xsaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] KVM: s390: Replace get_zeroed_page() with
 kzalloc() for the GIB
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260906-s390-kvm-v2-3-2cf6434e6646@kernel.org>
References: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
 <20260906-s390-kvm-v2-3-2cf6434e6646@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 08:37:21 +0000
Message-Id: <20260906083721.B9D531F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing hardware teardown (chsc_sgib(0)) on PCI AEN initialization=
 failure, causing a hardware Use-After-Free.
- [High] Premature free and nullification of `gib` creates a race condition=
 leading to a NULL pointer dereference in the adapter interrupt handler.
--

commit 507ef89f01184c6a51cfce1ef86dd6ded4bac518
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB

This patch replaces get_zeroed_page() with kzalloc() for the guest
information block (GIB) allocation, as the size is a page and it does not
strictly require the page allocator directly. It also updates the cleanup
paths to use kfree() instead of free_page().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrup=
t.c
> index 0381ae9817035..02065fb8d053e 100644
> --- a/arch/s390/kvm/s390/interrupt.c
> +++ b/arch/s390/kvm/s390/interrupt.c

[ ... ]

> @@ -3722,7 +3722,7 @@ int __init kvm_s390_gib_init(u8 nisc)
>  	gib_origin =3D virt_to_phys(gib);
>  	if (chsc_sgib(gib_origin)) {
>  		pr_err("Associating the GIB with the AIV facility failed\n");
> -		free_page((unsigned long)gib);
> +		kfree(gib);
>  		gib =3D NULL;
>  		rc =3D -EIO;
>  		goto out_unreg_gal;

[Severity: High]
This is a pre-existing issue, but does nullifying gib here before
unregistering the adapter interrupt create a race condition?

If the chsc_sgib() call fails, the error path prematurely frees gib and
sets it to NULL before jumping to out_unreg_gal to unregister the interrupt.
Between setting gib to NULL and the completion of
unregister_adapter_interrupt() (which waits for active handlers via RCU),
the interrupt handler remains active.

If an adapter interrupt fires on the shared ISC during this window,
gib_alert_irq_handler() is invoked and calls process_gib_alert_list().
This function unconditionally executes xchg(&gib->alert_list_origin, ...),
which would dereference the NULL pointer.

[ ... ]

> @@ -3742,7 +3742,7 @@ int __init kvm_s390_gib_init(u8 nisc)
>  out_unreg_gal:
>  	unregister_adapter_interrupt(&gib_alert_irq);
>  out_free_gib:
> -	free_page((unsigned long)gib);
> +	kfree(gib);
>  	gib =3D NULL;
>  out:
>  	return rc;

[Severity: High]
This isn't a bug introduced by this patch, but does the error path here
forget to detach the GIB from the hardware?

In kvm_s390_gib_init(), if chsc_sgib(gib_origin) successfully registers the
GIB with the hardware, but kvm_s390_pci_aen_init() subsequently fails, the
error path jumps to out_unreg_gal.

This path frees the gib memory but fails to call chsc_sgib(0) to revoke
hardware access (unlike kvm_s390_gib_destroy() which correctly does so).
The hardware retains the physical address of the freed memory and might
continue to access it, resulting in a hardware use-after-free and potential
memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-s390-kvm-v=
2-0-2cf6434e6646@kernel.org?part=3D3
