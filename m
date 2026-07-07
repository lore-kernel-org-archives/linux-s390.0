Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FB38B140;
	Tue,  7 Jul 2026 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416253; cv=none; b=aJJwvQZ8I98LeG4aZ2rSk4s7Sj8t2FgP1YlIJXIEaCFYmQ6DZib3jzQgNhQIHg6ZmmvoSgzcwvQAp7VntTfynlidF53lyrslnnBsgZSpVrLKj7xOpB67+cD/5IgwEuo+oSNeoNToZOyiABL45lf39OZiETzOtEnulho7wQbGNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416253; c=relaxed/simple;
	bh=eRoo8bGA9pkvOINSaq4BljFr2nk86EwUmPtXdbhh3iE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cGMA1P96sTRaL/Ih52GAcQJsSokxDg8LyDRNhyIr9onf/1Iyn3JYjDFImDsn/mr3fP17LhahTcsh6taGfcqi96HqLj0G5+gAyVLNP8tmJ59Aqn/l2NT3+KW5Fmby9l02+mHf57vYkmFh1w4JF+GsVtiuLkFh0xl2S+QnkjJP2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPkqffOp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPkqffOp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B47A1F000E9;
	Tue,  7 Jul 2026 09:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416251;
	bh=zVR77tCarUaLjzK9zo50A63cX/0g370KhzW8hMn3BCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPkqffOpndi0fdCyY2Qda1QJnl9rjLMbxAVpaueZrGRIbNby/U5cFTOTrqYzZV9N3
	 fC0Cf9h/fNG1D0SXd5ISlnmEmj49Cu8sscWWLqRUSLtYeEKU8oUHmsXvUIxMfBZM85
	 6eUJ27D3Hp171T4XdKzT7XUkP3SW9mWEZpooIkowhaLgrIlErYxHGqyTJ5J6ZI2gIU
	 ym5ispXmks39ttTICorRWOEab4coHYH9BbxqfVcILjZuiJlTHAYpk2auwlqqhYEI5J
	 9yEK5syMg9PhbpBP5J8E8yf641pQI9onuAispoF/TRGVCxgmlmYLQdFh8vYSG3ee8c
	 +KmwKvwL3ndHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/15] s390/vfio-ap: Transition guest migration state
 from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260707090226.3206695-7-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:24:10 +0000
Message-Id: <20260707092411.6B47A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The migration file descriptor's lifecycle is not decoupled fro=
m the VFIO device, and its release callback accesses device structures lock=
lessly. This causes a Use-After-Free and TOCTOU races if the migration file=
 outlives the VFIO device or if it is closed concurrently with device teard=
own.
--

--- Patch [6]: [PATCH v4 06/15] s390/vfio-ap: Transition guest migration st=
ate from STOP to STOP_COPY ---
commit 2960f99fd69c88ca78cea015d8ad75148e325f63
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY

This commit introduces the transition to the STOP_COPY migration state for
vfio-ap devices. It creates a migration file descriptor using an anonymous
inode to stream the guest's AP configuration, providing a stub read
implementation and a release callback.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +static int vfio_ap_release_mig_file(struct inode *file_inode, struct fil=
e *filp)
> +{
> +	struct ap_matrix_mdev *matrix_mdev =3D filp->private_data;
> +
> +	if (!matrix_mdev || !matrix_mdev->mig_data)
> +		return -ENODEV;
> +
> +	if (filp =3D=3D matrix_mdev->mig_data->stop_copy_mig_file)
> +		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);

[Severity: Critical]
Is there a risk of a use-after-free here if the main VFIO device is closed
or unbound concurrently while the migration file descriptor is still open?

Since this release callback accesses matrix_mdev and its mig_data locklessl=
y,
could matrix_mdev have already been freed during device teardown if userspa=
ce
closes the device but keeps the migration file descriptor open?

> +	else
> +		return -ENOENT;
> +
> +	return 0;
> +}

[ ... ]

> +static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matr=
ix_mdev,
> +					     const struct file_operations *fops,
> +					     int flags)
> +{
> +	struct file *filp;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	filp =3D anon_inode_getfile("vfio_ap_mig_file", fops, matrix_mdev, flag=
s);

[Severity: Critical]
Does this code safely couple the migration file descriptor's lifecycle to t=
he
VFIO device?

Because matrix_mdev is passed as private_data without taking a registration
reference on the VFIO device or wrapping it in an independent lifecycle
object, it seems the VFIO core will not wait for this migration fd to close
before tearing down the device.

> +	if (!IS_ERR(filp))
> +		stream_open(filp->f_inode, filp);
> +
> +	return filp;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D6
