Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CD32B135
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878752; cv=none; b=lkOajdfSDSspo6vXWBmbmp6c/kcbRtJp4rQInAVEdPl5bqgcwM/LbagOqxmkkB3EddLC8wACDx59InLiirHPXmS2a0VCfsrF1GFp3TM2I0I44gLD+6dHKC8tMgqXTOxUk5EnSAOpAKKGjvnp1g9SNHXOQG+eN3vXbyuFtjwfGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878752; c=relaxed/simple;
	bh=rgNpDCtDjn5oqCGen+I5/RuWmds6FhJBSq4OUVGMgNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tz23fCW7S/wlqXQV4OR75I8WA85gUM8fa9ZlVLx03Xy8JbozxbY6lC90gFbLtH1w/+zf6uW0TxR+eRqSZDfO88K6zIJDHqjoVUADxUHWc63a9sDWSvVcz1PVncpeC9SN3qk42QHeQrKMT0UT6sEUHr19LSx0egMeQM1xi3hL050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0JAotk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0JAotk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6E31F000E9;
	Sun, 16 Aug 2026 11:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786878751;
	bh=rgNpDCtDjn5oqCGen+I5/RuWmds6FhJBSq4OUVGMgNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q0JAotk+Ju9q1F883YkNfG5UchneqKMPgg8zxTWzwoSrJP1cncklvyG8VXIfYfWWt
	 2E7MoBoQBuM5SeF78oz83lRY/d8GBz8Va3+CPlTUqay2nLVwcqtlDHr1fHQh5b6dmJ
	 EF+4+w7DEZByVgifrD7blSZ+zazI3GL4eSXFCL6QSqznPOR3XP2upGAKsYrLH4yLFP
	 GkDHosGIMWXogS5mS8H7zesONwpYJ12wPQAePF8/93wFq4PfrI8jDjn3Is9TZS7JxZ
	 qXt3bq/c9SUTIama7zWmPHBnZI0pqN4L6LGn0fSh1YtuDAHzk4t3lwCLltXcPcSAc1
	 BtQhS7okWIr5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] set_memory: add number of pages parameter to
 set_direct_map APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-1-90944a3ad43f@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-1-90944a3ad43f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:12:30 +0000
Message-Id: <20260816111230.EA6E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When set_direct_map APIs were introduced by the commit d253ca0c3865
> ("x86/mm/cpa: Add set_direct_map_*() functions") the single page
> parameter made sense because the initial callers (vmalloc and
> hibernation) had sets of unsorted struct pages that required changes of
> their mappings in the direct map.
>=20
> Since there is an increasing demand for direct map manipulation and it
> is also desirable to be able to update larger physically contiguous
> mappings, for example an entire large folio, extend set_direct_map APIs
> to receive number of pages parameter.
>=20
> As there is still only a handful of callers, change the existing
> functions directly and update all the call sites rather than adding
> wrappers for single page case.
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-execmem-se=
t-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org?part=3D1

