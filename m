Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573844AB97
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336543; cv=none; b=aaL4UQTZZmx2RieQtfM0VAZ7HAGuiPNhJo9uFf4kjDYpXp3CW8/RWRC99/1vPnkqViAsFOjzCTvWf7cbqWYgSkpWRQXQYZ9bltWIdT9d0ck/58HIV9KFDsE6h9Nbuln9sqioz4EQTxM+ONJrzB/1o99N2pLlgit7BZFHQBBkcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336543; c=relaxed/simple;
	bh=HbCwzz8ghNJPXHQP1kFNFEAMl9BkxDgW/CpEBa4fN1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0v/2lMWekRZ21hkJvG1JJ5ohfk7GQM4TbFYbjwYsbvXOMWNreADJf0yrs23uL3OUgnh15ceoyI7RCgzCzKBmZmVQPbIH9X/mqmb5X16ulEpqM7sch9RBIBH2zqo7al8Z9E8v+MiXjCPZHZlf5GkZQfhnxSmqxwbPXvoGc+2ka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfpQ6ZD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfpQ6ZD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEA61F000FF;
	Fri, 25 Sep 2026 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336541;
	bh=HbCwzz8ghNJPXHQP1kFNFEAMl9BkxDgW/CpEBa4fN1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BfpQ6ZD0/K+RJxJnq5ze9vqEdpGb+ZWsBO4Jg2IO9FC5bYcEePB8XxldJVStgrQQ2
	 VQII3zetHbmyZLh9ON1Ji3fQ5N5pdCbMzHjHHxeymv5R9OfN+O+7v163hKoeKh2U8q
	 oJ9SdPv6HV/5jqGu0mXmLych1C/2382MvCHAB9xdRCQChmMy9eHPbJ/UZj6dciGCY/
	 PLWq87Oh/MDphY6QLaJhNt2zW2tTTeDE3lbVZkAdjt8jAOh4IkdByiaDx90tgOtiIW
	 zD6R2ulX2TV3KwB4IfJlDd3/X1Wqbng2vsyH2t64ETQJgyOswPILYvA1BNo52ztiMM
	 yhYA8S6tl62RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/9] lib/lz4: backport upstream's
 -Wmissing-prototypes fix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260925-lz4-vendor-upstream-v1-2-1c7ffbe21c4b@samsung.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113454eucas1p1ffe6b62a29086943a60137ed7e1f42ef@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-2-1c7ffbe21c4b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:42:20 +0000
Message-Id: <20260925114221.8DEA61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> v1.10.0 defines LZ4_loadDict_internal() in lz4.c and LZ4HC_searchExtDict()
> in lz4hc.c with external linkage and no prototype, which the kernel's
> -Wmissing-prototypes rejects. The first also prevents linking, since
> lz4_compress.c and lz4_decompress.c both include lz4.c and would each
> define it.
>=20
> Neither can be forward declared static in lz4_deps.h like the other bare
> helpers, because their signatures use types declared inside the .c files.
>=20
> Take the two hunks of upstream commit 5ef1f16929b5
> ("fix -Wmissing-prototypes warnings") that apply to the files we vendor.
> This is the only deviation from the tag, and goes away at the next
> re-sync.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-lz4-vendor=
-upstream-v1-0-1c7ffbe21c4b@samsung.com?part=3D2

