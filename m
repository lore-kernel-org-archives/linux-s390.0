Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127237A833;
	Thu, 27 Aug 2026 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837961; cv=none; b=Ri/O02YA3I39q1GUHLkaYH0zLRS8VhUPVcWmmzN7AwbjT4JwbJSacSSSrwc7twaXTbZ9psZrpifBZh/JwFXIiz3SOOEN2lvCy6UrXZpsTKvcnSQCjA6KdbJGIIjT+uO5aIgjpWF9LQbCvn5+lsE8oodFJMGhf9zN44haPX1LGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837961; c=relaxed/simple;
	bh=/BrLrnYa+hCq+YZQIZC2QutLCD61tybjkjmVbpFEuP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RzvqxXFuLBp6oRkvv3T5hqcXs3XECElVo8tfgcKBSsr7vXNvAHZPOiGJDLih0cVlnyK0m1LyDm9e7ae0QJBi1Tbwzxb6uHd6KTgF6gTJspDiqMqrDbO/nsYsomjlss+/5ai5/HJ3T/k8vXioIqIBKMTikHCUK0DVpDIbqldKYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCSsVsBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCSsVsBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BF81F000E9;
	Thu, 27 Aug 2026 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787837956;
	bh=df2nbsNXYB7hJc0L3Hk8O4cKRugdBO/QV1JuL8pkJbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cCSsVsBKn0p3puAcnFjpEYho7MVW6VtmupVaD27n/E3YdVvxGBmbgffIiI9pGVT9c
	 Hx9bPRUB0PX1iYM0M6+tHxkZVF7PBTuv6CFMSugtYxbWTmMSOIqWTxMVQ2AVy2E/CK
	 6oO348YgtcYqAlqKJqpDTfLSnX95a34e3M1pYPeAHgOHo9eDlgWNMoisiICsLI2CDS
	 8flWtzO3s47tzifxJIyrChAPHmyzbS5it20ZW432fq/LQMmvNmanRGqJi8vk9nKmle
	 YHl0LnzIW5aaBgZ5X2IuCrD6C9DQVOxB/GOKHpuq8tNK/NrrFRabs+YX6gRu8K7gXU
	 qBYGP/eN1wv7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] s390/vfio-ap: Fix leak of pinned NIB and
 registered NISC in vfio_ap_irq_enable/disable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260827132441.555866-2-akrowiak@linux.ibm.com>
References: <20260827132441.555866-1-akrowiak@linux.ibm.com>
 <20260827132441.555866-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:39:16 +0000
Message-Id: <20260827133916.93BF81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] State Inconsistency / Guest Memory Corruption

Pre-existing issues:
- [High] Guest-Triggerable Host Denial of Service via WARN_ONCE
- [Medium] Potential Use-After-Free when replacing an active NIB in `vfio_a=
p_irq_enable`
--

commit 01ac8813c3b445f045948ad22e87c958b38cb3b4
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_ena=
ble/disable()

This commit addresses resource leaks by ensuring the NIB is unpinned and the
NISC is unregistered when the PQAP(AQIC) instruction fails or times out. It
also introduces a wait loop to prevent a host use-after-free when disabling
IRQ resources.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 940c0ff668bee..64d6a8f8fa96e 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -257,12 +265,13 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>  		default:
>  			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
>  				  status.response_code, apqn);

[Severity: High]
This is a pre-existing issue, but could a malicious guest intentionally
trigger this warning by spamming AP queue instructions? KVM guidelines
specify that guest-reachable WARN_ONCE statements can act as a local
denial-of-service vector when panic_on_warn is enabled. Should this be
converted to pr_warn_once() or dropped entirely?

> -			return;
> +			return true;
>  		}
>  	} while (--retry);
> =20
> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
> -		  __func__, status.response_code, apqn);
> +	WARN_ONCE(1, "%s: tapq rc %02x: timed out verifying interrupts disabled=
 for %02x.%04x\n",
> +		  __func__, status.response_code, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn=
));

[Severity: High]
This is a pre-existing issue, but does this WARN_ONCE pose the same
denial-of-service risk if an untrusted guest intentionally stalls the
hardware response to exhaust the retry loop?

> +	return false;
>  }

[ ... ]

