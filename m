Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779229;
	b=tgy+uw5vnQWg0+xsQcUqEdU/BmO/FUmEDsw+2wTwaR2St8X8Ktw9+FSg5mqzFn70ziee
	 FQx5znpiS/JxYlJEJxDU4Bd+Tarmsymz/UWXtluh436PCRqcQeYJPXqWdZ7Wli7xzu5tE
	 CJAg+U4qzxV637CEI8TS5CX2YIjOi9CMDq2wF56Kyy1d94F+PtWK6k1f/sZ4NWAtIXrCV
	 g7Q32aRM0FjitpfPvZccWY3ft0TU+dXJk41fzJ3Tv8CdFbHJtlPgdSEMvrHiAyCXpWO+3
	 QNsxedFNnwrldHVH8qvwEYhMrNptxfseBZIHNRC7tqtySvIUX8436F3f0JxSEHdS1/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779229;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WWZYpLD6p8lDIIRCb9Aja2+cJuLGu+C5v0wPB2UvWwk=;
	b=Ni8AGgXM2hcQ2GzpWtHUqy1pqjtIhOZ81T9mKeBBVa6pWhuYmoFS/aF7Q+0S4DH4W/sr
	 eXI6li1YyQ2cNz7TqST739M7GLCkPtuadApx482dLJGAtAglkdbY8sGh0Cz1qNUfwTcX3
	 80+NvRFE/eS8T2RJFm88Sl/M1Biu778LWN/fSCjkkNYXbYoWhnwJxuyMeh4yP1cCEJl2l
	 jelS6bJSbtMuundidmgdBvFDkDJM1DCvaK3PKae91iHd3W8qalmtMpVBuhK11VQuEMTrj
	 +4TcqC4OclhnX/PAapZJMaOR6Ok5v1Kkeh+hODFfwVeRN5BGB/zzNk+OoJnu6vMU3fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6jA0Hs3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A5606A31A;
	Fri, 23 Oct 2026 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6jA0Hs3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480661F01825;
	Fri, 23 Oct 2026 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779228;
	bh=WWZYpLD6p8lDIIRCb9Aja2+cJuLGu+C5v0wPB2UvWwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6jA0Hs3Iazdpsb2Og1vHO+9qQIFACOvl+kTKQA/ujOpmPWkm4rRwL8VcZ+Zeavkm
	 ThN9EKkYX2/ntPe47vtIScBMjJ6RK06GFGuSznMEweK2bSCTIuk4FZ/LPsoWM5gWhU
	 /rVj0RKM3qA74HC1um6k1092NCHHc4p/Hy4Uq6xgCtrLjq71oZvEQbp7/qkgM556A6
	 SND9xMISkZaEbIAnxxfD0VMG+VBrMKNV0onHvAoLpB8y/EFW27dw8rJQvhY0XDfkOj
	 qY3BbxZgSdIxgEB6NMNyyIAnzM4yIXSQk4PYGvi44Te5Nv5/v8DbSykQFgoCeeyhn0
	 rfrYhQMO4IYPw==
Message-ID: <sashiko-outbox-183053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/15] s390/vfio-ap: Transition device migration
 state to from/to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-12-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:13:47 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/vfio-ap: stale resuming_mig_data_complete after write past =
expected_sz
--

commit d607b25bfceefded024b198c63db651dfdea7ce6
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state to from/to STOP

This commit implements the VFIO migration state transitions between STOP
and RESUMING, STOP_COPY, and RUNNING in vfio_ap_transition_to_state(),
cleaning up migration file state as needed.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 469fa09ec9087..cf38407d1b157 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -1052,7 +1048,7 @@ static ssize_t vfio_ap_resuming_write(struct file *=
filp, const char __user *buf,
>  		}
> =20
>  		if (*pos =3D=3D (loff_t)expected_sz) {
> -			ret =3D do_post_copy_processing(matrix_mdev, ap_config);
> +			ret =3D do_post_copy_validation(matrix_mdev, ap_config);
>  			matrix_mdev->mig_data->resuming_mig_data_complete =3D !ret;
>  		}
>  	}
> @@ -1146,20 +1142,46 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
 *matrix_mdev,
>  		return filp;
>  	}
> =20
> -	if ((cur_state =3D=3D VFIO_DEVICE_STATE_RESUMING &&
> -	     new_state =3D=3D VFIO_DEVICE_STATE_STOP) ||
> -	    (cur_state =3D=3D VFIO_DEVICE_STATE_STOP_COPY &&
> -	     new_state =3D=3D VFIO_DEVICE_STATE_STOP)) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +	/*
> +	 * Terminates the data transfer session of the vfio-ap device state
> +	 * to the destination guest.
> +	 */
> +	if (cur_state =3D=3D VFIO_DEVICE_STATE_RESUMING &&
> +	    new_state =3D=3D VFIO_DEVICE_STATE_STOP) {
> +		if (!mig_data->resuming_mig_data_complete)
> +			return ERR_PTR(-EINVAL);
> +
> +		/* Set resuming_mig_data_complete to false for clean reuse */
> +		matrix_mdev->mig_data->resuming_mig_data_complete =3D false;
> +		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
> +		return NULL;
>  	}

[Severity: Medium]
Can the transition from VFIO_DEVICE_STATE_RESUMING to
VFIO_DEVICE_STATE_STOP in vfio_ap_transition_to_state() still succeed
after a subsequent write() to the migration file descriptor pushes
filp->f_pos past expected_sz and returns -EINVAL?

In vfio_ap_resuming_write(), once a valid vfio_ap_config of size
expected_sz (with num_queues < MAX_AP_QUEUES) has been written,
resuming_mig_data_complete is set to true:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
	...
	memcpy((char *)ap_config + *pos, kbuf, len);
	*pos +=3D len;

	if (*pos >=3D offsetofend(struct vfio_ap_config, num_queues)) {
		...
		if (*pos > (loff_t)expected_sz) {
			ret =3D -EINVAL;
			goto out_unlock;
		}

		if (*pos =3D=3D (loff_t)expected_sz) {
			ret =3D do_post_copy_validation(matrix_mdev, ap_config);
			matrix_mdev->mig_data->resuming_mig_data_complete =3D !ret;
		}
	}
}

If userspace performs an additional write() on the same migration FD where
filp->f_pos + len <=3D VFIO_AP_CONFIG_MAX_SIZE, validate_resuming_write_par=
ms()
succeeds, the extra bytes are copied into ap_config, and *pos advances
past expected_sz. The check for *pos > (loff_t)expected_sz then returns
-EINVAL, but resuming_mig_data_complete remains true.

When userspace subsequently transitions from VFIO_DEVICE_STATE_RESUMING to
VFIO_DEVICE_STATE_STOP, vfio_ap_transition_to_state() only checks
!mig_data->resuming_mig_data_complete and succeeds despite the trailing
data and failed write(). Should vfio_ap_resuming_write() clear
resuming_mig_data_complete (or avoid mutating ap_config and *pos) when a
write exceeds expected_sz?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D11
