Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827F448BA8
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336832; cv=none; b=mtCBXxz1f7+0tzPFDwkUY+6dJ8uik9WyKQR8wmXoCpe5Ia5oTy87RJNh/aVx7VQU6IAWz4WhaC1vmddOpsyKhug+zt6xNc6sdiMFdmWNF98pWsGuhvl3JnBPjexUQvM+aTgGxq0B4FqBn67bcBRnQ1xEufQaHShXnqyFVAPsA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336832; c=relaxed/simple;
	bh=XBeOa+KoxfVGUrtFsxR0zX8lIMVxpLWtCZkZAmFIbEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hYcS30yo5NuaF09GA93qcY8ulsx7MJEdRP8KuY/949r/e8RvYlApVtvKU9ogfUKMSMGXbwbqw/fBC7ZDTEu3IoBeVuivBY1t1SHpSOjKwUVPLXIi5/YfSdVe1ywY3X3YScgCur7D7D5o2MTB3f24su1toGFTMU6DrTPw7dJzRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzhwvFuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzhwvFuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6931F000FF;
	Fri, 25 Sep 2026 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336828;
	bh=XBeOa+KoxfVGUrtFsxR0zX8lIMVxpLWtCZkZAmFIbEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kzhwvFuRMFLI4F4IVPAEPpEnwcEhbgnaJXqCWbXuIocz6X8hGr0sAvoj+JP+nsiQ6
	 uP/fhNG7aLP7VcZbkl5o19Njp2vY+wA9F9TcPYZNrkn+9Emz+0Gy03CW7o2hsDfpo5
	 zlK7oP2iZLxQNLBCTey2s24e6UkQe4kqZEs1YWnq69GneYSO6HwwRbtS9Lfxzlo6Rh
	 Vu/gNIjMqTdWD+MqFYyl/VEY+lmJ0k+aARpk7t04kfnNBin2SanBeT7eoPx3bDfSJM
	 gZqb/jGa6Ix2zkq0UqwpNpZY1ZNcS305h8XS0faAx+NFJklWq3Vts6cQ6TXsquz19+
	 UrDZdcmapFA9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/9] lib/lz4: add the build environment for the
 vendored sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:47:07 +0000
Message-Id: <20260925114707.AF6931F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> lz4_deps.h makes the unmodified upstream sources compile in the kernel:
> it supplies the ISO C spellings they expect, gives every upstream entry
> point internal linkage so an object carries only the codec it forwards,
> keeps every workspace off the stack, and renames the entry points the
> kernel re-exports with a trailing wrkmem argument.
>=20
> freestanding/ forwards the four ISO C headers upstream includes
> (stddef.h, stdint.h, limits.h, string.h) to their <linux/> equivalents.
>=20
> The vendored functions an object does not forward are unreferenced, so
> LZ4LIB_VISIBILITY carries __maybe_unused rather than disabling
> -Wunused-function for a directory. This also covers the pre-boot
> decompressors, which compile lz4_decompress.c textually and never see
> lib/lz4's ccflags.
>=20
> For the same reason this header includes <linux/build_bug.h>: the entry
> points static_assert upstream's structure sizes, and only some
> architectures' pre-boot environments have static_assert in scope.
>=20
> lz4_kernel_api.h undoes the renaming for the entry point files and
> declares what lib/lz4 exports. It starts out carrying its own copy of
> those prototypes, because it cannot include <linux/lz4.h> while that
> header still defines the three stream types upstream's headers also
> define. A later patch folds it away once they are incomplete.
>=20
> Nothing includes either header yet.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-lz4-vendor=
-upstream-v1-0-1c7ffbe21c4b@samsung.com?part=3D3

