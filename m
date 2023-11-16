Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FC6C54FB9
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 10:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjKPKww (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 05:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjKPKwv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 05:52:51 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E51AE
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 02:52:47 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67089696545so3408246d6.0
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 02:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700131967; x=1700736767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqJIzLc+e20w+CyJG0SPGKCmTSYxEHr4GKar1orgi4U=;
        b=FE0s2wm3PmLua//p/e6XeGXDBaBgpoIisWXgbbZ5mPjkMSBQC7CEyO+6TNpUNv7s1/
         rHuwLKDsX5oiijkhLGSZwdvMRdE+ecRQ1Rbt+AIsm06WeYbvLEUjMjXlrUp3UBupjrRm
         ydjRq4eXz9MyZBeqaPl8jw62q2i5MT8GahCq92hS8yq/K5DPgSmeAVYs/lj08i11FamG
         W8h3gMqbrBziHmzPGINlxZzJ6qUkKre7OiCdRNdYHhnGYGO/NCs6NxBCXTOIW/2OFhvk
         vWxT9MJxOgMG8ZSPINm5VSSMiigVpIc//xg8L2ZiNt/O6SsYnHuyJp+lV3sf1ubvM2og
         k+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131967; x=1700736767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqJIzLc+e20w+CyJG0SPGKCmTSYxEHr4GKar1orgi4U=;
        b=Jzgz0LT/WV+RIBfViAGrFhIT/xMV0H0ZFlMCMf1gd/n6G8q9dnZSc9IHa3qCUWJYzK
         wrUH0cas1YUbXmp4gUpMEavXYw9MuSLKisY/9lrtyDKsZTKlyXRUB+GVfec07hvRZ3Sk
         1XaE6Fp9V8gF/Z+YJFVKoj7iQv3VKulU+iQj/9eJ/97eVcqJqR1Ahq96Pms9FyHWi0rk
         rFRqKY0AxBsEgGDecAKiD21FIal+qCtHcH9WN1WxPwTYs76YTBQM7fy3Htagr1n2LMvY
         MaQyt9XaNFMaY9/Hcwmo++PXKErKXxmui3STyCAyBon7P3oxsnkDeeYtogeqnk50RjP3
         cUJQ==
X-Gm-Message-State: AOJu0YxYYG/sG5bY5fyVoPmeRJPOwV0tQPL4Dt5qCknirVt7ktf7x8dA
        rRhQHfxwU2GkBQc3Qw2Ftc8MfM5LnV626wFdJwCbQA==
X-Google-Smtp-Source: AGHT+IFL6OuFCAHtWGk+M6NysNl0dEVVN94VlaoyeFHRURNLqxhoGD85IALw3+5v3xQOWTXOZjFb/jzqyV+sTc8GtMo=
X-Received: by 2002:ad4:5990:0:b0:675:58de:b59a with SMTP id
 ek16-20020ad45990000000b0067558deb59amr7530365qvb.65.1700131966900; Thu, 16
 Nov 2023 02:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-8-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-8-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 11:52:10 +0100
Message-ID: <CAG_fn=WcuQxB6ZRKwi221EM-QsEfJ7udyQg9W_z0jv9nFCB89A@mail.gmail.com>
Subject: Re: [PATCH 07/32] kmsan: Remove a useless assignment from kmsan_vmap_pages_range_noflush()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> The value assigned to prot is immediately overwritten on the next line
> with PAGE_KERNEL. The right hand side of the assignment has no
> side-effects.
>
> Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operati=
ons")
> Suggested-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kmsan/shadow.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index b9d05aff313e..2d57408c78ae 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -243,7 +243,6 @@ int kmsan_vmap_pages_range_noflush(unsigned long star=
t, unsigned long end,
>                 s_pages[i] =3D shadow_page_for(pages[i]);
>                 o_pages[i] =3D origin_page_for(pages[i]);
>         }
> -       prot =3D __pgprot(pgprot_val(prot) | _PAGE_NX);
>         prot =3D PAGE_KERNEL;

This bug dates back to 5.1-rc2, when KMSAN didn't exist upstream.
The commit introducing vmap support already had it:
https://github.com/google/kmsan/commit/3ff9d7c640d378485286e1a99d85984ae690=
1f23
I don't remember what exactly required the more relaxed PAGE_KERNEL
mask though :)
