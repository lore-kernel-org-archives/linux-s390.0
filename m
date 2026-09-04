Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229B33A00C;
	Fri,  4 Sep 2026 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562289; cv=none; b=MM3vV5HNSzjPfUzaxFKMl+Elo8eSIx7+YaAA4yCo7ngevU9UadC6b72hSqvWQer8I2oHffUjvBdfCeiiNTJOYj6PR5b8O2G2nVpcqXQXmQn9hPbg0cl2txMmXhlYQxitedmDQ6yVvR+LH4cn+Ts9/Qumi6j3QJDg18LFu+baj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562289; c=relaxed/simple;
	bh=wcWOUQFWZKUg14JstxiLxPLmSH/hMNegI+uBYo403hA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EUciPqozYwARUzteFVcja86hTkz0onb3EHWp6VQQylqTpfiSjhMOYMmdz9TFQbMNIDOJoyn3jkkcSw0EiwekLbH+IcWL1yrayg1lSlatj7VNtA+pSVWIkX67GjXzVZlhrUjldmODXvs1pGnq7M2Sxe8C0qp9YJr/qWIGOfm+faA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWLCDErb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWLCDErb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A201D1F00A3E;
	Fri,  4 Sep 2026 22:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562288;
	bh=QgythvfTc1fScK+cLnpCsO20KPKprT7M+0qpHB8n2z8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XWLCDErbO3pFzjEk3MVMrLUL0Vf9l7fAiP8A0Vga4N5ZM4u40e2U7HYOB2HurZbqW
	 ItQSvM7g/B9PgFVrs3iCf/orbgVFDSo6x1Zo7WF3ZNU68s3kGDWrMPsESvr+OMDCXZ
	 xP98BAWxw6Q4StW1kJInYDsljlYrGbujKES66ur0mDbMm/ArEvcLkUvsfBKaqtVfun
	 KGiHFEc4Zqqvrs1FMPIF9nXkF2RtjWxviNeA1I3nH9qvcyGYQC3pPs+goH7NnYVd6B
	 azqzwEDnUF9GCgTroOMCmsvyD3a/MwLpdwfw+fTsjMUm+/v26tyGZKyKwRxRu934rD
	 rrZesLyQtuVag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] s390/vfio-ap: Fix leaks of pinned NIB and
 registered GISC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260904223531.1611088-2-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
 <20260904223531.1611088-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:51:27 +0000
Message-Id: <20260904225127.A201D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Eagerly freeing AQIC resources when ap_zapq() or ap_tapq() ret=
urns an unrecognized response allows wild DMA writes to freed host memory.
--

commit 6c73d9ea4d311d5d68e8f5501374842cccbe2c90
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix leaks of pinned NIB and registered GISC

Several code paths in the vfio_ap driver failed to free the AQIC
resources =E2=80=94 the pinned guest NIB page and the registered guest ISC
used to enable interrupts for a queue =E2=80=94 when a queue became unavail=
able
or when unexpected response codes were returned. This could cause memory
exhaustion and depletion of KVM interrupt subclass registrations over time
with repeated dynamic AP reconfiguration.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 940c0ff668bee..9d4f5b9e3301f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -1959,8 +2087,16 @@ static void apq_reset_check(struct work_struct *re=
set_work)
>  		elapsed +=3D AP_RESET_INTERVAL;
>  		status =3D ap_tapq(q->apqn, NULL);
>  		ret =3D apq_status_check(q->apqn, &status);
> -		if (ret =3D=3D -EIO)
> +		if (ret =3D=3D -EIO) {
> +			/*
> +			 * TAPQ returned an invalid response code. This
> +			 * indicates a hardware or firmware bug; the queue
> +			 * cannot generate AP interrupts or DMA-write to the
> +			 * NIB, so free the AQIC resources rather than leak them.
> +			 */
> +			vfio_ap_free_aqic_resources(q);
>  			return;
> +		}

[Severity: Critical]
If apq_status_check() returns -EIO due to an unrecognized TAPQ response,
is it safe to eagerly free the AQIC resources?

If the hardware is in an unknown state (due to a bug or unrecognized code),
could it still be actively DMA-writing to the pinned Notification Indicator
Byte (NIB) page?

If vfio_ap_free_aqic_resources() unpins the page and returns it to the
system allocator, could a subsequent wild DMA write from the malfunctioning
AP queue corrupt memory belonging to a new owner, potentially causing a host
panic?

[ ... ]
> @@ -1995,22 +2135,30 @@ static void vfio_ap_mdev_reset_queue(struct vfio_=
ap_queue *q)
>  	switch (status.response_code) {
>  	case AP_RESPONSE_NORMAL:
>  	case AP_RESPONSE_RESET_IN_PROGRESS:
> -	case AP_RESPONSE_BUSY:
>  	case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
>  		/*
>  		 * Let's verify whether the ZAPQ completed successfully on a work queu=
e.
>  		 */
>  		queue_work(system_long_wq, &q->reset_work);
>  		break;
> +	case AP_RESPONSE_Q_NOT_AVAIL:
>  	case AP_RESPONSE_DECONFIGURED:
>  	case AP_RESPONSE_CHECKSTOPPED:
>  		vfio_ap_free_aqic_resources(q);
>  		break;
>  	default:
> +		/*
> +		 * The architecture defines only the response codes above as
> +		 * valid for ZAPQ. Any other response code indicates a hardware
> +		 * or firmware bug. Since a malfunctioning queue cannot generate
> +		 * AP interrupts or DMA-write to the NIB, free the AQIC resources
> +		 * rather than leak them.
> +		 */
>  		WARN(true,
>  		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=3D%u\n",
>  		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
>  		     status.response_code);
> +		vfio_ap_free_aqic_resources(q);
>  	}
>  }

[Severity: Critical]
Similarly, if ZAPQ fails with an unrecognized response code in
vfio_ap_mdev_reset_queue(), does freeing the AQIC resources here present the
same wild DMA risk?

Even if a later patch in this series adds a retry loop that explicitly
handles AP_RESPONSE_BUSY, does this default case still expose the host to
memory corruption if any other unexpected response code is returned?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904223531.1611=
088-1-akrowiak@linux.ibm.com?part=3D1
