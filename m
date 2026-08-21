Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0E355F57
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297937; cv=none; b=mtnaiVGjaKvik5C3idN5EYM9hvdxIvpGN+s8JEe9z184OUO/TPhjxUnec3PC6he77ENJ+nfWSpLmT7+uyZcvdAjXfl7YvIxv8ybyFAq/sHtQQw8J6Jyj2WeobtVkABvqbiVF5++8e8tm1sqS9SfKz1Zw8Nzy2Pg6pPzsZGO6SfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297937; c=relaxed/simple;
	bh=VCOkteLiKt0ZZORXwOZNq9+Pti3s405UXxblWwP6SOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDiNhECNjwNWMCxqowVMKe3D9pxvo51FjgKN58JgbfLZo41grp9jBJTsnT8yKwAqAoRl2OVR9TjUGMP0443hjfKVMkRQGO7uNxfLSLIYkI2rx8tj5C7Ci7yh7Ek/Abr8XdVucOwsYFfFpwz0+ooCAYRuZvz8lpRCjMc5Ko1//i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9674d727c0aso1502309241.1
        for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 00:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787297932; x=1787902732;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YxslOCxTsNpYWz0xH5p+/EHLwQRWaj5GV5I5Lejizuk=;
        b=nGdt0Z9l0ixSPtlK4hB9Mh4L6myuecGfheJgIDcGXG+30ZONCTou9Fnr0vkzJ838GO
         cvnbkhVA+hUHfCAPg/iUhT3eH9m0VWyptNFlKCwoCmH6aW72kPvRz++gHDpVCWdb7t3C
         /G3dvUbWau6MIcD39BvAmXQxh+evvglJ6yZc2+F+srLjkOSqiJEywbF8Ixs2eg1btxjH
         nsMGxW1fJ22IqaOGGqoBqBOxsWNvyyNeYCkIWtuRE4l6I+8jeISAsG759Pmw5BvLBTbl
         lKIVRVGP9M0IqsE5Ibt0fMBZmnUfkXSdgxqqnnAwujmFaqdODbROuBaMkzqyZYT/t7Ei
         t+6g==
X-Forwarded-Encrypted: i=1; AHgh+RooyUs2ABC1dPEo+/pYL30lvenRKdwveaJwxeVj8gSglUDGH6t3ddVBA2238glSCCpgpihT6gj4/Jp9@vger.kernel.org
X-Gm-Message-State: AFuF++lieyJJEGkWRDyYnagu1YrK1cs/p221SaukDq2ixgWuI4wazhtS
	aQw6qdG/NAH4PxTc9me6vkJ28rQU5nS5Sb4u2dwg+PY2IvXDIUK7bIQtJ/cJBgM5
X-Gm-Gg: AR+sD10wlpSg/O1xvUf6YzwcYhgOg/cmGff1g2ZSJWtqVtsrkzb2jcszvVv3JLthfT2
	3IwH74pwPOWm3wh/x1n4Gr5GQxvEtUE75PjJkw9SQ4OR1pEFu60gZf3/2K7VG53AisYP5HwINze
	yzDM0u74O3pvYW1hWYixnXokZg7OXe6r5NS2UiXDzAdsmT7dAU6T/83UA35U4tnL/bbEkH1nOFc
	tknthkf9oMuhjAIYUVgbiNcpPbpPSo+afOHIOMcehyO1gki3LgVnpl4d5j04RuKoOEPmbXQtF9/
	lgjZsLy3Go2MmxFtbXKb9HNjVO7R/2ehAMPZ0i9IId3kCbCkIucM1wRsJEnQJ/owCs0taFDTMR7
	Vq0HzZq9gBNxwVsX1PDAZhbHwC/gJkgzvtPZ5OTd8Ae8Ey0gkeH0ZDNL5+DjrjeAdIY4crSZlvc
	ogDaB8Ch+zx89Uq8NXdgbIE2XiKityQ2+xb0pFsXUCGwTtlv9tZ1Q+iAK0PsrrgcaO4qjPWziko
	lvYI9YGx1bG/00IegCR3iIrwMw6OPw=
X-Received: by 2002:a05:6102:325c:20b0:745:3eb9:8de8 with SMTP id ada2fe7eead31-778f37da7bamr2394168137.17.1787297931977;
        Fri, 21 Aug 2026 00:38:51 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c4e7dd648sm8411032241.6.2026.08.21.00.38.51
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 00:38:51 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7737a1f65c0so565279137.1
        for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 00:38:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrrTK3t7LFcbnhXhADhXM95BN2guVSuQCLNKcrysa+4ZEVIKE6bOJ08MB7hJTEVWRawPhIbBUS6efuH@vger.kernel.org
X-Received: by 2002:a67:e018:0:20b0:773:2805:4ad1 with SMTP id
 ada2fe7eead31-778f2cd6fd7mr2276810137.11.1787297931367; Fri, 21 Aug 2026
 00:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820124649.143863-1-ailiop@suse.com>
In-Reply-To: <20260820124649.143863-1-ailiop@suse.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Aug 2026 09:38:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXyk=FUX0747qoONU3XFXF-4ijM_HZnS=9=gtzxaVqdrg@mail.gmail.com>
X-Gm-Features: AcwNN1WGpochy-1GGMYjutXPFFLovKue_EC8XsygPRAbcLxb2rhu9D3jNDQFOfg
Message-ID: <CAMuHMdXyk=FUX0747qoONU3XFXF-4ijM_HZnS=9=gtzxaVqdrg@mail.gmail.com>
Subject: Re: [PATCH] s390: remove unused setup_profiling_timer function
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anthony,

Thanks for your patch!

On Fri, 21 Aug 2026 at 08:05, Anthony Iliopoulos <ailiop@suse.com> wrote:
> setup_profiling_timer() is not used by any code at this point. Since a

It is used by write_profile()
https://elixir.bootlin.com/linux/v7.2/source/kernel/profile.c#L202

> default weak implementation exists, there is no need to keep this
> arch-specific definition around. Remove it along with the now-redundant
> profile header includes.
>
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -980,17 +980,6 @@ void __init smp_setup_processor_id(void)
>         lc->spinlock_index = 0;
>  }
>
> -/*
> - * the frequency of the profiling timer can be changed
> - * by writing a multiplier value into /proc/profile.
> - *
> - * usually you want to run this on all CPUs ;)
> - */
> -int setup_profiling_timer(unsigned int multiplier)
> -{
> -       return 0;

Just like on SH, this returns zero (success), while the default weak
implementation returns -EINVAL, so your change breaks write_profile().
https://elixir.bootlin.com/linux/v7.2/source/kernel/profile.c#L181

> -}
> -
>  static ssize_t cpu_configure_show(struct device *dev,
>                                   struct device_attribute *attr, char *buf)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
