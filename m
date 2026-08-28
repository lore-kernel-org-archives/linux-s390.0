Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A5397323;
	Fri, 28 Aug 2026 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787954271; cv=none; b=Mx6PX0Y/dZrE6ySsU+JgUfthbdUzN6TNoZpnRFKcj5hYvV7V2wMOPzfqP6djZNYBMYAEyh84/NeiuHLRPQMJYPY7OSGNv9zaWhrSa3803yOo/Uk0spsx68pkzPjvNZnonuODkZi7IxfE8x4ZSlxNS0EBplvHE44bFrIImmxfnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787954271; c=relaxed/simple;
	bh=rhsLJCNjyXGlDKQ64aa5cLUmX/tjksW8Lb6OlBUXSRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XNWbO3Ey2A7+4tNeZ6Ko9lpFO/BkHFSVbWd9I9pfiHe/JZKynXORcPr+uTZYx/GqAnwwyZCoT/mOby9PjhojLeyCmnrG7XjEGiC6B3gSOc24mt8sYPB0izwMrm5RAIMt979GGOzzHrRtwup5TpYtoviWWtPFzEfyWEAVkfPKHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBLOjm6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBLOjm6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3EA1F000E9;
	Fri, 28 Aug 2026 21:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787954269;
	bh=HBODWS9CJermAsFNAWIOB0VwgAz0tbzd/2wjsY8YGG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QBLOjm6zo8e2VHJFYqCv5rlYnGGtZ9phuAUpbE0fFcWe3+bgaUg5EqeT0UxkuM9Q8
	 T+7nhG2bAgGwHVLfbe4pOKXfMJU9VBJDz8Ww7OUiNQ4/TnnI+Z/3kxz+TnpMXnwMOD
	 p6UMmmWWI3LG7rePFxnqWEx9KsrPIVZbtIMo2wwwOZfw8tofZsvZwc6FF7IVxwKL1q
	 siPYsjfSIxk5aR5iL0ZiAXUBOpcG3CyOLf57Xw+nHSKttOMz73Z7NDPAXrLerOfO5K
	 ATq6HEShXjbO92yjqf1khcC5165b3O/WnDGggNKHkYdT71ewqJI7FHrjIUcHmTMsVB
	 WpgGVR3OzRtFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] s390/vfio-ap: Fix leak of pinned NIB and
 registered NISC in vfio_ap_irq_enable/disable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260828214653.1087009-2-akrowiak@linux.ibm.com>
References: <20260828214653.1087009-1-akrowiak@linux.ibm.com>
 <20260828214653.1087009-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:57:48 +0000
Message-Id: <20260828215749.5B3EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Prematurely unpinning the new NIB page on a hardware timeout i=
n `vfio_ap_irq_enable` causes a host use-after-free and wild DMA write if t=
he hardware later completes the asynchronous interrupt configuration.

Pre-existing issues:
- [High] Guest-reachable `WARN_ONCE` in `vfio_ap_wait_for_irqstate` and `vf=
io_ap_irq_disable` violates KVM subsystem guidelines and creates a denial o=
f service vector on `panic_on_warn` systems.
--

commit f514ef27dfc693d5c326ffed4fd1a9985acce1d0
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_a=
p_irq_enable/disable()

This commit addresses resource leaks by restructuring how the AQIC
instruction responses are handled for AP queues. It introduces a polling
mechanism to wait and confirm asynchronous hardware transitions before free=
ing
resources.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 940c0ff668bee..24e93fb7f81a2 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -245,8 +259,8 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>  		switch (status.response_code) {
>  		case AP_RESPONSE_NORMAL:
>  		case AP_RESPONSE_RESET_IN_PROGRESS:
> -			if (!status.irq_enabled)
> -				return;
> +			if (status.irq_enabled =3D=3D ir)
> +				return true;
>  			fallthrough;
>  		case AP_RESPONSE_BUSY:
>  			msleep(20);
> @@ -257,12 +271,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>  		default:
>  			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
>  				  status.response_code, apqn);
> -			return;
> +			return true;
>  		}
>  	} while (--retry);
> =20
> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
> -		  __func__, status.response_code, apqn);
> +	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts %s for=
 %02x.%04x\n",
> +		  __func__, status.response_code,
> +		  ir ? "enabled" : "disabled",
> +		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
> +	return false;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this guest-reachable
warning violate KVM subsystem guidelines?

A malicious guest can intentionally manipulate AP queue states or rapidly
spam PQAP instructions to stall the hardware, triggering these warnings on
non-operational states or polling timeouts. On systems configured with
panic_on_warn, this creates a host denial of service vector.

Could these be converted to rate-limited debug messages or dropped entirely?

[ ... ]

> @@ -326,18 +365,46 @@ static struct ap_queue_status vfio_ap_irq_disable(s=
truct vfio_ap_queue *q)
>  		case AP_RESPONSE_Q_NOT_AVAIL:
>  		case AP_RESPONSE_DECONFIGURED:
>  		case AP_RESPONSE_CHECKSTOPPED:
> +			/* AP not operational; no further interrupts possible */
> +			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
> +				  status.response_code);
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
> -			goto end_free;
> +			goto end_fail;
>  		}

[Severity: High]
This is also a pre-existing issue, but can this similarly be triggered by=20
an unprivileged guest manipulating the queue into an unavailable state duri=
ng
a disable attempt?

[ ... ]

> @@ -489,13 +557,49 @@ static struct ap_queue_status vfio_ap_irq_enable(st=
ruct vfio_ap_queue *q,
>  	status =3D ap_aqic(q->apqn, aqic_gisa, h_nib);
>  	switch (status.response_code) {
>  	case AP_RESPONSE_NORMAL:
> -		/* See if we did clear older IRQ configuration */
> +		/*
> +		 * AQIC initiates an asynchronous process; however, AP_RESPONSE_NORMAL
> +		 * does not guarantee the IR bit is set yet.  Wait to confirm before
> +		 * committing the new NIB and freeing the old resources.
> +		 */
> +		if (!vfio_ap_wait_for_irqstate(q->apqn, AP_IRQ_ENABLED)) {
> +			/*
> +			 * Timed out: the hardware may not have accepted the new
> +			 * NIB.  Clean up the new resources and return
> +			 * OTHERWISE_CHANGED to signal the guest to retry.
> +			 */
> +			ret =3D kvm_s390_gisc_unregister(kvm, isc);
> +			if (ret) {
> +				msg =3D "%s: kvm_s390_gisc_unregister: rc=3D%d isc=3D%d, apqn=3D%#04=
x\n";
> +				VFIO_AP_DBF_WARN(msg, __func__, ret, isc, q->apqn);
> +			}
> +			vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
> +			memset(&status, 0, sizeof(status));
> +			status.response_code =3D AP_RESPONSE_OTHERWISE_CHANGED;
> +			break;
> +		}

[Severity: Critical]
Does unpinning the new NIB page here introduce a race that could lead to a
wild DMA write and host memory corruption?

Because ap_aqic() returned AP_RESPONSE_NORMAL, the hardware accepted the
asynchronous request. If the hardware is merely stalled (e.g., due to a
malicious guest spamming instructions) and vfio_ap_wait_for_irqstate() times
out, the hardware might still eventually complete the transition and write
interrupt status bytes to the new NIB.

If vfio_unpin_pages() is called here, that physical page could be reallocat=
ed
by the host kernel for a different purpose before the delayed hardware DMA
write completes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828214653.1087=
009-1-akrowiak@linux.ibm.com?part=3D1
