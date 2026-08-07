Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9EF3F825C;
	Fri,  7 Aug 2026 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141832; cv=none; b=eC58BZxlrP2bFzLWmmXYwMIWWXp/r9ICUHcNMDH9WOop9cntF5QOp/0BbuRl9TElihexlu+YUNmwNDlj7ECHkN+hPf+kv9L4GQZ7aqZZC6ldYGZ42CQrqCUDKSP0wl8sdNxDESGFSGFwrV77SFXQVWkT4RBvxN+W9yMq9mpVdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141832; c=relaxed/simple;
	bh=8LzY2nLxO9Av3Dq/ESzeI3B0HI3GWklQvZ+uEzEsT24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jdIg0jXWZePEj8ID0y8fjbcWg0Z0m6GBi2SGeDDSqiC+scVymQ5uZ/LA43Xdb4rjVzWC66FjGPSedcRoEL6w/ojhCrbpDzfW+136I3bnHZHcCitbIanH54KOgaoNNWyV0Zz+2UEPNwhxCohG74+0IpXg7lxFx8pQvosBB5nJiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMz0kPsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMz0kPsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D808E1F000E9;
	Fri,  7 Aug 2026 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786141831;
	bh=fI5LPt1pkQWDLThfErbKyuYmyWE0Nme2jmN0Slj6puM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMz0kPsp/CeSqlVZWzR+HB9VEvwDiLm60GlmXNv6ywfGC1+v4957qqkd32inh+btd
	 NBkZyaEVlgBnWIYMbCPK57wSrTSAYz1ROit3EIOjUTGgHzAOHpPZHNbzZTbly9GsaP
	 /MvTMrz7Oz3hNOzEzbxcjY3/ZZ4RFOK/UevkizfVZfsd0mKnNSEVI08V9TeMGXA7G+
	 bmkGFcKrmVMB17gF3viiZa8jAQCayePdfVwkT3EHeE56VAqNOlEcLH+/hvHN+B0e5/
	 zWWuC5U6LenqSSWFqD8gitS2CHax83BL4dYVx9qRBANeFAv3UZMRJSnf0tfrFl3OeK
	 973vfTzFp29RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/15] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807221834.562851-11-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:30:30 +0000
Message-Id: <20260807223030.D808E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Heap buffer overflow in vfio_ap_resuming_write when processing=
 the initial chunk of migration data.
- [High] Memory leak of the dynamically allocated temporary ap_config buffe=
r in vfio_ap_resuming_write on copy_from_user failure.
- [High] Use-After-Free condition in set_new_ap_configuration due to a TOCT=
OU race when the migration session is concurrently replaced.
- [Medium] Missing validation of migration magic and version fields when th=
e entire configuration payload is submitted in a single write.
--

--- Patch [10]: [PATCH v7 10/15] s390/vfio-ap: File ops called to resume th=
e vfio device migration ---
commit 1f7d34b59709567819d8ff6eb6bf255fe0360e1b
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: File ops called to resume the vfio device migration

