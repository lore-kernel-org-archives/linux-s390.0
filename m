Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2909407CC6;
	Tue, 30 Jun 2026 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820593; cv=none; b=NTrrzIT+9/h/q5QuiUK4I2R1FExdRWncr8dAoFbpUswgDlzEBxMb/hm2OC9bSPiABGEqfELPLP/BNZfhq6tOllllyFL8W9TPe6GbhVDl/ZSAZd8Y5HCw8IuuwKpLcg7SCVLYYFrE8Sz+CH61LUpKVndASpNrRvlfxTmERwkvi48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820593; c=relaxed/simple;
	bh=SKYr8wXvNFDtwpUYFpXRKPRIZE4i6d8qwGIYJZJJCD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hnae6HsY2zvzZQ8d5V60Uof2HSsu2cio6VwCNUSvRe5mQzo8stBG6sMDUMCQ+KeH5FBGNDrSe3qz3h02s4Ei/YTiZFs/7rvhY/xeZOHW8SVbgoTF4/bUbWi7TJ6n+JQhxSQKe/69CP0/1A1RRqlFDzruVVo0rt456zIC3Px7BGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA8qlb+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA8qlb+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01EB1F00A3A;
	Tue, 30 Jun 2026 11:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782820591;
	bh=iCb5V49aIDl5k1qs08gc+VxaDrOeOLHdpWh02mrywkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IA8qlb+c6earjGnTdwsmu//h1oNY3zuPFBRi9WiRxVAz5p5iZFhMRbnqoFOQFttrH
	 zRAMFd1X4bTLl2CVj8fbloNbxC7Na7lumFiUilpthcatnCWmIkfKKp3ghqAmjMK0Nn
	 r5uf3h4zvk2m1+S1rRI7Q+ukKa9DalYRdmhBUqiJbJYU9T2wcqzgubmBt9N605wP2I
	 BEELNvWRhFNK4u82OpIqaarENfdmkoj/A96jCX6GTfRKTMsLdQaEDR6pWl8oYZ+NWZ
	 HEdzVYFcGFmM8umBCrDV53wkrt9ZjagHtmulmctLzA3sb3U46Exr/EvhOY2xN99xKT
	 JKuQtrIskE/WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/15] s390/vfio-ap: Add 'migratable' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-15-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:56:30 +0000
Message-Id: <20260630115630.F01EB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Dangling pointer in migration data after `krealloc`.
- [High] Unlocking an arbitrary thread's mutex using `mutex_is_locked()`.
- [High] Failure to persist `ap_config` pointer during chunked resuming wri=
tes causes memory leaks and breaks subsequent writes.
- [High] Uninitialized `config_sz` sent over the wire breaks buffer realloc=
ation on the destination host.
--

commit 0de28964ca6b520852841fe66380c0b0caacaec6
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue Jun 30 10:41:24 2026 +0000

    s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
   =20
    Add the 'migratable' feature to the features provided by the sysfs
    /sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
    of vfio devices is supported.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> new file mode 100644
> index 0000000000000..83e1ce2c40c0c
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -0,0 +1,1373 @@

[ ... ]

