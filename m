Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778273ACA57;
	Mon, 20 Jul 2026 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580021; cv=none; b=oCJgQ3/SIbskAKJBq5U4XLMsDhVCuP02+yTDECdDZPcl641TuOIykHQSG3JVnwKMH5/nWEOpd2vdApA1L0a1fAVBJDvxLJrFhSyc8b17nH8djGwE6nbEyuYJMQXcJTVvHT/8OXf7qmuxS4uoplL31LMlo2ywm6URmmrce/2VG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580021; c=relaxed/simple;
	bh=NgpCb5QQmwhvRPphIFiETIXCXVPWizK0M7XCCDm2Jew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ELQ+QTvUwY2ve0Ua9iD9dH5VWf4Tg1s0HD8ZPWpM3u3jRp07VETk2o5mTQW7MhtQ0sW42XzpWb0f8tg4+IIuv2vDd9w/4ORdwq+bC4otniEhcPwdKEIjQFGxqVwIPJr3h+Mzaez7EfjD1qxbodItLFl+iq0Cex1yFLVD+Ja6QRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNEMp09L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNEMp09L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD531F000E9;
	Mon, 20 Jul 2026 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784580020;
	bh=WszKRWAluuEQTZyYHLPyUJ6Z3hOhBknktNgBYLps/d0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZNEMp09LyjbTDvVKnScSIm1XFjIWPNDygHLSpBeJy4/xziibgnBEMVNPIWZGnWrOt
	 MZkM+FWLUoOslC6tx8oXwIxwKL9fQh7eOh/i6M9hms/xOhY2555F7HtmlImbHJ6jzc
	 +Li4s1HsUOQYvYCDHYQUomDBzmRNo5iXDZpezwK1alR2bohFfuVNv5scR7E833vhnU
	 ISQig8qUEkI5WflwMn1C1PhInPBh2aUIbtE/tkEGGVC7t0NCjC/spNe2wPe60DK6Pd
	 cs7ybZpNgeTOoTBNtcOU8IvJM2nrStMzCpcOWIOyERwbdKYalpdyrNlCijospNFt75
	 jys0fpH9Hs3wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] s390/vfio_ccw: ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260720201931.976660-6-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:40:19 +0000
Message-Id: <20260720204019.BFD531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Spectre v1 Mitigation / Speculative Out-of-Bounds Access
- [High] Broken Spectre v1 Mitigation / Speculative Out-of-Bounds Read in i=
octl handler
--

--- Patch [5]: [PATCH v2 5/7] s390/vfio_ccw: ensure index for read/write re=
gions are within range ---
commit 9523937d39e77d5858c1e23dd917c8844bcf3876
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure index for read/write regions are within range

The introduction of the capability chain rightly clamped the
region indexes to the range of the capabilities itself, but
neglected to do so for the existing read/write regions which
should also be enforced.

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 45ec722d25ea6..e695cd985369d 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -243,6 +243,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device =
*vdev,
>  		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
>  	default:
>  		index -=3D VFIO_CCW_NUM_REGIONS;
> +		index =3D array_index_nospec(index, private->num_regions);
>  		return private->region[index].ops->read(private, buf, count,
>  							ppos);

[Severity: High]
This isn't a bug introduced by this patch, but does this actually fix the
speculative out-of-bounds access?

We clamp the local index here, but we pass the unmodified ppos pointer
down to the read handlers. The handlers then recompute the index from ppos
without array_index_nospec():

drivers/s390/cio/vfio_ccw_async.c:vfio_ccw_async_region_read() {
    unsigned int i =3D VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIO=
NS;
    ...
    region =3D private->region[i].data;
    if (copy_to_user(buf, (void *)region + pos, count))
}

Can a malicious guest exploit this by passing an out-of-bounds offset,
causing the read handler to speculatively recompute the out-of-bounds index
i and perform a speculative out-of-bounds read via private->region[i].data?

The same pattern exists in vfio_ccw_async_region_write(),
vfio_ccw_schib_region_read(), and vfio_ccw_crw_region_read().

>  	}

[ ... ]

> @@ -295,6 +296,7 @@ static ssize_t vfio_ccw_mdev_write(struct vfio_device=
 *vdev,
>  		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
>  	default:
>  		index -=3D VFIO_CCW_NUM_REGIONS;
> +		index =3D array_index_nospec(index, private->num_regions);
>  		return private->region[index].ops->write(private, buf, count,
>  							 ppos);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but looking further down in
vfio_ccw_ops.c, is there a broken speculative mitigation in
vfio_ccw_mdev_ioctl_get_region_info()?

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_ioctl_get_region_info() {
    ...
    info->index =3D array_index_nospec(info->index,
                                     VFIO_CCW_NUM_REGIONS +
                                     private->num_regions);
    i =3D info->index - VFIO_CCW_NUM_REGIONS;
    info->offset =3D VFIO_CCW_INDEX_TO_OFFSET(info->index);
    info->size =3D private->region[i].size;
    ...
}

If info->index is maliciously out of bounds, array_index_nospec() will
speculatively force it to 0. Since VFIO_CCW_NUM_REGIONS is 1, i becomes -1.

Does this result in a deterministic speculative out-of-bounds read at
index -1 when evaluating private->region[i].size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720201931.9766=
60-1-farman@linux.ibm.com?part=3D5
