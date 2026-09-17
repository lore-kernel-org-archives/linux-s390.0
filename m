Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864049890B
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680033; cv=none; b=IbIT9bZWQCJuLBZs19Rndaz3DY5Zq34IV7NElvTbjoQ8J5RTwA2MPgtzdv9PhyIFNmTxgZTanesxvIjMOUoEosheej/u81angMEZe1THFlOWpeKrZjnDmULIFjLxPp9LOaQE07Gflfq8kOPyNBqzXh5s1xsd1oVX9k41b1vnqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680033; c=relaxed/simple;
	bh=PX5usUK6V+ByzrijNglR+rMXamcrFoSb5v7p/RpdWMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I0LCIgtplBW6MY4qn7PNsXsJ3jrxARRAYnuX8j5mk8MbFrqguY2L93rH8/w56RJt/RWkOAanxul9dDJnhYiihQRF9E7HGFWv/BnE/3C8MMcT07nFT4JZm/ad8kFynIp0/2cLT5f6jp7xYwmm5SYRgEHKiKCys57uWKrExbjwGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blDbL3iG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blDbL3iG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3933C1F000FF;
	Thu, 17 Sep 2026 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680030;
	bh=PX5usUK6V+ByzrijNglR+rMXamcrFoSb5v7p/RpdWMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=blDbL3iGdPkD05NncetK4MT/W3NfDegvHgHYD6dAyhdY/K8tPalg2wV0kqbxd+3fq
	 qlpJVjFANsYnrNWmvnlkaDIHq9TUIEFil0JUOFTC/tpYfrOd2W7Lh2LeSio5rm9Rur
	 w6esE9+y7InN2/lDfKqEF6cpr7MKOKigVLVW88nJRLpWOj20dIQ4Vfd7oWixQMINvT
	 qAWLeZd5G2UkwP9LuG9JVVFCVEA3Z8bcpcLeMz7vv4gGctvZYePcX/G12cZtY/Raiq
	 5fyhexJjLIFlp66VyTPpodRKBrhRcH0ngDd3s7iFNx4s1sKoswgR/xW1Eb/3FCGB6M
	 jwe6oP+L09MIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/keyboard: Allocate key_maps and func_table with
 ARRAY_SIZE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260917211239.i.576-kees@kernel.org>
References: <20260917211239.i.576-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 21:20:29 +0000
Message-Id: <20260917212030.3933C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Kees Cook <kees+treewide@kernel.org>
>=20
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
>=20
> These allocate as many pointers as ebc_key_maps and ebc_func_table hold,
> but the sizes were taken from the whole arrays, which would make the
> allocation types pointers to those arrays rather than the "u_short **"
> and "char **" being assigned. Allocate ARRAY_SIZE-many entries instead.
> The resulting allocation sizes are the same.
>=20
> Build tested ARCH=3Ds390 allmodconfig with GCC s390x-linux-gnu 16.1.0:
> drivers/s390/char/keyboard.o
>=20
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917211239.i.57=
6-kees@kernel.org?part=3D1

