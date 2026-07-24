Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07182ECE86;
	Fri, 24 Jul 2026 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914581; cv=none; b=FiZZDNPSG0/hBMuOAj6GY/yN1rEjUgodmTE9FJFI1cKzFnqfY/zTgTmn0F3VhCXXngmdFCbFgkqSmst2sj92nYe7jcFdLEPWw3vH3e3DkNNwknbF6qdYInqHo9DIgpxS9c522sjyNpyGu42QyCv9gZQuywDFCQuJhlsfysKeREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914581; c=relaxed/simple;
	bh=UqeRppZbe9Jg1d6NVwQM+PpKCFJ3SRqHkaLVjdAfWto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rsJPiI1jVvNOeTIGGLrmc4ugwg2A1NE9cckMSUv38BpM8J1yhpRvMvFmsqYDNlubQnrQz9zi1Qc9iB0g6xre25xkk0kAA/RERComnA6tEJTSUNHVkT0p9HutXHJemGWr+Wt3vQe6k15gsiCkbDIZxodW6oDW3Gr7/ARFNL8X45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arDEzkMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arDEzkMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499731F000E9;
	Fri, 24 Jul 2026 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784914580;
	bh=L6SxlJKU4q1uqOJstxucrMx9VJnFmsnSbgG54yD6A+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=arDEzkMr/sSOdn2VJRcZU2Kk6/I9Me/3nN2xQlMOvLszwd+YPpdYoSFXVw7WJfy+i
	 1ecC6hGUQovAjCkzdORyyXwD6Jw7166N+EiKB6CqiZ6Of/XSzR9zRNQawodEynQhK9
	 uKw/ixiVIyibrnxgHcpv1Z6lfCWp0HrCL9uVEVUWuGPdBShHo5v8IhkpJuUFaaIra9
	 yhk40/QrdLyAU0m8WFJPeTLv3SYioJyjIYfVUZPdjvtAoBeAZF9yCzd5jEh6/ZJZSl
	 idFd/qi0FQ9yKJY8CjwAHVmlZpA/+iy25YjxAbYLqCglVyZVeVmJep3qPXAGuv8qmz
	 0uwoB3A65CHSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/15] s390/vfio-ap: Provide function to get the
 number of queues assigned to mdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724161351.1802644-2-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:36:19 +0000
Message-Id: <20260724173620.499731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Extremely inefficient nested bitmask iteration to count the numb=
er of queues.
--

--- Patch [1]: [PATCH v5 01/15] s390/vfio-ap: Provide function to get the n=
umber of queues assigned to mdev ---
commit c5c27f83fbf7c245f4954e58e37786067ff32658
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: Provide function to get the number of queues assigned to mdev

Provides a function that returns the number of queues that are or will be
passed through to a guest when the mdev is attached to a guest.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..71d3e2c2e07c6 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -2098,6 +2098,20 @@ static void vfio_ap_mdev_request(struct vfio_devic=
e *vdev, unsigned int count)
>  	release_update_locks_for_mdev(matrix_mdev);
>  }
> =20
> +int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
> +{
> +	unsigned long apid, apqi;
> +	int num_queues =3D 0;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	for_each_set_bit_inv(apid, ap_matrix->apm, AP_DEVICES)
> +		for_each_set_bit_inv(apqi, ap_matrix->aqm, AP_DOMAINS)
> +			num_queues++;

[Severity: Medium]
Is this nested iteration the most efficient way to calculate the total numb=
er
of queues?

On s390, find_first_bit_inv and find_next_bit_inv are external function cal=
ls.
If a significant number of bits are set in both masks, this loop will make
thousands of function calls simply to count bits, resulting in an O(N*M)
operation instead of O(1).

Could we instead multiply the weights of the two bitmaps directly without l=
oops?

return bitmap_weight(ap_matrix->apm, AP_DEVICES) *
       bitmap_weight(ap_matrix->aqm, AP_DOMAINS);

> +
> +	return num_queues;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D1
