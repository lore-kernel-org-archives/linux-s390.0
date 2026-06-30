Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29F3FE645;
	Tue, 30 Jun 2026 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817826; cv=none; b=O/6GVx3vfnAfQ0eKRi832rgk6emNjpEXuxqvRI6dIxEis+IoyZEiGO+jj9cW3mHcsGTEaC2qOa2etmR4PC/pDxrkwYs6mUCgqDMXKJFQY4/0TEt45IEJPdPvgDOpGp96U4sOLKKGuR34yl3Eauhy31q/cR2GYPqDBaY3ms4Tvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817826; c=relaxed/simple;
	bh=Brs1ox8+gLMkZqZvlD/HEtRpUJHuQOucwwSeSNs23+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NNpOCK0lfhh4pLKm36Yul5NAMlfCfq/TF/wk2OoVwD4MGD5S2+OhF3sG0AWfi+JGAPsWO1p5k0Gw+wnJxWOEf+Fa6UUjgt4QSkPluRTg28tLFMOj9nOagscT0usousjZLE/R68G5LHVLa9g8oo+TxDOYwdnlanZncZObZVfMdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqFtdIbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqFtdIbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C1E1F00A3A;
	Tue, 30 Jun 2026 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817824;
	bh=FHaLKww1u+vU5lAE4gSX6v2ohi/k7OQp5WQAOpJkOeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqFtdIbZM2BckLvX/+0LuH7ajHslJJZR8HvVVdMdMJ7AvpPku6RoOPUk7YjAWIHXX
	 4cM/lGGbXJ+7Tgu5WAfeEVXJivFieBYM03mwuGIp86Zm3gSr3qKxVtWQBbfLnbQSr5
	 XWasw9kR+rN0y4Znrxa2L2Ya75RoKwIRMy4J1s4yenTr8aIgA2grnJ9gmOX4/DcqEu
	 83W6A9o195HnQjsUtoRoP5bgy+grXwk/8hg+2k+BTa+rbVhoJVMLqjTsPpyhVo4ASq
	 XnucmZ2hdUpDROsQeS/eB1S2jo0M/R8G8rcf/UXTA3zBRc+Gth1XPfjXW2IYthpEu1
	 MRdKTz4YpmEdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260630104132.1598851-5-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:10:23 +0000
Message-Id: <20260630111024.91C1E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Typo in the function comment block for `vfio_ap_reset_migration_sta=
te`.

Pre-existing issues:
- [High] Preexisting memory leak of `ap_config` in `vfio_ap_release_migrati=
on_data`.
--

commit 814157f788ce7725968457dca0dde1e8bb23d18c
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler

This patch adds a handler to reset the vfio-ap migration state during a
VFIO_DEVICE_RESET ioctl. It releases migration files and frees the storage
allocated for maintaining the migration state to return it to RUNNING.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 5b6d48ccf332c..c7c71980bdbb8 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -129,3 +129,23 @@ void vfio_ap_release_migration_data(struct ap_matrix=
_mdev *matrix_mdev)
>  	kfree(matrix_mdev->mig_data);
>  	matrix_mdev->mig_data =3D NULL;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this function leak the
dynamically allocated ap_config pointer stored within mig_data?

If the VFIO device file descriptor is closed before the migration file
descriptor, vfio_ap_mdev_close_device() calls this function which frees
matrix_mdev->mig_data without first freeing
mig_data->resuming_mig_state.ap_config.

When the migration file descriptor is subsequently closed, its release
callback vfio_ap_release_mig_file() checks matrix_mdev->mig_data. Since it
is now NULL, it returns -ENODEV and skips cleanup, which seems to permanent=
ly
leak the ap_config memory. Could this be triggered repeatedly by userspace?

> +
> +/**
> + * vfio_ap_reset_migration_state - Reset the vfio-ap migration state
> + *
> + * @matrix_mdev: pointer to the object maintaining the vfio-ap device st=
ate
> + *
> + * Called during VFIO_DEVICE_RESET to clean up any active migration
> + * stte and reset the device to RUNNING state as required by the VFIO

[Severity: Low]
This isn't a bug, but there is a typo in the comment block. Did you mean
"state" instead of "stte"?

> + * migration specification.
> + */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D4
