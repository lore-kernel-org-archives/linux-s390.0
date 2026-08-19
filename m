Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667E3E832B
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130159; cv=none; b=tnC3ekPAkJFQKHUpKdnC5lId904DWa7gS0b2CmpbcJkfDGSk1w4h3ULO9InmUpw+0Ih1VfRUqRMWD+3tQbA79kNcRDRDfEXRd5tXMy3q3mdb3iYPgVTUrQkOalbGEHlV/k3OFJn5Qa5CHklQTHTNZkjU0fKCDCyEbFi3w9FZUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130159; c=relaxed/simple;
	bh=RuK/KNe6ECf6rd/x/d8ttnpi61snvPyYeZJATg4+/70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovobc20ToYxXv4Z8kAviqeG/tCXl0jYQhPoSV9t7HHZMYplivR0j2/eoj/yrjU9QzmZBqAbA1JZnZQcKGKrfxq3NsK1O86m5K9TUhWuAF6fi0GUQM2wiicNdydUX60/1we9MzA7WIfqcfJvhpY/g/5crRDe5rvT+jC27fpX93hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI9c8KY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI9c8KY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61621F00A3A;
	Wed, 19 Aug 2026 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130158;
	bh=BNjMsmrO4vI18cvFuPGpXOH/ldFWzd3Qpg0oUWaDwHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kI9c8KY7KMEhN6kyErz1nIdj4f+BP1zVQJ4Qj0KjLPUv5u/8aaAVRW60HDd2ehdAO
	 mdC9l+WfYcrFFSjL6e3Fs2YXKhCEQ/aaukg1yPvQl/6XNxfoYku5gHKmrOh8YTwWf8
	 7dK16LXf/35xD4Kao86aV1NJVwNRhWLBAYZiE5jBk1ScDSVWn6rOCkp1wt4bXL3KMP
	 r+5VgfWJe6SqULJbThqc7q8HZ1PDW9qUiQXB4xeveldb8QJqAwSpkq+nn3lQV+Br8h
	 p7VSp1BiAogfZXhSlZ0J7o8t/Xf7B/+9KS317jWGVNCJvvE0i6mnxGPvol1rn4Xygk
	 jtwRV+uNeTYvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] s390/pci: add error cleanup in
 zpci_directed_irq_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-6-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-6-826ff27b6e97@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:02:37 +0000
Message-Id: <20260819090237.E61621F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added error cleanup path in `zpci_directed_irq_init` int=
roduces a DMA use-after-free vulnerability.
--

--- Patch [6]: [PATCH 6/7] s390/pci: add error cleanup in zpci_directed_irq=
_init ---
commit 5a0360870b410d13391fe09d0a8840ffaa9cb9be
Author: Tobias Schumacher <ts@linux.ibm.com>

s390/pci: add error cleanup in zpci_directed_irq_init

This commit adds an error cleanup path to zpci_directed_irq_init to release
airq_iv resources if per-CPU allocation fails, preventing a memory leak.

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 1515d8d7460ea..1ddf6b3625a26 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -586,7 +586,7 @@ static int __init zpci_directed_irq_init(void)
> =20
>  	zpci_ibv =3D kzalloc_objs(*zpci_ibv, num_possible_cpus());
>  	if (!zpci_ibv)
> -		return -ENOMEM;
> +		goto out_free_sbv;
> =20
>  	for_each_possible_cpu(cpu) {

[ ... ]

> @@ -599,13 +599,25 @@ static int __init zpci_directed_irq_init(void)
>  					       AIRQ_IV_CACHELINE |
>  					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);
>  		if (!zpci_ibv[cpu])
> -			return -ENOMEM;
> +			goto out_free_ibv;
>  	}
>  	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
> =20
>  	zpci_irq_chip.irq_set_affinity =3D zpci_set_irq_affinity;
> =20
>  	return 0;
> +
> +out_free_ibv:
> +	for_each_possible_cpu(cpu) {
> +		if (zpci_ibv[cpu])
> +			airq_iv_release(zpci_ibv[cpu]);
> +	}
> +	kfree(zpci_ibv);
> +	zpci_ibv =3D NULL;
> +out_free_sbv:
> +	airq_iv_release(zpci_sbv);

[Severity: High]
Does this new error path introduce a potential DMA use-after-free?

Just before the allocation of zpci_ibv, the hardware is configured with the
physical address of zpci_sbv->vector:

arch/s390/pci/pci_irq.c:zpci_directed_irq_init() {
    ...
    iib.diib.disb_addr =3D virt_to_phys(zpci_sbv->vector);
    zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);

    zpci_ibv =3D kzalloc_objs(*zpci_ibv, num_possible_cpus());
    if (!zpci_ibv)
        goto out_free_sbv;
    ...
}

If we jump to out_free_sbv and free zpci_sbv via airq_iv_release(zpci_sbv)
without resetting the hardware configuration first, could the adapter
corrupt memory by writing to the freed physical page during a spurious
interrupt?

Would it make sense to either defer the zpci_set_irq_ctrl() hardware
configuration until all software allocations succeed, or unregister the
hardware in the out_free_sbv error path?

> +	zpci_sbv =3D NULL;
> +	return -ENOMEM;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-s390_irq_d=
omain_fixes-v1-0-826ff27b6e97@linux.ibm.com?part=3D6
