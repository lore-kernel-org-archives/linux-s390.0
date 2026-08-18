Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649B4207A
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 04:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026376; cv=none; b=S+mSqrwScqor4RXAqRscCdIcB/5DpoWC4xIWiUE/b4wnEB9s5vdT5s3W+nPocthdNpZrT3srPcyoWqC6h/+T5toQXIbdkDQ7zAvl2Co/ptRAS2/tCB3RAaRNWTSOIy3nZZhFbTdfJYTpM9Ju+982DNMtp43GthFlpDT6s5qx45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026376; c=relaxed/simple;
	bh=lHAg7rAMUtVcTtCpOQF8bFFLqCDNYJnbbr3HQg6y9Jo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=egpSOOrt03KRAdw45M4DRA11MD/XcGOH9f4mfdYfa1bO/9+uF6m/+EBn8gEDGZ5K/M38ONrLI8rhEEj4I3n/HPEHq+crpyztGr+ZkAU4sJF7x/9PJbxbpQypP4SsS+1s0LGUjoHHtW4xz+ai7q8vUUjl/4HvPhaCcnzu7Pz2cFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdDzrbuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdDzrbuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0711F000E9;
	Tue, 18 Aug 2026 04:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787026375;
	bh=lHAg7rAMUtVcTtCpOQF8bFFLqCDNYJnbbr3HQg6y9Jo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdDzrbuASR5P14cYUmBc52gS/9yeNbAKkjgC98977K7Qc4DAp/5s4DvvPhZG9j87/
	 1IpjJFnL1DInY8PLJ7L6kuRx7AAnWzF+qZD1f2uG9GXrAhIUZ9O0Q90n7715oWhYcm
	 SIA3CPGkFxY2zjcyiDW7zq86JyLKNdGbR/UMWxeETpsfUJrzPGN7wcVR7qr7TzyZmj
	 axrg2GWGyz3Q+0Xs/XjX42PJusjHg0mSFQFP0Jbep1gwqoNG0G2nSJQ8cFGE5sr3CJ
	 faKL3z2tFvmfhAJ5PRjnfCj1tcRnYclDDz1w9rHLeKFpoo4bVAklgmokW5WCDE6St8
	 ie73W68l1VIrw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC V3 8/8] mm: Drop pxd_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260818040041.1891769-9-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-9-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:12:54 +0000
Message-Id: <20260818041255.1B0711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There are no more users left for any pxd_ERROR() either in generic MM or =
in
> the platform MM. Hence all these platform macros along with their generic
> fallback could be dropped across the tree.
>=20
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818040041.1891=
769-1-anshuman.khandual@arm.com?part=3D8

