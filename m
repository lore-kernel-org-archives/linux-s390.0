Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976414;
	b=IgLliqXZBPfnr6Xt0nsa+qxVpHgGeReK/WVspw698fjS5kxWNd0n4Mt8ZP/6W8JsdIM4
	 OCo8r3BSnQMa1oxmp1jYSe4u626ZDtXPYkxeQdgV0h96lPw5kdxc94opKjhYf+duxPECB
	 6PQ605/c9HZfWgldbm9HHc4//Q/WfWuyD9J1KT3OlavahvUEMlOKPmuX0+7c+x19HXxYj
	 /Y+PkVFlZL/5upl+0wjcxoPMldI3CkEDuIb6uOHFvCaI9Addxca6/BJLqLwS/wHYhjWxz
	 jAs5UrOOQ6M8I+05skZiQMHXn6nyzulBhCCsXTBJo3h4gUKk0+K9tyGoZpQjy82TjgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976414;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=17xoshFEE2rLQWpVaTHVjTfmwadGJTYLAt6UOD5Rkn0=;
	b=3HFsEeIPhf9u8QoEGgzWzLXW5Up/d62cHG1FzZTXe2YWRZmxvJaC7VsMkC7wcKmgmz/V
	 DTbkFjdqeJZTb7uAL5zhdZXAsqyiMjZr5YL/rHmVmvnbkkLSB439hBINhh+5v0DTS2VLh
	 2G1A8eMljYkZ/nB/jDuMzkdzu1lTg6s1tNQ5AWYYqbYU3ZyWF76QTJzk5u5yI72MXzbRg
	 cAfz0zmT3PE0OmGTTcSf0C17zTaGdZoONDv6Jwh89+ts8tGuojMvEKWYLVW2+aST45RkT
	 ZPGTATY1eubtNNVktnmmdSlwqhEkMvwHmI34bC0b+pdp0XwJPWxshAhYDnnB99VIEPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvQAi5XK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D640606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvQAi5XK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DC11F0089F;
	Fri,  6 Nov 2026 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976414;
	bh=17xoshFEE2rLQWpVaTHVjTfmwadGJTYLAt6UOD5Rkn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvQAi5XKG+s3PlEe4iBDYjKzw3M+t5yCXX1XCAgn3vIhK1HvzsXo8gYL5e1B0mP7V
	 a9+3zVAS7iBWSFKbvmXGYyEGXsqkYaz11UWZZZVYDP+JeJzzWc3wGJKqDajQHGNWRZ
	 73IkeUJl85LTn4/b0KOFu4WmRr2umlnyBZzS5MA2zkMvjUZpET93DM6bUAHZuXZ72h
	 27UH2lL/IwnAnHHfspa5R1Qso/iR2UBlshSjhZz8NFHHKZTc78mMi/bHF2VL8jWHDq
	 Uk4uUeyQauWy4AQx8WiAjVnuZUZzH38K1DfVSHCP+30fTdxNeanDzTDHo4vusBYxHR
	 e6ShobCTaKyYQ==
Message-ID: <sashiko-outbox-201605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/15] lib/lz4: backport upstream's
 -Wmissing-prototypes fix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-5-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144256eucas1p1beb947272dc94f916c8c8131722a480d@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-5-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:46:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> v1.10.0 defines LZ4_loadDict_internal() in lz4.c and LZ4HC_searchExtDict()
> in lz4hc.c with external linkage and no prototype, which the kernel's
> -Wmissing-prototypes rejects. The first would also prevent linking once
> lz4_compress.c and lz4_decompress.c both include lz4.c, later in this
> series, since each would define it.
>=20
> Neither can be forward declared static in the lz4_deps.h a later patch
> adds, as the other bare helpers are, because their signatures use types
> declared inside the .c files.
>=20
> Take the two hunks of upstream commit 5ef1f16929b5
> ("fix -Wmissing-prototypes warnings") that apply to the files we vendor.
> This goes away at the next re-sync.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D5

