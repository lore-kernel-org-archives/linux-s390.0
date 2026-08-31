Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04089303A04;
	Mon, 31 Aug 2026 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205231; cv=none; b=cXlcyJQnLHQVrU/n6NzEccScjK8lcWADy2XenMmaPCfOc656OYfJ3Sa2yuvgpKld2BvrzVdVct+JanPmByJ6Pk0rlXDQMy7Hv2UZLofRG4kT75czoJEGUIylcnDhPZCzreKWLxYJlI2TjFU96ZHhfl5au4fMFObSQ8VZ6F1w5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205231; c=relaxed/simple;
	bh=72cD1Nbh4dKv36yBPjpip2kvDJhlxVJIYnfAlFhLEcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jnjIOTonhvuPSZPwoTMaexpT3W9jM2cisn2Exs40D4pLSg40wu0Rm5L7+Oy/Br9jz/Qj8X4sBKFO3adwrq7PKPNsQmXgIKV690QgoZ05nXxgqghZesEpmLdMTonv9NNaGIiL8B5JHtYGejjuWbqbd4+94dcPFFWOFiywSZlz9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwgQHgI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwgQHgI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3896A1F000E9;
	Mon, 31 Aug 2026 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788205229;
	bh=fbkjsdrw2eDIEVU/17r0jVjUn3btLt+aoZWmpzC5IW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OwgQHgI8EC1frxf9i168Mg3bpAdoIJJp0uCtzRiBii2G61MdadvQHrMGkWBzGeV/Y
	 tv0nVVcwOpk1CCa6q+zpfBZvgliu7DsLWLugW19SnWhai2jL2JACd9cw6oY6nkL0+m
	 NPayvJrfDQIfO3UkD4pm0yD7cgqlLCcQtrR8W/IQy4d3wwjs02EOFWaPzg3LZ+UtSe
	 GCIcsEzw5dN+6h8jSpr9/CDidZOKwucNCLZg0FOXZ33M2nITEdj3MmM2/fOQV3CRDC
	 EAGctfn2IbeuSWNiSKHzJC6hv6nUg5cpYnP3VFSaAhxSB9/5UMPyMqmsHpwYV8CqlO
	 03WiK3qhgTQZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] s390/vfio-ap: Fix leak of pinned NIB and
 registered NISC in vfio_ap_irq_enable/disable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831171443.222225-2-akrowiak@linux.ibm.com>
References: <20260831171443.222225-1-akrowiak@linux.ibm.com>
 <20260831171443.222225-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:40:28 +0000
Message-Id: <20260831194029.3896A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unbounded memory leak of newly pinned NIB pages and GISC registrat=
ions when `vfio_ap_irq_enable` times out.

Pre-existing issues:
- [High] Guest-triggerable WARN_ONCE introduces a host-side denial of servi=
ce risk.
--

commit 82e69024e1f94318c978aa31bed7a9d1888b87e2
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_ena=
ble/disable()

This commit modifies the cleanup of pinned NIBs and registered NISCs after
PQAP(AQIC) instructions are executed. It introduces a wait loop to verify t=
he
asynchronous completion of the interrupt state transition before allowing
the release of older resources.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 940c0ff668bee..8fb0476e3d397 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> +static bool vfio_ap_wait_for_irqstate(int apqn, int ir)
>  {
>  	struct ap_queue_status status;
>  	int retry =3D 5;
[ ... ]
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
This is a pre-existing issue, but does this WARN_ONCE introduce a guest-dri=
ven
host denial of service risk?

If a guest issues a PQAP(AQIC) instruction and the hardware takes longer th=
an
expected to transition states, this wait loop times out and triggers a warn=
ing.
Because the KVM subsystem strictly forbids guest-reachable WARN_ON macros,
could a malicious guest artificially induce these delays (for instance, by
spamming requests) to intentionally panic the host kernel if panic_on_warn
is enabled?

[ ... ]
> @@ -317,8 +334,30 @@ static struct ap_queue_status vfio_ap_irq_disable(st=
ruct vfio_ap_queue *q)
>  		switch (status.response_code) {
[ ... ]
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
>  	} while (retries--);

[Severity: High]
This is a pre-existing issue, but does this WARN_ONCE pose the same guest-
driven denial of service risk?

If the hardware returns an unexpected status code in response to a guest-
initiated disable request, this warning is hit. Can an untrusted guest
intentionally induce unexpected hardware states to trigger this warning and
crash the host?

[ ... ]
> @@ -489,13 +557,49 @@ static struct ap_queue_status vfio_ap_irq_enable(st=
ruct vfio_ap_queue *q,
>  	status =3D ap_aqic(q->apqn, aqic_gisa, h_nib);
>  	switch (status.response_code) {
>  	case AP_RESPONSE_NORMAL:
> -		/* See if we did clear older IRQ configuration */
> +		/*
> +		 * AQIC initiates an asynchronous process; however, AP_RESPONSE_NORMAL
> +		 * does not guarantee interrupts are enabled yet (i.e., IR bit (7)
> +		 * is set). Wait to confirm before committing the new NIB and
> +		 * freeing the old resources.
> +		 */
> +		if (!vfio_ap_wait_for_irqstate(q->apqn, AP_IRQ_ENABLED)) {
> +			/*
> +			 * Timed out waiting to verify IRQs are enabled. If the
> +			 * hardware is merely stalled, it might eventually complete
> +			 * and write interrupt status bytes to the new NIB.
> +			 *
> +			 * If the NIB page is unpinned and freed here, this delayed
> +			 * hardware write would result in a host use-after-free/wild
> +			 * DMA write and a host kernel crash.
> +			 *
> +			 * To prevent this, we must leak the new resources (leave the
> +			 * NIB page pinned and Guest ISC registered) and return
> +			 * AP_RESPONSE_OTHERWISE_CHANGED to signal the guest to retry.
> +			 */
> +			msg =3D "%s: Timed out waiting to verify IRQs enabled for apqn=3D%#04=
x\n";
> +			VFIO_AP_DBF_WARN(msg, __func__, q->apqn);
> +			memset(&status, 0, sizeof(status));
> +			status.response_code =3D AP_RESPONSE_OTHERWISE_CHANGED;
> +			break;
> +		}

[Severity: High]
Will this timeout path result in an unbounded memory leak?

When vfio_ap_wait_for_irqstate() times out, the code breaks out of the swit=
ch
statement without storing the newly pinned 'nib' and registered 'isc' into
q->saved_iova or q->saved_isc. These local variables appear to be permanent=
ly
orphaned.

Because a guest controls the PQAP calls, could an untrusted guest VM repeat=
edly
trigger this timeout to deliberately leak pinned host pages and KVM GISC
registrations until host memory is exhausted?

Additionally, this seems to contradict the commit message which states:
"The fix is to unregister the NISC and an unpin the NIB used in the AQIC
call in the default case of the switch statement..."
Here the code explicitly notes "we must leak the new resources". Is this
omission of cleanup intentional?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831171443.2222=
25-1-akrowiak@linux.ibm.com?part=3D1
