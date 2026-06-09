Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABE3F5BE5;
	Tue,  9 Jun 2026 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008289; cv=none; b=I8POUeaZWvuVW2hGBe/tQtQ42NYJEklK5p/MXEKULHerwBitvek68EIw3hVM12P8yl8484GrhuiEetAKveY66mpdr1YY2rtByOl67n0xJrYb5ms9s7NxRV37GalpyG05AoKZkIm7n2ndFIP52fOyIX0iJWUqrPuN763uJ+vE+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008289; c=relaxed/simple;
	bh=68/ZQSofBvR0xwUsCFo7wlO4U1dqfr4wcfQCao39+1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS/cN8r108BCTi2xEGdoD8l0S6pvm61quplbMkM6aj5djfYhz0zEYO/PMVRq7bsKNS7ONdQXeNiwOvxuis4BW4/sw5Q/nA6ocfo+tA2tJCBLc3i4+/ms7capf2myIBa+qDbWfBPbqxmRwiIADBQvrLlKqQ3/JBZWuCDNBtjt0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGN3A0SD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGN3A0SD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490E31F00893;
	Tue,  9 Jun 2026 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781008287;
	bh=U0BaS54KHmvaXv/vxGfu2k/i8IbrbsOc/M3Rcwgq7Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dGN3A0SDVSKqo2u1/wQ1/zVpc+14ph63BVOcD0I/vMtQr0hMIYhCoXkbL3y4aG7DW
	 V8KxpK4g9iEEMonj89HX9vwHYAGVSAtrcdef4mDz4zC6vM2OZyNv9qL7Q2HRAOnxlp
	 DDQzpPv8YcLrfItttOb0rtHpzrNNoHrV0WslXokKvznC1rvg9SC60g/b5luQgq9+PE
	 JEPqg0CTcCGWslG4Ll+E8a8u++cUTkflEOYJ+gXXZA81xJPvTJxi9DYl1ZrT1oNiHk
	 QZXLXVpk4LrgnJPKYn2yz81/1kKzPW2V2wEBgkYL/3Q34Fqo7uGPmNkWThn9pk7CaT
	 oDi6N6dqKuPig==
Date: Tue, 9 Jun 2026 14:31:24 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@resnulli.us>, 
	Christoph Hellwig <hch@infradead.org>, "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260609-micro-pogona-of-wind-eab41b@houat>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
 <20260604135712.GV2487554@ziepe.ca>
 <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="o22bjoh6ffgpsyxy"
Content-Disposition: inline
In-Reply-To: <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>


--o22bjoh6ffgpsyxy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
MIME-Version: 1.0

On Mon, Jun 08, 2026 at 08:47:15PM +0530, Sumit Semwal wrote:
> Hi Jason,
>=20
> On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
> >
> > > Given that Christoph's objection is not really about the modules part,
> > > but that the set_memory_{encrypted,decrypted} should not be used here,
> > > one option is to revert 78b30c50a7ac until that issue is sorted out?
> >
> > Please no, we have stuff already using this so it would be a
> > functional regression. Revert making heaps into a module since that
> > doesn't have a functional regression.
>=20
> Thanks for your comments.
>=20
> To me, it looks like while system and system_cc_shared heaps share a
> lot of code, their user bases have different needs. It's apparent that
> system_cc_heap users don't care about it being a module while system
> heap users would very much like so.
>=20
> I also discussed this with Arnd, and he suggested we could rearrange
> the code so that system_heap_cc_shared_priv depends on a new Kconfig
> symbol like
>=20
> config DMABUF_HEAPS_CC_SYSTEM
>         bool "DMA-BUF System Heap for memory encryption"
>         depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=3Dy
>=20
> This allows building both into the kernel or leave encryption choice
> up to the consumers of the system heap.
>=20
> If this is agreeable to everyone, I can post Arnd's patch.

It would be the perfect compromise, thanks!
Maxime

--o22bjoh6ffgpsyxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaigHlAAKCRAnX84Zoj2+
dvQjAX9ms+5hiJAqLxOa025CX1FKZOt3A7bbVhvzSW0b67H16z/faZkoRrXNZzHG
FzjVGG8BgPW0Xyovl2KeSzQ85rYqIeg+8H++YPYve/0/YEmMBjN+LF51bW0Wp/ZC
DU4p8h04Yg==
=jwe3
-----END PGP SIGNATURE-----

--o22bjoh6ffgpsyxy--
