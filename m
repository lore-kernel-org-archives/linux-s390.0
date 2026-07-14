Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE43D666F
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008810; cv=none; b=tQi0mrTdALda5+ctUmBLwTX0AyrZYHrvh/uUuTae9P7bUXXg//nvdHHB6/hcu+HRv+17XCk0Dsn5Ek+FFQCxrewANrXpqFh64EMp1NMDCA74q14MALdze+8tQeXBeBXHWzsNE9CQ0pmRdkFd9oYYw14P9mzIEonUIa/9Uc1y1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008810; c=relaxed/simple;
	bh=xlJMw2tMmCEPTBG7tQsXutCy9H4kFNuobvk0IKQRiyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8PAN/jqJxQbMQDOHrH+bvRRl/c7ZpTyp06CBlsah/2d7YPdEi25uHk5db2lCiWufSM+6b3FCaJ1TIDU3r9wcFB+j11IXM3cgB+O0MCi6iIuWFohX3R4isuxWhOZO2TeuDzCeKzHvPWOt40Jb7pgzPC78WQBB7kdyf7H1pN5208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydjbv7oF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydjbv7oF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso3095740a91.1
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 23:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784008807; x=1784613607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ekTn3UMJic44VT5Ls673Az1lxgbjw95C1C5IWJSyBYM=;
        b=Ydjbv7oFS1gbZMQYzoi6cloRIjR4qzza5dDyY483Z56tHbeyITTS4wBhBlKQpNuyiN
         tJA0pPeL0SyGzd/wCbHUHwX3dTgRg4nMuIGmWFNsPuRpYgh4p9fmzk1Uo1UTjNCarKYv
         smpHf+VZg3XkrUM6AHRyaRZsKJOyoAUwUqk93W1RYNv0lnU2FHsmFedXNB1TLC/J0ye/
         WjA7bnIGd1zJc6zv0exSo24U6v4vKMPQdpG1clZPEvGmL6W+A1KAqbZYgzpx94m92GZY
         6B5N0S76JN3fnKcQPBJKQimMPiE/Z7H5RyhPduK0hmgtixbgwa3NqwqN48UbHnxiUui7
         MNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784008807; x=1784613607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekTn3UMJic44VT5Ls673Az1lxgbjw95C1C5IWJSyBYM=;
        b=aWqm8QGCi8w+/bDVr/xXP1rp/k9/cJEmoRgVwfS5ltRB677wUjjWmZHyvQ8fXGBe5b
         9d2zghd38L8qn3Qg5qH5pR2/YL1QEPPVEvo3gexa/YXdLz2/R3GC4WrkGKFB8qdV+7N0
         g4YmOzFI5Iv+rn8iamdNiL6sYxa1GPKBXF7gPNvbFE40tK9Fd0u4NrZLmbmhSJxIUdUT
         ljidntwlDSEr7uo+Ad5rdbCKAoBTEK6XaVrGLWuEiJ/2Bw6s9oGGGqUwJY8JLAu5peNM
         Ql9NTLNYkF8+wX5E40zboYF7jaXU/7vJBX3bOX4PqPaVBy3t6TBGqw+yI6SQ0cJj6aDe
         4QFg==
X-Forwarded-Encrypted: i=1; AHgh+RoKjGmE6eDrVG/lSriiyDcfrMo2gn3jNYV0IjLJOAlMC6RIylnjz6Wxde6GTdBhK5dcVkibicq/AtZg@vger.kernel.org
X-Gm-Message-State: AOJu0YzPW8teoaAGP6paWE7YT4YLled0aRO5nDZsOY0VqvgaWTznaJrh
	0CKHbhbkHhmljkf8e+h7PzSvQZ9OZIMKCS4bRsGChBCSBwrPa4oANME4
