Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1712E401
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202585; cv=none; b=GLIz5rPSfJs4+pc6UX08XpgXmYn5IYaZRtWmB68pq2dJrAPicsq+xwtUE04e4xwTBCi6uEcToOksvUSHa3AeuyeDHCUtoQEf/nrTNYySeLblw435GpEuLyVAcdfkNNM6vvBZqL7UMxJcCnts6eK5zODftKOSYznqsnaFzFUgVCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202585; c=relaxed/simple;
	bh=ulRs7oKQWSXx2Bzw2pVnAONXovIZM07mtQBMsi+HF6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GEnKfzxwo6EMuYEvTlj5TUqrmEnAAwmIUagr+5QREaD/3SAKT7IjYdYtECTWYCNgaC0zwDUkOiQx4fEuqnggWaC9WJjNX1jyLbPG4jNzrSzKlE6NKBp5fIY7nXQGLsClFAg5/EFiw58GC3lVJ8DvIhPiKCppJKB3LM99rxkkgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMsoEVSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMsoEVSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B38B1F000FF;
	Mon,  5 Oct 2026 12:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202584;
	bh=jY60CubYDIvkkmaRqO1Gjqw8cgjcMIpXCN5Aitoer/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMsoEVSbo0Za79wsrhqhgmIG5Oe/zu40B0iiUpGj9gyVyogjy3MPpo/+3+0YizKIH
	 AagWdkYzgwHC7KV4/uDXhR07yMBiUBi8b/6fCPwPcvCFxwKXb7bWO/Jm0ANt5hztUl
	 0m2VtHSaCXlOI0cQWC2YHGGKW6c1SW8vp0uhp0yZPaO+RBglckrfnibS+doUk6Bx6W
	 0F4mL8ue6CAFID/W57TzvZOjGTEe5iomgjSBpF106mLK25xD0Ul5X173D+8gst/9MD
	 +YBfdyxItQMNHb/sdFML8BIwSbdXcLrpu5j8VUBQcuU3kBS4tzIGn0UXehUN9frM9q
	 RuWqd8v1r0kCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] s390/pci: Add error cleanup in
 zpci_directed_irq_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-5-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-5-d45b824874c0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:16:23 +0000
Message-Id: <20261005121624.3B38B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] s390/pci: hardware use-after-free via dangling DMA pointer on init=
 failure
- [Low] mm: unnecessary complex error handling for __init memory allocation
--

commit 3f6f1514864f283bcc9b6097b32ff020d51e4124
Author: Tobias Schumacher <ts@linux.ibm.com>

s390/pci: Add error cleanup in zpci_directed_irq_init

If per-CPU airq_iv allocation fails in the loop, previously allocated
vectors and arrays leak. Add proper error path to release all resources
on failure.

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 81a27bf756a3a..682bceb6525e2 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c

[ ... ]

> @@ -576,7 +576,7 @@ static int __init zpci_directed_irq_init(void)
> =20
>  	zpci_dibv =3D kzalloc_objs(*zpci_dibv, num_possible_cpus());
>  	if (!zpci_dibv)
> -		return -ENOMEM;
> +		goto out_free_sbv;
> =20
>  	for_each_possible_cpu(cpu) {
>  		/*
> @@ -589,13 +589,25 @@ static int __init zpci_directed_irq_init(void)
>  						AIRQ_IV_CACHELINE |
>  						(!cpu ? AIRQ_IV_ALLOC : 0), NULL);
>  		if (!zpci_dibv[cpu])
> -			return -ENOMEM;
> +			goto out_free_dibv;
>  	}
>  	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
> =20
>  	zpci_irq_chip.irq_set_affinity =3D zpci_set_irq_affinity;
> =20
>  	return 0;
> +
> +out_free_dibv:
> +	for_each_possible_cpu(cpu) {
> +		if (zpci_dibv[cpu])
> +			airq_iv_release(zpci_dibv[cpu]);
> +	}
> +	kfree(zpci_dibv);
> +	zpci_dibv =3D NULL;

[Severity: Low]
Since zpci_directed_irq_init() is an __init function, is this complex error
handling for early boot memory allocation failures necessary?

Functions executed only early in the boot process generally do not need to
handle memory allocation failures gracefully, as physical memory should be
available and a failure typically means the system cannot boot anyway. This
could be unnecessary dead code.

> +out_free_sbv:
> +	airq_iv_release(zpci_sbv);
> +	zpci_sbv =3D NULL;
> +	return -ENOMEM;

[Severity: High]
Does this error path leave a dangling physical memory address programmed in=
to
the hardware?

Earlier in zpci_directed_irq_init(), the hardware is programmed to use the
physical address of zpci_sbv->vector:

	iib.diib.disb_addr =3D virt_to_phys(zpci_sbv->vector);
	zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);

If a subsequent allocation fails and we take this out_free_sbv path, zpci_s=
bv
is freed without unregistering the address from the hardware. Could a
subsequent spurious adapter interrupt cause the hardware to write to the fr=
eed
memory and corrupt it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-s390_irq_d=
omain_fixes-v2-0-d45b824874c0@linux.ibm.com?part=3D5
