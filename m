Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04E334688
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878221; cv=none; b=BpkLo6Ke7++/FwJ+z2s4NRC/bPTkpmdSeOOwVqsndX+BLO46YUq+5R/KD7vEARo16H3PhHxFvCnbjuTOOEvAHA4JnPutU43HmjilHUBYgNk0cW0sqEpxaz6yVUAvvw37hCXRPu7e0y88vD8AyFQFRo/rVHXmC7ijNn45MYlS/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878221; c=relaxed/simple;
	bh=k5pBGF4qq0Id1x0wQPHWUd9kNa/abXBK50X3EFWdO+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lZehK/9KMpyPM+VcxfauIZUkFxdYTyKZsLFx4JBriBfH2qh03e/8zJGcNrAl/f5rmsUioHOtpUjoHFJ0OJGS+DNzzGbAN2MV4bVtPxbEIGToXRgmZxNa60wZAW+acUlSOHAAPNxqBGQXs+KkFyvZIPAkf1WzQDd7f+ZHzdfKRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFSWE8GM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFSWE8GM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DFF1F000E9;
	Sun, 16 Aug 2026 11:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786878220;
	bh=k5pBGF4qq0Id1x0wQPHWUd9kNa/abXBK50X3EFWdO+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFSWE8GMDQern/xeAyPvw/PKpWXoZKLq/9ddssGkSrOccZYtO+eD+YKcFpx0fn7BI
	 ly34rShpj6C6fwx+LCDZXfY5+UHSprOR5DqCtd/K8vzlOzXoWS33f7JU0/KPJ+ClOD
	 giwBf6bgyEP8arUVyO/o2m3qbZQ4tbxcMH6I2E6OjaB+0nRkcLrznVaF8A+hcvTgLl
	 UBcCtJ0ZcclgdJQ8sapcHPK1pS477EyrBohc+R3NFX7cKx57b5dAZVYjz4FwziEH6s
	 hQt+ZE77Yl+6vVtdqxDWoF28ffTKM/jXCK0Ba7ksVD0I1ZEv9D7UU9AZwSXwWLIrGJ
	 ZlMEeA3ncTRQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] Revert "arch: introduce
 set_direct_map_valid_noflush()"
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-6-90944a3ad43f@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-6-90944a3ad43f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:03:39 +0000
Message-Id: <20260816110339.A9DFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit 0c6378a71574 ("arch: introduce set_direct_map_valid_noflush()")
> added set_direct_map_valid_noflush() to allow updating the direct map
> for a physically contiguous range in execmem.
>=20
> As Brendan recently pointed out [1], this API is confusing because on
> arm64 it means that is sets VALID bit in ptes, while on other
> architectures it is an analog of set_direct_map_default_noflush().
>=20
> The only user of set_direct_map_valid_noflush() was execmem's ROX cache
> freeing path and it was switched to utilize VM_FLUSH_RESET_PERMS for
> resetting permissions of the direct map alias.
>=20
> With the last user gone and with set_direct_map_{invalid,default}_noflush=
()
> accepting number of pages as a parameter, set_direct_map_valid_noflush()
> become a copy of set_memory_valid() on arm64 and a duplicate of
> set_direct_map_{invalid,default}_noflush() on other architecture, it is
> safe to remove set_direct_map_valid_noflush().
>=20
> Also drop a stale comment in arm64::__kernel_map_pages() that Linus
> bothered to add when merging changes containing set_direct_map_valid_nofl=
ush()
> to his tree.
>=20
> This reverts commit 0c6378a71574daa6cd1534ad42a956e3262756c7.
>=20
> [1] https://lore.kernel.org/all/DJ69RCVRBO0Y.3JCYSW50IC4RC@linux.dev
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-execmem-se=
t-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org?part=3D6