> +static int
> +vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev,
> +		   struct vfio_ap_config **ap_config, size_t *ap_config_size)
> +{
> +	struct vfio_ap_config *ap_configuration;
> +	int num_queues, ret;
> +
> +	*ap_config_size =3D vfio_ap_config_size(matrix_mdev, &num_queues);
> +
> +	ap_configuration =3D kzalloc(*ap_config_size, GFP_KERNEL_ACCOUNT);
> +	if (!ap_configuration)
> +		return -ENOMEM;
> +
> +	ap_configuration->num_queues =3D num_queues;

[Severity: High]
Does this code fail to initialize ap_configuration->config_sz before sending
it over the wire during vfio_ap_stop_copy_read()?

The config_sz field is left as 0, which is then sent to the destination hos=
t.

> +
> +	ret =3D vfio_ap_store_queue_info(matrix_mdev, ap_configuration);

[ ... ]

> +static ssize_t reallocate_ap_config(struct vfio_ap_config **mig_ap_confi=
g,
> +				    size_t len)
> +{
> +	struct vfio_ap_config *ap_config =3D *mig_ap_config;
> +	struct vfio_ap_config *new_ap_config;
> +	size_t new_cfg_sz, cur_cfg_sz;
> +	unsigned int num_queues;
> +
> +	cur_cfg_sz =3D ap_config->config_sz;
> +	num_queues =3D ap_config->num_queues;
> +
> +	/*
> +	 * If the current configuration size is greater than the
> +	 * size of a vfio_ap_config structure (i.e., contains the num_queues
> +	 * field), then there should already be enough storage allocated
> +	 * to store the source guest's AP configuration. Let's verify that the
> +	 * amount of storage allocated is what we expect based on the number of
> +	 * vfio_ap_queue_info objects that must be stored.
> +	 */
> +	if (cur_cfg_sz >=3D sizeof(struct vfio_ap_config)) {

[Severity: High]
Can this condition fail unexpectedly due to the uninitialized config_sz sent
from the source host?

During restoration, allocate_ap_config() receives the first chunk, storing 0
in config_sz. On the next chunk, reallocate_ap_config() reads cur_cfg_sz as=
 0.

The else branch is taken, where new_cfg_sz =3D cur_cfg_sz + len calculates =
len,
truncating the buffer to just the size of the incoming chunk, causing immed=
iate
-EIO failures.

> +		new_cfg_sz =3D calculate_ap_config_size(num_queues);

[ ... ]

> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
> +				      size_t len, loff_t *pos)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	struct vfio_ap_config *ap_config;
> +	struct ap_matrix guest_matrix;
> +	ssize_t ret =3D 0, cfg_sz;
> +	const char *mdev_name;

[ ... ]

> +	/*
> +	 * If this is the first write operation, then allocate storage for the
> +	 * AP configuration information; otherwise, reallocate the
> +	 * struct vfio_ap_config object used to store the AP configuration data
> +	 * sent from userspace.
> +	 */
> +	if (*pos =3D=3D 0) {
> +		ret =3D allocate_ap_config(&ap_config, buf, len);
> +
> +		/* If the allocation failed, we'll return the error */
> +		if (ret < 0)
> +			goto done;
> +
> +		cfg_sz =3D ret;

[Severity: High]
Is it possible for a chunked write to fail to persist the ap_config pointer?

If allocate_ap_config() succeeds but the write does not contain the complete
configuration (*pos + len !=3D cfg_sz), ap_config is not assigned to
mig_data->resuming_mig_state.ap_config before the function returns.

The allocated ap_config memory leaks, and on the next chunk, *pos > 0 but t=
he
state pointer remains NULL. This will cause validate_resuming_write_parms()=
 to
falsely detect an illegal state and return -EFAULT.

> +	} else {
> +		ap_config =3D mig_data->resuming_mig_state.ap_config;
> +
> +		ret =3D reallocate_ap_config(&ap_config, len);

[Severity: Critical]
Does this code create a dangling pointer in the migration data after kreall=
oc()?

The reallocate_ap_config() call uses krealloc(), which may free the old buf=
fer
and return a new one. The new pointer is stored in the local ap_config vari=
able,
but it isn't updated in mig_data->resuming_mig_state.ap_config unless the
entire configuration is received successfully.

If copy_from_user() fails below, the new buffer is freed via kfree(ap_confi=
g),
but mig_data retains the old, already-freed pointer. When the file is close=
d,
vfio_ap_release_resuming_file() calls kfree() on the old pointer again,
leading to a double-free.

> +		if (ret < 0)
> +			goto cleanup;
> +
> +		cfg_sz =3D ret;
> +	}

[ ... ]

> +cleanup:
> +	kfree(ap_config);
> +done:
> +	if (mutex_is_locked(&matrix_dev->mdevs_lock))
> +		mutex_unlock(&matrix_dev->mdevs_lock);

[Severity: High]
Does this error path illegally unlock matrix_dev->mdevs_lock if it is held =
by
another thread?

Because mutex_is_locked() just checks if the lock is held by any thread, and
vfio_ap_resuming_write() dropped mdevs_lock earlier to call copy_from_user(=
),
if a concurrent thread is currently holding mdevs_lock, this will unlock it.

This leads to race conditions and potential data corruption.

> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D14
