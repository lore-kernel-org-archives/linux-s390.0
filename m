Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E453EF0AC;
	Tue, 30 Jun 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818928; cv=none; b=frZcfOhRzXs6oyqLTBVNDwZIIv41z6EbX5sE980iX+KL9IZhIYs03op90x1rqzN1mYXs0yhvbJjfFa6NgWwgJkz2ek8NKC4N0NXflCbp8yNrI9XBNmjUnH1QVo6vgdXwSHO3j1tqlZrq409FTe1HJBrWmHdWYmfm3MPQk+4ufvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818928; c=relaxed/simple;
	bh=TXbWulyWr3vKUrOvdqQJXpfjJCtP24e8/RDgiYMIDKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EHDJX8wEy1EqN2D549jZZSzI4B0JmtLtE2o2TY0y5fj68j2ayuswzle86BCVZFMx36o+msmnxYs3s+2yREhReehytkm0x4KLi86S+XznrlMR1RS9rgwo1BVgBkRJkb89UYZJCw+jyMwtrawoMeTS/eoXNk8Da59BQhRQQ9DH9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amS2IYcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amS2IYcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EEF1F00A3A;
	Tue, 30 Jun 2026 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818927;
	bh=xbSj6dByoYq8dMqXx4iTd9RIXNTdmSVJjmEpDWUuGCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=amS2IYcdhosJwyckt0h/MGs5R3E+peAVRWwsoIxo/9gak/fJaOtORwav0cd7DozrJ
	 /AQiStCzKmM3fcFS29lOhHWIS6jMw6eFM86gNJTPu3xfIVeAC33o/1O23qF60MkpP8
	 Gio17oEoXJCyu2W+zOBrGWIpqtIs3wmmeTddJxUKjA/Ua4DN18CtIwNQx56rD1B4VW
	 GfVYx5Ni8kZyKelby0YfMjVjsYn6Ck7lrEFWfCP+LJV8bCeEVKnC+23vlFxj1/alzs
	 ASjblc4b4MOX/T08LrYGfdXkYpcH7Q6obXb/uZ9vjB14vaf/2c2WAwPHQpiXtcKxCN
	 +myRZ37iUZ5gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/15] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-9-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:28:46 +0000
Message-Id: <20260630112847.10EEF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The migration file descriptor lacks a reference to the vfio_device=
, and its release handler lacks locking, leading to critical Use-After-Free=
 and NULL pointer dereferences.
- [High] Concurrent read operations in vfio_ap_stop_copy_read bypass VFS lo=
cks and race on filp->f_pos, corrupting the migration stream.
- [High] Missing initialization of config_sz in vfio_ap_get_config causes a=
 zero value to be sent to userspace, breaking the resuming phase protocol.
--

commit fb4283ff8475958b596a7e1a1f9bf2aba56d90d8
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: Transition device migration state from STOP to RESUM=
ING

This commit introduces the transition from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_RESUMING. It prepares for restoring the device state by
opening a file stream to receive the guest's AP configuration. It adds a st=
ub
implementation for the write operation.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 5ef7127b697a5..e917cc995d352 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -65,6 +65,17 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migratio=
n_data *mig_data)
>  		mig_data->stop_copy_mig_file =3D NULL;
>  }
> =20
> +static void
> +vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
> +{
> +	if (mig_data->resuming_mig_state.filp)
> +		mig_data->resuming_mig_state.filp =3D NULL;
> +
> +	kfree(mig_data->resuming_mig_state.ap_config);
> +	mig_data->resuming_mig_state.ap_config =3D NULL;
> +	mig_data->resuming_mig_state.config_sz =3D 0;
> +}
> +
>  static int vfio_ap_release_mig_file(struct inode *file_inode, struct fil=
e *filp)
>  {
>  	struct ap_matrix_mdev *matrix_mdev =3D filp->private_data;

[Severity: High]
This is a pre-existing issue, but does vfio_ap_release_mig_file() safely
access matrix_mdev and mig_data here?

It appears the migration file descriptor is created in
vfio_ap_open_file_stream() without taking a reference to the vfio_device via
vfio_device_get(). Because of this, the file descriptor can outlive the
device structure.

If userspace closes the main device file descriptor and unbinds the mdev,
matrix_mdev is freed. When the migration file descriptor is subsequently
closed, vfio_ap_release_mig_file() accesses the freed matrix_mdev.

Also, since this release handler doesn't hold matrix_dev->mdevs_lock, can it
race with vfio_ap_release_migration_data() freeing mig_data, leading to a
use-after-free or NULL pointer dereference when accessing
matrix_mdev->mig_data?

[ ... ]

> @@ -311,6 +324,32 @@ static struct file *vfio_ap_open_file_stream(struct =
ap_matrix_mdev *matrix_mdev,
>  	return filp;
>  }
> =20
> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
> +				      size_t len, loff_t *pos)
> +{
> +	/* TODO */
> +	return -EOPNOTSUPP;
> +}

[Severity: High]
This is a pre-existing issue, but while implementing the resumption phase,
will the data coming from vfio_ap_get_config() be properly formed?

In vfio_ap_get_config():

ap_configuration =3D kzalloc(*ap_config_size, GFP_KERNEL_ACCOUNT);
if (!ap_configuration)
    return -ENOMEM;

ap_configuration->num_queues =3D num_queues;

The config_sz field is never initialized, so a zero value is copied to
userspace. During this write operation, if data is handled in chunks and
uses config_sz to calculate the new allocation size, could it read 0, shrink
the buffer with krealloc() to an undersized amount, and cause an
out-of-bounds write during copy_from_user()?

> +
> +static const struct file_operations vfio_ap_resume_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.write =3D vfio_ap_resuming_write,
> +	.release =3D vfio_ap_release_mig_file,
> +};

[Severity: High]
This isn't a bug introduced by this patch, but considering these new file
operations, is the f_pos handling safe from data races under concurrent I/O?

Looking at the existing vfio_ap_stop_copy_read(), the file's internal
position is updated entirely outside the protection of
matrix_dev->mdevs_lock:

vfio_ap_stop_copy_read()
   mutex_lock(&matrix_dev->mdevs_lock);
   ...
   mutex_unlock(&matrix_dev->mdevs_lock);

   if (copy_to_user(buf, (char *)ap_config + *pos, len)) {
       kfree(ap_config);
       return -EFAULT;
   }

   kfree(ap_config);
   *pos +=3D len;

Since stream_open() disables the standard VFS f_pos_lock serialization,
can concurrent read() calls race here, sample the same offset, transmit
duplicate data blocks, and double-increment the position pointer?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D8
