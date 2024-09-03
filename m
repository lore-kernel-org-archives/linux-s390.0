Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8A1DC72A;
	Tue,  3 Sep 2024 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393453; cv=none; b=Y1eprk6gJuR8I2zWEkKC0yqlKocHiSAPNTZ5XfEZg+WeX9ebwEcDdgVZ4KbzXSZSdnW2GM9TMC18Qs6chbiJuzT2jQxk3WdwGuGd1eK3te9OnN2hRLPKK0e1gskFAUkJEuDxZZNDqr/BmyRkVyf/s/YRakOAkTYm77Oq1FxEpbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393453; c=relaxed/simple;
	bh=NTkAihUq8wJ3QQyD2jsoOFW0fG+0732f5lSDZtBgAPI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3KsK8kljEB6KtexukcRBwe38u8xBeFcxAYf48eeki06+7POEHLqHs6uxC3ccIU5uq8MaUaF5+osYf0Aw+qIrfvOp1YHQtkWcaAyDRaYnr+iX653Bu7eJTNRu/v5lB43GsMsqlirIfmLBckCMoQYj+UutS6vyWXCpk3RGYm8FBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibTzt+Zg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibTzt+Zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C7EC4CEC4;
	Tue,  3 Sep 2024 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725393453;
	bh=NTkAihUq8wJ3QQyD2jsoOFW0fG+0732f5lSDZtBgAPI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ibTzt+ZgEdTELo0NowH5uGIH2Wtx8O6oChkl1Q28nqiyWxDTqR8tphBxYgCay32pV
	 1hPna6pOCaS45hl+sLTuFw+Pl79mj27SkX+HpLxKECYJlYBG0h7SaAkMmPwDx6njIE
	 2rYYbxd/PvXGm8b5i0aeQaggLGjHy5i+JmHGE7xq/T4LZ5poYfToPT4ar4DwnZ6LFz
	 xUVGuklq6NgdHhkMPsoZgMeus69wEVzDTS4x9rtvNNbP5iGQfDm+My7uvbaZprUrQJ
	 oMpGYNsaV408haO9OPNGCb7dBVZJWkElUMT/UHks93JFjH0pu162EUYzIc/cTsD9Sg
	 qFv2tPt1j4P1g==
Date: Tue, 3 Sep 2024 20:57:20 +0100
From: Mark Brown <broonie@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 3/3] mm: Care about shadow stack guard gap when getting
 an unmapped area
Message-ID: <dbaf5653-df46-4e17-bce1-aec7fb168197@sirena.org.uk>
References: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
 <20240902-mm-generic-shadow-stack-guard-v1-3-9acda38b3dd3@kernel.org>
 <is6ewj3bhtqy3zadj6lbdv6maupx4kmduvhny66ntifkji6hoj@xmhcf5jt4o66>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IPVQox5bvuHO+FID"
Content-Disposition: inline
In-Reply-To: <is6ewj3bhtqy3zadj6lbdv6maupx4kmduvhny66ntifkji6hoj@xmhcf5jt4o66>
X-Cookie: Words must be weighed, not counted.


--IPVQox5bvuHO+FID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2024 at 03:41:49PM -0400, Liam R. Howlett wrote:
> * Mark Brown <broonie@kernel.org> [240902 15:09]:

> > +static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
> > +{
> > +	if (vm_flags & VM_SHADOW_STACK)
> > +		return PAGE_SIZE;

> Is PAGE_SIZE is enough?

It's what x86 currently uses so it'll be no worse off if it gets moved
to the generic code (there's a comment in the arch code explaing what's
needed there) and it's enough for arm64, we only do single record
pushes/pops or (optionally) writes to unconstrained addresses.

--IPVQox5bvuHO+FID
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbXah8ACgkQJNaLcl1U
h9C2Awf/e7PKpZHkmToVtr07IL4qcZTgpwJkRcA4S8aF/OKy2aVmo+pW2nNnK5sc
/MpaZW0Ms2eiZxaG4R3y3oBshdiHLdMS1qimFTuewZWtDAJ9lE9Zubq1rr+onqIw
z7QLTklFTJhwJLiv4r822HjfHqW872zY7tA8OQKs18OmYzyGFWnMuKcdZwQWf/Wl
S0krgEkvPgYV5FyIP9SeyBVfAnRbH3u2q0dDWORZ7e3pVwZ+0huL1DYzlgP/Nx4a
EUb0rRhFG8tHp5EwazuvDfdaQyfqtytNRDe6NTrqVdsrqXi7QzkjglFsx44oMBFK
rSdl35QkF7WXDFsXE2sd4O+m2ZbJFQ==
=a8UG
-----END PGP SIGNATURE-----

--IPVQox5bvuHO+FID--
