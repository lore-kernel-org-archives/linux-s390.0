Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF62E36FD;
	Tue, 22 Jul 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208494; cv=none; b=Y/ipf6qXFX57Cix1ByyYgmCh2ziSbJ+q99novPXewbKvJky42LYCPD2Xfsmcv85ubXDUaFveexb0wqb18LTAp7G06DJmguXfto/rWESC6pOOWaZJBAv8I/bQIWV1V6bcOU7VfmXH3pkk40vg6009260pUIqoBVnWMNvBZ9RaEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208494; c=relaxed/simple;
	bh=qUqSSv3ifayW+xtWbyUpGpvV2Zozny15J74dw4n6dzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4sBQdou+m8AAEhTVTkJmwhnjslfnQ1wX/xlOGspzueupLnPzYf6CXlnaJSHhz3pqNt1MmKFE1Nwkdn/rIuqTFRV9V/tnmLFofUig5oGOuNYAKDpppbxp6WwMvYD/F1NP8/EZjlybdWiMwu617nY13OzxEumRHrotyQo4xmRh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7HtROlz; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7HtROlz"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5561d41fc96so6755431e87.1;
        Tue, 22 Jul 2025 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753208491; x=1753813291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1bfHAcPl/XMz8xDguK3teTl09r5v0kLVciBst2DtbI=;
        b=H7HtROlz+aCNBCEWL4P2T3zZjLURX5opQ92DGhXslcAW5Ke9jjPbnnNOTDStH9kzA5
         aNFyJy79XnPl5EjwK9ymx7CDr8FDnjm4G845TYzn1ctznvC8Ae8a+V8ObzvpRVRGkPDx
         JRlpsARcFsKUv4TRKpeRlQ383gKy4bwnqnc5FZ/Wg59ygoSgEcRMBcgSorw9Da1FU4lE
         LCEQAWZRUAHhCYhyXtvehGWRokMhcsz6muAiEQGwuvU7RTvN6jhzhICIVU9jowYitFGs
         uaYfUUhOHoOh5Cq3zvaBpr4jti1G8RJ6usgZ5/S4KmDRjIVhj4ydwreS7TwQqWVCFEs1
         phbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208491; x=1753813291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1bfHAcPl/XMz8xDguK3teTl09r5v0kLVciBst2DtbI=;
        b=jj/dvmibnm2XtzeZ2swtZJb6Zk/K7oANEkiKenutEHiUZIAh73Pbd9N21pUxWSRGo+
         3I2gV6veVyCDodsz4EBs49TrrWy5C59nEDtKnUCnRgDpeg+cKQbKDHw0m8lI4g6tWmro
         Vi/J++WrU7uG+vQQ8C3TbmGU/iQlPaBdJihUz66N1K0IRV3L5TERUs8Zp0roxOcF44hp
         MMn55ySbiePvxTbyZ3M0aJoXccXApGOt2NK8nGQYA48p2sgBfoI2ICLt0Qtu+mze+DCg
         GffoIJz5hZtw0fGj+iYDvd9SM4s8V3K2+OK40dTVyWlFAy0vh2xlev3902TLYE61Xhlh
         HYng==
X-Forwarded-Encrypted: i=1; AJvYcCUGpLYwdkBKhmytdHVEkRVQkFcJXjPmoiancQdXzuyYzZ3BAbm9HTCOTRmtpn+ba1S0J3cCdZXf749OO0E=@vger.kernel.org, AJvYcCUgHEmvjtazkEILwLpAd+tzQO8Hm3nfsqdlg92+zK9/IoA9vAx3VNVAL+ZqIINBv2DDAzTQPxUzVHAjYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PVeGwtLb6/RQQR/6ICPhWM7xS159Cs5oDh50lLY5ppnzmtTl
	4jihM1WIbdQLQy+h1sfI5xeX12fyUY8oypL+ALWdX67CdJKoUingguPm9N1iDDzqG7V5mrMF849
	hXEvR7jPuoJNDJ5vUWhtX/7Kaf5mqEjM=
X-Gm-Gg: ASbGnctI0lkaeSHWQHtrx8DWu5cH8QJgM94g/Soua5KZs+rbFhBRqOiRI2xQBNRI2Hw
	73xQ2t2PuUKh9dNkvUUg9fL7zYMkMR2odfehXptqumYcPoDj0R//T8GXzSjHLerme8D+JwcvlxB
	p5ve1zTjRhr4Adk+0KfHExSmGr7SsF/nR8+PDL0g1G3abifVVkG11jTPQaGvTnkjKFP1HLUaBI/
	krsAps=
