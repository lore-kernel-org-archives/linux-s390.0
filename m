Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064544AB97
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336596; cv=none; b=ZvcSCpF62C5xJNI0kyp51DX+s6gbH9+G6bYw//51rjOsLNP/S+3G63fAM4P2q4uBuEs9dMCPIKoOBZlEeGxsUNC/Fo3DSFvHO9vbqE6UakurbtSXZzLrxEnoKM6SUJAXpzVPSXoBLV2iMA45xBNADO+dpc/HySJN3VXccMejBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336596; c=relaxed/simple;
	bh=vEVH5RiefFKVMPpIsvHqj4tPG9+HvrAy1wEdWxNPky8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jm7w50j6s5sFJs5uMP1NRH2HselEM/kqnEjqtmaKOWwDNZUPVXrIgSRsU6HeCBsdBgbefTSmUG72X+BAuI4rgE0CTcPaSc8PlULKjEL2dtH/i2X8x1jSjk+3y89RHS1OoGIeJnEGT2+DK9qtUPQlFWl5YvYs4CE4el5pYLyYJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbq/EQk/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbq/EQk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AE51F000FF;
	Fri, 25 Sep 2026 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336594;
	bh=vEVH5RiefFKVMPpIsvHqj4tPG9+HvrAy1wEdWxNPky8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cbq/EQk/7Nq0KPKCQXCc2/pB3ys32+xuNLFeEd9KE2H/hFRpLLIkftIeiBybYfVds
	 UYJBradS969xxwCX5C34MGKWd+njt9xjLUv7hQ8dFBlE48SUx09PgUXhemTroNK09t
	 7jzaYb8Tuo2BhVxURfqMGQVk0Xo9caBvwQY1TvzF4jQx3FDPh6ztJQOl6J67Nq1G1B
	 ZB+Q3cy4qK3sOnsEovLhcfHNJotShmYlSleVYhTg2CUETwObapf2KJCR5CGECE/G0w
	 kIPMb3F+H0UqN3eh+P29XOu3AVWkQbiQvPv1oFu7YWJC/dw3UkYP7neEshnjLLbe/U
	 KF+yqldS+V1vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/9] arch: boot: put the LZ4 freestanding headers on
 the decompressor path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260925-lz4-vendor-upstream-v1-4-1c7ffbe21c4b@samsung.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113458eucas1p1fa17760e9d790d3108643ab7f54bc6a3@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-4-1c7ffbe21c4b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:43:13 +0000
Message-Id: <20260925114314.49AE51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> lib/decompress_unlz4.c pulls lib/lz4/lz4_decompress.c into the pre-boot
> decompressor on these five arches. A later patch makes that file include
> the vendored LZ4 sources, which include ISO C headers that -nostdinc does
> not provide, so put lib/lz4/freestanding on the include path first.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-lz4-vendor=
-upstream-v1-0-1c7ffbe21c4b@samsung.com?part=3D4

