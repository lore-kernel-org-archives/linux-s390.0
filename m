Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111823;
	b=UyvP8hWsLS4bql3BqgDh4nSCadzrCXh6T7CWMD4VplrW9IoENlzyRH7WlcjQVyw5AdRJ
	 20V/eg2dlEP4kX5PXtZJL8O9dR4O6XlZdShLQx/TCU1xleFA7mMf5t6f3dSgXymwc9rlc
	 qNc4AH0fVMZQEkupJ6RKlkm7u7F1LOHU/8egnG+Kk8hicR1Y4/Esqt40JCE7mvfWAfllD
	 BEcyfDNtBJSnIp86tV9KeZBCPGuxw9H3otViVp/nbiKOyN0TrQWcC6n/E45BqfyIV+5Rg
	 M4Cf6F1Zo3IRrdecoC+v3VBml2x5DZKK3lonOeZB07wgXdDjphoy9CTBZHqWcsubOFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111823;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FsA8tmbfIUuVNSZg/U5QFwdqA0RAQalVEarSN9OD5fI=;
	b=L7K84oaVgNWoxKnNYmfueVbsStYqxJvj/C/p2IVZxDIcDluBqTvkn9znqYa77zJva2oV
	 UYBIYZAK6knCIrFinlPeKXa+KVluN5hfOX8W4SyvKvFn5aGryN825UX20vn1AYPJnrfJ4
	 MNOKqV9hxlVRevyoiOf36wDpOl6qEuwDJU1ltwoNePz3p5AFxn4DIUdcTJtnuOYKLO/cY
	 6ZPCJIiOYFi40vJfna5DO5Yog8aMRAR7sZjuQfCKBANbuEnTqPhfi3fs4VUVt7OLnZP5X
	 Zgnl3K/51Uv9emuVPYTKLkTMsq1wv9oF/3T45dbeEW342niEMiubBfKUhvQhZ+lIoXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfRmLNPS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE6606A320
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfRmLNPS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5221F031E0;
	Tue, 27 Oct 2026 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111822;
	bh=FsA8tmbfIUuVNSZg/U5QFwdqA0RAQalVEarSN9OD5fI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AfRmLNPSRYYA6SuQKUGNGqJjkerymZMc8/kmR8oMPvYN9AS4GRpez9ayfSghX/LoC
	 Zcfy/6GlTnFlh4li1aQoAwjSmUNZJFj2J4ln2cc7dCjW5ZqFHYERvD4iM9YQE2sK9y
	 Xzfd79mL/jnWgwzON9aidt5byepwmzb8LZsW9wGNF5mrBsL7H5wIcpjRX87n0iE9CM
	 iZHZ3PMkycMKfppE65pGupzH/8tmmA/IAj1RlEqqEcWf3VFT6iXcHiZ1Bks/TC4VdF
	 4mT650YTXLqF1UvZNJ6S4yY3dlnWAJMvH1xxosIQYO3pXXyKwO2HibSJ2jr3aiVHnI
	 r2qd1Zrari91A==
Message-ID: <sashiko-outbox-186737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] s390/ftrace: Serialize text patching with
 text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-3-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:37:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add ftrace_arch_code_modify_prepare() and extend
> ftrace_arch_code_modify_post_process() to acquire and release
> text_mutex when ftrace code is modified.
>=20
> Also add locking to ftrace_init_nop(). This way s390 uses text_mutex
> like e.g. x86 and riscv.
>=20
> This is part of larger series where at the end s390_kernel_write()
> requires that callers hold text_mutex for serialization.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D2