X-Google-Smtp-Source: AGHT+IHgqZRO4CHZDXwO8i4qviF6GOSHLcIqgaK9MAu32BIYgiKkWD327bPslpy0X0mdn5DHRJd+TcwlCu2XTW4y0IA=
X-Received: by 2002:a05:6512:4021:b0:553:2190:fef8 with SMTP id
 2adb3069b0e04-55a513998a5mr31899e87.7.1753208490745; Tue, 22 Jul 2025
 11:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717142732.292822-1-snovitoll@gmail.com> <f10f3599-509d-4455-94a3-fcbeeffd8219@gmail.com>
In-Reply-To: <f10f3599-509d-4455-94a3-fcbeeffd8219@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 22 Jul 2025 23:21:13 +0500
X-Gm-Features: Ac12FXzOVMCIvnTEhZltt3TS4XKarYeDIkGkWcMAqG0GgJ62pPTw9Xni6fYiOgs
Message-ID: <CACzwLxjD0oXGGm2dkDdXjX0sxoNC2asQbjigkDWGCn48bitxSw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] kasan: unify kasan_arch_is_ready() and remove
 arch-specific implementations
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com, 
	agordeev@linux.ibm.com, akpm@linux-foundation.org, glider@google.com, 
	dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 3:59=E2=80=AFAM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
>
>
>
> On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
>
> > =3D=3D=3D Testing with patches
> >
> > Testing in v3:
> >
> > - Compiled every affected arch with no errors:
> >
> > $ make CC=3Dclang LD=3Dld.lld AR=3Dllvm-ar NM=3Dllvm-nm STRIP=3Dllvm-st=
rip \
> >       OBJCOPY=3Dllvm-objcopy OBJDUMP=3Dllvm-objdump READELF=3Dllvm-read=
elf \
> >       HOSTCC=3Dclang HOSTCXX=3Dclang++ HOSTAR=3Dllvm-ar HOSTLD=3Dld.lld=
 \
> >       ARCH=3D$ARCH
> >
> > $ clang --version
> > ClangBuiltLinux clang version 19.1.4
> > Target: x86_64-unknown-linux-gnu
> > Thread model: posix
> >
> > - make ARCH=3Dum produces the warning during compiling:
> >       MODPOST Module.symvers
> >       WARNING: modpost: vmlinux: section mismatch in reference: \
> >               kasan_init+0x43 (section: .ltext) -> \
> >               kasan_init_generic (section: .init.text)
> >
> > AFAIU, it's due to the code in arch/um/kernel/mem.c, where kasan_init()
> > is placed in own section ".kasan_init", which calls kasan_init_generic(=
)
> > which is marked with "__init".
> >
> > - Booting via qemu-system- and running KUnit tests:
> >
> > * arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results=
.
> > * x86_64 (GENERIC): no regression, no errors
> >
>
> It would be interesting to see whether ARCH_DEFER_KASAN=3Dy arches work.
> These series add static key into __asan_load*()/_store*() which are calle=
d
> from everywhere, including the code patching static branches during the s=
witch.
>
> I have suspicion that the code patching static branches during static key=
 switch
> might not be prepared to the fact the current CPU might try to execute th=
is static
> branch in the middle of switch.

AFAIU, you're referring to this function in mm/kasan/generic.c:

static __always_inline bool check_region_inline(const void *addr,

      size_t size, bool write,

      unsigned long ret_ip)
{
        if (!kasan_shadow_initialized())
                return true;
...
}

and particularly, to architectures that selects ARCH_DEFER_KASAN=3Dy, which=
 are
loongarch, powerpc, um. So when these arch try to enable the static key:

1. static_branch_enable(&kasan_flag_enabled) called
2. Kernel patches code - changes jump instructions
3. Code patching involves memory writes
4. Memory writes can trigger any KASAN wrapper function
5. Wrapper calls kasan_shadow_initialized()
6. kasan_shadow_initialized() calls static_branch_likely(&kasan_flag_enable=
d)
7. This reads the static key being patched --- this is the potential issue?

The current runtime check is following in tis v3 patch series:

#ifdef CONFIG_ARCH_DEFER_KASAN
...
static __always_inline bool kasan_shadow_initialized(void)
{
        return static_branch_likely(&kasan_flag_enabled);
}
...
#endif

I wonder, if I should add some protection only for KASAN_GENERIC,
where check_region_inline() is called (or for all KASAN modes?):

#ifdef CONFIG_ARCH_DEFER_KASAN
...
static __always_inline bool kasan_shadow_initialized(void)
{
        /* Avoid recursion (?) during static key patching */
        if (static_key_count(&kasan_flag_enabled.key) < 0)
                return false;
        return static_branch_likely(&kasan_flag_enabled);
}
...
#endif

Please suggest where the issue is and if I understood the problem.
I might try to run QEMU on powerpc with KUnits to see if I see any logs.
