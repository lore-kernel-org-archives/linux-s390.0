Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68D54774;
	Thu,  4 Jun 2026 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551257; cv=none; b=H9UHi99Q6A3JRmq5TuMtC13WwSwywYmFRsx8+7OFKVSB7MwSuXC7a28W/pu8pWwAaZMQegdTL2i0J/7wybHUqYZclO7WGxMzm5H3kLMX17W7P+tyjT9GxWXz/pkNyzYwxiqNkXXMQofK64sA8j3BpNnIJ0m71uGHmKyxYHUjM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551257; c=relaxed/simple;
	bh=0aSOuM7TjTHWPtprgbWm3Kxm5OvkqXojBkuVJvCqGsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3zndEYwt4/w4JTxW2QyRCIMfTDntxdj6RY6IWN5vAVjLNuELAjDD+VxpNKxhf/1Y7JAlRoQTFeDm6BTlumXiHnk/XG4mfmwgmhZ/BJko88ceyUuDo+BPu2G+h1ApWxFSQKyhnfvMy0juCCr8pbjxmBuZwjuOwRNlUPlQDOh1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCRKarqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCRKarqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F841F00893;
	Thu,  4 Jun 2026 05:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780551255;
	bh=j314sgZEJ2BPq8oCCjils0V0pfkJmoyrEoH+1wcS5k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KCRKarqRgscWmvkIuazYhE6YgPoRl81f/jSgLnxgHA3jrF5in45VV3I6+00lckijU
	 HZgGkLXbrrcjjmyYGamSXhA8Sh2/s2W1k2XWWNvsDoypK+rxS0d/dHPU1N/4ajHchI
	 FtwstIDZapl/FhrDCWCanJ8qNtw3lGyXIPzDldla2AWkHm/JTx5o5ZqB9vmTTOdZDj
	 6aQViy2MifdZ7pNOJQSRMvoTXFTr9mk4gxu35mAC1jBFdSnVqCwSchxd2elr0ZNBwM
	 jbkiWPK9NnfPMw4COfej82NQjiQp2fePVWvkeKna5SXF3mIDHkKCSgJStb+HwqasCy
	 ptExAnxNIx6kQ==
Date: Thu, 4 Jun 2026 07:34:12 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>, 
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, sumit.semwal@linaro.org, 
	lkp@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mm@kvack.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jqptshhieja74xp6"
Content-Disposition: inline
In-Reply-To: <20260527160716.GN2487554@ziepe.ca>


--jqptshhieja74xp6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
MIME-Version: 1.0

On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> > On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap int=
o a
> > > module") the system dma-buf heaps can be built as a module. The
> > > system_cc_shared heap uses set_memory_encrypted and set_memory_decryp=
ted
> > > but those functions are not exported on powerpc. This can result in a
> > > build error like:
> >=20
> > I'd much rather revert the above commit.  Yes, x86 has exported these
> > since 2017, but that's a really bad idea, and we should fix it instead
> > of spreading the export.
> >=20
> > Setting memory decrypted is a dangerous operations and should only
> > be available to core code.  We should have various allocators for
> > decrypted code, but not export the functionality to random code.
>=20
> At the very least an EXPORT_SYMBOL_NS.
>=20
> Looks like there are about 3 modules using it already..

So, I'm not really sure how to fix this now. Should we revert the patch
making the system heap a module, or should we export the symbols for all
archs?

Maxime

--jqptshhieja74xp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiEOSwAKCRAnX84Zoj2+
dsIpAX9h+K6tpCAvZItDUjp18GfV1Lws4Co6p+mCPIcMvXSb9nHyxnRm60dsf2DY
5WaP+wMBf3/f3uHeLbsQL6So6AEsb7aKUbpaAgJo6FK/gDrwlAX+ebBpuWxfClty
yJnTzPlrTw==
=ZFmF
-----END PGP SIGNATURE-----

--jqptshhieja74xp6--
