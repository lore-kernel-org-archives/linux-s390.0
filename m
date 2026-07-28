Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DE187346
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216951; cv=none; b=Xn+o2maOOTymPFAyCh704nReX8kUFIPr9oHo/pp6DpoVNym+6dEqXpw7HG9pKOMC17Qaw6i7pT8ewEl2ew8LqT822gnQaBVPBG6uVxZTK06BIatFzxzdiH82dl2dobIq68QMg0C8Q24qqD1TN1Oy/32H+xMF0PUMOYuOnNfRyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216951; c=relaxed/simple;
	bh=yYFwzPipi7Z7ZUac+udnJ87f4JIcStgX5J7RXNDZaOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SWAVIH0UNCtoQHFpBP1x5q8hNO+NeOA+5vw0oGh7PcJBJBIntts6JCrd5HZ+Irj/ZKf0rSegaw/AIG5IfUIduhe4/hb0LVXmp0JgN73+inIw5+STFzIrm7/bCF6gX0cgIMfSmmuQo654C6CEcylNk7iYk44jPZu05UlGrYnSAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAOgTO4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAOgTO4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B401F000E9;
	Tue, 28 Jul 2026 05:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216950;
	bh=esRd0DPb7k6sFDuKLMPpCh6d2SYs09MOw9Yk2Fzzato=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAOgTO4H9Goh1EI9VldQNIZaH/gTQdr3syXTKoy87pGgFWlpCteycG+wC2iX0Ybej
	 BYhYpusqkOKjhEs++zJ1HjYD75ljseLd8IKyjik5Dx+svT1FwFqV7nTm1yyF5I/pln
	 bRCcFMmYi3m0t2Q/dVy2x7lG1zII4aWKJe1qSxdaPCzpjdkC5Orpd4PMG2AMNYUEcz
	 HiDM30slh4gf5Syrvpy042Zw8osRLRR7jnwwSYubdeCViKmxEO3QbqOJrf1VKSTfKK
	 phJI5kBjU9f5tET80Njs2nfu3QJREQR4ePldKReIySGUQntsdsJA0+yBSqh6x9fMT+
	 keKqCI4OVLeVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/8] arm64/runtime-const: Use
 aarch64_insn_patch_text_nosync() for patching
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728052540.4728-3-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:35:49 +0000
Message-Id: <20260728053549.B3B401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The current scheme to directly patch the kernel text for runtime
> constants runs into the following issue with futex adapted to using
> runtime constants on arm64:
>=20
>   Unable to handle kernel write to read-only memory at virtual address ...
>=20
> The pc points to the *p assignment in the following call chain:
>=20
>   futex_init()
>     runtime_const_init(shift, __futex_shift)
>       __runtime_fixup_shift()
>         *p =3D cpu_to_le32(insn);
>=20
> which suggests that core_initcall() is too late to patch the kernel text
> directly unlike the "d_hash_shift" which is initialized during
> [ ... ]
>=20
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052540.4728=
-1-kprateek.nayak@amd.com?part=3D2

