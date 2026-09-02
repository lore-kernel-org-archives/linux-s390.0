Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C637881D;
	Wed,  2 Sep 2026 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330489; cv=none; b=qjgPOU2BH7FNo8A/f7AOL6EWBqMNB9cZEiIlkybyZqyFnt3JtiF+ib6ePSSWB9LZKF1AtIAxfsqZt1anpA7oUPjuukyaL8rru3AqShRFaBefzMztxjl6Lo8oDupgOFw2DHetRhsB+JVDimqXbmmVpSJBmXWd+GyESJMOBijOziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330489; c=relaxed/simple;
	bh=q2I5CDQh9TA+VI9hf8JYsPR6dSyaNpmEaREbJExDekg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YeY8acl0O5a4RoQ2jpYrkiWThCvLQZKKFZZQhRhwIQa0wAo9jMhwbRiQVK6bGgtj0upfDS1hsEGIwz+Y2xoiL/4PgG8tkE69Nj9D8sWM0Lz4JQFt7ndb3Aa20aEmrV+BVXgXWqyXOIql6MMHSioiLe6FHeHCfXHxkR7y0W+hJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTTVaP5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTTVaP5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D381F000E9;
	Wed,  2 Sep 2026 06:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788330487;
	bh=zUgCURL6YmB+rlRFNdTFkS/+ZDRj2unAWpWo6zKpA7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTTVaP5el2Gq0AyaLbIhh31hssUGpFcncdv/+/Pnx66K2j7rL8s0obZltiLGOyYdM
	 Uyzrw6pvbUgdmDeMFUHiL0axxR7GGG6k/X9mOuwhWXAy2dXGRh5xrRvJFH3CYNgJxt
	 /5BZCbzAJzVmxaCAusLk6LeNNbQNKDi+LJ7KbBp/uEHJMzQOzWUq4/9KVat7J+e+LM
	 I172LX+wGcrssD2ExBW4cGosRSgQ8MLA1L3mSp+d/JyCF6A9yuDBf8oHz9czZTGQBs
	 pufVbO6Fgzsz6nH7YPcsBQ2QxQddTgN6uaVsHrUwLQRYqjS1NAjdL382kFSXXRVCDY
	 NNAXLl0PfKeoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for the GIB
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260902-s390-kvm-v1-3-3bc0986550b1@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
 <20260902-s390-kvm-v1-3-3bc0986550b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:28:06 +0000
Message-Id: <20260902062807.25D381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Hardware Use-After-Free due to missing `chsc_sgib(0)` on `kvm_=
s390_pci_aen_init` failure path.
- [High] Race condition in `kvm_s390_gib_init()` error path leading to a NU=
LL pointer dereference.
--

commit b7e0a2c7fc946fc151e2d875aa6df00a71151750
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
Subject: KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB

This commit replaces the use of get_zeroed_page() with kzalloc() and
free_page() with kfree() for the guest information block (GIB) allocation.
It notes that kmalloc() guarantees page alignment for power-of-two sizes,
making it suitable for this buffer without requiring direct page allocator
access.

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

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition in
this error path in kvm_s390_gib_init().

When chsc_sgib() fails, the code frees gib and sets it to NULL. However,
this happens before calling unregister_adapter_interrupt(&gib_alert_irq) at
the out_unreg_gal label.

Since the interrupt handler is still registered and active, if another devi=
ce
sharing the same ISC triggers an interrupt during this window, could
the gib_alert_irq_handler execute and call process_gib_alert_list()?=20
If it does, it looks like it will unconditionally dereference the NULL gib
pointer.

>  		rc =3D -EIO;
>  		goto out_unreg_gal;

[ ... ]

> @@ -3742,7 +3742,7 @@ int __init kvm_s390_gib_init(u8 nisc)
>  out_unreg_gal:
>  	unregister_adapter_interrupt(&gib_alert_irq);
>  out_free_gib:
> -	free_page((unsigned long)gib);
> +	kfree(gib);

[Severity: Critical]
This is also a pre-existing issue, but does this cleanup path result in a
hardware use-after-free if kvm_s390_pci_aen_init() fails?

In kvm_s390_gib_init(), if the GIB is successfully registered with the
hardware via chsc_sgib(gib_origin), but the subsequent call to
kvm_s390_pci_aen_init() fails, the code jumps to out_unreg_gal:

	if (kvm_s390_pci_interp_allowed()) {
		if (kvm_s390_pci_aen_init(nisc)) {
			pr_err("Initializing AEN for PCI failed\n");
			rc =3D -EIO;
			goto out_unreg_gal;
		}
	}

This skips calling chsc_sgib(0) to tear down the hardware registration.
When we reach out_free_gib and free the memory backing the GIB, doesn't
the hardware AIV facility still retain the physical pointer to the freed
memory?

>  	gib =3D NULL;
>  out:
>  	return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-s390-kvm-v=
1-0-3bc0986550b1@kernel.org?part=3D3