X-Gm-Gg: AfdE7ckJdc6eky+TV08ZAhGiWy4R/JQKg+sBQxGKPy4eDGkFpwp2UhB2rw+s6j5bfGC
	BF0DKQxcky1glBQ9xMQ24uKrVXSbJPeE5dUCaqqcJoHGXy0HseG7pudlSx+6v0vBSVXYnGBoCMp
	z+TdRDnw/Y3Anxfa+B07E6GMHz4b0nmixXHO0rOkJkN142Jznk4rqWMCJ///OjN5V37QYlZ9ws5
	dwGa2BYXOz7FTQkW7vKIe9WKbPWCgULDHVjpKI3ghKXJSXr3WvG+SXgLI/cXGKxAg7+DJtcOnUy
	lXjfMzAufjrfa54xTTlliUUxC7eySDBNCt6HUfvT6D0jUDkIMMIs/CkeCwnbtuBCc9lke8a7FRa
	25EwIP5/gKy5m31fANgMXjqhK06+9HqqgiXwLN7z7ftM/9yULT3AfP1UtcDKeWAr8S6VEp+9QnU
	WIAwG6SV7MPfi4cb2yNa8IXpaq5aI1ibnj
X-Received: by 2002:a05:6a21:8cc1:b0:3bf:6011:53b with SMTP id adf61e73a8af0-3c3571d0438mr1375652637.38.1784008806472;
        Mon, 13 Jul 2026 23:00:06 -0700 (PDT)
Received: from blinky ([2601:647:4000:5070::76e1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm63657400c88.1.2026.07.13.23.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 23:00:05 -0700 (PDT)
Date: Mon, 13 Jul 2026 23:00:03 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v5 5/8] riscv/runtime-const: Introduce
 runtime_const_mask_32()
Message-ID: <alXQY4hgZYLmr8x7@blinky>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-6-kprateek.nayak@amd.com>
 <178366995930.1208691.2993932866462893112.b4-review@b4>
 <650c7050-2a77-4415-b597-3bb39ccfb1e8@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <650c7050-2a77-4415-b597-3bb39ccfb1e8@amd.com>

On Fri, Jul 10, 2026 at 01:47:10PM +0530, K Prateek Nayak wrote:
> Hello Charlie,
> 
> On 7/10/2026 1:22 PM, Charlie Jenkins wrote:
> > [You don't often get email from thecharlesjenkins@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Tue, 30 Jun 2026 04:55:28 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >> Futex hash computation requires a mask operation with read-only after
> >> init data that will be converted to a runtime constant in the subsequent
> >> commit.
> >>
> >> Introduce runtime_const_mask_32 to further optimize the mask operation
> >> in the futex hash computation hot path. Since all the current use-cases
> >> are of the form GENMASK(n, 0), with n > 0, following sequence:
> > 
> > I really appreciate you spending the time to do this, thank you!
> 
> My pleasure! And I really appreciate you taking time to review and test
> this series. Thanks a ton for that!
> 
> > 
> >>
> >>
> >> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
> >> index 1ce02605d2e4..dbf96c937dbb 100644
> >> --- a/arch/riscv/include/asm/runtime-const.h
> >> +++ b/arch/riscv/include/asm/runtime-const.h
> >> @@ -262,6 +279,33 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
> >> [ ... skip 24 lines ... ]
> >> +     BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) != val));
> >> +
> >> +     __runtime_fixup_shift(where, 32 - width);
> >> +     __runtime_fixup_shift(where + 4, 32 - width);
> >> +}
> >> +
> > 
> > It would be "optimal" to use an andi when the mask is <=11 bits since
> > andi can fit an 11 bit mask. What you have is good enough but I'll leave
> > my stab at doing the andi patching here in case you want to apply it.
> > 
> > From 9e5527aaddd464783af795aacdb6d094e11cc31e Mon Sep 17 00:00:00 2001
> > From: Charlie Jenkins <thecharlesjenkins@gmail.com>
> > Date: Thu, 9 Jul 2026 23:18:09 -0700
> > Subject: [PATCH] riscv: Optimize __runtime_fixup_mask for masks with <= 11
> >  bits
> 
> Peter seems to have merged the v5 series in his tree but If you could give
> your S-o-b, I can throw in a commit log, some testing along with a few
> cosmetic modifications, and send it for official review on top of
> queue:locking/core ;-)

