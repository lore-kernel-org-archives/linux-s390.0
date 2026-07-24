Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE22380FCC;
	Fri, 24 Jul 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916607; cv=none; b=f3rVfpE9fTK1WBT83GRi5tcTDm7M88XWDbwmVmbnz9QE6FenQdwV8M4aJF12n+3/W3UgNmP1X+qicqbXMo2BU1XcdReeny1G/K9inBSmILBQn5n/tLitvmPFhnsta02f32hn0YlzrjTWfeFGumoA06bztOIs7jkC8JFM0Tch8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916607; c=relaxed/simple;
	bh=v/xUfqpUlCjhtjyKtUeoFEfuwtC7bJ/PFWwLHezP65c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e3Afs/jCrpoI3WBuOBsTaQARqvpyWk3BEci2wQwcTVrHFmFh83d5CRyos66lJIyX1KBY2JVNtdfCCEejE87zMRR/TRxL6ByZXtI3RTsOc8RMKH30nPG7++G4gUYKeFqClPCIk2F1B5PjCSL4sTiNM8N8KTyAbDcXivA5KvFyJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlgDQ7SE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlgDQ7SE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5F61F000E9;
	Fri, 24 Jul 2026 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784916606;
	bh=toITdvDwP3v9Ap/6mHn7IcilP8/fL5/5z8C/htRpyHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZlgDQ7SEdBw51U345cR+z3EDVhCbuDbs1P3V6024/OSt11Mmrp+/LuapiHbvcU96f
	 7cphtzGlM0Hna04zP6BkSdklRpyFfHVzm6ilY28wx4UbUlnYEKGezvEukaUntv9DqX
	 pdL+8b/DUvUdR1BnZrGyh/2dxgazpEuA4Uyy8GMGf3UAxhyEnshGrEyhNMheGxA3Eh
	 spDXXrAvqny+2LvZT/8f2FPtmGkWvPPxSzFLMy6wHlgexleusAJxd4FUaHsVHsnIVc
	 u5FH5Lj1TfTa8GQrU4JUERdZsfPQJpKqqSn0gM032o/Qz7SK6nRwU48R84EKezE/77
	 mBy4rl2c5z1Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260724161351.1802644-10-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:10:05 +0000
Message-Id: <20260724181006.3C5F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] vfio_ap_mdev_unlink_fr_queues incorrectly links instead of unl=
inking queues, causing a Use-After-Free when an mdev is removed.

Pre-existing issues:
- [Critical] Queues filtered from the guest APCB do not have their matrix_m=
dev pointer cleared during hot unplug, leading to a dangling pointer UAF.
--

--- Patch [9]: [PATCH v5 09/15] s390/vfio-ap: Add method to set a new guest=
 AP configuration ---
commit c2bb55ba8d50e1fc1f6fb1459cd3cfcecf5e78d5
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add method to set a new guest AP configuration
   =20
Adds a new vfio_ap_set_new_config function to set a guest's AP
configuration. This is needed in order to set the state of the mdev when
it is migrated from a remote host system during the RESUMING phase.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 678bdd4c82e95..454bb9fe19716 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -875,7 +827,7 @@ static void vfio_ap_mdev_unlink_fr_queues(struct ap_m=
atrix_mdev *matrix_mdev)
>  			q =3D vfio_ap_mdev_get_queue(matrix_mdev,
>  						   AP_MKQID(apid, apqi));
>  			if (q)
> -				q->matrix_mdev =3D NULL;
> +				vfio_ap_mdev_link_queue(matrix_mdev, q);

[Severity: Critical]
Is it intended to link the queue here rather than nullifying the pointer?

When an admin removes an AP mdev device, vfio_ap_mdev_remove() calls
vfio_ap_mdev_unlink_fr_queues() immediately before freeing the matrix_mdev.

Since this replaces the pointer nullification (q->matrix_mdev =3D NULL) with
a call to vfio_ap_mdev_link_queue(), which acts as a no-op if the queue is
already linked, does this leave the physical queues with dangling pointers
to the freed mdev?

>  		}
>  	}
>  }

[ ... ]

> @@ -1725,54 +1678,100 @@ static void ap_matrix_copy(struct ap_matrix *dst=
, struct ap_matrix *src)

[ ... ]

> +int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
> +				 struct ap_matrix *m_new)
> +{

[ ... ]

> +	/* Need old bitmaps in matrix_mdev for unplug/unlink */
> +	ap_matrix_copy(&matrix_mdev->matrix, &m_old);
> +
> +	/* Unlink removed adapters/domains */
> +	vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, m_removed.apm);

[Severity: Critical]
This is a pre-existing issue, but can this lead to a use-after-free for
queues that are filtered from the guest APCB?

If an admin unassigns an adapter that was filtered from shadow_apcb,
vfio_ap_mdev_hot_unplug_adapters() unlinks it from the hash table but skips
adding the filtered queue to qlist (checked in vfio_ap_mdev_unlink_adapter).

Because it is never added to qlist, the cleanup loop in
vfio_ap_mdev_hot_unplug_adapters():

list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
        vfio_ap_unlink_mdev_fr_queue(q);
        list_del(&q->reset_qnode);
}

completely misses this queue. This leaves q->matrix_mdev pointing to the
mdev. Since the adapter is cleared from matrix_mdev->matrix.apm, a later
mdev destruction would skip cleaning it up, leaving a dangling pointer.

> +	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, m_removed.aqm);
> +
> +	/* Need new bitmaps in matrix_mdev for linking new adapters/domains */
> +	ap_matrix_copy(&matrix_mdev->matrix, m_new);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D9
