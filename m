Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD613ACEED
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430999; cv=none; b=d/6XdBVUhaDpeOMvSa0QnOEUkTrQeKJaMB7hsixUzlVQJOE0JjRxviGM2C2okZyfC7X6M+MrkjYMa/r3UzDqVctvjjO4bPWyEbGIcciTOKt/6CbizSGUSmi5A6Sg56Oit7hvxSRjDWc0sS+NeCXtwN/txa0QSjYR6ICjbWx/2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430999; c=relaxed/simple;
	bh=tZZLV6eyiwcGv5N3oyI6rD0AMUqGK1dWtQ5SUdhqr2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfFUKXDlAVtriqVhP1qBaOUaxNKjYCeWxJqPx2CbJVZ1LSDpVbPwSsXkF1NMxylfaa61Xf3kdZic+QSy5rTG73Wwp2m7cxsp/McM7XeccDWoFc6tVitue74YUNAOtxymbIgH2/CSgiBoxsvQP+K6Zw/oCL+U318l5xv3scNHQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9770fffa5a6so558581241.3
        for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 23:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430996; x=1787035796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=;
        b=ScDpoUSr7wGJtFw6qPMrm1pD1HedLOot6Lcwf6x/jPsvn7g1NylAo5AeMICCoTXLA8
         msMvQfcy8cNll+PQLw97TaA1BXHtMYpR6/FIf2nCy6XrEDj/dVkP+QO8vnkcAtWfvPZM
         J7jdahIe/soJT/HSaXvJCsYviW8R9KN7iWfS16S1AKyh2LELHIPwUlAqYO/Io9yGAQlg
         0KoKtCvkoV5Sy3T1obAAKSd58XSFATZl6+FahXS+TSHZg4HukjEMRLN5Mx3Zh8PA75Ug
         2cE/Tt/J4R+DULBmnKXngYf33goSptZHTgjxICejMF1KHZWjA7j5g0P3AX7QmKEbgpWy
         Ym5w==
X-Forwarded-Encrypted: i=1; AHgh+Rp4BYyhIK4Owm2UJjYnpsS610UZnrB83XN7Z4Hinfu6G48pwFww6vzlczgXFbZ916G96p9BqdE7WcZq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1i8+VNvluHK/tqwmQxkx3Hwdg4JVpFGxPRZT3xK+TlghKU6k
	a2ZP72O8eD7Alf78st6aD0N9eggswmshvTocQCjHkP5usdYSFF2+m6s8eukhufGN
X-Gm-Gg: AR+sD10rtnU+23vdeh51chkNWlhbNJtXvVZm3EFeDf+2InwH8GC338BEbsvVOg+fl0d
	LPchXBXRmb9cSX6twj/BOL0LH7h/5iqA5fSAomBB6LB8Vgt6EB32lo1/meVgGSe5MNUsS6vDjce
	d/PNuAHnqZ8M5tAs3zxI3gDqknOczu5fSeHDMpw778/QxWLPSu91VJH/uSF40Hp63GZ98BDxwEJ
	rkNDXGUGz7tsnO+ArkrQTVjQg3z5/0mvGRPZktby/pp62/UiQuAit1hzlcRt1duW3M7l78kJ8Q6
	h25L5IEM6tLNEACt3QP1mVN2LTnU9IYs0WsF0+3rZaoEwtHmZJmZLYtoG/V7GJ0lL7fXmlcgiWJ
	ic9bpXKYn9MHoS7vCjFAhHuCQl2qXYoFItmcjmJ9ToUuVCBuX5ZpHXG5p2cKh1zMBAFD9YGHGhp
	YNo5sALJ8jr58OjSff0kDQi4Wx6rUqLR9VG5KiBk+28VHV+i1SUyukamW9sLP2yVDJclFH4zey0
	8qlri8KHhC4H1TZJMVObXbkPA==
X-Received: by 2002:a05:6102:5120:b0:728:f34d:f410 with SMTP id ada2fe7eead31-76b55785514mr294467137.7.1786430995936;
        Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97a366ffbc9sm114379241.9.2026.08.10.23.49.55
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7466771f1caso824483137.0
        for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpX+GWMNNUzr0AT3rmaeISpukvZH6xmrjnvEhGEFUiF2RrompErCU+GM0+dYAgje30vsQr73J2Idgj1@vger.kernel.org
X-Received: by 2002:a05:6102:c4a:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-76b54a7a17fmr283026137.3.1786430995503; Mon, 10 Aug 2026
 23:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811042119.3652929-1-anshuman.khandual@arm.com> <20260811042119.3652929-7-anshuman.khandual@arm.com>
In-Reply-To: <20260811042119.3652929-7-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 08:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
X-Gm-Features: AUfX_mwgji-OqM2d70As4nCfmG84npBMa5IuhuEcV5XEKzcXYS3fe_Pqx16lD20
Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anshuman,

Thanks for your patch!

On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
>
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> page table entries thus completely dropping dependency on platform provided
> pxd_ERROR() macros which can then be dropped off. First move all required
> helpers in core MM into a header file which could then be used else where.

Oh, the "x" in "pxd" is a wildcard?
Except that is not, as it does not match "pte" ;-)

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
>  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
>  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
