Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FD30149F;
	Sun, 26 Jul 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087491; cv=none; b=BhtwagKrg+M9G0FlDkvp9dKBOyGZQvElpFf6sjYmwyCEPMBghBhryxVjICRqi97jHRn5+Cd3nGkFnTtZ+JzTGl8fyGpStw4499uAeme4Mn/TDNcIAmZH5z6YKgfECWGTxhyIzo3GHO//PQpNV292wlhAAKtVdAuqRDh7Ckkl9ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087491; c=relaxed/simple;
	bh=k2SPWff/idsc137ytew3M5JarPc56wMdDA85EMwkouI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WRnLc2GclI9HR9Y9qsW7HSBBun8ZJRRdClQqo3DFLbsFHmB3t6BFjSKd8+wFfFsm0hyvCXl2NDPDJzlyKVXAAnC2rsk1Rmkv51ELvN+fBY3HXeZTatTE04bZ6VK5VIYIm57AylNYMhHULy7gLmlQzzr4YUZjDLzytOeh7maDyk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxmU4jsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxmU4jsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3761F000E9;
	Sun, 26 Jul 2026 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087489;
	bh=wrGvXW5I7SoFd1U1AwALQdv+Aes30/S0eNIAVcUXyCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MxmU4jsSDsyiPt/ys/2T3LIfDotdgHlL9tY/fxbdUo7jk/o8S16qnENxqu/D7jthZ
	 Ra2M3uVLUKFf3oVGrbQVl+61kvofz+mEBeUdPYdcozTfY6WIeTfggiMRVTu0Jf47yW
	 9c7yghZydVlbTTazQ75uhJBK0WQCJMH/Tu7RxMI5Tc1HwZzu4mRm9GrAjry0vrldC4
	 pemSzcaejtb6u2yosrB/0rLPDRdd1814HRB/tiOcCKmuc5MJ4b0lIctVl1kmTB8nSl
	 Z1fhno+ga1cOW1/Jk2D2U6ZzZPGWc3t7uVE8zzqa7VGl7SwifDEZCYld7n0UGJYDTA
	 vgDX/OOeQROIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] s390/vfio_ccw: ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260726172153.1818056-7-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:38:08 +0000
Message-Id: <20260726173809.5F3761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data Race / List Corruption in private->crw
- [High] Use-After-Free due to missing cancel_work_sync in release handler
- [Low] Event Loss on Failed copy_to_user
--

--- Patch [6]: [PATCH v6 06/10] s390/vfio_ccw: ensure index for read/write =
regions are within range ---
commit f91d3ca5d2a5910d7f313cb125ab777b26c1f34e
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure index for read/write regions are within range

The introduction of the capability chain rightly clamped the region indexes
to the range of the capabilities itself, but neglected to do so for the
existing read/write regions which should also be enforced. This commit
ensures read/write region indexes are within range and clamped via
array_index_nospec.

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index 38c176cf62957..f3015132d4b5f 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
[ ... ]
> @@ -97,6 +105,12 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
>  		list_del(&crw->next);
> =20
>  	mutex_lock(&private->io_mutex);

[Severity: High]
This is a pre-existing issue, but can this list modification race with
concurrent additions?

Looking at vfio_ccw_crw_region_read() just above this diff, the crw list is
popped and modified without holding any locks:

	crw =3D list_first_entry_or_null(&private->crw, struct vfio_ccw_crw, next);
	if (crw)
		list_del(&crw->next);

Could this race with vfio_ccw_queue_crw(), which adds to the list using
list_add_tail(&crw->next, &private->crw)? If a hardware event asynchronously
occurs while a guest reads the CRW region, could this result in list
corruption?

> +	if (i >=3D private->num_regions) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	i =3D array_index_nospec(i, private->num_regions);
>  	region =3D private->region[i].data;
> =20
>  	if (crw)
> @@ -109,6 +123,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
> =20
>  	region->crw =3D 0;
> =20
> +out:
>  	mutex_unlock(&private->io_mutex);
> =20
>  	kfree(crw);

[Severity: Low]
This is a pre-existing issue, but does this unconditionally free the CRW
event even if the copy to userspace failed?

Looking at the end of vfio_ccw_crw_region_read():

	if (copy_to_user(buf, (void *)region + pos, count))
		ret =3D -EFAULT;
	else
		ret =3D count;

	region->crw =3D 0;

out:
	mutex_unlock(&private->io_mutex);

	kfree(crw);

If userspace provides an invalid buffer, copy_to_user() will fail and return
-EFAULT, but the event is freed rather than requeued. Can this lead to a
permanently lost Channel Report Word event?

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 45ec722d25ea6..032a1cdf4df70 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
[ ... ]
> @@ -243,6 +243,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device =
*vdev,
>  		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
>  	default:
>  		index -=3D VFIO_CCW_NUM_REGIONS;
> +		index =3D array_index_nospec(index, private->num_regions);
>  		return private->region[index].ops->read(private, buf, count,
>  							ppos);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but looking at the lifetime
management in this file, is there a potential use-after-free during
device removal?

In vfio_ccw_mdev_release_dev(), the private struct and its embedded work it=
ems
are freed without calling cancel_work_sync():

	kmem_cache_free(vfio_ccw_io_region, private->io_region);
	kfree(private->cp.guest_cp);
	mutex_destroy(&private->io_mutex);

If an mdev is created but never opened by userspace, channel path events can
still trigger vfio_ccw_chp_event(), queuing private->crw_work. If the mdev =
is
subsequently removed without being opened, the flush_workqueue() in the clo=
se
handler is bypassed. Could a background work item then execute using the
freed vfio_ccw_private struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D6
