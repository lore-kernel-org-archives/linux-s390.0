Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1649CF39;
	Fri, 25 Sep 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341196; cv=none; b=qQ5wrAvS3FCwKC6+U52LoiLD1uktNZ+pzMMtvZd4f8tTszHMHrW6tfWY/szbQSXHUEspVILUt5Bdm2KZ+rD0RQO2opHJtmuIxGJYV8vr6lb5w1qIhg7GVTlOE7wMm1VSGH2/zJt1u8TEsyCRp97/UAjmgEypCzRVTtMjmpnceMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341196; c=relaxed/simple;
	bh=JedtBopJ5YW/Ih/XS69Ytluv6ZfOMgMyFdSzpBoTdbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZiSAQiH7hHggzpVW627weHKoUnrQRPWPJRDT+/rLbxWSXWyADvr1PLUcsos4AtRk4xaYnChW9RS7aYIEbJVGCw87nff1N5uUTDMycGs9rPZRY9BV+3GSiol7SFLVC81l2hHsk2puri1zOesXV18z4tjmEw3m3wXHCW0E6RMqbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyCErHx4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyCErHx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFAA1F00893;
	Fri, 25 Sep 2026 12:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341194;
	bh=zPhcui6w8pl756gc0CcsOusp+gQ16G7RhqFH5EnJe14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jyCErHx4egCNjvYfv6CgeWVnOFTV9Vejp+lC5I10Icc5rTVVNrCmc/Fg2amXtFNYS
	 CtntgjZra0D2RcciISlpujLAOSMWCgplgyZoHo6xxYt+4l5aOJpXm+DtPO1sr7nRzb
	 9iHOz1xzx8nQzpcrDbvBSjpeCPPjr6t2SrdF6WRZi8TvGb7cna2AdmHcixJ882wcFL
	 A5ucRDlcNXkFNCa7Sf6+i3bDs5Wv7jt9RnTRSBTPlaKjGsds7r8N6Dp8YmBW68MwQK
	 lxMtN8RDZDpB83qoYEZ33+Du/1M7fm0zRMAK7F/P3JFvxzWJ3ON5fGAk2KaV2jnRKL
	 ZHP4j7CLe0FZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] s390/vfio-ap: replace guest-reachable WARNs with
 ratelimited warnings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260925124551.665448-7-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 12:59:53 +0000
Message-Id: <20260925125953.DAFAA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] s390/vfio-ap: NULL pointer deref in vfio_ap_free_aqic_resources()
- [Low] s390/vfio-ap: format specifiers truncate DMA addr and corrupt log
--

commit bb0d1a9a828269662641d7a1b6f445a55a9d0e1d
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: replace guest-reachable WARNs with ratelimited warnings

WARN and WARN_ONCE macros in code paths reachable by a guest
can be triggered repeatedly by a malicious or misbehaving guest,
flooding the kernel log and potentially impacting system
stability. Replace all WARN and WARN_ONCE calls reachable from
the guest AP interrupt enable/disable and queue reset paths with
ratelimited warning functions.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index cd4a436c43194..4b6e64daed253 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> +static void report_gisc_unregister_failure(struct vfio_ap_queue *q)
> +{
> +	if (q->matrix_mdev) {
> +		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
> +				     "APQN %02x.%04x: Failed to unregister guest ISC %c\n",
> +				     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
> +				     q->saved_isc);

[Severity: Low]
Could this result in missing or mangled information in the kernel log?
The guest ISC is printed using %c, which will output a non-printable ASCII
character for the numeric value, rather than the integer itself.

> +	} else {
> +		pr_warn_ratelimited("APQN %02x.%04x: Failed to unregister guest ISC %c=
\n",
> +				    AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
> +				    q->saved_isc);
> +	}
> +}
> +
> +static bool verify_free_aqic_resourcers(struct vfio_ap_queue *q)
> +{
> +	bool verified =3D true;
> +
> +	if (q->saved_isc !=3D VFIO_AP_ISC_INVALID &&
> +	    !(q->matrix_mdev && q->matrix_mdev->kvm)) {
> +		report_gisc_unregister_failure(q);
> +		verified =3D false;
> +	}
> +
> +	if (q->saved_iova && !q->matrix_mdev) {
> +		pr_warn_ratelimited("APQN %02x.%04x: Failed to unpin NIB page %08x\n",
> +				    AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
> +				    q->saved_iova);

[Severity: Low]
Does this truncate the logged DMA address? q->saved_iova is a 64-bit=20
dma_addr_t, but it's being printed with a 32-bit format specifier %08x.

> +		verified =3D false;
> +	}
> +
> +	return verified;
> +}
> +
>  /**
>   * vfio_ap_free_aqic_resources - free vfio_ap_queue resources
>   * @q: The vfio_ap_queue
> @@ -316,17 +398,13 @@ static int vfio_ap_wait_for_irqclear(int apqn, stru=
ct ap_queue_status *tapq_stat
>   */
>  static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
>  {
> -	if (!q)
> +	if (!q || !verify_free_aqic_resourcers(q))
>  		return;
> -	if (q->saved_isc !=3D VFIO_AP_ISC_INVALID &&
> -	    !WARN_ON(!(q->matrix_mdev && q->matrix_mdev->kvm))) {
> -		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
> -		q->saved_isc =3D VFIO_AP_ISC_INVALID;
> -	}
> -	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
> -		vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
> -		q->saved_iova =3D 0;
> -	}
> +
> +	kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
> +	q->saved_isc =3D VFIO_AP_ISC_INVALID;
> +	vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
> +	q->saved_iova =3D 0;
>  }

[Severity: High]
Can this lead to a NULL pointer dereference or a memory leak?

In verify_free_aqic_resourcers(), the logic couples the validation of the t=
wo
independent resources. If both resources are empty (q->saved_isc =3D=3D=20
VFIO_AP_ISC_INVALID and q->saved_iova =3D=3D 0), the function returns true.=
 If=20
q->matrix_mdev is NULL, vfio_ap_free_aqic_resources() will then uncondition=
ally=20
dereference q->matrix_mdev->kvm, resulting in a kernel panic. This path can=
 be=20
reached when an unbound queue is removed from the host AP configuration.

Additionally, if only one resource fails validation (e.g., kvm is NULL),
verify_free_aqic_resourcers() returns false, which skips the cleanup entire=
ly.
This prevents the NIB page from being unpinned, leaking the memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925124551.6654=
48-1-akrowiak@linux.ibm.com?part=3D6
