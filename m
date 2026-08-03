Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16437F33A;
	Mon,  3 Aug 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774752; cv=none; b=omWpyqacHIfC/hpwOZtk7uKueClMGRWfU1v4m9Ixd4Qg4DOrPruCCGUluR6KuDX7Y/r0+UjVLVNN2CNy8GmCS3RdYvZJzYFAH7b5xEYhgA2ZE2rfVuTlBy9mZqgtU/mMCEeqzUDEWi6QvSAWZnZ7lXGt+VtXCVdvHN0/20gEsIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774752; c=relaxed/simple;
	bh=mluT2BnVVp3fVn1dYIaNwW9JuxHmGNKSJQ1E2IjcnHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sh9nU4WE1SQggkjZYoeEjWAR/Lv+O8exXwgS3kKbjLtSJrxu0sR8jPLrxmcF39yV/xCRP8RzlXXtfJr9aZLtPHeG+g97YkyoT2FBswr6lwlJKluNdPczjJ0oHzUFoVnBPalcwjBu3N2GqpXINBBY3GtszTW/nJxeSU65zxQuDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeCxul1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeCxul1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E40F1F000E9;
	Mon,  3 Aug 2026 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785774750;
	bh=irvVOwAEw5037HIHtLiUc720fSkWqjlfllPEH2j6RI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VeCxul1y1arNbfO9AuZxhbCVQe2z6EeVrc+85fmIvI/mg56jNQ4X880E/zaVGu33z
	 Y78pKk38RbUa2tyBgTOcZxRW8JWwz8n/QtKcin418gz8ZLHb5o0WY6otiAv7rWDk7z
	 ASuW/77cy39XbMVbPWJ6dqtoJadTfHbLA6kQg014oaSmSWO//I2za9U075qwwwCjzs
	 uB7f14qvi/mxljG7Qw5GJV6SxQY6PdwKDBY2jkDJeKUWqlB8ByUtMHz/hLp9tzrXEd
	 +xE56xgPbcszZPkwIGiSJipsGpPjBFLPMIKQp/1WKjWhH9av3vG6NmbO1uyLy7aILs
	 mQTSUkKGEA3fg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 02/23] s390/vfio_ccw: Limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803160924.236807-3-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:32:29 +0000
Message-Id: <20260803163230.6E40F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sleeping in atomic context when processing NOT_OPER FSM event
- [High] Race condition leading to Use-After-Free / list corruption on chan=
nel program
- [High] Out-of-bounds read in ccwchain_calc_length
--

--- Patch [2]: [GIT PULL v1 02/23] s390/vfio_ccw: Limit the number of chann=
el program segments ---
commit f04946000e5f4fc0876ae6db794b58a1b8744e08
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: Limit the number of channel program segments

The processing of channel programs, and the CCWs within them, is done
recursively. As such, there is an arbitrary (but not architectural)
limit to the number of CCWs that can exist in a single channel program.

The vfio-ccw logic breaks these channel programs into segments whenever
it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
of segments count towards the global limit. Impose an equivalent limit
to the number of segments until such logic can be made non-recursive.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 086d1b54bdb05..1c2890d139c6b 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
[ ... ]
> @@ -441,6 +442,10 @@ static int ccwchain_handle_ccw(dma32_t cda, struct c=
hannel_program *cp)
>  	if (len < 0)
>  		return len;

[Severity: High]
This is a pre-existing issue, but can the call to ccwchain_calc_length() ju=
st
before this block result in an out-of-bounds read?

If a guest provides a channel program with 256 command-chained CCWs, the lo=
op
in ccwchain_calc_length() reaches cnt =3D=3D 256 and increments the ccw poi=
nter
past the end of the array.

The loop condition while (cnt < CCWCHAIN_LEN_MAX + 1) then allows a 257th
iteration, which dereferences the out-of-bounds ccw pointer in the
ccw_is_chain(ccw) check.

> +	/* Limit number of chains in a single channel program */
> +	if (cp->ccwchain_count >=3D CCWCHAIN_COUNT_MAX)
> +		return -EINVAL;
> +
>  	/* Need alloc a new chain for this one. */
>  	chain =3D ccwchain_alloc(cp, len);
>  	if (!chain)
[ ... ]
> @@ -745,6 +750,7 @@ int cp_init(struct channel_program *cp, union orb *or=
b)
>  			vdev->dev,
>  			"Prefetching channel program even though prefetch not specified in OR=
B");
> =20
> +	cp->ccwchain_count =3D 0;
>  	INIT_LIST_HEAD(&cp->ccwchain_list);
>  	memcpy(&cp->orb, orb, sizeof(*orb));

[Severity: High]
This is a pre-existing issue, but could this channel program initialization
race with a subchannel event, leading to a use-after-free or list corruptio=
n?

The I/O request path holds private->io_mutex and initializes or modifies
private->cp in fsm_io_request(). Concurrently, the subchannel event path
(like a device offline event) holds sch->lock and unconditionally frees
private->cp in fsm_notoper().

Since the two contexts use disjoint locks, is there anything preventing them
from racing?

[Severity: High]
This is another pre-existing issue, but can fsm_notoper() sleep while holdi=
ng
a spinlock with interrupts disabled?

When a subchannel event occurs, vfio_ccw_sch_event() acquires sch->lock usi=
ng
spin_lock_irqsave(). It then calls vfio_ccw_fsm_event(), which executes
fsm_notoper().

fsm_notoper() calls cp_free(), which can eventually reach
vfio_iommu_type1_unpin_pages(). That function acquires a sleepable mutex:

drivers/vfio/vfio_iommu_type1.c:vfio_iommu_type1_unpin_pages()
    ...
    mutex_lock(&iommu->lock);
    ...

Could this lead to a deadlock or crash if triggered by hardware or
virtualization events while a guest is operating?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D2
