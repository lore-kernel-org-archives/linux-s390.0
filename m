Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E83B1006;
	Fri,  7 Aug 2026 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142274; cv=none; b=imJOtiF4QFBkTDmP6XyGX+y4nTtYVmz5eEeVSoBDGSlGKztaARrWGpl4/XHT2zICrtwS6rHd6fXkS+v3wLXOL0e1PFYd6XkQLkyMBZfRtSC+ah488lkjfD9JbYXx/m7DcQDrbb4VwFQpZ7595QR9Ls4AotSYzMNNW3mML8CU5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142274; c=relaxed/simple;
	bh=0ZJmedOLYoRv7UR92bKf4BdwKjTxr0xBvI24UFvfYY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RK/RQUKkt86zDcGhomC16LzefIh26bXqBw0eaqiRt4H6MZHvG+VXWqaZhaS7FLhHLP0SItmzrByloaODPReA3UPgW3vpegm3knXLa33YLq6wHG5V/tN5/qq3FkCv/NA5HRhzT7ydEmbZTVCiAdpBnY3k+l8wakkdSSL9sby9CDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIQ8uC/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIQ8uC/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6F21F000E9;
	Fri,  7 Aug 2026 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142272;
	bh=N8y+dzhNbe+35HF2ffv/jt7iTHDdtdG5MP9uY8ON3JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIQ8uC/cOVvx7YKxaB17jPtvV5Ncy8woUulpeXcDi8sY+oyUzGAkr6jSoSeqqKS6X
	 Dq6P+c98lWL/gWs3XrHfREZGdB4cWRWQ7ZmAlqeuTVpACdFTZoGcp+1KDoT4Qh/oj2
	 ksYj4EOb0zmxvBMHjgI4NgrDlmfyx8AhntjqqvLDefESfZgWXtu9wp6UCRO8lclPrh
	 rjFz7VZpf1NRZs4gQ4yvnYvHnze5SC77XfAZ7ZthM/ktPERaQBOIGDSlW3IOnWpiuw
	 hUvzulPm+jTfMPOD2RDGeB4uLKRt/mNNWPWBJvDu6Zc0dEOcuPPoJYxLcxm1c5fWHd
	 q/SD/ZVzm4wYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260807221834.562851-8-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:37:51 +0000
Message-Id: <20260807223752.4A6F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Dropping `mdevs_lock` before `copy_to_user()` in `vfio_ap_stop=
_copy_read` exposes `mig_data` and its `ap_config` buffer to concurrent fre=
es, leading to a Use-After-Free and kernel memory leak.
- [High] Concurrent reads from the stop_copy file race to initialize `ap_co=
nfig` because `mdevs_lock` is temporarily dropped in `vfio_ap_get_config()`=
, causing memory leaks of dynamically allocated configuration buffers.
- [High] Caching the local `mig_file` pointer before dropping `mdevs_lock` =
in `vfio_ap_get_config()` leads to a Use-After-Free if `mig_data` is reallo=
cated.
--

--- Patch [7]: [PATCH v7 07/15] s390/vfio-ap: File ops called to save the v=
fio device migration state ---
commit 373ad9ea7be2af5d58b1a74f7797578d1528e3b7
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to save the vfio device migration state

This patch implements the read callback for the vfio-ap device migration
state file. It copies the guest's AP configuration and hardware information
to userspace when the migration state transitions to STOP_COPY. This state
data will then be transferred to the destination host.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index de693b308925d..50781b61f7f18 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -150,6 +144,279 @@ static int vfio_ap_release_mig_file(struct inode *f=
ile_inode, struct file *filp)
>  	return 0;
>  }
[ ... ]
> +static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
> +{
[ ... ]
> +	ap_configuration =3D kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
> +	if (!ap_configuration)
> +		return -ENOMEM;
[ ... ]
> +	/*
> +	 * Unlock the mdevs_lock so other mdevs are not precluded from being
> +	 * accessed while a potentially long running operation is performed.
> +	 */
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +	ret =3D vfio_ap_store_queue_info(mdev_name, ap_configuration);
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	if (ret) {
> +		kvfree(ap_configuration);
> +		return ret;
> +	}
> +
> +	if (!matrix_mdev->mig_data) {
> +		kvfree(ap_configuration);
> +		return -ENODEV;
> +	}
> +
> +	matrix_mdev->mig_data->stop_copy_mig_file.ap_config =3D ap_configuratio=
n;

[Severity: High]
Can two concurrent reads cause a memory leak here?

Since mdevs_lock is temporarily dropped above, both threads might observe
that ap_config is NULL in vfio_ap_stop_copy_read(), and both would allocate
an ap_configuration buffer.=20

When they reacquire the lock here, they will both blindly overwrite
matrix_mdev->mig_data->stop_copy_mig_file.ap_config with their respective
allocations, permanently leaking the buffer allocated by the first thread.

> +	matrix_mdev->mig_data->stop_copy_mig_file.config_sz =3D ap_config_size;
> +
> +	return 0;
> +}
> +
> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *bu=
f,
> +				      size_t len, loff_t *pos)
> +{
[ ... ]
> +	matrix_mdev =3D filp->private_data;
> +	mig_file =3D &matrix_mdev->mig_data->stop_copy_mig_file;
> +
> +	if (!mig_file->ap_config) {
> +		ret =3D vfio_ap_get_config(matrix_mdev);

[Severity: High]
Could the cached mig_file pointer become stale and cause a use-after-free?

Because vfio_ap_get_config() temporarily drops mdevs_lock, a concurrent
thread could potentially free and reallocate the mig_data structure. When
vfio_ap_get_config() returns, the stack-cached mig_file pointer might still
point to the old, freed mig_data structure.

> +		if (ret) {
> +			mutex_unlock(&matrix_dev->mdevs_lock);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Compute the offset and clamped length fully under the lock so that
> +	 * concurrent read()s on this stream file each see a consistent view of
> +	 * the current position.  *pos is advanced here while we still hold the
> +	 * lock; copy_to_user() then uses the snapshot read_pos.  This prevents
> +	 * two threads from calculating the same offset and both copying the
> +	 * same region (or one reading past the end of the buffer).
> +	 */
> +	if (*pos >=3D mig_file->config_sz) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return 0;
> +	}
> +
> +	len =3D min_t(size_t, mig_file->config_sz - *pos, len);
> +	if (len =3D=3D 0) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return 0;
> +	}
> +
> +	read_pos =3D *pos;
> +	*pos +=3D len;
> +
> +	/*
> +	 * Drop the lock only for the copy_to_user().  The ap_config buffer is
> +	 * stable: it is allocated once in vfio_ap_get_config() and freed only
> +	 * in vfio_ap_release_stop_copy_file() which requires mdevs_lock.
> +	 * Since we already advanced *pos above, no other thread will compute an
> +	 * overlapping region.
> +	 */
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))

[Severity: Critical]
Is it safe to access mig_file and its ap_config here without the lock?

Once mdevs_lock is dropped, a concurrent thread could close the VFIO device
or issue a reset, which acquires mdevs_lock and frees both the ap_config
buffer and the mig_data struct.=20

If that happens before or during copy_to_user(), it could result in reading
freed kernel memory and leaking it to userspace, or crashing the kernel.

> +		return -EFAULT;
> +
> +	return len;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D7
