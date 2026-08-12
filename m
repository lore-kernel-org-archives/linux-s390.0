Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651C346774;
	Wed, 12 Aug 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555740; cv=none; b=ZUIYdONSfzyNi3GbRxzmNvgDBv1tfRrial5+oXnMczX/XotNF6KGCJ2nBvqb05qMztl9HncX0I+I8S6ZBn6Hd5ozRtMue2Fq2BT+GiW0gN8Wi6SGpIP7ETBdtj/9pX5rm7tGkZ4pL5+JJxApILKBIeXSltjv2xfSBFwMtuo+4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555740; c=relaxed/simple;
	bh=jU82JFdYllII3mdYoWvjLPSv6HUN1EyeJs6MEUv9JMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJ1utZSUz3edWctkSP5GVlgWHwJjDG8sP5IhzzrKOUFZVIMqqH3LPtQhDH+hgbiZYZSUFf8OgOOGNxRhu73Ek+Ur0+m83axWMz/Io4GPbn8w98WwyuWeyM3ZLE92fI0CRwtR3TYvYCSeq4aDFPH4ZNmGGxU5dp0UlWWysdJ3mmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubn50fnA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ubn50fnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7241F000E9;
	Wed, 12 Aug 2026 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555738;
	bh=UZlkjwEqfT+694LNki6gFTXGnDqTp0C4ibbG2jUWGtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ubn50fnAk2kwgtwnnaMiqJBa+6ZlRY/kOUhOoq7Gyu8j3G82WvCU/XUbrMxMSVOju
	 I458jgYEsMLcjZVdJYnX89mgr21vo3M89zvEoKKZr7AgrlM5VEW2s/WzO69mj87Syx
	 GvFGsx03RQiG7u7EV9i7oNUS+UGXCyAUFgeM4fU1xC5gX51+m5qMZAfaUU5H0Yh74E
	 7xjiEl5UGIiPDRJx6rbppN5xd7+/rcThamwQCxj5M8yXOLTZtAVYQGQtr1LWkpG1wq
	 0xw8SkPOLDGDDhe/Wf+49SfiF2w7kPDs8prPnFyQedIrQYbyw8CY3a68MUBPTTLa62
	 GIGpd4zzbsmvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] s390/vfio-ap: Fix missing lock required to
 access list of ap_matrix_mdev objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812170945.738351-4-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:28:57 +0000
Message-Id: <20260812172858.2B7241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The sysfs file 'status' is exposed to userspace before the dev=
ice's driver data is fully initialized, leading to a potential NULL pointer=
 dereference in status_show().
- [High] A race condition in vfio_ap_mdev_probe() allows userspace to bypas=
s the 'one mdev per KVM' isolation restriction.
- [High] Eventfd contexts for `req_trigger` and `cfg_chg_trigger` are leake=
d when the mediated device is closed or removed.
--

--- Patch [3]: [PATCH v4 3/9] s390/vfio-ap: Fix missing lock required to ac=
cess list of ap_matrix_mdev objects ---
commit b763c5c7bf7a38cb1fc2e2da2ff0df92d3ae360c
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev ob=
jects

This patch fixes list traversal synchronization for ap_matrix_mdev objects
by adding guests_lock around mdev_list access. It also removes redundant
zero-initialization of eventfd triggers in the probe function.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index c6bee69cc22f6..f2d662e388bdc 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -800,12 +800,17 @@ static int vfio_ap_mdev_probe(struct mdev_device *m=
dev)
>  	ret =3D vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);

[Severity: High]
This isn't a bug introduced by this patch, but does exposing the VFIO
device to userspace here create a race condition?

vfio_register_emulated_iommu_dev() makes the device visible to userspace
before it is added to matrix_dev->mdev_list under guests_lock. Could
userspace open multiple mdevs concurrently, allowing them to bypass the 'one
mdev per KVM' isolation restriction since vfio_ap_mdev_set_kvm() won't see
the other devices in the list yet?

>  	if (ret)
>  		goto err_put_vdev;
> -	matrix_mdev->req_trigger =3D NULL;
> -	matrix_mdev->cfg_chg_trigger =3D NULL;

[Severity: High]
This is a pre-existing issue, but since you are touching the eventfd trigge=
rs
here, are they properly cleaned up when the device is closed?

Userspace can set IRQ triggers via VFIO_DEVICE_SET_IRQS, which calls
eventfd_ctx_fdget() and takes a reference. If the user closes the device
without unregistering the IRQs, shouldn't vfio_ap_mdev_close_device() or
vfio_ap_mdev_remove() call eventfd_ctx_put() for req_trigger and
cfg_chg_trigger to prevent a memory and file descriptor leak?

> +
> +	/*
> +	 * Take the matrix_dev->guests_lock mutex before adding the matrix_mdev
> +	 * to the mdev_list. All functions that traverse the list must also hold
> +	 * this lock to guard against additions to or removals from the list
> +	 * while it is being traversed.
> +	 */
> +	mutex_lock(&matrix_dev->guests_lock);
>  	dev_set_drvdata(&mdev->dev, matrix_mdev);
> -	mutex_lock(&matrix_dev->mdevs_lock);
>  	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
> -	mutex_unlock(&matrix_dev->mdevs_lock);
> +	mutex_unlock(&matrix_dev->guests_lock);
>  	return 0;

[ ... ]

> @@ -2316,6 +2323,7 @@ static ssize_t status_show(struct device *dev,
>  	struct ap_matrix_mdev *matrix_mdev;
>  	struct ap_device *apdev =3D to_ap_dev(dev);
> =20
> +	mutex_lock(&matrix_dev->guests_lock);
>  	mutex_lock(&matrix_dev->mdevs_lock);
>  	q =3D dev_get_drvdata(&apdev->device);

[Severity: Critical]
This is a pre-existing issue, but is it possible for dev_get_drvdata() to
return a NULL pointer here if the status sysfs file is read concurrently
with device probing?

During vfio_ap_mdev_probe_queue(), sysfs_create_group() creates the status
attribute before dev_set_drvdata() initializes the driver data. Can a
concurrent read of the status file fetch a NULL pointer in status_show() and
pass it to vfio_ap_mdev_for_queue(), causing a crash when it dereferences
q->apqn?

>  	matrix_mdev =3D vfio_ap_mdev_for_queue(q);
> @@ -2343,6 +2351,7 @@ static ssize_t status_show(struct device *dev,
>  	}
> =20
>  	mutex_unlock(&matrix_dev->mdevs_lock);
> +	mutex_unlock(&matrix_dev->guests_lock);
> =20
>  	return nchars;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812170945.7383=
51-1-akrowiak@linux.ibm.com?part=3D3
