Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976927FD4F
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262253; cv=none; b=tYobEXjMmkorWrDURoK45pT2Im8HcgALDzSkiYdAAbCe6X7Cl2KJw0pqj9Rgc+l/p5QB8xCJfBBkgOgUqi6my8q1r+aaov621kGnW3e1f23G6j1ImeydQ4o7/TX666m/g6pcWhVQJ4hMnYbjXsrf2x3/moRK6YmQXf71KiO+Jy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262253; c=relaxed/simple;
	bh=Y3F/Fo8B8Hy7+3V90VBdAlM+hH67dK3FhDs0omPfDEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E/hFkUan/WD+Dvlv9o8EWi9WAXnRJbT4BdmlpLpzOyRkIOYZo4KAUB5IVBuZ8kYLkDtzRw/mPn9wSQ4R6ZZSINnzR/GXUKlIzfJOVC3/qgLPchg5GGrQUaSR49oRBnq3EAMOYI9nMlWbADChsy7zyTDtR2v9faJoaDt5ZvAq6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kADnAsrx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kADnAsrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2256B1F000E9;
	Tue,  1 Sep 2026 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788262251;
	bh=Y3F/Fo8B8Hy7+3V90VBdAlM+hH67dK3FhDs0omPfDEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kADnAsrx08g3gjuh76EqyvSI7m5f0Z5gHnrbPRa+/Y3gkaJY+O4IHJdkRUcKh+xm/
	 k+zVoXTKBooXK8rEyxWYvbyWpl1lnz15N2sptaRyYPD3dSz7gHYGSrOBJSTOxYniTp
	 c/BPNvEew+gR4rtNFtlJvhPZ1dK5d94I7cFTNX0P44yB2uM0toigkcR7n601LTTkPb
	 0O8TXymRWqmcHVC9izhSwhpvWnoGKl2EeLZ75ggyuYlSZGQSf8kxFEn4izwRds4OOM
	 JUm7Vxv9kCHOR1PuytpmqEmZRrRSyK1yMtv8gu5mAcn9dBKksEbNjyi3d0CM5NF+UM
	 R7T+wVGDfWPcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-motorola
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-9-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-9-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:30:50 +0000
Message-Id: <20260901113051.2256B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> sun3 and coldfire are already supported, however motorola requires a litt=
le
> more care.
>=20
> Here, custom table removal logic is required, so
> CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is enabled for m68k-motorola.
>=20
> Firstly as part of this change, the page table level must be communicated
> to the underlying __tlb_remove_table() implementation.
>=20
> Take advantage of the fact that page tables are aligned by more than enou=
gh
> to permit setting TABLE_PTE or TABLE_PMD in the low bits of the pointer,
> and store this there.
>=20
> Then update __pte_free_tlb() and __pmd_free_tlb() to pass this through,
> then have __tlb_remove_table() decode this and pass it to
> [ ... ]
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D9

