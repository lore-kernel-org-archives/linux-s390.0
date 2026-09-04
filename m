Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AC377AB2;
	Fri,  4 Sep 2026 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562002; cv=none; b=CfsRYwW0xWtgtU17wxenaPbRZR6ZMIONnQRIKfgOhwyzMO9+pkbCu9kIXiFIBv38NygJrwdtAr3gyVacXB9xyi3qdCLl7wMRKFRDkR8Sfx6dRD2wVsGRqDMWmMHlHNtvzjdSTssszDeEGIUyuXkSkWEy4/kJVCWe1zUdDww0bEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562002; c=relaxed/simple;
	bh=Ddb7UET6kE81Biqb9D+16VHNLTR+PTJaAGU1xlZnNXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SF3QZdBHOXLWGoNpl1fyq72A5a3YUekQVJSTYhpa7FdrElO3h1k8V0ffNfHtqqXG0kU2FKOgHQjWSmHz7q8hHlhJd0ULYDEIs6IQM+fYjcy81XZeJAoD0WbEDyi19YxbvJ3gATJ8lXFpt/2lXvCzdB7mJNpR3kOvZDzR4du2Kjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuADnRkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuADnRkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C711F00A3D;
	Fri,  4 Sep 2026 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561998;
	bh=eXGGoA8RQwpabku5s5rbUXJTQRbggJ5gYIoMexvTnB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UuADnRkNCCcjiUgDx8JLNxiXljTV3EGq5eP1KSSzSWy/vDHFq4aEeHeXHMij6Ma1B
	 K390hF0EDOj9w0TGvU+Kb9D3d+WEjy87+ckFOcwBi4EhyFTBjp0XX53Ik40eOagfwR
	 h3ufznMWX1gVH853nF9X9bxpdJhzvrqafD49q3HbVN7JY+97VYlCk9GJebyDcfZYV5
	 5FN5tT7wpQCyDXQsXL4NXssn7lVxTGAwipQenC+wgrTobFxfL11Gbgp0Ith24XwAUm
	 5hMTAfPgg57G920kdJVF8KgEnhU1ZTpLRLA8df5GB2yr8ba6bLWSVjLckKUTSllrtP
	 sGeADuTz+2HXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] s390/vfio-ap: fix queue state leakage to guest
 and host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904223531.1611088-6-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
 <20260904223531.1611088-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:46:37 +0000
Message-Id: <20260904224637.A2C711F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A hardware error during queue reset circumvents the newly introduc=
ed security check, incorrectly marking a potentially un-zeroized queue as '=
passable'.
--

commit 239f603c9ac4d1441b4d22a11bde0df9a2b5aa5c
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: fix queue state leakage to guest and host

This commit introduces an upper bound on the wait time for a queue reset
to complete and prevents the leakage of queue state to guests. It ensures
zeroization is strictly confirmed by returning true in _queue_passable()
only when the response code is AP_RESPONSE_NORMAL.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -785,14 +785,14 @@ static bool _queue_passable(struct vfio_ap_queue *q)
>  	if (!q)
>  		return false;
> =20
> -	switch (q->reset_status.response_code) {
> -	case AP_RESPONSE_NORMAL:
> -	case AP_RESPONSE_DECONFIGURED:
> -	case AP_RESPONSE_CHECKSTOPPED:
> -		return true;
> -	default:
> -		return false;
> -	}
> +	/*
> +	 * A queue is only passable if zeroization was confirmed by
> +	 * apq_reset_check() via TAPQ status bit verification. This is
> +	 * indicated by reset_status.response_code =3D=3D AP_RESPONSE_NORMAL (0=
).
> +	 * This is to protect against leaking the internal state of the queue
> +	 * to the guest.
> +	 */
> +	return q->reset_status.response_code =3D=3D AP_RESPONSE_NORMAL;
>  }

[ ... ]

> @@ -2129,7 +2153,7 @@ static void apq_reset_check(struct work_struct *res=
et_work)
>  			 */
>  			vfio_ap_free_aqic_resources(q);
>  			return;

[Severity: High]
This is a pre-existing issue, but does this error path leave
q->reset_status.response_code set to AP_RESPONSE_NORMAL if a hardware or
firmware fault occurs?

When vfio_ap_mdev_reset_queue() successfully initiates a reset, ap_zapq()
returns AP_RESPONSE_NORMAL (0), which is initially copied into
q->reset_status.

If ap_tapq() subsequently returns an invalid response code causing
apq_status_check() to return -EIO, this workqueue function aborts and frees
the AQIC resources. However, it exits without updating q->reset_status to a
failure state.

Because _queue_passable() now strictly checks for AP_RESPONSE_NORMAL, could
this fail-open state result in an un-zeroized queue being incorrectly passed
to an untrusted guest, leaking cryptographic key material?

> -
> +		}
>  		if (elapsed >=3D AP_RESET_MAX_WAIT) {
>  			/*
>  			 * Zeroization confirmed (ret =3D=3D 0): the TAPQ status bits
> @@ -2143,8 +2167,10 @@ static void apq_reset_check(struct work_struct *re=
set_work)
>  			 * queue cannot generate interrupts, so the NIB page is
>  			 * no longer a DMA target and it is safe to free it.
>  			 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904223531.1611=
088-1-akrowiak@linux.ibm.com?part=3D5
