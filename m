Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927F408243;
	Tue, 24 Mar 2026 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374204; cv=none; b=jvc3kQMi+DcKo78HBIgJPeV8kMl0HvMisgDl2pJNZSoKy/r9BeekzGpMOf36AMqXSF4Y+hrMfvw6+HwCYHEJSir9tOyPGwkfQPu+NFaHLB45tlyHQyNGtu+LdcCP9YokvJ5UnJLYBCQ9HLNUIfaDIF7RVUgn4RhfRMOqTJUYlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374204; c=relaxed/simple;
	bh=CNmUFp8JkVWBujLfh61agf5vcNlLITuFzj372hFmm5c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/NyNrylFfNeSsuy3KucAf7nBhnDcTmiOifndbTk43/T6KSsa+FWs98aP7oviSstKkNMgDNJ/JcyNIHj5sjpeIw/BWBc87FECZJUVKx8nsTsU9y78pbC7i246pR08u2to5xPehUiFARUnJzR+BmSxz9N2pH0b/gs04ImO6DHuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=D8SNo1uQ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="D8SNo1uQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=AP49Wml/Qr/wzH3y6BxqbwOt7JtkHcoMn8XiWeebrkI=; t=1774374200;
	x=1774979000; b=D8SNo1uQMsOa3NR3jAQLPTo8B8nkT3YKcrSYvXuGfS3r3fvdqP2LOT5nkSiDC
	RzqVvPjJOKl+BYKoUDufQQoqA5Qnu2N0y5kx19WrEa8rBbb0PBTwVLpXI/TGjJW0d+4tnhA8Tlxib
	yBfyKnQlv1OvjakwFcCONIH/j/EDAa5h2ya0KBEGgdM8RUyCktIIlBT5ygRozB6k5tkZp/BG3BKXx
	SJdaOfD37ZDNl35T8600JNJUabXBbMrqblYmjQNOmEv8jud4hUk+AOUuzdX+F81aaaEmjVm1IGxBN
	uxrpqJSnTJk0Dc+iLPRjbJ4UBcYn0VTSOma287OhRbs868datg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1w55mW-000000048aG-0PwD; Tue, 24 Mar 2026 18:43:08 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1w55mV-00000001qau-3Gph; Tue, 24 Mar 2026 18:43:07 +0100
Message-ID: <5de97ed9556bfcc3b1f26bd71e09fa4016ae3ff8.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 05/10] am68k/PCI: Remove unnecessary second application
 of align
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Guenter
 Roeck	 <linux@roeck-us.net>, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Michael Ellerman	 <mpe@ellerman.id.au>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar	 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen	 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Chris Zankel	 <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Madhavan Srinivasan	 <maddy@linux.ibm.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker	 <dalias@libc.org>,
 linux-kernel@vger.kernel.org
Date: Tue, 24 Mar 2026 18:43:06 +0100
In-Reply-To: <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
	 <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ilpo,

On Tue, 2026-03-24 at 18:56 +0200, Ilpo J=C3=A4rvinen wrote:
> Aligning res->start by align inside pcibios_align_resource() is
> unnecessary because caller of pcibios_align_resource() is
> __find_resource_space() that aligns res->start with align before
> calling pcibios_align_resource().
>=20
> Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
> result in changing start either because 0x300 bits would have not
> survived the earlier alignment if align was large enough to have an
> impact.
>=20
> Thus, remove the duplicated aligning from pcibios_align_resource().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/m68k/kernel/pcibios.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index 1415f6e4e5ce..7e286ee1976b 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, cons=
t struct resource *res,
>  	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
>  		start =3D (start + 0x3ff) & ~0x3ff;
> =20
> -	start =3D (start + align - 1) & ~(align - 1);
> -
>  	return start;
>  }
>=20

Sorry if it's a stupid question, but what does "am68k" in the subject refer=
 to?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
