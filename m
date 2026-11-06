Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986129;
	b=43B2NYmSeUGIuTAJHg6Cj2TiHOrqouhJBgpMyncEzN/L/NCxbxoABU9tQ1kwdz4cBO2i
	 Xs1xF6GjeSX7+18LdsZ1URKhV2H2b9a9bGz2oHWbU3ITIDxF0ntfT3rt6Zg70dFJP0Ley
	 WdAHPmHOUV0YrBFUwdivfYMZRXcq5n4NfVCZ0vpnoMmmBBmUzEJ01Q1+ufHWGSKBaz1CL
	 LlxQZ5aCIE2WCUxK/tNTlaeaPVuFiCLi87zDh2JFpkYOB/0wYHZroL9RAJtha+IvR2MjH
	 wM4FAIyNjnt9R5kFK1O/K/bDzqzXyNnhy9oXuNO8F6HPC3CmmgMYa7siHRLUKCZ0bXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986129;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DwummoyOz6Zu5ArmWTq2hTkRLeoSlw+73xpteqEKGJg=;
	b=Jin1KSMYWaz0uyVtd4YWw01mlI5jupYMRYUCoZp0IPw4bqwIyohY71lyaCgmboR4pkyB
	 pD7Lj2wFLx3bJVpnkr1ohFucTyJ/SmSiQ10e5KH7BksrC3KN8Ny1VrQg5J0nszFVnAZgB
	 KhP0WdbEdiIUnRqXoGEI/RTmABWwRCtaU/ydfjE9beJfQBhyGytN5xtjW9csMtwl4owiZ
	 3mxxQg/dLdW5RfGlqMIa1DVLsmxj67aPkzdSsj9YKYHERcYwF4aTiNu131Qbr/4CnOftZ
	 Hksp3xeePRZHNG3I97bBJJIIPXzEGZsb3Xsinvq5FWVGmOkp6bdlF8e7fBNB+TzX1Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olruZO8D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076D606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olruZO8D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D341F0089F;
	Fri,  6 Nov 2026 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986129;
	bh=DwummoyOz6Zu5ArmWTq2hTkRLeoSlw+73xpteqEKGJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=olruZO8DutDTtKygsXJFhMvNuwQPpVJTXA7dFyH6c4lCBF5C6/XL4I7n/tUHPl4R1
	 8gjUFQ+SM2mugOHYv3xE7id9qxCooP2X/YF1TvVlIJ+Z0CR74opXBM+2awsWlNfuQs
	 KNPC6wWwnljlkA8GOhx2fe/Uzw7Xq5xuRooe7VWzuGbXo+5yHHTQIgnCDhH9M+RORB
	 RHlTqhMahCAP5FI0X8mplO7pKWn+MUL75a18Fh2N/znl66HVGmqN3cDPahuGLwg6YD
	 fP3mNORyR5pQuVn+sMYQFJmBkx9fMgaL3BmELPJJSC+obd4xFyxfcwwfAyNW3S5i+x
	 9d+5btNF/qEyA==
Message-ID: <sashiko-outbox-201931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/mm: Allow hugepage migration for s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106170844.4079771-1-gerald.schaefer@linux.ibm.com>
References: <20261106170844.4079771-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:28:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> After hugetlbfs PTE_MARKER support for s390 introduced region-third
> and segment table swap entries, it is possible to also allow hugepage
> migration for s390.
>=20
> This fixes the problem that hugetlbfs pages could not be allocated
> from ZONE_MOVABLE memory, which is often used in combination with
> memory hotplug. Therefore, without support for hugepage migration,
> a large portion of system memory could be unavailable for hugetlbfs
> page allocations.
>=20
> Besides selecting ARCH_ENABLE_HUGEPAGE_MIGRATION, this only requires
> definition of arch_hugetlb_migration_supported(), which can make use
> of the existing arch_hugetlb_valid_size() function, similar to other
> architectures.
>=20
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106170844.4079=
771-1-gerald.schaefer@linux.ibm.com?part=3D1

