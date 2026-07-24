Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C7447812;
	Fri, 24 Jul 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917067; cv=none; b=SkHg3evsrf/4cgPDSKt0FJbi1Q5op/OdQ3AcBUdqC2Kxvw/S70DR/604MeCyKfZVCrzUSGE1XAXKe6Zdsw93RkgBaA1nWhva2hKcX9jrrRrpICch//tRNGtFcXmXwnoaTSccxSpA7sxoclVfuaxL3aBYhzNs1pKhePw5IBgHwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917067; c=relaxed/simple;
	bh=vD1fOeDmLZVktQ2d0BuvKQ+790lT/zmizqKKauK8SCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fvcMlYmc/uah/5NU8mwtGcme1k2vLTduhyTj0OLRpNTVvGKbDXNT3WtyGxwQ/EWSlEesjvdPUftl+tAxsm2Ga07wSeywiid4DMs6aqsycXN6OtO0oURCwvX0LxSWQBBGIGI4lWbvaVF3OSZEqb1EzsvNpRhcLHcEaX7hZ1x4BHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY0ZG4bm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY0ZG4bm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E851F000E9;
	Fri, 24 Jul 2026 18:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917060;
	bh=tfnCAxqcRNCkSiMrjRuJSgjZxCZ+e0cZZGXT57flNcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HY0ZG4bm+exg8ZTS4FfO+K+lZYDLeObZ3nG6v9kg0b0w7qYoFarrr1go4KIwtaKD1
	 /BUvgHYXyZAsqN3HenAjSjuq7TjVguHnTEpd9jQOPOPJ0DAedOzqS4T9bE4qFzSKrm
	 qudsRlUPdS/WQjT8GtFSdHj0dsu06PBEDHhGpXzTUKffH4Ok4FdDmMtBYYiBaBDKaW
	 c9TIZg45V8msfENHE5LpYVzziyRKru7leKLBD4/o8ccefFaYWZGCBiCPfmWhUCZjJ3
	 yDNoVG+Gvsc8REASnQYp10NxSx9PXhTJuDQ9tK17LgHTE7HkkTqo9IUEaYtSmI14Pf
	 tScLkVw4iB1LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/15] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724161351.1802644-11-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:17:39 +0000
Message-Id: <20260724181740.67E851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Uninitialized stack variable `guest_matrix` applied to guest confi=
guration.
- [High] Truncated write bypasses bounds check leading to massive out-of-bo=
unds reads.
- [High] Double-fetch of `num_queues` leads to validation bypass (TOCTOU).
- [High] Zero-length write yields ZERO_SIZE_PTR and causes an immediate NUL=
L/invalid pointer dereference.
- [High] Un-serialized writes to the migration stream file lead to heap ove=
rflows and memory leaks.
- [High] Use-After-Free of `mig_data` due to concurrent device closure.
- [High] Prolonged execution of slow hardware instructions while holding ma=
ssive global and KVM lock chains.
- [Medium] High-order memory allocation for `ap_config` breaks live migrati=
on reliability.
--

--- Patch [10]: [PATCH v5 10/15] s390/vfio-ap: File ops called to resume th=
e vfio device migration ---
commit e61d7c6d952455d8c5221b566f8371c207901817
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: File ops called to resume the vfio device migration

