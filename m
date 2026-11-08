Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178713;
	b=F/l26HNJUQ0ea8r7dUJGjg3K76Dwdbkzov58m/D4xobqarwIJ7KvD6H30Z/3+wDEhccM
	 Gfr23k/jOBdInubdRq5HRAV3VZFDIiRgfJ+WToJgZ3778KV9piDcZ2/jiLOEP6ax5Pxi5
	 Pkea5imGAjcM0Inech2Dj1IRal/yhJlPf8lyXlLbnN/MY7L3Fordsygd7QNVUDGLBK+0D
	 PkhZv3kk0Ct2Q9ILtYC/aTUho/MI0ugFONvinytXexhJ7IiJQ4d5SN+4hZOzsQoDTO941
	 1Zfe1QNj3mzcAS/H+Rpxxae9nnpqkHTWinAJNwNWPaRkeVBR93/A1h6w73kKYYeSyPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178713;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yw+dyZYZrdEmqw43wrzNogOBwKEbcS51ed3jxLORYRk=;
	b=fjgF3XisV2wICC+S17N92X/EJcvDpD8XFsyniv6I1O2ooGYemGqVPQ3hAwxWCQ5aPg2j
	 M6ECdOHPdW7jUwyV51qnZuXyCOcV7QskeWlu+kPh+ViHDW+Qs8tu62UHtyAH1fyiDDk6S
	 SUCnV/Nz8UnHYZkLNdq2aOAgAkITmGiMMaC/aUmNTx18iTEM7phJecRKm/KS3U1pTHXTV
	 1fpJZntZTlKDbAlyL/8DvX5FFqd5+AKHTF/CiYlWLO9KrGnslaZrR5MDv8fkkplsKuR6t
	 A5isWiWydpyhdgqDEgZR9joFwkV2bAgVceb4Fbr253zEp9mkEz5buT2C0FZrSQ0ahcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZ1KVY67;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B9606A31C
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZ1KVY67
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C510B1F0089F;
	Sun,  8 Nov 2026 22:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178713;
	bh=Yw+dyZYZrdEmqw43wrzNogOBwKEbcS51ed3jxLORYRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZ1KVY67S4O9F0NgPh6fB7MMFwDyZRounsjikNBfGCOKS1mJCxD0sBK3Bh+tEg+cH
	 fre0zVaegJRy83bsiByErr0bGoWtClj9iI8MKYLF8wOJD1Z5r4xK/DxFK2O9fkcbrp
	 aCUfbZgIItqndQ69JpzFPUPbBsEux1MZJSHA0u89YGjjP/lPWGYR2JLLua+EJRgS7c
	 8iYAyudN4CEZWJHWIJl/k9mT0JyZ5Y90rqb+P6RSfn1NO/gKaxsRWoEZtHGKl+rlg/
	 ZCqCTL8X5D4gWNvaRuIJRSeUp9zcHb4frJHThvMxdV5BL68C9cTE2qUxyP4r3vvNS8
	 XUA+6QyCZAVdw==
Message-ID: <sashiko-outbox-204142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-5-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 22:58:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Export cpufreq_dbs_data_release() and initialize .kobj_type.release
> statically in the ondemand and conservative governors instead of
> assigning it at runtime in cpufreq_dbs_governor_init().
>=20
> This prepares for annotating struct kobj_type::release with
> __must_init.
>=20
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D4

