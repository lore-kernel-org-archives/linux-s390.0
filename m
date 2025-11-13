Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA36C3218A6
	for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067185; cv=none; b=UG0gS1li+YaVLVqe70kyviPKcCkfkt41WY/nCHqqconZ+1cqKwtHH2gv6amSRXoc6KlDXzeIdResqibydpHnTiu+fM0/QFxl6p4wPNjQ38YZ5Zbjfptlo3q9Yk9HErqkKpC7hxOhTtTwwOPGpwvNu0lOeFdXSaNfnAMLD6ukIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067185; c=relaxed/simple;
	bh=vn8ogXe0YRKcmMRM5WxtTx4YwW0ig83RgedzyLS2RGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdTOnwdvfIOVzOAiuzEidj67ZD4nX/n373MUA0/uUeuT9FjBTl+pUvgoP/YgtVG8uj3uXQVVSfEZOgeNNERc7O5QW5C4yHjhximwMNAgXkDXqIk/yR8KVXk6fmcoV/vGnoxkKupkWrtn3StOLTxphnJVSuZFRmo8X69gq1Ihi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa2jIiVK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa2jIiVK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso1035956f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 12:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763067182; x=1763671982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHKi2c90qWan2zC8wuUwIw9LkqFuCkHgH6vXrVkAv64=;
        b=Wa2jIiVKo5AvPrCIowtEtbI5X1DHUo2c16US1Ne6ojmfnoGo7QHkVKbD/YjQghqZ3n
         8G/7R9gQoLTG49gDXFLVs78/vBJ0DRP5PH6kZZaicbGzudH8rwd2PKee+3UiOnhUVP+S
         NbUiKY68uXqNk4maH89wJ4h38P/p4bHgKmQzQhk2wdF9zlPiEntEI22M+Ul/OXTk7acv
         Q9AH4hats/Tmr9/6J08mE0zLENSowXMe60uWmmdGnE2zsmWlXptZFlAsQznqxH5fgyGg
         aRGT2oQTkVRt/0CfNmtJzx/T3PLe+v7geDuIjam+DhqhpANnpJSVSai9W1ZQkHW9vzuP
         hUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763067182; x=1763671982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GHKi2c90qWan2zC8wuUwIw9LkqFuCkHgH6vXrVkAv64=;
        b=DZfz78EP5ufbVAJe2hkJrH9NsRyblykcJ/RUK+hOfMaH5A7vdDl+V/zz+0CfD+b9jH
         jVsPceZQbtNXOUNr9t3xVawr/IihB7u8gzFMuJiaeYw9VSKagjITk0tzhQItLBXVIDtw
         8LdJehrMzZyx9RlgTDE/H3j9V2jN8G6mkRQGbIxBH2tQn6FMMI/Rg6n1s3gyY7xX4Woo
         jPY1MHu5Cb8YKJVvKChkEWma3grWJqfZAkE9gACNrzPcKrA4ZeSR1GRYQGinEyXU0cFS
         DYRzulx/OvyeCcIbRxFBw0Sk9M63kx+lskn/rdr6Y9zdHex8qYw4rmaw7QVfajtnWD2K
         mFNA==
X-Forwarded-Encrypted: i=1; AJvYcCUYLUyjZc0zIgEZIEPCfeFfPCbg4NETxraEkOItcN5sA5ZO/k4ESbWb5IukCdfYXC4+bDrUpH8MDQGC@vger.kernel.org
X-Gm-Message-State: AOJu0YwNeX0hFPkqFXgwTgH+Od0mzZFAlvBffMGEX6xTpzco09G0xteS
	m9/DUsGr3lg0RCFbYinJJmTlgYqPUspkXKyeoTuv2UTx7e6f2eU3DLBvDlbg7EbqQTupvxtm5vE
	mW8QF+Fm2Grub5EGiQZq5FEVJjwUTDyA=
X-Gm-Gg: ASbGncvhxokTXIbi6QSF/hOTVUvzixuFj5FpFlHpIgW5VogaX7luiNqlWBuzQ32zU+W
	y2G+XwklkxOV9oe/g2He45ALT451OH1S/U1fHKK2E5W//a7r3ZC5akxJo6wJfzjZc8n11NLkw8f
	vllYawkJ3BT3dWv1HmEjrlLYs+HgACXKrok4/yO+d+z1ZKfG9LsAXK3AAZEtFzWPjcI3d35uEfn
	O/IYzvlMi3gKtHiE7JY2U4BN5/gZlcqZ+onGLcQxFP0Vmd82aVDk5+mGwBs5v2FC8Z8daLuqD1+
	wamPdtUgqPM=
X-Google-Smtp-Source: AGHT+IEh2RPALHpzP1laCRjEn74cXco6+h6l7pCThRZl/oBRXiZdCsuqesx010gucWniBZ2zilstwr8JbIHw7BaggNE=
X-Received: by 2002:a05:6000:61e:b0:42b:43cc:9830 with SMTP id
 ffacd0b85a97d-42b59378e03mr609835f8f.41.1763067181851; Thu, 13 Nov 2025
 12:53:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113150731.2697279-1-hca@linux.ibm.com> <20251113150731.2697279-5-hca@linux.ibm.com>
