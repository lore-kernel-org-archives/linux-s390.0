Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97AD3644AB
	for <linux-s390@vger.kernel.org>; Thu, 29 Jan 2026 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658947; cv=pass; b=b2n7Bh06VXhgrftxTd4dBsFO0/AF0NMzIUh3ACBu8VHDG0jM419zPRJTWD2WxdCoM2xmbGHnPSnDi3lpOX8vDiX40FBvSHH2A4+hy6CVOk09fzG69yoc4EPgJtek5mQ4xqR76r2cEfMZ0ErYZr3Pp8Q0YUq+0G3l0Hwt31hBZtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658947; c=relaxed/simple;
	bh=dreyxwAadnjRw4GmLNjYV9KTAhpZn4PH/bUL/r3ljrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr4hOa+8pe2H4GWTKoAoKnLzpEJjklPQtit68UpWrfOiqOAw49tn17HQSqX4ENT23sI8HSpoStPHHPPULSRy5rwjG+C5h0GByp2sY7V0ozA+jnqiJpQsWUznDYQZ8yeJfpsDWmSyny3o6UqEXvQuQgf0hYJvmPEk4PgDOzG5jik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lb5j6+FE; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb5j6+FE"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88a367a1dbbso8002456d6.0
        for <linux-s390@vger.kernel.org>; Wed, 28 Jan 2026 19:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769658945; cv=none;
        d=google.com; s=arc-20240605;
        b=dNquukrt+CN3bYlyaO6mO7pnKjsVID2fvCu6/aJ0fj+5WmP9sdUW9WjjhuPDb98/Yt
         vL4jHDV0Zk0ZuDXlyvWz+cnh/yn6zIY74hhoO87K5q7qQrPQlDl6/Lcu2BwRNVFuSozv
         xTBkzC9fpiA7r60eKb4c0H2qaAd+uDXubqIv6MzNzoML025dZWfG1lHI8PDyj80UVAiF
         pN/v5Je5hAFfx9yHInkwSWPYNPqSPJsGYlaNGFBp4F5vkfVAMgr+bp2Wat50Ffv4H5qf
         GoV3vPjZHOPqKO1bUjRdDwSD97eunrmbQ1hurb1Trh/kmsNBDH6PpriStvbv01xcNIEI
         XgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dreyxwAadnjRw4GmLNjYV9KTAhpZn4PH/bUL/r3ljrU=;
        fh=BxXCNeUrOsmGf81bHR6DkVe6DlzzwSR7qTGZgNjfHdQ=;
        b=WNvgIMMRw6v0yQrgRJPkC1Px31iugUy9ZSNnIIZpTo/NsBh/K5BwVlnjCzlIUx1GDm
         mDAd1kKM+xDPQzIlg6d38c2GaYDoJvlG6vvsVGAnDrFVAOCR6rEi+w7sMkuVEwF7NhKd
         zTAmvPqn2e9VeXtC9R9A/vlK+ycjr/XwSF0wJyMteldfqkOVRW6kPWjNc1/6G4/V72jA
         Exi/fA2gH73gUpTrTkXuZFGNe69jc5kaNcr3nLyDZKmuRz6+31Ww5vAJCvv5cUhAW0KD
         l/6tei/U+0q4Gnuy92CWGUsulDCeqNa/ubOoPAhWxbTN34w4zahlGQl06a0xvU1z/ikZ
         AkNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769658945; x=1770263745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dreyxwAadnjRw4GmLNjYV9KTAhpZn4PH/bUL/r3ljrU=;
        b=lb5j6+FE2O0Pl62pBEhMsNfLi2bWioImX+YbzHIDJk4U2UjdvonV9hoEojHeu1HDGU
         ba9+vJKWf1JgciuIV0brHuUb2cXLpY+i87GPeZ3NzF2nlRluwxkLtohrda4B2cyDQmuv
         QKBBR4tT++0NpInsKX2COkILgZq4+SO1iCr99j6B1qV8SSxithPR44AxSL9unhlsMynZ
         WvZxyvrSYf/7P3kQ1uEPugknX2eFqjtca+Q6W68zkBAH2dcFkWm7rkGxxuJp0ZME/a28
         +Hcmnnd1SMohD30jCpLbPFXK5AnpHyZz/JP4CVz2Kz4GBOQSSW1rOFr3rDLAQ4IfnJa7
         6dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769658945; x=1770263745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dreyxwAadnjRw4GmLNjYV9KTAhpZn4PH/bUL/r3ljrU=;
        b=xTZ6DauUlo/hizGim52uhELvKBgLYkA4AizDaVRmICN8fFlcT0kH3OW/0MagRv3EBU
         2yewfBHFBYHnOmlyNRjfvBjfyxEd9NhduIXvn5nRO/H1l9gnF3Srk35sV8NtDAoHVWp9
         WaSwaWJf4wFvQakuvbsOA0HWS88pkOIeTOhokRxsGK+gcmWSEcWqpbnxfAw/WrvrRA7+
         XafKkdMGO4vRPoKZIjTfxbhF9Hu1o1ywhvvlYr0nPVa5Kkjd3Dw5IXlKlOFMklpfEtcv
         cRagwLkCCpn26Hzk0czD7VollnNjiarzznpOsVk65+5FomQNJIEkI7szMO1XUl2qatUM
         3toA==
