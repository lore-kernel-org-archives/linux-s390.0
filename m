Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF7369991
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371245; cv=none; b=SAF2jww1kZJ5NZBcUe9/7ZdcrGVFGoaHtTVvr0Mcod+eAAkZOZiMGZNFR+3dE7uWoKVvCzJ3XHtqrRSfD94pdb/9WLwNQb/h94UZS7Ut2LrQKL15I6n5NLrzF2OJ6e8MJF4Pb6PR99yh7FEG0Qdh2I9QEytu2fM0EN1RA7I7/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371245; c=relaxed/simple;
	bh=bmuEYBlEXqz/Jtn3Kb0LCarMFxoxAhV6KShQ8gS2EC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ik//U5RgCo/y0jd/hpn9W4k+eseoqzOq4hLc6Z3swMeanCbkupl3LUVxgn/9T6SGg/X712OnYESzfZMqStGutWWrUikBmok6oixeTUb20p/qJg/tAfsGQbdvw6/utlbtAzRtVZEbAcigGmyBCYk4YoijSJCJZRbgvLHxmAZ15vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBOQ/Juf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBOQ/Juf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5271B1F000FF;
	Mon, 14 Sep 2026 07:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789371243;
	bh=bmuEYBlEXqz/Jtn3Kb0LCarMFxoxAhV6KShQ8gS2EC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HBOQ/JufMtncq4jSsmYZmDDoNaHTGRllDxORWPDA/kyE8kIc680JDO85buhvZ6yAw
	 ib8VPUg6Cu6CucytccxAhcMJCppnmiKfnNTmx7/GBJMUTCSa4mqvpKM6cQxzqu9PfV
	 +lwr2bssH4GDnxrcPc+u615kidviNqB9vMeUdBcknNG6wQJFk38qi8xLpFNYFUDHRF
	 KBSiZvmKFF08QfBDcaLyVp7NKpeWzfdC/KDnU86RWv/YacMkTpaZ2K8fLL4y2bKo3s
	 TWdsSR+3/xwfVazuNZSm+V9kCVsceWVlTBpsykAPJ0q+iS5yV5ARbc7mgfgjp8/pVe
	 PGpl9gEm7xvTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] dma: swiotlb: Centralize minimal pool sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260914070135.313337-3-aneesh.kumar@kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:34:02 +0000
Message-Id: <20260914073403.5271B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> A default SWIOTLB pool used only for unaligned kmalloc bouncing can be
> smaller than one required for limited DMA addressing. Arm64 and RISC-V
> currently implement this sizing independently, using 1 MiB of SWIOTLB
> space per GiB of RAM.
>=20
> The SWIOTLB core now identifies this case with SWIOTLB_POOL_MINIMAL.
> Size that policy in swiotlb_adjust_pool_size() and remove the
> architecture-specific adjustments.
>=20
> Explicit swiotlb=3D sizing remains unchanged because swiotlb_adjust_size()
> preserves a user-configured size.
>=20
> NOTE: We lose the RISC-V SWIOTLB_ANY setting in this patch. It will be
> reinstated in a follow-up patch where we make SWIOTLB_ANY redundant.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914070135.3133=
37-1-aneesh.kumar@kernel.org?part=3D2