In-Reply-To: <20251113150731.2697279-5-hca@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Nov 2025 12:52:48 -0800
X-Gm-Features: AWmQ_bmN-cbqPx2gFrxymdsLCU9xoAafHvPPBzOYfUaJ1Cen9t3ei6asriXby8M
Message-ID: <CAADnVQL4cERs+hYmQ818a6LRGKLdcObD2+WReATyhpoRjrE8JQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] tools: Remove s390 compat support
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:08=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> Remove s390 compat support from everything within tools, since s390 compa=
t
> support will be removed from the kernel.
>
> While removing s390 compat code replace __s390__ ifdef guards with
> __s390x__ everywhere. Even though this is not strictly required this
> makes it easier to spot s390 compat code support leftovers.
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  .../arch/s390/include/uapi/asm/bitsperlong.h  |  4 --
>  tools/include/nolibc/arch-s390.h              |  5 ---
>  tools/include/nolibc/arch.h                   |  2 +-
>  tools/lib/bpf/libbpf.c                        |  4 --
>  tools/lib/bpf/usdt.c                          |  2 -
>  .../testing/selftests/nolibc/Makefile.nolibc  |  5 ---
>  tools/testing/selftests/nolibc/run-tests.sh   |  6 +--
>  tools/testing/selftests/rseq/rseq-s390.h      | 39 -------------------
>  tools/testing/selftests/vDSO/vdso_config.h    |  4 --
>  9 files changed, 2 insertions(+), 69 deletions(-)
>
> diff --git a/tools/arch/s390/include/uapi/asm/bitsperlong.h b/tools/arch/=
s390/include/uapi/asm/bitsperlong.h
> index d2bb620119bf..a226a1686a53 100644
> --- a/tools/arch/s390/include/uapi/asm/bitsperlong.h
> +++ b/tools/arch/s390/include/uapi/asm/bitsperlong.h
> @@ -2,11 +2,7 @@
>  #ifndef __ASM_S390_BITSPERLONG_H
>  #define __ASM_S390_BITSPERLONG_H
>
> -#ifndef __s390x__
> -#define __BITS_PER_LONG 32
> -#else
>  #define __BITS_PER_LONG 64
> -#endif
>
>  #include <asm-generic/bitsperlong.h>
>
> diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch=
-s390.h
> index df4c3cc713ac..0a39bee261b9 100644
> --- a/tools/include/nolibc/arch-s390.h
> +++ b/tools/include/nolibc/arch-s390.h
> @@ -143,13 +143,8 @@
>  void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_prot=
ector _start(void)
>  {
>         __asm__ volatile (
> -#ifdef __s390x__
>                 "lgr    %r2, %r15\n"          /* save stack pointer to %r=
2, as arg1 of _start_c */
>                 "aghi   %r15, -160\n"         /* allocate new stackframe =
                       */
> -#else
> -               "lr     %r2, %r15\n"
> -               "ahi    %r15, -96\n"
> -#endif
>                 "xc     0(8,%r15), 0(%r15)\n" /* clear backchain         =
                       */
>                 "brasl  %r14, _start_c\n"     /* transfer to c runtime   =
                       */
>         );
> diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
> index 426c89198135..ef4743aad188 100644
> --- a/tools/include/nolibc/arch.h
> +++ b/tools/include/nolibc/arch.h
> @@ -27,7 +27,7 @@
>  #include "arch-powerpc.h"
>  #elif defined(__riscv)
>  #include "arch-riscv.h"
> -#elif defined(__s390x__) || defined(__s390__)
> +#elif defined(__s390x__)
>  #include "arch-s390.h"
>  #elif defined(__loongarch__)
>  #include "arch-loongarch.h"
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index dd3b2f57082d..85abc357da31 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11325,8 +11325,6 @@ static const char *arch_specific_syscall_pfx(void=
)
>         return "ia32";
>  #elif defined(__s390x__)
>         return "s390x";
> -#elif defined(__s390__)
> -       return "s390";
>  #elif defined(__arm__)
>         return "arm";
>  #elif defined(__aarch64__)
> @@ -12113,8 +12111,6 @@ static const char *arch_specific_lib_paths(void)
>         return "/lib/i386-linux-gnu";
>  #elif defined(__s390x__)
>         return "/lib/s390x-linux-gnu";
> -#elif defined(__s390__)
> -       return "/lib/s390-linux-gnu";
>  #elif defined(__arm__) && defined(__SOFTFP__)
>         return "/lib/arm-linux-gnueabi";
>  #elif defined(__arm__) && !defined(__SOFTFP__)
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index c174b4086673..d1524f6f54ae 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -1376,8 +1376,6 @@ static int parse_usdt_arg(const char *arg_str, int =
arg_num, struct usdt_arg_spec
>
>  #elif defined(__s390x__)
>
> -/* Do not support __s390__ for now, since user_pt_regs is broken with -m=
31. */
> -
>  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_=
arg_spec *arg, int *arg_sz)
>  {
>         unsigned int reg;

for bpf bits
Acked-by: Alexei Starovoitov <ast@kernel.org>
