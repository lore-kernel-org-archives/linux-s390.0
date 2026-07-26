Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B672630;
	Sun, 26 Jul 2026 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785040398; cv=none; b=kbVUE/BOI2eTJh4ngHqm1lCIe7fTmRdzMGUMZjen3wypPigt7T3C3iLs8CTkYJiraxeBSE2MvNL+bO6F/icSDeQTUpuezt71JsSjExmaQvuhSAG9HJKMhV/NTCn4HDE8pRMMAlrDt2rFqaGYtVSEfhns01nVWmm3gW1EoBy+k+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785040398; c=relaxed/simple;
	bh=BhldJj8NMtns8R1IwdCUPVArctn3UFrBmmU6Mh+gc1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kJhl4KAFc6txynEJCp1XwP2ZkBx5UXbz00f/JUo61AT73oWl2TzYkCqu2n6u434joyJdPdnE6D05CaC0tveW3d3tdxV0pQA1Pi21HNkgGI/8l2xd2zOHOXLiIDyW8/IPtnWEt94lN+GY4+JwblkjILCOY5mVb7X/HOh/YANDCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S96t2S5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S96t2S5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9201F000E9;
	Sun, 26 Jul 2026 04:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785040397;
	bh=zctwmYHbNrPEn+v5dxkM1nBPquoh07Hp2GQJOVfS6P8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S96t2S5gDEId59nS5OJUSQCHHX1f3i5NlFl6GF5OXZyGbpXaq9ODJP8IJhXndLHHY
	 5me++7rsHh9MnQC39baJJXxxfdEmwPcARSn/r736C+0Dzq1GvUXvQx3id4aFmZen7j
	 J8vQoiW0b6hAsdb4AL74dZ3B84wXizFjlXoO3ABXXO0p8Q8Lh9Ds0K3tlI0PhcDk4E
	 eaCyx6Yfy+Hcf00MaREDYzMPydINudC2IEL/u5QOVjdX7AzoW0N3eXS4rieE0oFbtk
	 4Hix9y4t7IBBCLIUphNwFjvV5QbmWjR/feKkn1OyA6rQB9clCzLvoxqzvFt+mDH8TI
	 nZ7WpcECCqGhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] s390/vfio_ccw: fix out of bounds check on CCW
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260726040129.2946151-4-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:33:16 +0000
Message-Id: <20260726043317.0B9201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Hardware Status Modifier skips allow the channel subsystem to =
fetch and execute CCWs from out-of-bounds host memory because VFIO prematur=
ely truncates the allocated chain.
--

--- Patch [3]: [PATCH v5 03/10] s390/vfio_ccw: fix out of bounds check on C=
CW array ---
commit 7c8a75a862f0fe5c95ff1ad636c202fa276e66c2
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: fix out of bounds check on CCW array

This commit fixes an out-of-bounds array access in ccwchain_calc_length().
It restructures the loop to exit safely once the maximum number of CCWs
(256) have been processed, preventing the code from evaluating memory
outside the valid range.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c

[ ... ]

> @@ -377,11 +377,9 @@ static void ccwchain_cda_free(struct ccwchain *chain=
, int idx)
>  static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>  {
>  	struct ccw1 *ccw =3D cp->guest_cp;
> -	int cnt =3D 0;
> -
> -	do {
> -		cnt++;
> +	int cnt;
> =20
> +	for (cnt =3D 1; cnt <=3D CCWCHAIN_LEN_MAX; cnt++, ccw++) {
>  		/*
>  		 * We want to keep counting if the current CCW has the
>  		 * command-chaining flag enabled, or if it is a TIC CCW
> @@ -391,15 +389,10 @@ static int ccwchain_calc_length(u64 iova, struct ch=
annel_program *cp)
>  		 * after the TIC, depending on the results of its operation.
>  		 */
>  		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
> -			break;
> -
> -		ccw++;
> -	} while (cnt < CCWCHAIN_LEN_MAX + 1);
> -
> -	if (cnt =3D=3D CCWCHAIN_LEN_MAX + 1)
> -		cnt =3D -EINVAL;
> +			return cnt;

[Severity: Critical]
This is a pre-existing issue, but does this termination condition fully
account for hardware status modifier skips?

If a guest constructs a channel program where a CCW specifies chaining
and executes a command that generates a status modifier, and the
immediately following CCW explicitly clears the chaining flag, will
ccwchain_calc_length() stop counting at the second CCW?

If the calculation stops there, it appears the subsystem would allocate a h=
ost
buffer sized for exactly two CCWs. When executed, the hardware would see
the status modifier, skip the second CCW, and fetch a third CCW from
memory immediately following the allocated buffer.

Could this allow the channel subsystem to fetch and execute an untranslated,
out-of-bounds CCW from host memory if the guest places one adjacent to the
allocation?

> +	}
> =20
> -	return cnt;
> +	return -EINVAL;
>  }
> =20
>  static int tic_target_chain_exists(struct ccw1 *tic, struct channel_prog=
ram *cp)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D3