I'm glad it got merged, I missed that! Here's my tag that I forgot to
add...

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

> 
> > 
> > ---
> >  arch/riscv/include/asm/insn.h          |  2 ++
> >  arch/riscv/include/asm/runtime-const.h | 29 ++++++++++++++++++++++++--
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> > index c3005573e8c9..0a34cd7305d0 100644
> > --- a/arch/riscv/include/asm/insn.h
> > +++ b/arch/riscv/include/asm/insn.h
> > @@ -141,6 +141,7 @@
> >  #define RVG_OPCODE_JALR                0x67
> >  #define RVG_OPCODE_JAL         0x6f
> >  #define RVG_OPCODE_SYSTEM      0x73
> > +#define RVG_OPCODE_ANDI                0x13
> >  #define RVG_SYSTEM_CSR_OFF     20
> >  #define RVG_SYSTEM_CSR_MASK    GENMASK(12, 0)
> > 
> > @@ -175,6 +176,7 @@
> >  #define RVG_FUNCT3_BGE         0x5
> >  #define RVG_FUNCT3_BLTU                0x6
> >  #define RVG_FUNCT3_BGEU                0x7
> > +#define RVG_FUNCT3_ANDI                0x7
> > 
> >  /* parts of funct3 code for C extension*/
> >  #define RVC_FUNCT3_C_BEQZ      0x6
> > diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
> > index dbf96c937dbb..24a9b13081f7 100644
> > --- a/arch/riscv/include/asm/runtime-const.h
> > +++ b/arch/riscv/include/asm/runtime-const.h
> > @@ -9,6 +9,7 @@
> >  #include <asm/asm.h>
> >  #include <asm/alternative.h>
> >  #include <asm/cacheflush.h>
> > +#include <asm/insn.h>
> >  #include <asm/insn-def.h>
> >  #include <linux/memory.h>
> >  #include <asm/text-patching.h>
> > @@ -302,8 +303,32 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
> >          */
> >         BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) != val));
> > 
> > -       __runtime_fixup_shift(where, 32 - width);
> > -       __runtime_fixup_shift(where + 4, 32 - width);
> > +       /*
> > +        * A riscv 'andi' instruction can fit an 11 bit immediate, so the mask
> > +        * can be directly applied. Otherwise fall back to SRLI + SLLI.
> > +        */
> > +       if (width < 11) {
> > +               __le16 *parcel = where;
> > +               u32 insn;
> > +               __le32 res, nop;
> > +
> > +               insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
> > +
> > +               /* Replace the slli/slliw with an andi */
> > +               insn &= 0x000fcf80;
> > +               insn |= val << 20 | RV_ENCODE_FUNCT3(ANDI) | RVG_OPCODE_ANDI;
> > +
> > +               res = cpu_to_le32(insn);
> > +               /* Replace the srli/srliw with a nop */
> > +               nop = cpu_to_le32(RISCV_INSN_NOP4);
> > +               mutex_lock(&text_mutex);
> > +               patch_text_nosync(where, &res, sizeof(insn));
> > +               patch_text_nosync(where + 4, &nop, sizeof(insn));
> > +               mutex_unlock(&text_mutex);
> > +       } else {
> > +               __runtime_fixup_shift(where, 32 - width);
> > +               __runtime_fixup_shift(where + 4, 32 - width);
> > +       }
> >  }
> > 
> >  static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
> > --
> > 2.54.0
> > 
> > 
> > I would prefer including this, but I am happy to approve this
> > regardless.
> 
> Ack! I'll keep it as an optimization on top to retain your attribution.
> 
> > 
> > Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> > Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> 
> Thank you again!
> 
> -- 
> Thanks and Regards,
> Prateek
> 
