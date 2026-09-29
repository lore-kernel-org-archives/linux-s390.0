Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83193E49F5;
	Tue, 29 Sep 2026 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685194; cv=none; b=p6jerIRpdT6nGyowYwf9skgSzvV0U9t97ZpMxgNr6NyW09ByDG9Hi/sL9qVxYiq6kK8mNStIO6Ers0cm3nEsSDgysHhj6cM/niW7yru9ryO+hVlLU20m2O9kc5sRV7HgD4Dw6qydzQZ11sGwZ9HkGf2LgrAIO0OMl++S6GWKKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685194; c=relaxed/simple;
	bh=u1HnNkUGA6hM+FlYfklHT1+Y+NujlXh75n+G22q8h4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gJnrSO7Z78TUqio7S1yAMKoV+ZkO2l8hI12sW6KI1HSYgpsf5PAgv7BB/qLpM/cOnV+bM3AqCuTFYb3/nwMutnvT5sA9deUuPJxGikLnLbqQHv69XEF8I2CU4HiyDb+z+aQ487bt20eCfLGLIDg0URgp1ZCLfJYfDPAQ914Pplw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuMx5W2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuMx5W2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC6F1F000FF;
	Tue, 29 Sep 2026 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685192;
	bh=CK1m/NW/c68GOCsYbS/l1oWMix0f6p96xXWSbQWJmvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuMx5W2ds8tLv5ZHLZ/BbPLBGjOQx8aWocrP+cS+VZT30SJx1iJdQn0qBVYrYn9j6
	 wmekHhRppnEXVb9jF2kny6p6bVEpZ/WAhdoSbfDpCMfVbUwUqj2Mos/0ghpO4zOHos
	 QB6AnG3/Kou9DWg9snjy3F0gSF8Y8Nzv14X2CZrCx8neVpFGBpl3nlTGYHK0Zd1JHX
	 mObcWw+qFIBEHmovXi8xyDnIbrg+eWK14R6APRX1Z4uOKhEiPNFo8RAUmWjSZOYcxf
	 O8v41wUMtmpV01tPQfvc+yJz2oTVkGfmvDZ/tutqcvcbCpmDaV0ADQwsPosml+ZhFn
	 2KzRebW+SQ08g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/6] s390/vfio-ap: fix queue state leakage to guest
 and host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260929121837.2715710-6-akrowiak@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
 <20260929121837.2715710-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 12:33:11 +0000
Message-Id: <20260929123311.ECC6F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] crypto: vfio_ap: stale reset_status allows non-operational queues =
to bypass zeroization validation
- [High] crypto: vfio_ap: unassigned queues bypass hardware zeroization due=
 to 0-initialized reset_status
--

commit 24e15c35f349b082c58fb854babbe21937a8bd2c
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: fix queue state leakage to guest and host

This commit limits the wait timeout for queue resets and modifies the
passability checks to ensure strict queue zeroization before guest
assignment. It also introduces a state machine callback to handle
hardware queue state transitions.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index ad19d44a67bc4..89efb73d70355 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -881,14 +881,14 @@ static bool _queue_passable(struct vfio_ap_queue *q)
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

> @@ -2855,6 +2855,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apde=
v)
> =20
>  	if (matrix_mdev) {
>  		vfio_ap_mdev_link_queue(matrix_mdev, q);
> +		vfio_ap_mdev_reset_queue(q);
> +		flush_work(&q->reset_work);
> =20
>  		/*

[Severity: High]
Does the 0-initialization of reset_status in vfio_ap_mdev_probe_queue() cau=
se
unassigned queues to bypass the zeroization verification in _queue_passable=
()?

If a queue is probed without an assigned matrix_mdev:

	memset(&q->reset_status, 0, sizeof(q->reset_status));
	INIT_WORK(&q->reset_work, apq_reset_check);

	if (matrix_mdev) {
		vfio_ap_mdev_link_queue(matrix_mdev, q);
		vfio_ap_mdev_reset_queue(q);
		...

The hardware reset is skipped, but the memset sets the response code to 0
(AP_RESPONSE_NORMAL). If this adapter is later linked to an mdev via
assign_adapter_store(), will _queue_passable() incorrectly evaluate to true=
 and
grant the guest access to unzeroized hardware state?

[ ... ]

> +	case AP_QUEUE_CONFIG_OFF:
> +	case AP_QUEUE_CHKSTOP_ON:
> +		/*
> +		 * The queue has become non-operational. Hot-unplug its adapter
> +		 * from the guest's shadow APCB so the guest stops issuing
> +		 * operations to a queue it can no longer reach. Since queues are
> +		 * addressed via a card/domain matrix it is not possible to remove
> +		 * a single queue; the whole adapter must be unplugged.
> +		 *
> +		 * The queue remains bound to the driver and stays in
> +		 * matrix_dev->info; vfio_ap_mdev_filter_matrix() will
> +		 * re-admit it automatically when the queue returns to an
> +		 * operational state (CONFIG_ON or CHKSTOP_OFF).
> +		 */
> +		if (test_bit_inv(AP_QID_CARD(q->apqn),
> +				 matrix_mdev->shadow_apcb.apm) &&
> +		    test_bit_inv(AP_QID_QUEUE(q->apqn),
> +				 matrix_mdev->shadow_apcb.aqm)) {
> +			clear_bit_inv(AP_QID_CARD(q->apqn),
> +				      matrix_mdev->shadow_apcb.apm);
> +			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +			reset_queues_for_apid(matrix_mdev,
> +					      AP_QID_CARD(q->apqn));
> +		}
> +		break;

[Severity: High]
The commit message states that for non-operational queues, q->reset_status
is zeroed and its response code is set to AP_RESPONSE_DECONFIGURED or
AP_RESPONSE_CHECKSTOPPED.

However, does this block miss updating the reset status?

If the queue retains an old AP_RESPONSE_NORMAL (0) status from when it was
operational, can _queue_passable() incorrectly evaluate to true and allow t=
he
queue to bypass the required hardware zeroization when later evaluated by t=
he
filtering logic?

> +	default:
> +		break;
> +	}
> +
> +out_unlock:
> +	release_update_locks_for_mdev(matrix_mdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929121837.2715=
710-1-akrowiak@linux.ibm.com?part=3D5
