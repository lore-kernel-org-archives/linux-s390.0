Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274845172CA;
	Tue, 13 Oct 2026 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907152; cv=none; b=coxUGwvCoqP6craEeow9CMeEEPXuUke4/opVzPCTPeqFVeGYl3dKncZgSwUWLmTcp20EnUsaycnpZh1L5SOUBQksYgTtCCAyUFTS7bHmLLIi2y+8HXc24EyJ8q7kngSXjXB+HGtVmXW0thrNNfFrt5ezNBNzyadNaWMVHu/aRqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907152; c=relaxed/simple;
	bh=ZvgSN9US0SiBg9EUfDBzHteIIuztpRpqPeTqI5DUq6c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WNODawc3nf2SKtBw+VC6t5TwG40kAZL4hHGmlldhof1B047Dglw+MxQhZlJytjSp/xVhyTZS8A+/VHSUO5WUTM3GlvSZfVKpproblrSteK8fHnO7fAaVvFC37lQm4sWr9RCIZFhCtXva264Me6aPGJ7i6q7nmFkYyHXpOotP8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrLYsJRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrLYsJRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27581F000FF;
	Tue, 13 Oct 2026 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907151;
	bh=7ffZuAK4jZs9uvHwAUEPp+hVA5QNiqDZgQy0qT6fVnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrLYsJRqe5RRRF6sQjNQND9awP8Vb1cEOBKbvY+b02EcEaHqI5837DuUPCP+lDNP/
	 bZAVPDBzB1t93cL968YlZhgIXfkgPyiyAL/4KVTtrckgtKEpltQEThhlFeuUUe9S9e
	 s884C9J81RF4i2QADLkmrYxfGDm4HrF3BOiDdqmKKVAQBBKwvHf5SlzcCIrj7jBrzn
	 9FYxEhFDd8JGy6Y5+eNULv2TwKvTzXaplKqIcmy+voSMVUxr5JJcyuBwAQVajFugEs
	 prZIEo5fqazYF5WfZt6t7DcCTOihVR5XyR66iHjRauFn1i5UXu7DU/60iyGRZpLDCG
	 aUbC4izNSu8bw==
Message-ID: <sashiko-outbox-170075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-8-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:59:10 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/vfio-ap: Undefined hardware state is used when TAPQ returns=
 an async error
--

commit 449bfb4f03a8737bf9d26180f1c9b9cb38b82556
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to save the vfio device migration state

This commit implements the read callback function to save the state of the
vfio-ap device during migration. It copies the guest's AP configuration
information, including queue hardware information, to userspace.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index bbd007c06a776..cf3f95e2846cb 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> +static int get_hardware_info_for_queue(const char *mdev_name,
> +				       struct ap_tapq_hwinfo *hwinfo,
> +				       unsigned long apqn)
> +{
> +	struct ap_queue_status status;
> +
> +	status =3D ap_tapq(apqn, hwinfo);
> +
> +	switch (status.response_code) {
> +	case AP_RESPONSE_NORMAL:
[ ... ]
> +	default:
> +		/*
> +		 * Without a pending async error, the tapq info should be
> +		 * available
> +		 */
> +		if (status.async)
> +			return 0;

[Severity: Medium]
When the ap_tapq function returns with an async error (status.async =3D=3D =
1),
both the response code and the hardware information returned in general
register 2 (hwinfo->value) are undefined.

Since we return 0 (success) here, does this cause the caller to save garbage
data into the migration stream?

Looking at the caller:

vfio_ap_store_queue_info()
    ret =3D get_hardware_info_for_queue(..., &source_hwinfo, ...);
    if (ret)
        return ret;
    ap_config->qinfo[num_queues].data =3D source_hwinfo.value;

If get_hardware_info_for_queue returns 0 when status.async is true,
source_hwinfo.value could contain uninitialized data that is then stored in=
to
the ap_config and migrated to userspace.

Should this return an error when an async error is pending so that we don't
migrate uninitialized state data to the destination host?

> +
> +		pr_err_ratelimited("vfio_ap_mdev %s:Failed to get hwinfo for queue %02=
lx.%04lx: TAPQ rc=3D%d",
> +				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
> +				   status.response_code);
> +		return -EIO;
> +	}
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D7
