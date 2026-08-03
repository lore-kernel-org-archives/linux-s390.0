Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661233FE33;
	Mon,  3 Aug 2026 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774870; cv=none; b=J9f3nvc2QavV6v9Qxc76Pjmla0t6D6vRo5HP2sGDrZuN2+3qLBGuAmM87xFDzmyih5aig9PJkJprfn2MbWPG41r9DIVJIxIpbeYSgMy8QvopYmCXWMZsnkIU1ryF4K0XXbGac1boPa6c5dqYrXfL5+7F8ZOV9J+7BbXuHCZnG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774870; c=relaxed/simple;
	bh=7VQ5pa+RpJe8T2VXYqwHcL0S7IG5ik8Yxooyc7jqByM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/tvdjptNTCbnSO/TDC2tyKugGGCGILcUw4CWPhN8nBDmTfrxjd2iHHO0rZc2s2XW2Apb6uWmWURGyXkZrSKdVgED75PErMVp7qF7BIT8XvAbXE7ioXJp0TF8Z6z7+t3TM6m5cOy8wfQLftB+ge3ImHfMgnu2S/dbWDlEVnVU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTsLxqy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTsLxqy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C830F1F000E9;
	Mon,  3 Aug 2026 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785774869;
	bh=R3muTn1aaV2rPIlMhUoPHbqXgEcDCYx0/1sWYcNX5T4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VTsLxqy847LAyXw4f1xWgQhpkXxMI8IC3uBB7ejrzCqdixaooJzDgG3wt8i9N1zXg
	 aIRuUSh+pPtEoWERdRQX4wcMODCpIsDUQB3L9Uv4DGoDJNgxXcByXNI5Z4M+NmYPYC
	 8wvAzLXQLsIVXVfKCCCZ7BIb6STcy3a4HQqCC7r3qbbStcp8HbJoMKiZOc2wXvRNap
	 TAsPmCt5KtkrDu7MkkvmAPKpxxUrmvQJ1GLtL0wITkY4Ejo0viKQYkvH1DVcPi/cIz
	 lmdY/kmjYHxq0yCPc7rKvs53U+sRQpm97/JlgZCpj/bhL0jPEW3cnuAu+8f/XGziFy
	 wI/JTKrzPNR7g==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 06/23] s390/vfio_ccw: Ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803160924.236807-7-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:34:27 +0000
Message-Id: <20260803163428.C830F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `private->crw` linked list is accessed and modified concur=
rently without any synchronization, leading to list corruption.
--

--- Patch [6]: [GIT PULL v1 06/23] s390/vfio_ccw: Ensure index for read/wri=
te regions are within range ---
commit e1d18d0b96d197063d1125d864eec65df5351f67
Author: Eric Farman <farman@linux.ibm.com>

    s390/vfio_ccw: Ensure index for read/write regions are within range
   =20
    The introduction of the capability chain rightly clamped the
    region indexes to the range of the capabilities itself, but
    neglected to do so for the existing read/write regions which
    should also be enforced.

[ ... ]

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

[Severity: Critical]
This is a pre-existing issue, but does this code corrupt the private->crw l=
ist?

CRW events are dequeued from the list here without any lock protection, all=
owing
concurrent read() syscalls to race and corrupt the list.

It looks like events are also appended to the list locklessly by
vfio_ccw_queue_crw():

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
	...
	list_add_tail(&crw->next, &private->crw);
	queue_work(vfio_ccw_work_q, &private->crw_work);
}

This means a single read() call can race against an incoming channel path e=
vent
handled by the asynchronous CSS callback vfio_ccw_chp_event(), resulting in=
 list
corruption.

>  	mutex_lock(&private->io_mutex);
> +	if (i >=3D private->num_regions) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	i =3D array_index_nospec(i, private->num_regions);
>  	region =3D private->region[i].data;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D6
