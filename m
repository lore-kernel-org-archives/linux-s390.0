Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C513921C1
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849455; cv=none; b=G9+dMer052GJqG5p11eqAF0XgeCZVttmHZHurtP3Gf09nqFQUJN3RDBxqdpfZAlcOm0kvNHSKt4C+GeIVY1pLrxyxGIsQgLvYeVdfvIIxtGIIEtGGUoPyioZE1mimQnRc/F/jzGiZtbgxiaJ1lMr0dPIT0VOzgbvEU2+Xy5JPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849455; c=relaxed/simple;
	bh=8w5Y6dTsLEnp6yN4twJhZwS7mnpSF3mqW1D/qWEyPLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DgrFkBJyBGswqAC+JPYCyBPj1iD2y4Z9F0JBiixRA7JQar1S8PTmfLZbmUpv7JCHV+zy36lj3POcheZUYH1EUJUXV/Nvg91s6hZImLc/CBh861uzaukIQnLcrmxKV+EmEudIEpeDcjUqlhbpvXjTuBR48d5n1f8V7GHNby5FxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3hG/sAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3hG/sAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9359C1F00A3A;
	Tue,  8 Sep 2026 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788849454;
	bh=8w5Y6dTsLEnp6yN4twJhZwS7mnpSF3mqW1D/qWEyPLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g3hG/sAypPEA8suYpTQ/zO7Aksat04rMxYft3U5O2ZWcKhln9c4fKNz0Bn42bzMrg
	 0YVWxQBU6fI3sVnnwTZhnZGuMeymt0X2FZ6KTKMVPjHtkZAQsHid+shJQ8MfnFCojj
	 V7psP1+k97bQs+dJRhbKodNaAOsp5I7Ypz72iHyJTkg6MRXM8dPHWGKuxRCJghkMvw
	 ij+ruOoeDCGvAePCdwVxRwVbt+K2im7LUO6vO1KmgAqqmS37X0jOCViuRfHQYfmgLK
	 563lyh6MTNzh3i6T8GOHq1eq/DFAUzHNF5TLYKOBdDKdffWIJvkCfrux/C+ZBh1k9E
	 T0ttsFNQLe87A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/24] elf, uapi: Add a header for relocation
 constants
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, ojeda@kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-1-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-1-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:37:32 +0000
Message-Id: <20260908063733.9359C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> While the numeric constants for relocations are architecture specific,
> it is still useful to get access to them from other architectures.
> Also the definitions are useful for userspace in general.
> For example tools processing elf files during a kernel cross-compilation
> can make use of them.
>=20
> Introduce a dedicated header for them, similar to the elf-em.h header.
> For now the header is empty but it will be filled step by step in
> upcomming commits.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D1