This commit implements the write callback function to restore the state of
the vfio-ap device during migration. It reads the source guest's AP
configuration from userspace and validates it against the destination host.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 4a489a7a05ff1..7a9a8f63a76d3 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -538,24 +538,36 @@ static ssize_t allocate_ap_config(struct vfio_ap_co=
nfig **ap_config,
>  				  const char __user *buf, size_t len)
>  {
>  	struct vfio_ap_config tmp_ap_config;
>  	ssize_t config_size;
>  	size_t copy_size;
> =20
>  	/*
>  	 * If the length of the data sent exceeds the size of the vfio_ap_config
>  	 * structure, then we will copy enough data from userspace to get the
>  	 * number of queues which we can use to allocate enough space all of
>  	 * the queue information.
>  	 */
>  	copy_size =3D min(len, sizeof(tmp_ap_config));
> =20
>  	if (copy_from_user(&tmp_ap_config, buf, copy_size))
>  		return -EIO;
> =20
>  	/*
>  	 * If the length of data sent includes the number of queues
>  	 * in the AP configuration, then calculate its size; otherwise
>  	 * set config_size to the length of data sent.
>  	 */
>  	if (len >=3D sizeof(struct vfio_ap_config)) {
>  		config_size =3D calculate_ap_config_size(tmp_ap_config.num_queues);
> =20
>  		/* If the calculation returned an error */
>  		if (config_size < 0)
>  			return config_size;
>  	} else {
>  		config_size =3D len;
>  	}

[Severity: High]
If userspace provides a small length (e.g., 4 bytes), does this bypass the
bounds check? It looks like config_size is set to len, meaning a tiny buffer
is allocated, but later validation loops rely on the unchecked num_queues=20
field from this undersized buffer, which could result in a massive=20
out-of-bounds heap read.

> =20
>  	*ap_config =3D kzalloc(config_size, GFP_KERNEL_ACCOUNT);

[Severity: Medium]
Since MAX_AP_QUEUES allows up to 65,536 elements, the size calculated by
calculate_ap_config_size() could exceed 1MB. Could this cause legitimate li=
ve
migrations to fail if a contiguous order-8 or order-9 physical allocation
cannot be satisfied by kzalloc() due to memory fragmentation? Would it be
safer to use kvzalloc() here to allow falling back to vmalloc?

[Severity: High]
If a zero-length write occurs, len will be 0 and config_size will be set to=
 0.
Passing 0 to kzalloc() returns ZERO_SIZE_PTR. Because the completion check=
=20
in vfio_ap_resuming_write() (0 + 0 =3D=3D 0) succeeds immediately, would th=
is
ZERO_SIZE_PTR be passed directly to do_post_copy_validation(), causing an
immediate kernel panic when it attempts to read source_config->num_queues?

[ ... ]

> @@ -1079,22 +1079,30 @@ static void setup_ap_matrix_from_ap_config(struct=
 vfio_ap_config *ap_config,
>  					   struct ap_matrix *guest_matrix)
>  {
>  	struct ap_config_info host_config_info =3D { 0 };
>  	unsigned long apid, apqi, *guest_adm;
>  	struct vfio_ap_queue_info qinfo;
> =20
>  	ap_qci(&host_config_info);
>  	vfio_ap_matrix_init(&host_config_info, guest_matrix);
> =20
>  	for (int i =3D 0; i < ap_config->num_queues; i++) {
>  		qinfo =3D ap_config->qinfo[i];
>  		apid =3D AP_QID_CARD(qinfo.apqn);
>  		apqi =3D AP_QID_QUEUE(qinfo.apqn);
> =20
>  		if (!test_bit_inv(apid, guest_matrix->apm))
>  			set_bit_inv(apid, guest_matrix->apm);

[Severity: High]
Does vfio_ap_matrix_init() in drivers/s390/crypto/vfio_ap_ops.c zero out the
apm, aqm, and adm bitmaps in guest_matrix? It appears to only initialize=20
scalar max values. Since guest_matrix is declared on the stack in=20
vfio_ap_resuming_write() without initialization, using set_bit_inv() here
could leave stack garbage in the bitmaps, potentially granting the destinat=
ion
guest access to arbitrary unassigned queues.

[ ... ]

> @@ -1113,87 +1121,95 @@ static ssize_t vfio_ap_resuming_write(struct file=
 *filp, const char __user *buf,
>  				      size_t len, loff_t *pos)
>  {
>  	struct vfio_ap_migration_data *mig_data;
>  	struct ap_matrix_mdev *matrix_mdev;
>  	struct vfio_ap_config *ap_config;
>  	struct ap_matrix guest_matrix;
>  	ssize_t ret =3D 0, cfg_sz;
>  	const char *mdev_name;

[ ... ]

>  	/*
>  	 * We don't want to lock all mdevs while copying data from userspace so
>  	 * we don't block all other mdevs in case the I/O takes a long time.
>  	 * From here on out we don't need this lock because we are not
>  	 * accessing the matrix_mdev until we need to get the update
>  	 * locks to set the new destination guest's AP configuration in which
>  	 * case this lock will be taken then.
>  	 */
>  	mutex_unlock(&matrix_dev->mdevs_lock);
> =20
>  	if (copy_from_user((char *)ap_config + *pos, buf, len)) {

[Severity: High]
Since copy_from_user() fetches the entire configuration from the same users=
pace
buffer pointer a second time, could a concurrent userspace thread modify
num_queues between the initial fetch in allocate_ap_config() and this one?
This could overwrite the validated num_queues value with an arbitrarily lar=
ge
number, bypassing the sizing logic and leading to an out-of-bounds read lat=
er.

>  		ret =3D -EIO;
>  		kfree(ap_config);
> =20
>  		return ret;
>  	}
> =20
>  	/* Check if we've completed writing the entire configuration */
>  	if (*pos + len =3D=3D cfg_sz) {
>  		/* Acquire locks required to update the guest's AP config */
>  		mutex_lock(&ap_attr_mutex);
>  		get_update_locks_for_mdev(matrix_mdev);
> =20
>  		/*
>  		 * Verify the device wasn't closed while mdevs_lock was dropped
>  		 * for the copy_from_user above. get_update_locks_for_mdev()
>  		 * reacquires mdevs_lock, so the check is safe here.
>  		 */
>  		if (!matrix_mdev->mig_data) {
>  			release_update_locks_for_mdev(matrix_mdev);
>  			mutex_unlock(&ap_attr_mutex);
>  			kfree(ap_config);
>  			return -ENODEV;
>  		}
> =20
>  		ret =3D do_post_copy_validation(mdev_name, ap_config);

[Severity: High]
The commit message mentions that get_hardware_info_for_queue() was modified=
=20
so it can be executed without holding matrix_dev->mdevs_lock. However,=20
do_post_copy_validation() iterates over up to 65,536 elements and calls=20
get_hardware_info_for_queue(), which executes the slow ap_tapq() hardware=20
instruction. Is it safe to execute this lengthy loop while holding=20
ap_attr_mutex, matrix_dev->guests_lock, the KVM lock, and mdevs_lock? Could
this result in severe latency spikes or soft lockups?

[ ... ]

>  	mutex_lock(&matrix_dev->mdevs_lock);
>  	kfree(mig_data->resuming_mig_file.ap_config);
>  	mig_data->resuming_mig_file.ap_config =3D ap_config;
>  	mig_data->resuming_mig_file.config_sz =3D cfg_sz;
>  	mutex_unlock(&matrix_dev->mdevs_lock);

[Severity: High]
Could mig_data point to freed memory here? The mig_data pointer was cached =
at
the start of this function before dropping mdevs_lock. If the device was=20
closed concurrently while the lock was dropped for copy_from_user(), wouldn=
't
this code unconditionally dereference the stale mig_data pointer, leading t=
o a
use-after-free?

> =20
>  	ret =3D len;
>  	*pos +=3D len;

[Severity: High]
Because the migration file is opened with stream_open(), the VFS does not
serialize write() calls with f_pos_lock. Given that mdevs_lock is dropped=20
during the copy_from_user() call above, could concurrent writes see the same
shared *pos offset? This seems like it would cause multiple threads to copy
data over the same region, and eventually leak the newly allocated ap_config
buffer when they race to reassign mig_data->resuming_mig_file.ap_config.

> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D10
