Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC94915B5;
	Wed,  7 Oct 2026 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382327; cv=none; b=UnVGZd4CGTiS9JzFfN7fTHJJQOO6p/idg8+OF/eKu8N5GeFqADmq69B6Zau+oTjMCtDnP7nZLwHT2QnEuqiszAN7Vn3wuhU4QTuXX2QZAWKbqJeqBYB8PBHOEvP3qelu+EsCShSNJ8cvTHAG8TDLx5HMyG5Pgb8ZgRu/yJ4W/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382327; c=relaxed/simple;
	bh=mrajy9lGkYBZ/q4kHLTflkuphCi33X30fKp0yhvnexU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UvCYywe4hjGrTvFGQpfG5olWDK4IEQnsqx+PglyPgGGt+mefLoSjIRqDum5HkGeG/X5KVhLO31tO/QY+ZFUe9/wdL9FZk+ZnrykLdYzsKPWZKrydryfyly/lQ4Eg7Oev4MWfYL0C6Jnt2cPGZmedkZdBBCZYuQKJzQtl18WMi68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeDRLTTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeDRLTTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2221F0089B;
	Wed,  7 Oct 2026 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382318;
	bh=wJ1iK3cyTjeG9zLHOBlmNpSp7xRS1aANtii1S+jXrSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OeDRLTTMC2Ubgv1GLJdA6fZmXoq76f0R8cCt6sbATm0nuR7Zt//+65ycI4U4bPDRr
	 Z5U0hB8ILr6Tre5gyR87MOhzr1c7cIINWtPksCU4HPGKgrjvC3eNKETbvtVdj0RKnA
	 Rl9ElDiHvRy1qGNN6knguxWif81YeNTxZvzBY/8qFML4mAtePMejdp3FIYznAivOiR
	 GGk2ZB0gBEsd8loi4y/EqJUKOcCle1Hawv3WWg6IMnNz+YAxCBF654WIBnwogOMlt2
	 3hKNlSsjVHev+VXt8GgG/XhkIUohcjO0BqOcEcTGsxzT66EjkpDQTPuHbhqqVKqezj
	 nVeHNvZDIXxaA==
Message-ID: <sashiko-outbox-163090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261007135926.82935-3-oelghoul@linux.ibm.com>
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
 <20261007135926.82935-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 14:11:57 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: NULL pointer deref in pci_perf_show() if FMB allocation fails
- [High] s390/pci: NULL pointer deref if FMB allocation fails during enable
--

commit edcda811c60da07b857039d32e74cbe9c76de00e
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Reuse FMB buffer and preserve state in device re-enablement

Don't free the FMB buffer when disabling measurement in
zpci_fmb_disable_device(). Instead, make the buffer persistent for the
lifetime of the device and reuse it across enable/disable cycles. Defer
freeing the buffer until teardown in zpci_release_device().

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index c055a9ad09724..bda91d79bafdc 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -167,43 +167,13 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 =
dmaas)
>  /* Modify PCI: Set PCI function measurement parameters */
>  int zpci_fmb_enable_device(struct zpci_dev *zdev)
>  {
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
> +	if (zdev->fmb_requested || sizeof(*zdev->fmb) < zdev->fmb_length)
>  		return -EINVAL;
> =20
> +	zdev->fmb_requested =3D true;
> +	return zpci_fmb_reenable_device(zdev);
>  }

[Severity: High]
If zpci_fmb_reenable_device() fails, is zdev->fmb_requested left set to
true? If the allocation in zpci_fmb_reenable_device() returns -ENOMEM, it
appears this state change is not rolled back.

[ ... ]

> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
[ ... ]
> +	if (!zdev->fmb) {
> +		zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
> +		if (!zdev->fmb)
> +			return -ENOMEM;
> +	} else {
> +		/* reuse the same FMB buffer for as long the zdev lives */
> +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
>  	}

If kmem_cache_zalloc() fails here, zdev->fmb remains NULL, but the caller
zpci_fmb_enable_device() has already set zdev->fmb_requested =3D true.

> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index c7ed7bf254b5e..9a960310d4ddf 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
>  		return 0;
> =20
>  	mutex_lock(&zdev->fmb_lock);
> -	if (!zdev->fmb) {
> +	if (!zdev->fmb_requested) {
>  		mutex_unlock(&zdev->fmb_lock);
>  		seq_puts(m, "FMB statistics disabled\n");
>  		return 0;

[Severity: High]
If fmb_requested is left true after an allocation failure, can this
lead to a NULL pointer dereference here?

Since this check now relies entirely on fmb_requested rather than checking
if zdev->fmb is actually allocated, it seems like pci_perf_show() will bypa=
ss
this early return and proceed to dereference the NULL zdev->fmb pointer
further down:

arch/s390/pci/pci_debug.c:pci_perf_show() {
	...
	/* header */
	seq_printf(m, "Update interval: %u ms\n", zdev->fmb_update);
	seq_printf(m, "Samples: %u\n", zdev->fmb->samples);
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007135926.8293=
5-1-oelghoul@linux.ibm.com?part=3D2
