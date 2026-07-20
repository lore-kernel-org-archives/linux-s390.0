Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20503C9ED0;
	Mon, 20 Jul 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579455; cv=none; b=QiUbLDLp41ndTqxhoxb0ERTgrLJ+MsPq8RltprGcM1fuc/5vDzd8QFwDaq/t8wi2Trsp6xtEYqStsk6pDnqtFH1paa6fr/Kr3yGh9Bk6/LwCuxxQdaa4TkNEz4ShbFZjv+EvgIKjBScTGuM08CSoYKmqJu5kSDIvXDWJ33Nd4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579455; c=relaxed/simple;
	bh=d6t2+nMY8ri0J+bOm+Kh03WzIqKt6xjn79tC1P7YHRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lV58RvO19bRCVeA8nm7S+ipY6MGWGoc0YUfft7M55Gs8xxodnqr99/XheLai0MF7E585c189G7zBRDa3iNu9iJHb3VRGpcW3bbzrUvN2lhAQ1L5ZK7lz8Ze+1AIknvjDdZoh6OxHXH2djO6u+c68PXuTUljeK2DpGg+8KdTYkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcZax5y2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcZax5y2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C041F000E9;
	Mon, 20 Jul 2026 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784579454;
	bh=XZHB8uCKP9/m8El3/5o/j+cg2uEZxQGR5sSb6ddpyCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcZax5y2IRuD87q+yqU2hzRCGQ7YVEs9LEiNgj+7RlO+fVAVnDgDXfvOCUedNjws5
	 4mWJIpHJ1+9YDcgJwNuedCQwUsKPheMqYJusG8ySvnZ5skBMH4W04qcTDMXVrOCnd2
	 IaxZsg9GtptW0dmSXEAVe/0HFSL8bUBmaq96ljewd7MlcVmLqFjGWA5JAVhbF3sSbU
	 ETl4Cr7dn7t4O7fceUcsNCqWwtA0lfO1Cp5p26Pl5kMZBdTWxhIE6bwjOdzUrBX2W8
	 G5k8R0ldyh+hGCHG1+W4omHMIdku10cXHCrEaKME6Q05tYq2xxx/o/HJFAA4y/IoWN
	 0CqcBhd6ZMLzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] s390/vfio_ccw: limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260720201931.976660-3-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:30:52 +0000
Message-Id: <20260720203054.07C041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Returning a pointer (`ERR_PTR`) from a function that returns an `in=
t`.

Pre-existing issues:
- [High] Concurrent unprotected access to channel program structures via io=
ctl reset and write paths.
- [High] Out-of-bounds read on `cp->guest_cp` when calculating the CCW chai=
n length.
--

--- Patch [2]: [PATCH v2 2/7] s390/vfio_ccw: limit the number of channel pr=
ogram segments ---
commit 55497ee3c2db8e265add0b6679cc5ddd751ba7ce
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: limit the number of channel program segments

This commit imposes a limit on the number of channel program segments to
prevent excessive recursive processing. It tracks the count in the
channel_program structure and fails if it exceeds CCWCHAIN_COUNT_MAX.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 086d1b54bdb05..7abdebd8f7c3d 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c

[ ... ]

> @@ -441,6 +442,10 @@ static int ccwchain_handle_ccw(dma32_t cda, struct c=
hannel_program *cp)
>  	if (len < 0)
>  		return len;
> =20
> +	/* Limit number of chains in a single channel program */
> +	if (cp->ccwchain_count >=3D CCWCHAIN_COUNT_MAX)
> +		return ERR_PTR(-EINVAL);

[Severity: Low]
Does this return a pointer from a function that returns an int?
ccwchain_handle_ccw() returns an int, but ERR_PTR(-EINVAL) returns a void
pointer, which could cause a type mismatch or compilation warning.

[ ... ]

[Severity: High]
This is a pre-existing issue, but can concurrent unprotected access to
channel program structures occur via the ioctl reset and write paths?

If a user-space process concurrently invokes ioctl(VFIO_DEVICE_RESET) and
write() on the VFIO device file descriptor:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_reset() {
    ...
    vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
    ...
}

This calls into the state machine to close and free the channel program
without acquiring private->io_mutex:

drivers/s390/cio/vfio_ccw_fsm.c:fsm_close() {
    ...
    cp_free(&private->cp);
    ...
}

Concurrently, vfio_ccw_mdev_write_io_region() acquires io_mutex and process=
es
IO, allocating and using private->cp. Could this data race lead to a
use-after-free?

[Severity: High]
This is a pre-existing issue, but is there an out-of-bounds read on
cp->guest_cp when calculating the CCW chain length?

If an unprivileged user provides a channel program filled with exactly 256
command-chained CCWs:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_calc_length() {
    ...
    if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
        break;

    ccw++;
} while (cnt < CCWCHAIN_LEN_MAX + 1);

The loop executes a 257th iteration when cnt =3D=3D 257, evaluating
!ccw_is_chain(ccw) on guest_cp[256], which points past the 256-element
guest_cp array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720201931.9766=
60-1-farman@linux.ibm.com?part=3D2
