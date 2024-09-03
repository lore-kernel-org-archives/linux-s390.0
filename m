Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14018B47A;
	Tue,  3 Sep 2024 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387615; cv=none; b=VAEd1XJlwYMpnWfdOqkr0WgSU8tG4dePX4HAGUzQ2ysE+3BhmaAUDBa5OVI4byDrJc5lVGXj9iJbn41a+qgFK/LWqL2eJ3TgLNYev1J9N0u/0zrfrGQqoGQAChV4iyUTNJUdNLphs0Gc0CUdy0Z9G/rcNpIP4prnat4Tse0IrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387615; c=relaxed/simple;
	bh=3M41hDuZ2hOv4A0wqx1B4EpRjBwVCpmQ+MYvSeDr0Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGMMLnBcsEaFUKwe2v2o+N57hJO9DxOn/YJ3/i39S4HgxL9vQHYlbMTke5Awe/omL/XwUfXacsyDN6ZQoG9fVLmxSVO0r5hMxgyu1tHnnT7p35Cph+bSDvQ95lCXtcYktqmQ2abSu7xeyYihjjMQvORSyRBMzGDe4kg+izHLCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciUdQG6T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciUdQG6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05262C4CEC5;
	Tue,  3 Sep 2024 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725387614;
	bh=3M41hDuZ2hOv4A0wqx1B4EpRjBwVCpmQ+MYvSeDr0Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciUdQG6Ttgi9yvvZQGiq8UopO75eB7vVzLKBng7HwibzPFRnXBalgGP0DHJOhsgYw
	 3uk4X//pO6AWblx6uj2/rrtcfZi8xJ+KLRhTGUIMHNMXYzXGdpl88AE1LNLYhQLrSP
	 DF8KUTdzVN5U6fM8gZroVggjf3verSxfxLuJNEjmcXfbWXBE0OFnt2KZ4iEV5Vhk9j
	 JeNKEHjQ3QpE+rmpaiNn2XI0qgA0oJV7QO0sGId48qZnT0wsdO40PdufRSPzAvFgKn
	 YqlXDkAF0Dp4f65YVZerwA+zsLHpTSAMy3EtYLEl14MtxYmN71YQsS6p8hzMMNF/7p
	 L/5KsXBbyQ2oQ==
Date: Tue, 3 Sep 2024 19:20:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <3ff7a6dc-a21a-4a53-b3d5-cc8b0b5333fb@sirena.org.uk>
References: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
 <20240902-mm-generic-shadow-stack-guard-v1-3-9acda38b3dd3@kernel.org>
 <6d91ca85-def3-422c-8fb2-76337136257d@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o37zrp9IxB4WCgx3"
Content-Disposition: inline
In-Reply-To: <6d91ca85-def3-422c-8fb2-76337136257d@lucifer.local>
X-Cookie: Words must be weighed, not counted.


--o37zrp9IxB4WCgx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2024 at 06:49:46PM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 02, 2024 at 08:08:15PM GMT, Mark Brown wrote:

> > On x86 there is a custom arch_get_unmapped_area() which was updated by the
> > above commit to cover this case by specifying a start_gap for allocations
> > with VM_SHADOW_STACK. Both arm64 and RISC-V have equivalent features and
> > use the generic implementation of arch_get_unmapped_area() so let's make
> > the equivalent change there so they also don't get shadow stack pages
> > placed without guard pages.

> Don't you need to unwind that change in x86 now you're doing it in generic code?

No, x86 had a preexisting custom implementation for some other reason
(hence the "updated by the above commit" part above) - the shadow stack
support would most likely have been added in the core in the first place
were it not for that.

--o37zrp9IxB4WCgx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbXU1EACgkQJNaLcl1U
h9D6cgf/XDZdPu9OMFQe6TQgFZfL0q5O9mqkm+BWBPaJVUsfz+b1eJX8MY/X94i7
isw0bRIKXl4Rdgglf/Mjack/jKZI2dA1nVQtiA0++/6tT814x3Y/iykb6tAbghmy
uinhNXZQlV9/DYrMjNAbBcGeFlMlKmRBSrZEuoHwLuaOsQ3CfzCxB7zqsWtaxrBk
Ct7Jtsia48hr6Df5deBgMHgDTE6xyu7fxb9fDqVippx4fBJzXvjimEBvAG8OWp/z
77YIEDqfJ+JuDQvg3E5YL5EW1xarV++hvLacqfnaffNQFwngWwUWM8TyY7p5C4VK
LKP++oAShrv2wbyvnGgxkpomt/Eb5g==
=xc/U
-----END PGP SIGNATURE-----

--o37zrp9IxB4WCgx3--
