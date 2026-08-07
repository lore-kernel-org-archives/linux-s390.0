Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCF41D129;
	Fri,  7 Aug 2026 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142707; cv=none; b=iGvmZjX3L2fpfzC/ec7veBhsIgW1spsECSxduZUOsG9Kj2oEnQOMgJ5trIDPiFb8Lo5+BitA03Vg/z0uCSWBm03LWIyoc/7vz4zhf3GLbZVGIBhOgV59uTjRuQLfMQS0pKaldZrl910YT31LxInlon5KpGt9FXyEIpHtNv7km7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142707; c=relaxed/simple;
	bh=NFE7nq6ll+TU+IMMFxM8Qk4Cv1aOJyqZHJNHHDO1bLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NofjkfWU2HKy0oGXRPp43mRbNn2WqkMQie9/j34eiEYxELqPKjambtg9JfKXmPlHhRenzUKxa1hQF1Hu6DwPd0QQD5pTvZHeUCRd7gON8nwfOSGbmo4iFc2JzR/mbF0lW/+2rkdgOWxv3GLa4zbAssQ5xB0Sky6YJMfqmOuo2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxAEai42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxAEai42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4044C1F000E9;
	Fri,  7 Aug 2026 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142705;
	bh=dpN4LDcTmuSO4saSFOQYRzAvEfqYoaNXTMipx/81630=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxAEai423BlSWzqADP9Rh+iFzAop1kBaeYteYpOwIQvmwDIg/crFsiPt4LEMR8baE
	 RPkA25N2wvRpRrRNfGkIm1sywwVaT6p6n3uNX8DJ+VtUNjbEda2OVktrmvIj7D1NW6
	 zWikjMRJaI/Ok2ggziaJpXWXYmV66MyTU1pTudgu3NePvCQNbwZ97zULKmFkebQ4aS
	 auXeYy4xymx4Qz1bg2g1Dlg3ujgIHIe+QqR0sWsXwaFr4x2cwIFgHLcizSQKCoDmgj
	 WnsWfQu1eJ3efbx/zAVd02+0U36TdMxur7L0HY3a7nnGeEF5KZq+DBieySR6A9Al0v
	 TAgVs78wKNztA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/15] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260807221834.562851-6-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:45:04 +0000
Message-Id: <20260807224505.4044C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vfio_ap_set_state falsely reports success when attempting to trans=
ition out of the VFIO_DEVICE_STATE_ERROR state.
--

--- Patch [5]: [PATCH v7 05/15] s390/vfio-ap: Callback to get/set vfio devi=
ce mig state during guest migration ---
commit 4d4bb0a626dab0e0e55ea92759151b23e4fe2cdf
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Callback to get/set vfio device mig state during guest migrat=
ion

This commit implements two callbacks for the vfio-ap device related to its=
=20
current migration state. It provides the mandatory callbacks to get and set=
=20
the migration state during live migration of guests with pass-through acces=
s.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 1613813124b6f..af740b177c97c 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
> +				      enum vfio_device_mig_state  new_state)
> +{
> +	int ret;
> +	struct file *filp =3D NULL;
> +	struct ap_matrix_mdev *matrix_mdev;

[ ... ]

> +	while (mig_data->mig_state !=3D VFIO_DEVICE_STATE_ERROR &&
> +	       mig_data->mig_state !=3D new_state) {
> +		ret =3D vfio_mig_get_next_state(vdev, mig_data->mig_state,
> +					      new_state, &next_state);
> +		if (ret) {
> +			filp =3D ERR_PTR(ret);
> +			break;
> +		}
> +
> +		filp =3D vfio_ap_transition_to_state(matrix_mdev, next_state);
> +		if (IS_ERR(filp))
> +			break;
> +
> +		mig_data->mig_state =3D next_state;
> +
> +		if (WARN_ON(filp && new_state !=3D next_state)) {
> +			fput(filp);
> +			filp =3D ERR_PTR(-EINVAL);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return filp;

[Severity: High]
If the device is already in VFIO_DEVICE_STATE_ERROR when vfio_ap_set_state()
is called, the while loop condition evaluates to false and is skipped entir=
ely.

Since filp is initialized to NULL, does returning NULL here incorrectly
signal a successful state transition to the VFIO core? Should an attempt to
transition out of the error state return an explicit error pointer (such as
ERR_PTR(-EIO)) instead to properly reject the transition?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D5
