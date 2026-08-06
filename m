Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC630C637
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021869; cv=none; b=HrUanSidEPIr8piBmFbg5akZB8VRVe1ffcsBN6Uk64khwnGPa2b+3EZx+yWETmtkLMHcV/cW0L9H78atk7w1BKxsvzhAR5V68IjYD8GaLiZXjW2/B3ApSXGGRidQKBsk50cujkzPSAB+utvaAbOrmudzH+gEG9Dcbc1L7mdhEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021869; c=relaxed/simple;
	bh=mmmhDjdXQVvNNR+qeUiM0eaprSknxf7rCFQjYb+osMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p2YGbTG+VEFV8yQ9xbA5Bp5/sIdOrNULVBOKWuc9KaYdCLZCggxcXXJfbZu/bFRnne2xGSd2avQeHdJyvUvgS10cZz2ncfCGcVyHYZwfbQkWPC/IyC8z74bgrDfRjjnD3w8XBULNZf/PsW819/qkxUYaYVkIUwLiSmblXQxxea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td3hdhk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td3hdhk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077EC1F00A3A;
	Thu,  6 Aug 2026 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021866;
	bh=wjBcUN4vN4JhKQN1yjmIxEm1YudxDbzkuodFuYqu54s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Td3hdhk6Op63LO97EKXYLFDztFZOq+1/TvrGVfXqfDU1IiZh1VSDMD/J4ju73MF10
	 IWL5oZ3Dv/Xh7Qx399l/JmolbHlgmXMoFeXWjKFLSzYa5Lq5W3/5eVfusK3MqMhV1u
	 oDHlSYvcW1sTz9IH8bsMj6TyZRTO9Lwk8YfHqRxCgcWSwpdeKK8yOhibhTm+CtSmPX
	 Q5WeokgXFIwSbTzFcaZ+p4nub2Kc37uwAw0nXgZ8YqPIy6LSekf91IMiPB0QdlThJ4
	 iEIfp7iYdEqvRd2+jUcSx8/H6udz9tXp1EAdJ56lbmPc6OHa/6zUkd29Jug276KpUl
	 7wH98DZoesZHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] s390/ism: Fix UAF of sba and ieq during
 ism_dev_exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandra Winter" <wintera@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805131043.954639-1-wintera@linux.ibm.com>
References: <20260805131043.954639-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:11:05 +0000
Message-Id: <20260806131106.077EC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The patch unconditionally frees DMA memory even if the firmwar=
e command to unregister the structures fails, potentially causing the hardw=
are to perform DMA into freed pages.

Pre-existing issues:
- [High] Incomplete fix: The `ism_dev_init()` error path frees the SBA data=
 structure before unregistering the interrupt handler, preserving the Use-A=
fter-Free/NULL pointer dereference race condition.
- [High] The interrupt handler is registered before the DMA structures it d=
epends on are fully initialized, leading to a possible NULL pointer derefer=
ence on early/spurious interrupts.
--

--- Patch [1]: [PATCH net] s390/ism: Fix UAF of sba and ieq during ism_dev_=
exit() ---
commit b7d428b60205e305c1f2fbb4f8ba1ff2da436f6f
Author: Alexandra Winter <wintera@linux.ibm.com>

s390/ism: Fix UAF of sba and ieq during ism_dev_exit()

This commit fixes a use-after-free race condition in the device teardown
path by draining ongoing interrupt handlers before freeing the internal
shared memory data structures.

> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -148,13 +148,16 @@ static int unregister_sba(struct ism_dev *ism)
>  	if (ret && ret !=3D ISM_ERROR)
>  		return -EIO;
> =20
> +	return 0;
> +}
> +
> +static void ism_free_sba(struct ism_dev *ism)
> +{
>  	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
>  			  ism->sba, ism->sba_dma_addr);
> =20
>  	ism->sba =3D NULL;
>  	ism->sba_dma_addr =3D 0;
> -
> -	return 0;
>  }

[ ... ]

> @@ -585,9 +592,13 @@ static void ism_dev_exit(struct ism_dev *ism)
>  {
>  	struct pci_dev *pdev =3D ism->pdev;
> =20
> +	/* ism will only generate new IRQs while ieq & sba are registered */
>  	unregister_ieq(ism);
>  	unregister_sba(ism);

[Severity: Critical]
If unregister_ieq() or unregister_sba() fails (returning -EIO) due to a
hardware or firmware error, the device may still be active and performing
DMA to the SBA or IEQ memory regions.

By separating the free operations and calling them unconditionally here,
could we be returning active DMA pages to the kernel allocator, leading to
memory corruption?

> +	/* drain ongoing irpt handlers */
>  	free_irq(pci_irq_vector(pdev, 0), ism);
> +	ism_free_ieq(ism);
> +	ism_free_sba(ism);
>  	pci_free_irq_vectors(pdev);
>  }

[ ... ]

> @@ -573,6 +579,7 @@ static int ism_dev_init(struct ism_dev *ism)
> =20
>  unreg_sba:
>  	unregister_sba(ism);
> +	ism_free_sba(ism);
>  free_irq:
>  	free_irq(pci_irq_vector(pdev, 0), ism);

[Severity: High]
This is a pre-existing issue, but I noticed the error path here frees the
SBA data structure before calling free_irq().

If register_ieq() fails during initialization, could a concurrent interrupt
fire after ism_free_sba() but before free_irq(), causing ism_handle_irq()
to dereference a NULL ism->sba pointer?

Additionally, this is another pre-existing issue, but looking earlier in
ism_dev_init():

ism_dev_init() {
    ...
    ret =3D request_irq(pci_irq_vector(pdev, 0), ism_handle_irq, 0,
                      pci_name(pdev), ism);
    if (ret)
        goto free_vectors;

    ret =3D register_sba(ism);
    ...
}

[Severity: High]
Since request_irq() enables the interrupt handler before register_sba()
allocates and assigns the data structures, what happens if an early or
spurious MSI interrupt fires during this window?

Will ism_handle_irq() unconditionally dereference the uninitialized
ism->sba pointer upon entry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805131043.9546=
39-1-wintera@linux.ibm.com?part=3D1