> @@ -317,8 +326,21 @@ static struct ap_queue_status vfio_ap_irq_disable(st=
ruct vfio_ap_queue *q)
>  		switch (status.response_code) {
>  		case AP_RESPONSE_OTHERWISE_CHANGED:
>  		case AP_RESPONSE_NORMAL:
> -			vfio_ap_wait_for_irqclear(q->apqn);
> -			goto end_free;
> +			/*
> +			 * AQIC disable was accepted (NORMAL), or the queue was
> +			 * already disabled or a prior async request is still
> +			 * completing (OTHERWISE_CHANGED).  In both cases, we must
> +			 * wait until interrupt processing has been disabled
> +			 * before proceeding.
> +			 *
> +			 * If it could not be determined whether interrupts
> +			 * have been disabled, do not free the AQIC resources: the
> +			 * hardware may still write to the NIB, so leave it pinned
> +			 * to avoid a use-after-free. The resources will be leaked.
> +			 */
> +			if (vfio_ap_wait_for_irqclear(q->apqn))
> +				goto end_free;
> +			goto end_fail;

[Severity: High]
If vfio_ap_wait_for_irqclear() times out, the code correctly takes the
end_fail path to prevent a host use-after-free. However, doesn't this
result in returning the original AP_RESPONSE_NORMAL status back to the
guest?

If the guest receives a success status, it might assume interrupts are
fully disabled and proceed to free and reuse the memory containing the NIB.
Since the hardware may still be actively writing to the NIB, could this
corrupt the guest's re-allocated memory? Should the driver override the
return status (e.g., returning AP_RESPONSE_BUSY) to force the guest to
retry instead?

>  		case AP_RESPONSE_RESET_IN_PROGRESS:
>  		case AP_RESPONSE_BUSY:
>  			msleep(20);
> @@ -326,18 +348,46 @@ static struct ap_queue_status vfio_ap_irq_disable(s=
truct vfio_ap_queue *q)
>  		case AP_RESPONSE_Q_NOT_AVAIL:
>  		case AP_RESPONSE_DECONFIGURED:
>  		case AP_RESPONSE_CHECKSTOPPED:
> +			/* AP not operational; no further interrupts possible */
> +			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
> +				  status.response_code);

[Severity: High]
This is a pre-existing issue, but does this WARN_ONCE similarly allow an
untrusted guest to trigger a kernel panic if panic_on_warn is enabled?

> +			goto end_free;
>  		case AP_RESPONSE_INVALID_ADDRESS:
>  		default:
> -			/* All cases in default means AP not operational */
> +			/*
> +			 * The AQIC disable was rejected; IRQ is still enabled
> +			 * and the hardware still holds the NIB address. Do not
> +			 * free resources.
> +			 */
>  			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
>  				  status.response_code);

[Severity: High]
This is a pre-existing issue, but could this WARN_ONCE also act as a host
denial-of-service vector if a guest provides invalid queue states?

> -			goto end_free;
> +			goto end_fail;
>  		}
>  	} while (retries--);
> =20
>  	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
>  		  status.response_code);

[Severity: High]
This is a pre-existing issue, but could an adversarial guest intentionally
induce a timeout to hit this WARN_ONCE as well?

[ ... ]

> @@ -490,6 +540,11 @@ static struct ap_queue_status vfio_ap_irq_enable(str=
uct vfio_ap_queue *q,
>  	status =3D ap_aqic(q->apqn, aqic_gisa, h_nib);
>  	switch (status.response_code) {
>  	case AP_RESPONSE_NORMAL:
>  		/* See if we did clear older IRQ configuration */
>  		vfio_ap_free_aqic_resources(q);
>  		q->saved_iova =3D nib;
>  		q->saved_isc =3D isc;
>  		break;

[Severity: Medium]
This is a pre-existing issue, but if ap_aqic() accepts a new NIB replacement
and returns AP_RESPONSE_NORMAL, does immediately freeing the old resources
via vfio_ap_free_aqic_resources() pose a use-after-free risk?

If the hardware processes the change asynchronously, might it still have
in-flight DMA writes directed to the old NIB (stored in q->saved_iova)? If
so, does the old NIB need to be fully quiesced using a similar wait loop
before it can be safely unpinned?

>  	case AP_RESPONSE_OTHERWISE_CHANGED:
> -		/* We could not modify IRQ settings: clear new configuration */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827132441.5558=
66-1-akrowiak@linux.ibm.com?part=3D1
