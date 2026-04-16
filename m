Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCB3AA1A7
	for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339035; cv=none; b=bWyT4gnhM/MANtG4+ujkXkmTByQ0nykO8LghfEIQy/W/eC/BozMZL1S3hmrodV/3aJtMhyZKl288QmEcMNyI09yPfIaORTcoDRvfHHNUzqKIKWmrFs15+wxP0FfHP5tfYBwThE8oNDiRMJ2bH5+3xt/LuE6pSppL6lKR0/g8u2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339035; c=relaxed/simple;
	bh=5RcGmn3E6IkK/4PLTUVN24XJ2jAiV11BodM4t9S5uGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtPSWNNOpeMZciaEkDobR/wjb05HTSNMl2HnQXjBpz/am9oS0zRNKFx9r3j+OAi/zYo+e+MXwIFopg2zuDDQ/vTIrsBxl2asf5nWVEwcjp2cBZ3kv+Sz1Aip/TIWXnYoA+y3ApVzRiWDNKd0cR5AqXns05mSVoI5WEsAj6Y6ecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d7e7f48499so770585085a.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 04:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339032; x=1776943832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6jqlHRyBmHp78NPQbVn/INUSPCxYZ/sUXVIyq1nXfE=;
        b=YUHv0zMjkfzqMbk9BWqOotBFQeW9yP347FApq/BqGl66vP4o+mr7NQaXFF8rC1ObL0
         s5XKgopFtZ/KSPc9QHDD/KUf8xbmYAyLb/SlMIxVGfRSjjesb1+otsmb07TrkB5G2ume
         VWU79dI2EWQFK26iTGkdf2+YQUP95GgKUNeDyI9dHKSjfWOWjgxs0i4ijJPz43kMiuPK
         rghN4qX9Bz/sbbn+KoPv3QKpSjAtFGibSyR6tdLXIYZJFKPGxRSkxw2KpT07/M0DdOTA
         rFlvFWTpjCL4OApNdFlDSkyjk2acvmegPzjl5PYJTRbb85reASI6GM+YIGK5rUuWeyhx
         Qr/w==
X-Forwarded-Encrypted: i=1; AFNElJ/w0XrgBW6RTu01qfNCC/27vDNoVtAjSpxtC7E1CkcRkxXF2fhkQRmg4Scd9n5b/Gx3dnWyq2WZQPB2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4c/CJRDGj1OOvl7MtjrSvspmcO+5QTTWdIZtEWiZrx/5bvpfY
	a7QHfUnglLR4s6GMP0SoskLQItYKxOPsu71YzLZtmFtQDJqKeZ2tY+1ylyJ5r3qZ
X-Gm-Gg: AeBDieu7hfS+BmVwB7J9PhP5fFN9otdHrupMErCLWdtb9JFCZLm2mEGa6u9IrkVuBWT
	VXO8VMqON8p7sc+jMhnrRwmbGXjOYdljCnbB5Dnmm+hL4HD0pyhVsQXQ+claWV0K9MCxtTNEqXV
	AMU8MOPaK+mwaT0hNqlQAaufHJOWJkyzrdLzLmODp50sRfKmBiIKrly4SVggjUYvF8eRTENoReU
	6kivC+kRcI75lf6ctAX8ORBf0M8L0YZBSw9NgUqa1FAZO3SCMYPTKtasghe9Eywtd/2Y8MyDK2W
	nSzBLzEf546YaEfRgiltLF9A3K9EcIbeapxtfTlG2Af5o+vBlrP37XXAOlLsVhrCXNy8rmtXN1V
	iezY8ELsLSPwCaYoy4x7/080gsECOOqEVgo6UTKoW4d12hkil17EkFDb42ooH3p9i5ckkLA6kfq
	pmOX2TgCnwzpY51t+lbWxn5U9fnoIIilNtY1EiGNZaHRwHLEN5LqLvHyKPK4Psvfjk5VBN+zc3M
	sXluwRUUeyLCQ==
X-Received: by 2002:a05:620a:29c9:b0:8cf:dd93:acb3 with SMTP id af79cd13be357-8ddd049a4b2mr3815680585a.56.1776339031204;
        Thu, 16 Apr 2026 04:30:31 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33af5dsm343098085a.16.2026.04.16.04.30.31
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:30:31 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50baafd6c4aso80993301cf.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 04:30:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9zYawXPCBN3oogylbLYiVn4uSCdlycK6Ng0MHoUNJ9xju5Qdc71JCZiKe7V7KjY3MWBJ+XHZvfeW/1@vger.kernel.org
X-Received: by 2002:a05:6102:6044:b0:5ff:c64d:2283 with SMTP id
 ada2fe7eead31-60a0157295cmr11348128137.30.1776338547396; Thu, 16 Apr 2026
 04:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
X-Gm-Features: AQROBzCJ6rVnwwfhi99PI36wWXAFQ5DEgo1zw3RhVwYNSXoxkTYAcgIxt5Z0K1g
Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
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

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
