Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA3C197A0
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345377AbjKPPD7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 10:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbjKPPD6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 10:03:58 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C3AD
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 07:03:55 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7781b176131so46006885a.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700147035; x=1700751835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEPBtVIehZENietqQgMRaLfueUPVKPaQSiz0lKmUCO4=;
        b=tjOM6T73bOgVHYQnAA8nPqN2GtcyJDN9hU/+eWFapfh9qsj6akbzxvTmB7mF5Xsmka
         hg3XoaWF5IkBAfSxhNko5AFheUYEtsWs4KMJOdbGTZCCleCHpXIeJwERsLSZR9umf9b0
         3AbtkJkBBZIAzfmAoO44j3SccK+pQzZDNf+e4RSpQ7Yh/ugPtLimqQjubpXdYByVtp89
         YtQOYiWnQhFPnFX+I0qcl1gzLpLqBWy4NcxihC+r5FJljUtckS4XxsEEx1TCc5qFlXA7
         KUHnqFXdEN3ELNVt2PzlBEDPoNRZir5EmW9FsKY2eR/1STbflbYrcDJBQYExSyJddJe8
         O39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700147035; x=1700751835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEPBtVIehZENietqQgMRaLfueUPVKPaQSiz0lKmUCO4=;
        b=dyQwCBfiMazW+DvodDkPUvY04ZBoFpQiNvgWCqUEIRe0afmrDQK73Tf4HYPtpAzgGv
         +fMu5R0/psuSYX10FuhjCFm84hnNxgTJ7geZ+pIScbSZYcZeD4WXELHDfpDOCxpbEX3E
         wvkLsWzaPIliLiUVLgSF0kSd3+bHzmh8uEmS7E6BpfyDLIu/Aft/mVLEKGP+Csbr9G9v
         pMyU9EwNUtOIBVZxXHmcQs6CUnknw6OGjDuYi/lnV1FiH/UOLHYlUGcyNgZlQke6Jkzn
         HeZEQvi9JlJmV8M9DsmHDy57wwYcW8j8Xom/N5lyUTNiQ+q56UbpqqxjYRq4QEthUFh+
         rdHg==
X-Gm-Message-State: AOJu0YxR3lhxsUwKiO5YB/v9yXxP/Xfg2aUIIHuGEa9mRmM2hrzUAthf
        70zVVGVGFHqEPWWIlTWVrcoEdUVJWuOWfNR67dmWoA==
X-Google-Smtp-Source: AGHT+IGm2krVDnKXXhSMoJn1uvqnmJEHLLH/sx6QaCvlfNlZK+ZHTBQsOV3/QFPtlz0RyiLxE6410dtEDy0WjvMczws=
X-Received: by 2002:ad4:4b6f:0:b0:66d:55d9:bc7b with SMTP id
 m15-20020ad44b6f000000b0066d55d9bc7bmr8646936qvx.31.1700147034569; Thu, 16
 Nov 2023 07:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-27-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-27-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 16:03:13 +0100
Message-ID: <CAG_fn=XSKh=AmU3mEC7dNmEFk5LaLt+y+TfsVcD0Dn5NsbTBSw@mail.gmail.com>
Subject: Re: [PATCH 26/32] s390/mm: Define KMSAN metadata for vmalloc and modules
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

On Wed, Nov 15, 2023 at 9:35=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> The pages for the KMSAN metadata associated with most kernel mappings
> are taken from memblock by the common code. However, vmalloc and module
> metadata needs to be defined by the architectures.
>
> Be a little bit more careful than x86: allocate exactly MODULES_LEN
> for the module shadow and origins, and then take 2/3 of vmalloc for
> the vmalloc shadow and origins. This ensures that users passing small
> vmalloc=3D values on the command line do not cause module metadata
> collisions.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/boot/startup.c        |  8 ++++++++
>  arch/s390/include/asm/pgtable.h | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
> index 8104e0e3d188..297c1062372a 100644
> --- a/arch/s390/boot/startup.c
> +++ b/arch/s390/boot/startup.c
> @@ -253,9 +253,17 @@ static unsigned long setup_kernel_memory_layout(void=
)
>         MODULES_END =3D round_down(__abs_lowcore, _SEGMENT_SIZE);
>         MODULES_VADDR =3D MODULES_END - MODULES_LEN;
>         VMALLOC_END =3D MODULES_VADDR;
> +#ifdef CONFIG_KMSAN
> +       VMALLOC_END -=3D MODULES_LEN * 2;
> +#endif
>
>         /* allow vmalloc area to occupy up to about 1/2 of the rest virtu=
al space left */
>         vmalloc_size =3D min(vmalloc_size, round_down(VMALLOC_END / 2, _R=
EGION3_SIZE));
> +#ifdef CONFIG_KMSAN
> +       /* take 2/3 of vmalloc area for KMSAN shadow and origins */
> +       vmalloc_size =3D round_down(vmalloc_size / 3, PAGE_SIZE);
Is it okay that vmalloc_size is only aligned on PAGE_SIZE?
E.g. above the alignment is _REGION3_SIZE.
