Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQLmIfQt"
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866DC19A6
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 05:52:32 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67ad891ff36so11505416d6.1
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702043551; x=1702648351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxr02EuEVtCzgI9ve8IFgXJLU7RV4njnkPo6roz6Un8=;
        b=hQLmIfQtUoPQQ/g+M5NJHOhVTMi/Y1THsU954vbcdOtOpsMso+OHDAraBpSrghwm6X
         hyRdY+0nNT10aK7nqithEl8x0VivxxO2wa8iWpkYu8N0wJySjvyybUMiHtALeboehjK7
         MJsWYYiCp5GTIgoK4QC2XBz8cPnaAhiCejIZO1t3erzBBvvJS0k0rWlEm1EhFGiTcdLY
         VzTxiNqyLN28it/3bvasse2L56XyRxai+4CokEYrmDjQQuay6iPNgNWh1v8EBs414WpX
         aIbz+mYhqt3TCAa1RZRNS3pck3BgaUsa8gl3aDi2CGScowdgfqysa8c6asPTGfA/DsIT
         m6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043551; x=1702648351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxr02EuEVtCzgI9ve8IFgXJLU7RV4njnkPo6roz6Un8=;
        b=F7P/QKcCmkkClBnuDFad2+rbZmYAVwDT7bwMb1v1ISDRAGVYnsrKgDAPyUNjcYYrCx
         RqCWCXkYxCq480et//e/laCiTLCwPaKuf2QgYS544vuqGziE1YCJ8SIGD7RGVWp7/3DO
         zolLerrmJj26VncbEQbVkOWPXk21P57JHYnvoiXQ+Jacl8aNiuLWe+Q/cQwRP+V3ioLL
         ZybMT/S3N1HjSHpMk37IXOYyur5o/cK1ogvdDTx8wuaZ4JZTKklsVG/bHd1ob50dPCIx
         1B8XCI4Zm0EJDpCXH/75mSrTEx22ADIv6X7p1aINdxzlOKTPVrD/If1XsZZtU7piW8b9
         kLmw==
X-Gm-Message-State: AOJu0YxEFWBOYPppgsMo4aqxRsVRDW8tkykbY8O3bQeZLZPYG4Gf9Cnh
	gJ5SKYX605E33fOVP0EvIQoppDAr/G3ZC8ZtmURC/g==
X-Google-Smtp-Source: AGHT+IE6sRnpL+taCI8PmNwlcDfKw8+NbZCU4p6sDWRNgt5aul5bA5OudQ9MrHnc4a/zgth0bHWfV2d1K6PDTg15VRA=
X-Received: by 2002:ad4:50c8:0:b0:67a:d049:bd31 with SMTP id
 e8-20020ad450c8000000b0067ad049bd31mr4464764qvq.72.1702043551094; Fri, 08 Dec
 2023 05:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-15-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-15-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 14:51:51 +0100
Message-ID: <CAG_fn=Vmp70auiTCZCtjhsC_vwnqPLsz_wn12cWd2iU-T5By8g@mail.gmail.com>
Subject: Re: [PATCH v2 14/33] kmsan: Support SLAB_POISON
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Avoid false KMSAN negatives with SLUB_DEBUG by allowing
> kmsan_slab_free() to poison the freed memory, and by preventing
> init_object() from unpoisoning new allocations. The usage of
> memset_no_sanitize_memory() does not degrade the generated code
> quality.
>
> There are two alternatives to this approach. First, init_object()
> can be marked with __no_sanitize_memory. This annotation should be used
> with great care, because it drops all instrumentation from the
> function, and any shadow writes will be lost. Even though this is not a
> concern with the current init_object() implementation, this may change
> in the future.
>
> Second, kmsan_poison_memory() calls may be added after memset() calls.
> The downside is that init_object() is called from
> free_debug_processing(), in which case poisoning will erase the
> distinction between simply uninitialized memory and UAF.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  mm/kmsan/hooks.c |  2 +-
>  mm/slub.c        | 10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 7b5814412e9f..7a30274b893c 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -76,7 +76,7 @@ void kmsan_slab_free(struct kmem_cache *s, void *object=
)
>                 return;
>
>         /* RCU slabs could be legally used after free within the RCU peri=
od */
> -       if (unlikely(s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)))
> +       if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
>                 return;
>         /*
>          * If there's a constructor, freed memory must remain in the same=
 state
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..169e5f645ea8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1030,7 +1030,8 @@ static void init_object(struct kmem_cache *s, void =
*object, u8 val)
>         unsigned int poison_size =3D s->object_size;
>
>         if (s->flags & SLAB_RED_ZONE) {
> -               memset(p - s->red_left_pad, val, s->red_left_pad);
> +               memset_no_sanitize_memory(p - s->red_left_pad, val,

As I wrote in patch 13/33, let's try to use __memset() here (with a
comment that we want to preserve the previously poisoned memory)
