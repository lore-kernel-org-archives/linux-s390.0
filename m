Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09505403EB5;
	Thu, 23 Jul 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845467; cv=none; b=duJsiUfCTb/cz0FxhGpxNBctUh8TTX68umt6cVuDDcTh9xQK3mOdFdIUMWKc/LHyPpK1eX29g9gKToZtowAGDqRklgnjFkhUmkjUJb8ZYR1tpqBOMGH7xkFQN+G6ofKKzXR0fsqSo2sterwIfsObOc3gR3wtsc5pzERcNBl8OuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845467; c=relaxed/simple;
	bh=wyXeIS3cmEfH07anTwpJDLOmyMJnaeI4nCGBLkr2ido=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UMnh0qhW7jDYRLVuJPEJjsrm6Fc2y6JaFictJHc7vRdxD2huZTWprBSmj+QdlEtuezcDYGX9/flqULonaABiup4MuKREPIxcAA2xjYtnNvboPCFnkmgogob9+mRWWvgzttleMJvG9znLZodvBTJRNvLxnPOJU6KEQD89w1fHmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0gs/fQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0gs/fQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AF91F000E9;
	Thu, 23 Jul 2026 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845464;
	bh=wyXeIS3cmEfH07anTwpJDLOmyMJnaeI4nCGBLkr2ido=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0gs/fQTEABgSSdRJEsajw1EJftgeBJhMY8q/3S0WgRHJVMtD6y6+pJpCY3oq32VK
	 sF5HhhESQ2fndIQmCgVcKjV1aXsXm3cKKJv107VAIfeg55KYRwP6IQFCJhrLbRDexV
	 L95aW5kJV0zc0X6FeYGHvFVffG22/9c+Ss4BjC5OJrNlmxjSuGECCLk+CZIKKkF1MU
	 NP2XRGXE+vga+QQ19+SyuLB4o2VhALpOLvUK5gwuWE7liSnRiw+HIq9lOjcNmxiPz9
	 c8wdD+oUpdJPis4TeF+7yd6HIceDdQSpA5y2rYVvuFOjhEh4wfUzsp56/IW9FcArAj
	 jCdkKeSwGxZdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] KVM: s390: pci: Validate AIBV and AISB before
 pinning guest pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723221409.5874-7-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
 <20260723221409.5874-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:24:23 +0000
Message-Id: <20260723222423.D1AF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The AIBV holds one bit per MSI-X vector for a given function. The size of
> the bit vector is derived from the NOI and the AIBVO. If the size of the
> AIBV exceeds a single page boundary, then reject the request as we cannot
> safely pin the guest AIBV.
>=20
> Similarly reject the request if the AISB address is not 8-byte aligned as
> the architecture requires doubleword alignment for the summary bit addres=
s.
> Since the AISBO can address up to 64 bits, the size of the AISB can only =
be
> 8 bytes for the function. This also ensures the AISB doesn't exceed a
> single page boundary.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723221409.5874=
-1-alifm@linux.ibm.com?part=3D6

