Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061623EAB4
	for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372345; cv=none; b=sPsy9qfAVwNPoLcY8Uq58s8RcfGTsJ8k9D5G+fYLRIx4zBBeQXuvB5QX77kSG87TK5o29AqLuiXoc9aLw6ZhMDMEojQ1uPO9Rnjxf1MUnAvhnZxp0V0P+B1opQ5KvehQ+UXe31E8ogARGpTWAbbgIqRziQ1Tmon4eZNS6Wsq3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372345; c=relaxed/simple;
	bh=3GEJwPfpmz1HAcFqPqDcCHr7DP7fs2OA9k1TBgcroIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP2qP0Dx6HOatLjS/mFVv0Mgwzggj4TUZr/GH2/JZKraqqO9dd7NIfddqPTjAZ05GrGs+UjwFmiZtu48bM8bHbcJWSD1RLEWwtGpfVkfpAKdTPkRihAAZBB98TvkkDMalGa/j76xYzXLT9sMju0rPI90S0wO+ylpubX9bV8OAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a8fba3f769so26267075ad.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 10:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372343; x=1774977143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imA4hBFgRxEV6K6PxesH3aFI8Gk9es7sFYCGiASF9lc=;
        b=dd4/zQQsrimDTK2NrJvxeEO6hcgRIaXFtKwYszAnvgO7zeynPCNKGX5g+I49DTjH0a
         k9QtnPK4R7km0rAnfd4S0PDJc+aUPO/sHr7Bc8WUgKIMz+bd1QB3tTRiJqMdfkPagRMC
         4CathJqtZpdZgXSoD9uR70mZ3OyJPrQME9tRdfpUuQGAmO24tyElcuQlvcQvltMqou42
         ccy/vKcbsd5U67zdQIcRfjioB8EGE5Pc3bWxG9OgiKW61EX8uq1tOY2W50iKykRYxqvo
         HwNWR1tm24sWfi517qCn8I324njYNz2yJ6XSuPAc5kS9WdTEv+sFT7PiQVGKaVoV6IjC
         dDEA==
X-Forwarded-Encrypted: i=1; AJvYcCUS92OapuLJGw8kXwejazjZdnqqe63wHnH+9N7jPGPBwvhy+6MWYfWpu0FH6el2NzBuYF19TDD4mylM@vger.kernel.org
X-Gm-Message-State: AOJu0YxUe5QVj222G3dO/NRM8Zp/x+sfAsPLjTwzNEy+BSMQIYfye+g2
	pbywJ8PfxlequEW1+orhDbkcMj6M4DJlaom1ZB5HAjn1JBslKe2UT5ciZfIP5q37jXI=
X-Gm-Gg: ATEYQzzvyG+rvk2/92qRfxXoVE3BDTWzxto7iLfG4H23njbFTeTcK1NZ5O1A8kwHa1l
	52Ls77FqB7bDpB46l0AnW587CA69K9I1c4jwMFvpnS/E67QI6SH/1vMKjc01kDEb5T2u3WqsxSE
	6w48QI8sJRnzXu4tRIkcbsoHQB8JqZtQIHb4/gMJ+3W1FbURVrUWr41gN0SqkUo+3gDeDon3KCN
	IlxVRArcIudob7HVBfVbkkwwLg7Ytulk0jl0nHzzMJZDH1T1HPjFQrbvX6C6QO51387bkwiyTkO
	dujstqdGWLdSYP2vKOZ7mwnppkDlKPKUOtx6bdQMyHErRt9+0EUVwToswyrfK7hSnJ3+dcRM5Pd
	7oO6VXUdbeXniwTIrpKUK3HZ37F1zm9/nvPTcM2LBLgOp0nDe+d1GBKWblM6RCfVVr/fG+4WkvK
	FTfLcqVmaSeA0PGHegyVGkNA8MqYSSHxvyfL/0CSZ/qySNmBwD0BUuNeM2bvQ=
X-Received: by 2002:a17:903:183:b0:2a9:e8b:5326 with SMTP id d9443c01a7336-2b0b0a7fc81mr3867315ad.23.1774372343029;
        Tue, 24 Mar 2026 10:12:23 -0700 (PDT)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com. [74.125.82.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366b5besm153357795ad.55.2026.03.24.10.12.21
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 10:12:22 -0700 (PDT)
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128ebee22caso4566116c88.0
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 10:12:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeVk/MwCBEo5bpb74SkOXk2sNFbR/DPF4E4Tn+fenkP7quupYd/T/4G95BW3vRlKfujwWKvsaipWQ6@vger.kernel.org
X-Received: by 2002:a05:6122:1da4:b0:56b:5978:22f5 with SMTP id
 71dfb90a1353d-56d220a8b85mr416671e0c.12.1774371994638; Tue, 24 Mar 2026
 10:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com> <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Mar 2026 18:06:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXX16=pih34yehj=3bJkg2H3ivGUj_34JDg31ABheLE5Q@mail.gmail.com>
X-Gm-Features: AQROBzA3vydAXwvxX7mNaSzU55R-3eBg9lznDuFtNbFYtRdYd66gsLQKONTytjo
Message-ID: <CAMuHMdXX16=pih34yehj=3bJkg2H3ivGUj_34JDg31ABheLE5Q@mail.gmail.com>
Subject: Re: [PATCH 05/10] am68k/PCI: Remove unnecessary second application of align
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-kernel@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC gerg

On Tue, 24 Mar 2026 at 17:59, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Aligning res->start by align inside pcibios_align_resource() is
> unnecessary because caller of pcibios_align_resource() is
> __find_resource_space() that aligns res->start with align before
> calling pcibios_align_resource().
>
> Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
> result in changing start either because 0x300 bits would have not
> survived the earlier alignment if align was large enough to have an
> impact.
>
> Thus, remove the duplicated aligning from pcibios_align_resource().
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/m68k/kernel/pcibios.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index 1415f6e4e5ce..7e286ee1976b 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, cons=
t struct resource *res,
>         if ((res->flags & IORESOURCE_IO) && (start & 0x300))
>                 start =3D (start + 0x3ff) & ~0x3ff;
>
> -       start =3D (start + align - 1) & ~(align - 1);
> -
>         return start;
>  }
>
> --
> 2.39.5
