Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799542FCA9;
	Mon, 27 Jul 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175943; cv=none; b=pkghzsaObSQjhDaKu1bnbwZVMN1Rw1Wj2+Xd5QQUnabAkdk9wUvMNkHfLxXlmNH9fiLE01TQtWrG+CqkTPOswMviwtnjnoYtdKtXcvu8G3ZyyDEIyeQP1dQU/4rMyuBfeuxBl0kx36onMDwp2lqo5BUJ4UP1pr2IhbFH97c+iQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175943; c=relaxed/simple;
	bh=YIO8icb+0xG8z1Mzu59n8vLBuxdh6Z3feiAvXdpFQrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ig++K9gFj9c25doO1nJZQE/H127IgZ4VJ0CK0YxxYDdSCF2x+PDfWR2Pr+uzuOlVBWlW8+TcK9UEtzjYHmQ5l9kbA9YaNGPfzJHm+NVhDk4ptKTFpCdgf0eSlwLUFdddMeTVtgD2LYzvCRb5ckZ2ZBU+2ltFNTCoq6Qg/0usq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j64vTuDm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j64vTuDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355E61F000E9;
	Mon, 27 Jul 2026 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175941;
	bh=XNqB88BfotlJ0BbfMC5kHjSO7n4xtGNTQq8LYKoP2H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j64vTuDmoJWg9OE5E/A66PAgvr8i1j9tFS+tuaWmrafrkLq8DVzyxTaElmUyoRkTE
	 qjNlhFsCbjE00lM4AuSUVBfkvHUypGke6R3iv+EWr8cMiEqd/rXf/FMMlbowFhCZjW
	 LpqSsqA3dwAWd6ynRwtPXhSaOWJO2IgqBLR8X2K8EXUHqmC4z+e5YV5ux5/96TRCu8
	 5L2J7Tw4JsfYAcnjdkzjab7CnqOYofupfIQp+IYBokDNVU/AKw3hMROU7kpnvHyIp0
	 oO9ULDrLU04cTQHZl/jlnH1O0DHcmzjB8XaOz81wKzxj79O0cUBueiOv3+hPu3hsor
	 Z6vzLPZJIXq2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/15] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260727173239.2420754-11-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:12:20 +0000
Message-Id: <20260727181221.355E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Double fetch vulnerability in the resuming write path allows o=
ut-of-bounds kernel reads.
- [Critical] Use-After-Free during concurrent device teardown while executi=
ng copy_from_user.
- [High] Lack of rate limiting in validation error paths allows userspace t=
o flood the kernel log and cause a Denial of Service.
- [High] Unsynchronized concurrent writes can trigger premature configurati=
on validation on uninitialized memory.
--

--- Patch [10]: [PATCH v6 10/15] s390/vfio-ap: File ops called to resume th=
e vfio device migration ---
commit 56776518d352cfe0d799d4f95bc7d9c8703337bf
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: File ops called to resume the vfio device migration

This commit implements the write callback for the vfio-ap device migration
file stream. It restores the source guest's AP configuration by validating
and hot-plugging it into the destination guest.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index c7fecad0b6769..c12ba82ec5277 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -881,14 +881,20 @@
>  static void report_qinfo_incompatibilities(const char *mdev_name,
>  					   unsigned long apqn,
>  					   struct ap_tapq_hwinfo *src_hwinfo,
>  					   struct ap_tapq_hwinfo *target_hwinfo)
>  {
> +	pr_err("vfio_ap_mdev %s: Migration failed: Source and target queue (%02=
lx.%04lx) not compatible\n",
> +	       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));

[Severity: High]
Is it possible for userspace to flood the kernel log here?

If a configuration with a large number of incompatible queues is provided,
verify_ap_configs_are_compatible() continues processing rather than abortin=
g.

Since report_qinfo_incompatibilities() and its helpers issue unconditional
pr_err() calls for each mismatch, could this cause CPU stalls or a denial
of service?

> +
> +	report_facilities_compatibility(mdev_name, apqn, src_hwinfo, target_hwi=
nfo);
> +	report_mode_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);

[ ... ]

> @@ -1071,61 +1071,80 @@
>  static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
>  				      size_t len, loff_t *pos)
>  {

[ ... ]

> +	/*
> +	 * Snapshot and advance *pos under the lock before dropping it for
> +	 * copy_from_user().  This prevents concurrent write()s on the same
> +	 * stream file from computing the same destination offset and clobbering
> +	 * each other's data or racing to reassign mig_data->resuming_mig_file.
> +	 */
> +	write_pos =3D *pos;
> +	*pos +=3D len;
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_from_user((char *)ap_config + write_pos, buf, len)) {
> +		if (new_allocation)
> +			kvfree(ap_config);
> +		return -EIO;
> +	}

[Severity: Critical]
Can a concurrent device teardown cause a use-after-free here?

The mdevs_lock is dropped to perform copy_from_user(). If a concurrent
thread closes the VFIO device, vfio_ap_release_mig_files() will call
kvfree(mig_data->resuming_mig_file.ap_config). Would this result in
copy_from_user() writing into freed kernel memory?

[Severity: Critical]
Could this sequence introduce a double-fetch vulnerability?

The first fetch in allocate_ap_config() reads num_queues to determine the
allocation size. The lock is then dropped, and this second copy_from_user()
overwrites the entire buffer, including the num_queues field.

If userspace modifies num_queues between these fetches, could it inflate
ap_config->num_queues beyond the allocated size, causing out-of-bounds
reads in queues_available() when it loops over source_config->num_queues?

> +
> +	/* Check if we've completed writing the entire configuration */
> +	if (write_pos + len =3D=3D cfg_sz) {
> +		/*
> +		 * do_post_copy_validation() calls ap_tapq() which is a slow
> +		 * hardware instruction.  Run it before acquiring the update
> +		 * locks to avoid holding guests_lock, kvm->lock, and
> +		 * mdevs_lock across the hardware calls.
> +		 */
> +		ret =3D do_post_copy_validation(mdev_name, ap_config);

[Severity: High]
Does this completion check safely handle concurrent writes?

If userspace issues asynchronous write() syscalls for different chunks of
the payload, they might execute copy_from_user() concurrently. If the
thread writing the final chunk completes its copy before threads writing
earlier chunks finish theirs, could do_post_copy_validation() be called
on a buffer that still contains uninitialized data?

> +		if (ret < 0) {
> +			if (new_allocation)
> +				kvfree(ap_config);
> +			return ret;
> +		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D10
