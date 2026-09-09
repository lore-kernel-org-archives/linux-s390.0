Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD03A7F49
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944270; cv=none; b=japS4D7/9GZifFoWwuaCJkPmq6GT9MMk8vfrNktqmLVOTRs6j5HUjH05Rm6ke+nUibSC/KCaUOHNV4KMvUeGbLFLIvd+9dodHn/esmKG81gpknMtDIVZwIsg06068Ao23rBWHvNwLazJG2tfjMKlb06LS5HYNGpck6W9cofkq0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944270; c=relaxed/simple;
	bh=gs3h0BJuGH/U7dY2Dq2KQW3csDBPQfwGhA9z7kQIeS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uhb0I5tHX5KZ6LH0ivrw21IIYOZ3ttowXw/L9ULefS9WDbzgtL2luINj8mP5FCLzJr/FyzJTsQD32GJdnTvuh3070v7vDmJPFmS60KJK/BfgwOc7T5TTBnv4XmozPczyDzx5GmZ9cdBkOG7gnqgGPcH6r7A7JfjutIisFNN/hiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAFw5xAu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAFw5xAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0712D1F00A3A;
	Wed,  9 Sep 2026 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944269;
	bh=gs3h0BJuGH/U7dY2Dq2KQW3csDBPQfwGhA9z7kQIeS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OAFw5xAu1UGw91LvX0EdjqhK3WdlJcId8qAtlfp59UyTgPbEYb0PWOIOVvHLvWUFf
	 cJzP9y2vwyQhIcIy4VWKFQjjNmpD97yHE4Q5bA8pg3aiJpENoP+9as4PtU2GAiokhM
	 5gPBypQMuQOIbB82JH4H1GcIVSKAM5De5q1pEexvnQrjoo5fQAMU6exN0Ru81KECLr
	 rZzzNi+maOCa5LP9Hr8mJK92HLjQJBAZKHAKyrsegy4KZWGv/Z3WoOmlQu0Znc+mnk
	 j7GUnYVAVTHGJW3mxfFbFM8jNKfqItOReOegakwYiqe8g000KKA/yqj0mmQV0VPUCp
	 spoLAq9v4EEsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/15] vdso/gettimeofday: Define fallback
 __arch_get_vdso_u_time_data() in gettimeofday.c
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-2-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-2-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:57:48 +0000
Message-Id: <20260909085749.0712D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __arch_get_vdso_u_time_data() is only used in gettimeofday.c. vsyscall.h
> has become a dumping ground for different kinds of fallbacks.
>=20
> Move the fallback function definition into gettimeofday.c,
> similar to other fallbacks.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D2

