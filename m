Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DF4D37B8;
	Fri,  9 Oct 2026 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546873; cv=none; b=XRBaQ/kGL7eFWNHCUOPWhdv+ootchLXL7aJQimvGkt6e2SfXZeamwU+3bGTBDhMXZVBvpX2uVWXypFep+K/4L8vP/cX3GQDmub7Y1PLos3N+KM7IX0Se2XcLNQeIVP+U1579ushDS6TiV+8Wn5eLu1/4/sr2vxVxlBjDMrXcgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546873; c=relaxed/simple;
	bh=6t6mEz+cvcR0oXo7AK8iK13o7n0j+GsJ2nywTs3Ke+s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ge195ztfM/4Pxr5d97FzXeTJ1x6YDn3w2RQ8cFInesKBybMbLViJAdjRcilfDfedajti6F53OTWpolt1dbfD3jTBGt2er6vCpBzloJiYAqZRULSF9Plg9Kysi0lcLyutvUor8p6Rb7nplNt9TIWF9xyPm+aqVTzoYc4+BPV6Gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHQGfxDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHQGfxDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6241F000FF;
	Fri,  9 Oct 2026 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546862;
	bh=Mjt3+EwF7hHNPXGqu9sKhUnfo5HWRd6xcgmHTg1dUOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHQGfxDLNnipx/hqrV9rErZmKVYC42rBpqnA9ZZwWVkvYxJuFoGn5H73T2fKFCfSV
	 0dYCOZTfVmvR5k6TQrj1J6Fzg03Toj9sHVSuk54wDd3og0cEa4rV3HQMMxhG8TXzzj
	 TNjMIppE1o2mgg8kelRCpj9Yv+nCFmBC2iC1nSLzNDOqXF12vjNJwmDD5ZAK/s89E8
	 BVdyL3tqx5c6A8NO53sN+YAY9cH5pGxhF/WxlcpXRMCOFq+xS0BSFaaX/wnWNI/Yt8
	 9TpT9j2PWH3YECnGuah17vaGvXn+3MMk+mPNRuVaSuwEDY6zMQgWDA7juNvDFm2kFE
	 viIgEJ1vJ/rpw==
Message-ID: <sashiko-outbox-165444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20261009114244.1213173-8-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:54:21 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] vfs: stream position permanently advanced on copy_to_user failure
- [Low] vfio: missing memory cleanup in vfio_ap_release_mig_file contradict=
s documented design
--

commit e098ee9f1268fb534553f678f8c768d5b444ac95
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to save the vfio device migration state

This commit implements the read callback function for the file created to
save the state of the vfio-ap device when transitioning to the STOP_COPY
state. It copies the guest's AP configuration information to userspace.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index bbd007c06a776..0c43f25e2d9ba 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -150,6 +144,276 @@ static int vfio_ap_release_mig_file(struct inode *f=
ile_inode, struct file *filp)
[ ... ]
> +	/*
> +	 * Lazy initialization: the migration config is generated on the first
> +	 * read() call. vfio_ap_open_file_stream() initializes ap_config to NULL
> +	 * and config_sz to 0. On first read, we generate the config by
> +	 * snapshotting the guest's APQNs from shadow_apcb and retrieving hardw=
are
> +	 * info via TAPQ for each queue. The result is cached in mig_file->ap_c=
onfig
> +	 * for subsequent read() calls. The config is freed when the migration =
FD
> +	 * is released (vfio_ap_release_mig_file -> vfio_ap_release_stop_copy_f=
ile).
> +	 */

[Severity: Low]
The documentation here states the configuration is freed when the migration
file descriptor is released by calling vfio_ap_release_stop_copy_file() from
vfio_ap_release_mig_file().

However, looking at the existing vfio_ap_release_mig_file(), it doesn't
appear to call vfio_ap_release_stop_copy_file() during cleanup:

static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *=
filp)
{
	struct ap_matrix_mdev *matrix_mdev =3D filp->private_data;

	/* ... */
	vfio_device_put_registration(&matrix_mdev->vdev);
	return 0;
}

Could this lead to delayed resource reclamation and a dangling pointer since
the ap_config buffer isn't actually freed when the file descriptor is close=
d?

[ ... ]
> +	read_pos =3D *pos;
> +	*pos +=3D len;
> +
> +	/*
> +	 * Keep mdevs_lock held across copy_to_user() to prevent a concurrent
> +	 * vfio_ap_reset_migration_state() from freeing ap_config while we are
> +	 * reading it.  copy_to_user() may fault on a non-resident user page,
> +	 * but that is legal for a sleeping mutex.  The data transferred is at
> +	 * most a few KB for any realistic AP configuration, so holding the lock
> +	 * here is acceptable.
> +	 */
> +	if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len)) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return -EFAULT;
> +	}
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return len;
> +}

[Severity: Medium]
If copy_to_user() fails and returns -EFAULT, pos has already been permanent=
ly
advanced by len.

Will a subsequent read() on this stream start from the advanced offset,
skipping over those bytes and breaking the migration data stream?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D7
