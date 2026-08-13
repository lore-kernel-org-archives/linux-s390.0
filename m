Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92E44683F
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619971; cv=none; b=VUv8+JNBUcy1E0g28kCz9uW5PzVgpD8s2mkPVpXP8wrmPR/vWykKYH8faUgOuWuDIeYPeIK06mFjUVcTCVrfXvvDVMRHbjx0MXJsmpqhNqpGMa6+Cn+6vc+Z6Zaw3XRnUNLD8ct/+t7mFr0LKnD8bfc+GliMjVf7wx4RVW3yFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619971; c=relaxed/simple;
	bh=PPd/1kkt7pZnDIXL7yLrnfKvlC/Rq1/EK6l4IBx8y+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hNLR4GvEVcT0ck8pq/CzadjpZRNRdrDwTaXptUxbhe5vvULgYPKjYIUwvg73n8dUQsZMPIt8zPy/NZabYBRegX/WNM1wxI37bVyKLSNOCy2sc+f9jxQrm/jdiDD4b+yfr7ay7f0CqaEyZ2oSI294tVy4loApam+32TAdBx2X73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7U/JilK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7U/JilK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184701F000E9;
	Thu, 13 Aug 2026 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786619968;
	bh=9Eyhd6FSz3wKSRpAyUTsypmujj/rM/WmvHhQ12UJgEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7U/JilKY6vzfXQ1+q9fm2MTQzria/z88UHgDVt9F60b/K5xOOCItWmiGPKShR3c/
	 GzqOm6g6VLXit2EyOtygbOpcXRLFtQNKjB/6zAQbx5SMIyOq14E0W6n7yZopnIdPaL
	 rsL6YOOvGEb/W7gj2zRmTjVz57hldlSVJDon0PuvQY284zzswZ1JU9Ry8snHSs+6Bz
	 vMB3B70kUM1MC1htvO1FPOg5vVcvbnF3DzLK0XRanZvwze+ddMnzfWg65i7/DYbOy2
	 IvgHJudzIaHj+kjhT17ltdjcuY/Y0Ad0+7fQfKo6qsbDB404SbYDetFRFsBZFihlDG
	 T09up9bTlSHSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] s390/ipl: Fix NULL deref in kdump without re-IPL
 parm block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasily Gorbik" <gor@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <p01-02.g87de83845c5f.ttjpfvt@ub.hpns>
References: <c00-02.ttjpfvt@ub.hpns> <p01-02.g87de83845c5f.ttjpfvt@ub.hpns>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:19:27 +0000
Message-Id: <20260813111928.184701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference in `dump_reipl_run()` when the system is =
booted without an IPL parameter block.
- [High] Unbounded `memcpy()` in `reipl_type_init()` causes a heap buffer o=
verflow in the dump kernel.
--

--- Patch [1]: [PATCH 1/2] s390/ipl: Fix NULL deref in kdump without re-IPL=
 parm block ---
commit f223a6548d3bfb367ccf07d1f7597eab8c386045
Author: Vasily Gorbik <gor@linux.ibm.com>

s390/ipl: Fix NULL deref in kdump without re-IPL parm block

Some IPL types, like HMC FTP boot or QEMU direct kernel boot, might
not provide an IPL parameter block. In this case, reipl_type_init()
selects IPL_TYPE_UNKNOWN, and reipl_block_actual remains NULL.

> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 3c346b02ceb95..7024fc4137152 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -1157,6 +1157,8 @@ static struct attribute_group reipl_nss_attr_group =
=3D {
> =20
>  void set_os_info_reipl_block(void)
>  {
> +	if (!reipl_block_actual)
> +		return;
>  	os_info_entry_add_data(OS_INFO_REIPL_BLOCK, reipl_block_actual,
>  			       reipl_block_actual->hdr.len);
>  }

[Severity: High]
This is a pre-existing issue, but looking at dump_reipl_run(), if the system
boots without an IPL parameter block and sets reipl_block_actual to NULL,
won't this unconditionally dereference it?

arch/s390/kernel/ipl.c:dump_reipl_run() {
    ...
	csum =3D (__force unsigned int)cksm(reipl_block_actual,
					  reipl_block_actual->hdr.len, 0);
	abs_lc =3D get_abs_lowcore();
	abs_lc->ipib =3D __pa(reipl_block_actual);
    ...
}

Will this cause a recursive fault during a crash shutdown sequence when the
on_panic action is configured to dump_reipl?

[Severity: High]
This isn't a bug introduced by this patch, but looking at reipl_type_init(),
could an untrusted size from the crashed kernel memory overflow the
PAGE_SIZE buffers here?

arch/s390/kernel/ipl.c:reipl_type_init() {
    ...
	reipl_block =3D os_info_old_entry(OS_INFO_REIPL_BLOCK, &size);
	if (!reipl_block)
		goto out;
	/*
	 * If we have an OS info reipl block, this will be used
	 */
	if (reipl_block->pb0_hdr.pbt =3D=3D IPL_PBT_FCP) {
		memcpy(reipl_block_fcp, reipl_block, size);
		reipl_type =3D IPL_TYPE_FCP;
	} else if (reipl_block->pb0_hdr.pbt =3D=3D IPL_PBT_NVME) {
    ...
}

If a malicious primary kernel crafts an os_info payload with a valid
checksum but a size greater than PAGE_SIZE, wouldn't this cause a heap
buffer overflow in the dump kernel, preventing the crash dump from being
collected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c00-02.ttjpfvt@ub.h=
pns?part=3D1