This commit implements the write callback for the file stream created to
restore the vfio-ap device state during the RESUMING phase of migration.
It parses chunks of user data into a vfio_ap_config structure and sets
up the new device configuration.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index e2e7ae8515e55..4dd7373c3d9d9 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -451,11 +539,916 @@ static struct file *vfio_ap_open_file_stream(struc=
t ap_matrix_mdev *matrix_mdev,
>  	return filp;
>  }
> =20
> +static int validate_resuming_write_parms(struct file *filp,
> +					 size_t len, loff_t *pos)
> +{
[ ... ]
> +	/*
> +	 * If the vfio_ap_config object has been allocated, then the 'config_sz'
> +	 * field indicates the total size allocated. If the write operation
> +	 * will exceed the allocation, return an I/O error.
> +	 */
> +	if (resuming_mig_file.ap_config) {
> +		if (resuming_mig_file.ap_config->magic !=3D VFIO_AP_MIG_MAGIC ||
> +		    resuming_mig_file.ap_config->version !=3D VFIO_AP_MIG_VERSION)
> +			return -EINVAL;
> +
> +		if (*pos + len > resuming_mig_file.config_sz)
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does this miss validating the magic and version fields if userspace writes
the entire configuration in a single chunk? The validation here is skipped
if the configuration buffer is not yet allocated. If all data arrives at
once, it appears to be allocated and processed in do_post_copy_processing()
without the magic or version ever being verified against the expected
values.

[ ... ]
> +static int set_new_ap_configuration(struct ap_matrix_mdev *matrix_mdev,
> +				    struct vfio_ap_config *ap_config,
> +				    size_t cfg_sz)
> +{
> +	struct vfio_ap_config *cur_ap_config;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	/*
> +	 * Re-read mig_data under the lock; the device could have been closed
> +	 * concurrently while the lock was dropped for copy_from_user().
> +	 */
> +	if (!matrix_mdev->mig_data) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return -ENODEV;
> +	}
> +
> +	cur_ap_config =3D matrix_mdev->mig_data->resuming_mig_file.ap_config;
> +	if (cur_ap_config)
> +		memcpy(cur_ap_config, ap_config, cfg_sz);
> +	else
> +		matrix_mdev->mig_data->resuming_mig_file.ap_config =3D ap_config;

[Severity: High]
Can a concurrent state change cause a use-after-free here? The mdevs_lock is
dropped prior to the copy_from_user() call in vfio_ap_resuming_write(). If
the migration state is cleared during that window, the original ap_config
pointer would be freed and cur_ap_config will be NULL upon reacquiring the
lock. This path then assigns the temporary ap_config to resuming_mig_file.
However, if the write was a continuation (!new_allocation), the temporary
ap_config is unconditionally freed at the end of vfio_ap_resuming_write(),
which would leave a dangling pointer in the active migration session.

[ ... ]
> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
> +				      size_t len, loff_t *pos)
> +{
[ ... ]
> +	/*
> +	 * If ap_config is a new allocation, then the contents of the
> +	 * 'magic', 'version' and 'num_queues' fields will already have
> +	 * been copied in; so the write_pos must be set to the location
> +	 * following the 'num_queues' field and the length to be written must be
> +	 * adjusted accordingly.
> +	 */
> +	if (new_allocation) {
> +		size_t nbytes_already_copied =3D VFIO_AP_CONFIG_BUF_SIZE - *pos;
> +
> +		write_pos =3D VFIO_AP_CONFIG_BUF_SIZE;
> +		write_len =3D len - nbytes_already_copied;
> +		buf +=3D nbytes_already_copied;
> +	} else {
> +		write_pos =3D *pos;
> +		write_len =3D len;
> +	}
> +
> +	*pos +=3D len;
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_from_user((char *)ap_config + write_pos, buf, write_len)) {

[Severity: Critical]
Is there a missing bounds check on the user-supplied len parameter here?
When allocating a new ap_config, the driver calculates cfg_sz based on the
num_queues field. However, the calculation for write_len uses the unmodified
user input len, which is not verified against cfg_sz. If a userspace process
provides a len that exceeds the dynamically calculated cfg_sz, it seems this
copy_from_user() will write past the allocated heap buffer bounds.

[Severity: High]
Does this leak the dynamically allocated temporary ap_config buffer when a
continuation write fails? During a continuation write (!new_allocation),
the ap_config buffer is freshly allocated via kvzalloc(). If the subsequent
copy_from_user() fails, this error path explicitly skips the kvfree()
because new_allocation is false, leaving the temporary buffer permanently
leaked.

> +		if (new_allocation)
> +			kvfree(ap_config);
> +		ret =3D -EFAULT;
> +		goto out_clear_write_in_progress;
> +	}
> +
> +	/* Check if we've completed writing the entire configuration */
> +	if (write_pos + write_len =3D=3D cfg_sz) {
> +		ret =3D do_post_copy_processing(matrix_mdev, ap_config);
> +
> +		if (ret) {
> +			kvfree(ap_config);
> +			goto out_clear_write_in_progress;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D10
