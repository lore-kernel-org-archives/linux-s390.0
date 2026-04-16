Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49853A7F5F
	for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338937; cv=none; b=PDKOiGh4em+BwKQtC1ay3+nMmNJuR351KaInQJ6uTdOm+tYI86/ZMGbGIpwdeMxo4ppjzuatgKm5w4cPlYXFEo7CElRjlQn8ysRwG3iiKq5qn02iABvqB6OQBo+QMb5AxPQ11K/6S6dqWI0AmveOQ3pNTOerNA47ztt/zRVqvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338937; c=relaxed/simple;
	bh=onL90hyVAUlPY0ASaWQwK2lX8QEYr5m106IAfPoIE0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWldb5xe2wp/HYGIi7CIk3VTCxtRU3InZrthwYUT1V5xU3zY9ceHQQjs4Aqwx9PXTx8VXYgwDhmHTrL68omgQ7qqI2d9TWiJKubahJa2UC/y9IH/IRinC2SE8rx5ZQKCL1ry6Px+mZjZ+CEt9VfWBqfL0WswsB7e8rDmG9cigtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506251815a3so65647231cf.0
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 04:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338934; x=1776943734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N28AiHhMQm9a3ncbvMl4jwXcNZbOrN6OiiJm2DjJOE=;
        b=lcyjWNBvG4IBbsQsYntiuQFdHz5VJj02zVfrvVmx96hKk0CBu90olOSGIew3T6g8jA
         5HscYHpOKR/QBAeJ6WjLy9RGOTb4g1K6znsJ6HgGZV1scHpxnWHyL5ZRJmKyH3j3YvCA
         X4zOSdPTPgMaNlDOVogJaydfKpae8BcR5Dc0bHKYXdbUeDztmpOYg/zyzuw6X8ms19a+
         YhIqayh+NBurlvywSvA0g3yPdCkYS0fDkgeYaglcC8eV9y8ueHlrSmI/3UNtoJdfLIA/
         vbLK1iElpomiyJyixrcGN89uRfEIidHC7whtQsMP0FFxzyBm17jMBpOpJ+9obUIQ8GmK
         JRUA==
X-Forwarded-Encrypted: i=1; AFNElJ93+QPU4491jDt/K2+hIcnFRdmOZ/NrA51iXun9/ISIAJ1y3/TWgSiiqM+qT3RO0K3FBKJdKdrFAVgO@vger.kernel.org
X-Gm-Message-State: AOJu0YxWv0K05Y6skM/ITevBaTiaYFxNU9+G9RhrxndCkjyk1d73Z8d8
	iCtaMDMVs5HLvN1euAjjzQRvbOyaMWtZ+j0qDY+m3alMS3fXCwCe4IP+VdC9VOf/
X-Gm-Gg: AeBDieuBTUlDURLz70Z1MnNcjI5MhRbDGCPT/GNViA5PDwvB/P4BE68rNRnQFIV/cFX
	5CvnBlWGQZr4RE5kBxyTKjPtb+lvG6HqJDd7IOycQe6D97BV1DkXOhWVZ6tU16mTDKbC8oSPirI
	Bpw3AWD/dGxhXECzLwAGlPBoV2DGbJnKT7jy5tLHQqQpUecvDIMh53xqBIMFfiZk/Uxkd3FE8P+
	YWuJOssM3xzqss6M3HsLooR+JEaZiAQCQplwJhsbieEhpWWSEOOrUMxWTpN/VeHEVFc8U0eQ+te
	wsvOgpnytlrX1A+BuIsz8/qDu5YmUrlXhqMNVoNI6HOnuKJC30ShPhAdFTd8FCHwZjBUdcR9LqC
	uJDrKRIWlOuhGTSh2q31HfY11GkV4MgevjYXubFv6TWcGCuwY0ZZIgCRpEF3hEq994fKceE2Uze
	TnBd4klR3WcTeD3do8Aa3XqN3WHzWlywextVm0K4DaDyeyR6bup3e7xs+mU/tEBdF6xcBjfPDaG
	a4=
X-Received: by 2002:a05:622a:1493:b0:50d:9ea9:7083 with SMTP id d75a77b69052e-50dd5af211amr369307021cf.24.1776338934186;
        Thu, 16 Apr 2026 04:28:54 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9da11sm35274471cf.17.2026.04.16.04.28.54
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:28:54 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb40149037so729357285a.2
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 04:28:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9FqX7qxBTxJ216Sv0k7GUNisczO/Crl2Mn61+8L4fw7LYuUVj1bs4OaGkaeOmX0rY1hFVoxJ+A8Y2L@vger.kernel.org
X-Received: by 2002:a05:6102:3fa2:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-609ff0c50e9mr11028119137.11.1776338540828; Thu, 16 Apr 2026
 04:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.045532623@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
X-Gm-Features: AQROBzCyA8BqoTVnHFn7fWQMKVWyMF2wrQlYn44P8f0X0RsdCOwGnnxui8decDA
Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:19, Thomas Gleixner <tglx@kernel.org> wrote:
> Most architectures define cycles_t as unsigned long execpt:
>
>  - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
>
>  - parisc and mips define it as unsigned int
>
>    parisc has no real reason to do so as there are only a few usage sites
>    which either expand it to a 64-bit value or utilize only the lower
>    32bits.
>
>    mips has no real requirement either.
>
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h      |    2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
