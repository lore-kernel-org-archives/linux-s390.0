Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GEZd4owe"
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2CABC
	for <linux-s390@vger.kernel.org>; Thu, 23 Nov 2023 00:34:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28397a2c402so505673a91.2
        for <linux-s390@vger.kernel.org>; Thu, 23 Nov 2023 00:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700728467; x=1701333267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwJpO+HiDZw/9/oXGeHCL3JIdqDb9YbJK2ol1m1T6nA=;
        b=GEZd4oweSHcp4kBEPXdvoaKGWXqivQgFLMznVgBnMsjhFPbA5Bp2Vs+YfxkX4uaRRr
         fCcbCQNNsmAiXN8IHGz/QwNCZpWkdN1Ex2VzzFMrtVU2pcC6ObbB+65M690mPdZyWHdc
         Y3hDgTfiOoG2fjlYlC0434HBqYuwH88O4ZwvEcQryyzubdTzs33zkhNY7l+DLe+SNJqY
         LnKNkS0tJ6uxDaGlTbh7kXUin3+vU7gffK7S8gRmJ6g9WJOdrZ8hf/Maom9cUx4/PrIj
         ak2Ze5daHXMF8/7Qg42qdYoBArqK+CSr0nvugrxknddekveyYkFCqlSm6alGbJp4e1Tv
         vbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700728467; x=1701333267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwJpO+HiDZw/9/oXGeHCL3JIdqDb9YbJK2ol1m1T6nA=;
        b=CB9vDnkdehkgKFxnZJIvsI+ZmyGOeSs5vFwZhiNDVfgZjb9r/KeLFywRzlEbdPVxnC
         1jJKe+5T6qSmMzp4RFZttBVwgR0C52Lwb6+6WPuEVg+gLcrll6AwwnGnFU4eWNX4vwKW
         F7osNGHrSmuEYWyioediQVeFta29KyAK6/T1HRF24avSs3ASNSr/5y5VikZdAiBe15T9
         whIJQQfqrCS8PcRSeTe2sSdfCPuS/hkBQALhYzGm2mzyjNTFAt83+PnInlKGR1zS/dP3
         k+mqdS7XeHUf++fTBxSXpetFlBxUMClmiivsGjqE43cqADefWGM5ruy44BfgZb31Eosf
         bysg==
X-Gm-Message-State: AOJu0YyBjuAcBed7Y8s7hyqrqSO+2C8lJ9yp9Mv8YS7aLLLMgMGCZXZL
	IyqUT8p9pYmnKTtwTcBX3cS6uaDrVSTOAHcs/2vB+A==
X-Google-Smtp-Source: AGHT+IHv8tVmYrr0nVNwRf4ArxBSj2WKhPiPUlG/rnS4yd9QZHgWaaWGkAsHvCntxohQ4dGYjeVUfzjGlT4Y0zoZ7IY=
X-Received: by 2002:a17:90b:350c:b0:280:4829:52cc with SMTP id
 ls12-20020a17090b350c00b00280482952ccmr5402011pjb.37.1700728467437; Thu, 23
 Nov 2023 00:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123073652.507034-1-bhe@redhat.com> <20231123073652.507034-3-bhe@redhat.com>
In-Reply-To: <20231123073652.507034-3-bhe@redhat.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Thu, 23 Nov 2023 08:34:16 +0000
Message-ID: <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
	akpm@linux-foundation.org, eric_devolder@yahoo.com, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 7:37=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> When below kernel config items are set, compiling error are triggered.
>
> CONFIG_CRASH_CORE=3Dy
> CONFIG_KEXEC_CORE=3Dy
> CONFIG_CRASH_DUMP=3Dy
> CONFIG_CRASH_HOTPLUG=3Dy
>
> ------------------------------------------------------
> drivers/base/cpu.c: In function =E2=80=98crash_hotplug_show=E2=80=99:
> drivers/base/cpu.c:309:40: error: implicit declaration of function =E2=80=
=98crash_hotplug_cpu_support=E2=80=99; did you mean =E2=80=98crash_hotplug_=
show=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>   309 |         return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support(=
));
>       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                        crash_hotplug_show
> cc1: some warnings being treated as errors
> ------------------------------------------------------
>
> CONFIG_KEXEC is used to enable kexec_load interface, the
> crash_notes/crash_notes_size/crash_hotplug showing depends on
> CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
>
> Fix it now.

Can we add Fixes/CC stable, so it gets eventually backported into 6.6?

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  drivers/base/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 9ea22e165acd..548491de818e 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -144,7 +144,7 @@ static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_releas=
e_store);
>  #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
>  #endif /* CONFIG_HOTPLUG_CPU */
>
> -#ifdef CONFIG_KEXEC
> +#ifdef CONFIG_KEXEC_CORE
>  #include <linux/kexec.h>
>
>  static ssize_t crash_notes_show(struct device *dev,
> @@ -189,14 +189,14 @@ static const struct attribute_group crash_note_cpu_=
attr_group =3D {
>  #endif
>
>  static const struct attribute_group *common_cpu_attr_groups[] =3D {
> -#ifdef CONFIG_KEXEC
> +#ifdef CONFIG_KEXEC_CORE
>         &crash_note_cpu_attr_group,
>  #endif
>         NULL
>  };
>
>  static const struct attribute_group *hotplugable_cpu_attr_groups[] =3D {
> -#ifdef CONFIG_KEXEC
> +#ifdef CONFIG_KEXEC_CORE
>         &crash_note_cpu_attr_group,
>  #endif
>         NULL
> --
> 2.41.0
>
