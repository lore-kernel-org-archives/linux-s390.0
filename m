Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268772630;
	Mon, 27 Jul 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176389; cv=none; b=hHHohkmCPMwm7R7LZEL8p2ciSCEQrBE2ijwE6iEwgxC8/woXrMgBZiQGI55v41XcLyhEFqe9XQVQl/7avNGW1jRuHdLkj+Y7oxn4l9cE7ip6UdIVztPWgGPnYJIAE7u+30aXJG/C4vQtYtGj4jmht+XytW5KmOlbmAt65BneNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176389; c=relaxed/simple;
	bh=toOwfmao43E6KACUKATlOMZvYgB9Kn5VyGVICJgMC4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mp+U3vll5KA7fs631IWPVQ8E2cRY5k+ZjE21vjihshsgSnBruRSg9nTh7bO6XVlKDPGOy0Kc65nm1gQhQCzJCThsG6szBx9qn3/zuQ9bDxi0SNmWaisZK+P953iT1pOSOscj8S8UWkStq/A1CazVum9kwPKaWV8Er83mjSu2Vjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mendpg59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mendpg59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E251F000E9;
	Mon, 27 Jul 2026 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176387;
	bh=tHE+gnG24Ffg8HAvzMcAEr+BskULN9R9nTiYVYgVKJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mendpg598uZJS9viAU2LAtzY0xKvnegE9Fv9Qr2i8kuWaRXSfnB+VlOTKDtSCZknj
	 ejlr37U4Vxd2Mctdw7p7ix6aG/040deyh6Y3ygvRcnlz4ONOdJwzXxZ+8Dq95nEHrV
	 zXNp1rBudziVEG9uhkUC/RTAnsh/Eqckz41c3SUWhTe7Z4c9Fgeq0BxCfTHZlAuKhN
	 YgT9mNWW08osKPCH0+nWGe9XrqbhFbymcZETTDQHJU3A82OkhOWYrX6dLPtkox8Mjn
	 vep6VHyYeA9X8qPu/ulNfOdlZLvKDgySeVv2eQ2jgMQurwb+0yVznqv1F8dTxMZmVL
	 ho0fVOXdbwfTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/15] s390/vfio-ap: Callback to get the size of data
 to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260727173239.2420754-14-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:19:46 +0000
Message-Id: <20260727181947.66E251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Logic duplication for calculating the configuration size.
--

--- Patch [13]: [PATCH v6 13/15] s390/vfio-ap: Callback to get the size of =
data to be migrated during guest migration ---
commit f0e78a002713b19ca67967cef71fbd73dea59ee7
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Callback to get the size of data to be migrated during guest =
migration

This commit adds the mandatory migration_get_data_size callback for VFIO
migration support on the s390 vfio_ap driver. The callback calculates the
estimated data length required to migrate the device's internal state.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 1c385908fc39b..8379cf8bbce89 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1392,7 +1392,18 @@ static int vfio_ap_get_state(struct vfio_device *v=
dev,
>  static int vfio_ap_get_data_size(struct vfio_device *vdev,
>  				 unsigned long *stop_copy_length)
>  {
> -	return -EOPNOTSUPP;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	size_t qinfo_sz;
> +	int num_queues;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	num_queues =3D vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
> +	qinfo_sz =3D num_queues * sizeof(struct vfio_ap_queue_info);
> +	*stop_copy_length =3D qinfo_sz + sizeof(struct vfio_ap_config);

[Severity: Low]
Does this code manually duplicate the size calculation logic already presen=
t=20
in the existing static helper vfio_ap_config_size() within this same file?

Additionally, since struct vfio_ap_config uses a trailing flexible array=20
member for qinfo, would it be better to use the standard struct_size() macr=
o=20
to compute the total length instead of manual multiplication and addition?

> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D13
