Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528BFBE1;
	Mon, 27 Jul 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175878; cv=none; b=J4G8wU7LdLF0Fb0lLW9GOJToe4XDjURIxs2oDET7s6eS4lM6lHltAJVw7mvNCqbnVe0EVCZgQffgnQgiSt4BTe+8rvvNcVZQvUH+afPIT0WtH2tCus9/jVqvg2tOryc9VlN7n03pDfYrn9+kt6sK9I3INarg+wR/vC66siBhINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175878; c=relaxed/simple;
	bh=/dUFCDT0k9LkJ/89b1BXcF9jTyoN5IE5ZlvON9j2jHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IfkyQbg05iwf3yxCJhmDQPlNdz/dfdwOEasjrsJ5qtQyEyI+clJaPgPrp78NlExn1pfdrpqfIObpabrDIoHtGrCPjuZQbtcbfuOqyxfsnWQIQSEVyu2XmF8y7lue5oXNFDaCjs9SNgjnoPQFpCUH7DglSCPutHuGbrm/S+UC9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKY1gnhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKY1gnhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766031F000E9;
	Mon, 27 Jul 2026 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175877;
	bh=tHJ508COkk567brZxTHS/BtqqliuTsjTU18/5CcI6wM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YKY1gnhhrvqfanQKLRUBxqG0CPq9MbQONF8qAa57au4oXNa3Bek0Nqto7N1vun969
	 2SQD6X2GBeaKnXA0PS/2dzpkXGdD2ssFIKX1cmgJTw/jzge+2+F6oQLPlz82f82coe
	 UHziRCe8o3BRdYCtO0DRkjAPGihBKQ8K0So/N0uCuCkwcZjGLpKJAEXqBJpo7rV7Df
	 a3Xzgn7ftSUWiLBuKYdgkMzjxEx0FPiGxC8JqZ9xbO/FLFHgihhcn7ip5BQZJDb8vR
	 Ji5U9l4j0U5Tjvg0D6J0+OBBmHHrMrJXqNB1nG18XJ6ZOlDDM+sPcZdp7BhhawrV8o
	 jhD1XGocvZu6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727173239.2420754-10-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:11:17 +0000
Message-Id: <20260727181117.766031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Latent NULL pointer dereference in `collect_queues_by_apid` due =
to contradictory logic.
--

--- Patch [9]: [PATCH v6 09/15] s390/vfio-ap: Add method to set a new guest=
 AP configuration ---
commit 5b979f09ef9429e09eace5977dabbd22cc832bbf
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add method to set a new guest AP configuration

This commit adds a new vfio_ap_set_new_config function to set a guest's AP
configuration. It refactors code from ap_config_store to handle changes to
the sysfs ap_config attribute and support live guest migration.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index d05372b50d2fc..0b49be22d5d8b 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> -static void collect_queues_to_reset(struct ap_matrix_mdev *matrix_mdev,
> -				    unsigned long apid,
> -				    struct list_head *qlist)
> +static void collect_queues_by_apid(struct ap_matrix_mdev *matrix_mdev,
> +				   unsigned long apid,
> +				   struct list_head *qlist)
>  {
>  	struct vfio_ap_queue *q;
>  	unsigned long  apqi;
> =20
>  	for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS) {
> -		q =3D vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi));
> +		q =3D matrix_mdev ?
> +				vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi)) :
> +				vfio_ap_find_queue(AP_MKQID(apid, apqi));

[Severity: Medium]
Will this result in a NULL pointer dereference if matrix_mdev is NULL?

The loop condition unconditionally accesses matrix_mdev->shadow_apcb.aqm.
However, the ternary operator inside the loop (matrix_mdev ?) suggests
that matrix_mdev could be NULL.=20

If matrix_mdev can indeed be NULL, the unconditional dereference in=20
for_each_set_bit_inv() will crash before the check is evaluated. If=20
matrix_mdev is never NULL in practice, is the ternary check necessary?

>  		if (q)
>  			list_add_tail(&q->reset_qnode, qlist);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D9