X-Forwarded-Encrypted: i=1; AJvYcCVOWDs4JS2V3HUfQ/QUOhqyafWQmlDkJnPezcvzHBTWn0/QT/h651gFVU7ixbfYG44IgUHQ4gcirBTQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzfbJWww71osFbcLnTcgzowmLJT22T777F2bcEyMSK/YWP8DFFN
	v28c7AodZs6fuKyhYwjKEPe9jSBz6aSbvYbKoqFpFy4Bav5yhGSoajkVrQDxFVD8GmpgLks1pU7
	JbuqA9YWRDxdUyw80MDUwuVTdpIItB9g=
X-Gm-Gg: AZuq6aKhotoeYyjlFva2giORC712bZJXv9xqT4DFjbUhDYMYJnCelUrIFD3oFtKMHUd
	jZzzXbG4UmrvhKY6RAmoygYfXDuT33PCZ3sun53VfIQ1IcNvR4JaH6vqVi1UVaejTQfVh9fkJ4o
	cgHn4UsbrnpJ5ZgEVPvMZH2OhffxIkSH/BC5YryVq3lZb7JqjiU48vfMezmxJNkrELq3qabedQG
	VNWMlL5Eg86ueU/6FYGCmJnTua7V/X76z2APHHHEobs5pCuFdwOXkpxWJIRLuHN2lLJf87e2Aic
	yns2xAq+gUYALH5VFWkihOJvEHwv1+huaEYPzvKH2VgGub4mXMZy7lwz
X-Received: by 2002:a05:6214:d47:b0:894:2d44:509e with SMTP id
 6a1803df08f44-894cc821c27mr116372646d6.23.1769658944665; Wed, 28 Jan 2026
 19:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126031352.22997-1-enelsonmoore@gmail.com>
 <alpine.DEB.2.21.2601270110590.40317@angie.orcam.me.uk> <20260127155607.3f80ec99@kernel.org>
In-Reply-To: <20260127155607.3f80ec99@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 28 Jan 2026 19:55:33 -0800
X-Gm-Features: AZwV_Qjhl5q7xOvj31R-bM_rs_0zlvr3v6oaj-AmWEWA1eTbTy2My24hcAGKR1E
Message-ID: <CADkSEUjfBQLqibc2zrcWHhOwu7kUf8FceYDfevAFHV4rCqsUUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: ethernet: neterion: s2io: remove unused driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Linas Vepstas <linasvepstas@gmail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Pavel Machek <pavel@ucw.cz>, MD Danish Anwar <danishanwar@ti.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Takashi Iwai <tiwai@suse.de>, Huacai Chen <chenhuacai@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Eric Biggers <ebiggers@google.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Konstantin Shkolnyy <kshk@linux.ibm.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>, Dong Yibo <dong100@mucse.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 3:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> We deleted the vxge which I think(?) was for a newer version of this HW
> 3+ years ago and nobody complained.
Yes, it was for the newer PCIe version of this hardware. Since no one
complained about that (unlike when fealnx and sundance were removed
and then restored on request), it's even less likely someone is using
the PCI-X version. FWIW, 64-bit PCI and 66MHz PCI are even rarer than
PCI-X, so there's basically no way to use this card with reasonable
performance nowadays.

> On Tue, 27 Jan 2026 01:19:34 +0000 (GMT) Maciej W. Rozycki wrote:
[...]
> > What's the gain from removing a driver unless say it's broken and
> > does not build?
It very well might be broken. When vxge was removed it emerged that
someone had reported it as having last worked in 4.1 and broken
somewhere between there and 4.4 - see:
https://bugzilla.kernel.org/show_bug.cgi?id=3D197881

Ethan
