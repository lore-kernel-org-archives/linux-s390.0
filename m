Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4A33F8A1;
	Sat,  8 Aug 2026 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786210336; cv=none; b=V55/RGT3YGPpXVClIdXujAg7bUPZoLiDtRYc34UMwz8jgL4q5Y6zphBM5TmfLve+PT+dye8s2K07BdVZIRowcKlHuYrmBvRe/bpbfKCGhPvmJZ5CtLjdYV/VXcGCgSUrw1AAh5bZFQml+T/bV9t1YSt3mINx6rzBtPYqCEz2rHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786210336; c=relaxed/simple;
	bh=H+680w6SS93gkmv9OZX15+fQJwC9HmpKAORUplrRw40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjFq+oAoTG+xM0V6lhH07WxvXsPDC+woEqZ0FvwSA70bwp0b7RSuSJAbdWQsDFBlcQPYwRVG7TsE6R7c7n4O/450Oh+NbeR8dOJD77WXfnF/KE287tjAZ+d0IWJTU8RICgRMil4WMUWbHKLKTNgl+6gcfzzKQNgVaqfVb7GVwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuX9i7sM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuX9i7sM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405CB1F000E9;
	Sat,  8 Aug 2026 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786210334;
	bh=yZJtGAHeqExc89lExjssGTS+rQLn06kc2qqJrnZ4U9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZuX9i7sMnxgL5dEhwrIZleWA4G1xpISmoQSw26URxdSJVSarUyfNJR2GLwWMlTV+6
	 Dv1PDihiV/zjv7oHEIk+OnFiwqN2kGT8CjWUzpTvc6hce4UCF8SFzuc9yXI7lH+v14
	 Cz77AZgmQVjjCiMYt+BNfmFpUUUCzBDvEvqGHQHX4BTQTFUsqxqh+revOm3rw5JJsJ
	 6uHaNOqjymlFPO6dwFgOnAeE3VFWi/39B+NvlHPueSsjg3pcFgo1WLAoaRT3osFJoM
	 n0VHAMmhhooJ+9xkQU9TqdvATEs01aLNuOobDKjLHEA5LEXD2d45wNrmz7LiI9u/Gt
	 Y9zxB7FfltcqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] s390/vfio-ap: Fix use of wrong lock in mdev probe
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260808170712.839066-4-akrowiak@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
 <20260808170712.839066-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 17:32:13 +0000
Message-Id: <20260808173214.405CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race and list corruption due to mismatched locks on list trav=
ersal and mutation.
--

--- Patch [3]: [PATCH 3/5] s390/vfio-ap: Fix use of wrong lock in mdev prob=
e function ---
commit 6ed976a494c7af5de9033ac808583fad9a0cb4f7
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix use of wrong lock in mdev probe function

This commit changes the lock used to guard the addition of a newly created
ap_matrix_mdev object to matrix_dev->mdev_list in vfio_ap_mdev_probe()
from mdevs_lock to guests_lock.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index e382e5a1cb996..a472de00bc149 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -803,9 +803,9 @@ static int vfio_ap_mdev_probe(struct mdev_device *mde=
v)
>  	matrix_mdev->req_trigger =3D NULL;
>  	matrix_mdev->cfg_chg_trigger =3D NULL;
>  	dev_set_drvdata(&mdev->dev, matrix_mdev);
> -	mutex_lock(&matrix_dev->mdevs_lock);
> +	mutex_lock(&matrix_dev->guests_lock);
>  	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
> -	mutex_unlock(&matrix_dev->mdevs_lock);

[Severity: High]
Does changing this lock to guests_lock create a data race when traversing
the list in other functions?

For example, when a userspace process reads the status attribute,
status_show() only acquires mdevs_lock before calling
vfio_ap_mdev_for_queue():

drivers/s390/crypto/vfio_ap_ops.c:status_show() {
    ...
	mutex_lock(&matrix_dev->mdevs_lock);
	q =3D dev_get_drvdata(&apdev->device);
	matrix_mdev =3D vfio_ap_mdev_for_queue(q);
    ...
}

Which then iterates over the list relying on the assumption that writers
will hold mdevs_lock:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_for_queue() {
    ...
	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
    ...
}

If vfio_ap_mdev_probe() is called concurrently with status_show(), could
this cause list corruption or a use-after-free panic since the reader and
writer are no longer synchronized with the same lock?

> +	mutex_unlock(&matrix_dev->guests_lock);
>  	return 0;
> =20
>  err_put_vdev:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808170712.8390=
66-1-akrowiak@linux.ibm.com?part=3D3
