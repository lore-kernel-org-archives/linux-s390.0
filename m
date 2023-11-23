Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YwNiy1T7"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489BFD41
	for <linux-s390@vger.kernel.org>; Thu, 23 Nov 2023 00:23:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2802c41b716so546894a91.1
        for <linux-s390@vger.kernel.org>; Thu, 23 Nov 2023 00:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700727826; x=1701332626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxyQvllrMD+S9nUR2i6XqgEe1Uz/MXq2oi0l9PmN/sI=;
        b=YwNiy1T7grxEyt7Xng/CF/khp7hKSiJOPq8+ISS7jrggHEkeVI4+U5yXPVbKODTCUY
         GHAGIpA8eqVFeCLBwiwAem5PgAbEA79j6sMpL+6LciKiV/WbFK7TNY8DEqECZpuS4EsP
         EPwK3plzbk/yRQD/Uccbcb0SAVyBorQnpYoadIkVQse6tGjH0SEPt/BcIUGM0OEGyyIZ
         4FInmJ3ey/z9SE8npeQ8PXBSxxAlceFLup/3RlUNc4w8+lgcgrqufy2HP0lFrqX8VQp1
         c5RBN9NyCDYm0v4oDLnJfMcD6jHFtb/9VZlPQk4Z3/4mbHDyY7YTcU1oj57wPOchy8GM
         uRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727826; x=1701332626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxyQvllrMD+S9nUR2i6XqgEe1Uz/MXq2oi0l9PmN/sI=;
        b=Vajk+834mZ7ZJPeurz8DWYP/XrxvHDSbglk9slLueB7XYJgUEecu28eW/KTMK7pJcQ
         tNWzxfLboZnwmyQSa7L5bOv6zGoODaEIQFwo8rIqJLUL7vbia4o51uBJ6NykMjLdmT6d
         DNI2rlLWwHQAFMlML+JYWMQPanKYgNWdnIWdiXiZn7q5SsZ+ms9HsjYQO6nFZRg4OY9z
         5cG5YWEMzxzHVHk5oeaSMBJlN1O5c3RQN43NAUG2Z9nEABgn4THrHxr2VzQFDjZ5uclH
         49iKRjAlcOMfb1IsALRBBXi0UzUgmvU8894rPaTL/jSe6fwt1DHON9RTLezKZ8DRGfZb
         KwkQ==
X-Gm-Message-State: AOJu0YyIN8aepZsncN/hsYXZZYybGX8vVZszXCPb+s9CUoH9F81BALC+
	X+t5ZqkRhTyuqbrNzBUUHtIJoHqhUExDUVMLjSJNdw==
X-Google-Smtp-Source: AGHT+IFi7qsrLCSSOcApqa1ERtzIeHUoDbf3aFgi2HK5T0smIgc+93Gp6aWh+OLekkrorVduK4kKcUAuqv35kcpbqDE=
X-Received: by 2002:a17:90b:3803:b0:27d:882f:e6c5 with SMTP id
 mq3-20020a17090b380300b0027d882fe6c5mr4440955pjb.9.1700727825600; Thu, 23 Nov
 2023 00:23:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123073652.507034-1-bhe@redhat.com> <20231123073652.507034-2-bhe@redhat.com>
In-Reply-To: <20231123073652.507034-2-bhe@redhat.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Thu, 23 Nov 2023 08:23:34 +0000
Message-ID: <CALrw=nEO3A2MPeSXhO3=cPdrAFB07sQcnjNN5V5jj2YcqAZ+bQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
	akpm@linux-foundation.org, eric_devolder@yahoo.com, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 7:37=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Ignat Korchagin complained that a potential config regression was
> introduced by commit 89cde455915f ("kexec: consolidate kexec and
> crash options into kernel/Kconfig.kexec"). Before the commit,
> CONFIG_CRASH_DUMP has no dependency on CONFIG_KEXEC. After the commit,
> CRASH_DUMP selects KEXEC. That enforces system to have CONFIG_KEXEC=3Dy
> as long as CONFIG_CRASH_DUMP=3DY which people may not want.
>
> In Ignat's case, he sets CONFIG_CRASH_DUMP=3Dy, CONFIG_KEXEC_FILE=3Dy and
> CONFIG_KEXEC=3Dn because kexec_load interface could have security issue i=
f
> kernel/initrd has no chance to be signed and verified.
>
> CRASH_DUMP has select of KEXEC because Eric, author of above commit,
> met a LKP report of build failure when posting patch of earlier version.
> Please see below link to get detail of the LKP report:
>
>     https://lore.kernel.org/all/3e8eecd1-a277-2cfb-690e-5de2eb7b988e@orac=
le.com/T/#u
>
> In fact, that LKP report is triggered because arm's <asm/kexec.h> is
> wrapped in CONFIG_KEXEC ifdeffery scope. That is wrong. CONFIG_KEXEC
> controls the enabling/disabling of kexec_load interface, but not kexec
> feature. Removing the wrongly added CONFIG_KEXEC ifdeffery scope in
> <asm/kexec.h> of arm allows us to drop the select KEXEC for CRASH_DUMP.

Hm... With the patch, when cross compiling for arm and
CONFIG_KEXEC_CORE=3Dy
# CONFIG_KEXEC is not set
CONFIG_CRASH_DUMP=3Dy

I get the following linker error at the end:

  CALL    scripts/checksyscalls.sh
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.kallsyms1
arm-linux-gnueabi-ld: kernel/kexec_core.o: in function `kimage_free':
kexec_core.c:(.text+0xf5c): undefined reference to `machine_kexec_cleanup'
arm-linux-gnueabi-ld: kernel/kexec_core.o: in function `__crash_kexec':
kexec_core.c:(.text+0x15bc): undefined reference to `machine_crash_shutdown=
'
arm-linux-gnueabi-ld: kexec_core.c:(.text+0x15c4): undefined reference
to `machine_kexec'
arm-linux-gnueabi-ld: kernel/kexec_core.o: in function `kernel_kexec':
kexec_core.c:(.text+0x1a04): undefined reference to `machine_kexec'
make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
make[1]: *** [/home/ignat/git/linux-upstream/Makefile:1154: vmlinux] Error =
2
make: *** [Makefile:234: __sub-make] Error 2

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm/include/asm/kexec.h | 4 ----
>  kernel/Kconfig.kexec         | 1 -
>  2 files changed, 5 deletions(-)
>
> diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
> index e62832dcba76..a8287e7ab9d4 100644
> --- a/arch/arm/include/asm/kexec.h
> +++ b/arch/arm/include/asm/kexec.h
> @@ -2,8 +2,6 @@
>  #ifndef _ARM_KEXEC_H
>  #define _ARM_KEXEC_H
>
> -#ifdef CONFIG_KEXEC
> -
>  /* Maximum physical address we can use pages from */
>  #define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
>  /* Maximum address we can reach in physical address mode */
> @@ -82,6 +80,4 @@ static inline struct page *boot_pfn_to_page(unsigned lo=
ng boot_pfn)
>
>  #endif /* __ASSEMBLY__ */
>
> -#endif /* CONFIG_KEXEC */
> -
>  #endif /* _ARM_KEXEC_H */
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 7aff28ded2f4..1cc3b1c595d7 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -97,7 +97,6 @@ config CRASH_DUMP
>         depends on ARCH_SUPPORTS_KEXEC
>         select CRASH_CORE
>         select KEXEC_CORE
> -       select KEXEC
>         help
>           Generate crash dump after being started by kexec.
>           This should be normally only set in special crash dump kernels
> --
> 2.41.0
>
