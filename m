Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E138E8BA;
	Wed, 12 Aug 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555452; cv=none; b=sJDR4VATRycYM7Z3Fm5zYgI67vNvAPtjuBxUUqGYVTCZ2ehL344JGNLsu5wxep+Ilk2F/8fpRAjtbIi7kU6UDVVW0eBfWpbA01C1hhQKk81WI5lkr2JDQ+xfBIk2E4rnwZqNcMzp5flpWwGrvvrok+p55XdvFUES3XXKHHo96ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555452; c=relaxed/simple;
	bh=/8BZynyWj2yBD6DBzfTS1GxhyQQD2qzFP9Mwq2yOJTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QhWiPiHcbLZWytvWMfrVXDFhB5HvE98OGMEz8z8iGSyatGbNaE3fmxxkgc6FYZbYxKGsE84EOKGXyKHtUdSvArFhEUs+vB1fS2yQOquoE6xUDa0zJKOd7YUtxAhRyCK99GK9wAJVP7bozNCRZuGA2V5EnIxQZDJ82kCpTAIhz/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM59o8i6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM59o8i6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032A51F000E9;
	Wed, 12 Aug 2026 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555451;
	bh=+NBa0T0J7sLgitLHG6Q+vJYHQk0bUcHb/On6Jv08cQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dM59o8i6pFWSF+BBAs6e6mKx2cAOLSs7Efc6WnqKdniL3CodzfOjHaqtB3W+d2M+K
	 P8p/nA+i1/Hf44eQ0vXdPgXKTeLVuVOH8lMOVLcak2fmX3AEiexMoaOhe+JOEZyrEw
	 Gg6QZm+jU9ohS8Iw5/O6+jG4+iC9c7pgaQ1I9bVmm6e5y3Gz16cFrfXK/Cl4YIYJ+Y
	 29homCope+xgrCZopReFghWVdYaw27kQ167KsrSCYExxBUpLN6UVJAajrERYHTcnaP
	 x40CX1q6XZ8uTTe2kmD74AA+rY+ULOv13AvRkSUZm4bf+l5ruj9c/1pt7b82DAo+Es
	 YKNIhaamc9GPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] s390/vfio-ap: Fix hot-unplug skipped when last
 AP adapter or domain removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812170945.738351-8-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:24:10 +0000
Message-Id: <20260812172411.032A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pinned NIB pages and KVM ISC registrations are permanently leaked =
when an AP queue is removed from the host configuration.
--

--- Patch [7]: [PATCH v4 7/9] s390/vfio-ap: Fix hot-unplug skipped when las=
t AP adapter or domain removed ---
commit b0a12cab04822e364a31d2095615141da73872b3
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain removed

This commit fixes an issue where the guest APCB is not updated when the
last AP adapter or domain is removed. It replaces the bitmap_andnot check
with bitmap_intersects to properly detect overlaps and trigger the guest
update.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2568,24 +2568,28 @@ static void vfio_ap_mdev_hot_unplug_cfg(struct ap=
_matrix_mdev *matrix_mdev,
[ ... ]
> +	if (bitmap_intersects(matrix_mdev->shadow_apcb.adm, cdrem, AP_DOMAINS))=
 {
> +		bitmap_andnot(matrix_mdev->shadow_apcb.adm,
> +			      matrix_mdev->shadow_apcb.adm,
> +			      cdrem, AP_DOMAINS);
> +		do_hotplug =3D true;
> +	}
> =20
>  	if (do_hotplug)
>  		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>  }

[Severity: High]
This is a pre-existing issue, but while reviewing the hot-unplug path I
noticed a potential resource leak in vfio_ap_mdev_remove_queue().

When an AP adapter or domain is hot-unplugged, it is removed from
matrix_dev->info during the configuration change. Later, when the AP bus
calls vfio_ap_mdev_remove_queue(), it checks the matrix_dev->info bitmaps:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_remove_queue() {
        ...
        if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
            test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
                vfio_ap_mdev_reset_queue(q);
                flush_work(&q->reset_work);
        }

done:
        if (matrix_mdev)
                vfio_ap_unlink_queue_fr_mdev(q);

        dev_set_drvdata(&apdev->device, NULL);
        kfree(q);
}

Because the queue is already removed from matrix_dev->info by the time this
is called, the test_bit_inv() checks evaluate to false.

Does this bypass vfio_ap_mdev_reset_queue() and permanently leak AQIC
resources like NIB pinned pages and KVM ISC registrations before the queue
is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812170945.7383=
51-1-akrowiak@linux.ibm.com?part=3D7
