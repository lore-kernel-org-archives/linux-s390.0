Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAAEDB
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872613; cv=none; b=QJXjnRxGmZH2nAGtVQ4ix3xoCEawzCMNww2hU+tXIuJERYi/el96m66jo2pd7sLyEk6CpOnIb4PwvJP+sHV0R4RyzdJk7Qt77vROi/kGrtZDqabY0+gGue0NTtI/PTo10+QkClgQV6ie/1ke7BAXC3wIiT/SbxHHhmbSNh7SE+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872613; c=relaxed/simple;
	bh=gThRgA+KYC5GB8/QMnZsGnppNwIjDv7ifk09VTYI/e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhZkYDizfPwgHNeKIs6YLIz3PGm9Kfe6IT3gvhhXcFr7bbd48bFGmdhODf9e2/H7zYDybDb7vyXmNCp7yLF6DgyVzgYqGFULLqniI5z8BHMrgXl9n6uhaaR0YMb83WON/cOEm4Hyo2Ly44CLMnEAwiu0Vascg4OD6ZiCw8CdXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDp2fqA6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDp2fqA6"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-440609dd118so2588251cf.1
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718872611; x=1719477411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OUYcIAPu8Sr/lzFQuuddP6LocZmaVvpQ1N05tgsbXo=;
        b=mDp2fqA67B5SeRvojKMA6ld+w7F4NgXSmoLXY3ykDVCuzWa8IK2xH8blxrJFyNUcIj
         nQoE4lcEXSN3FyolpQZSxAjCs4Q2STezxFzvF5KgGE07shXk1smCEGNX+FmAkmYS3o6C
         mgl+kgnLyvywhLHH/TeZWm5VUwAdElHb7UpoCcEteNxIvoviIDuUecf0gYEw3mIx++fO
         1fIEL6WB3GtcAFcY4rZ34tViPuqM94syz9Necn9np2DNTEhKwZsgFO5PBpfJBwDP2+iA
         Yi8QYiyuXh4B85vdRgyD6pH5AgbBVJ4NUCh26EAUulYynLcWYFqoar6A7K8jdhiBIn4Z
         Lk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872611; x=1719477411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OUYcIAPu8Sr/lzFQuuddP6LocZmaVvpQ1N05tgsbXo=;
        b=ktu8DDQ2zPBQwC1AQmU2iebfETuJsNLx/oaacNB4Y8oU2PgB22Zrz+9uaJLCZAezxC
         UY9HC5KS97lmftd7jSrUdEIT4oo3p7BEoNDXgTwcCo1+R6Nas3JS0Hl8xYMYA08EX7+m
         vwRUfZzi+jd+FbJt3Szj51FLiFURhPIbmU4anIV4t5jlPXCbv43rZLTdfLtj8f3SqlGn
         rVtSA9oCarwmoh7QsyKbdQJiB4AM7ueYZpO8CAqyQtcGcOlBnLvNbRSy68Ym/cvwqsYA
         U6jMN1beF+3EgpVQzBi2t9fkgH+SA3Tvr/bUJFORespnDJduLKfa7wDfbpMeE7G/yf8J
         e+rg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ3AOl8kxJcOF+feexanAcEttTZ7HrKS7nmF/37biaQUTsBnQhz2IumfFq5IoQozAbbbCLUJe2swGiWG67z224TwP727kuFDtjw==
X-Gm-Message-State: AOJu0Yy/DjzvDV1SeHsGR7p+xuDT/XKsY83FefD8W2fcqP2EaRS9zpxt
	Ljq+XHq5J41ZSTWu0oOv7CABxMSfri1zJmnfuCKUDdXc3jg3H7HjKJY5YPCIdcyE3FgewLq50vY
	842MDdq/dXdV9Y+xk261jx0rIJqjc7dAUwYkl
X-Google-Smtp-Source: AGHT+IErmEp1x0YBOZTZJdlWJwFXEfsRyPhDcy8wmEVW3hTA6/SyMHr3il2LMbLMxYtDvHsm6Ik4jSDo32quxqAzw+g=
X-Received: by 2002:a05:6214:4a42:b0:6b4:f761:f0b8 with SMTP id
 6a1803df08f44-6b501dff5a9mr45755846d6.8.1718872610557; Thu, 20 Jun 2024
 01:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-34-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-34-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 10:36:12 +0200
Message-ID: <CAG_fn=V8Tt28LE9FtoYkos=5XG4zP_tDP1mF1COfEhAMg2ULqQ@mail.gmail.com>
Subject: Re: [PATCH v5 33/37] s390/uaccess: Add KMSAN support to put_user()
 and get_user()
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

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> put_user() uses inline assembly with precise constraints, so Clang is
> in principle capable of instrumenting it automatically. Unfortunately,
> one of the constraints contains a dereferenced user pointer, and Clang
> does not currently distinguish user and kernel pointers. Therefore
> KMSAN attempts to access shadow for user pointers, which is not a right
> thing to do.

By the way, how does this problem manifest?
I was expecting KMSAN to generate dummy shadow accesses in this case,
and reading/writing 1-8 bytes from dummy shadow shouldn't be a
problem.

(On the other hand, not inlining the get_user/put_user functions is
probably still faster than retrieving the dummy shadow, so I'm fine
either way)

>
> An obvious fix to add __no_sanitize_memory to __put_user_fn() does not
> work, since it's __always_inline. And __always_inline cannot be removed
> due to the __put_user_bad() trick.
>
> A different obvious fix of using the "a" instead of the "+Q" constraint
> degrades the code quality, which is very important here, since it's a
> hot path.
>
> Instead, repurpose the __put_user_asm() macro to define
> __put_user_{char,short,int,long}_noinstr() functions and mark them with
> __no_sanitize_memory. For the non-KMSAN builds make them
> __always_inline in order to keep the generated code quality. Also
> define __put_user_{char,short,int,long}() functions, which call the
> aforementioned ones and which *are* instrumented, because they call
> KMSAN hooks, which may be implemented as macros.
>
> The same applies to get_user() as well.
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/include/asm/uaccess.h | 111 +++++++++++++++++++++++---------
>  1 file changed, 79 insertions(+), 32 deletions(-)
>
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uacc=
ess.h
> index 81ae8a98e7ec..70f0edc00c2a 100644
> --- a/arch/s390/include/asm/uaccess.h
> +++ b/arch/s390/include/asm/uaccess.h
> @@ -78,13 +78,24 @@ union oac {
>
>  int __noreturn __put_user_bad(void);
>
> -#define __put_user_asm(to, from, size)                                 \
> -({                                                                     \
> +#ifdef CONFIG_KMSAN
> +#define get_put_user_noinstr_attributes \
> +       noinline __maybe_unused __no_sanitize_memory
> +#else
> +#define get_put_user_noinstr_attributes __always_inline
> +#endif
> +
> +#define DEFINE_PUT_USER(type)                                          \
> +static get_put_user_noinstr_attributes int                             \
> +__put_user_##type##_noinstr(unsigned type __user *to,                  \
> +                           unsigned type *from,                        \
> +                           unsigned long size)                         \
> +{                                                                      \
>         union oac __oac_spec =3D {                                       =
 \
>                 .oac1.as =3D PSW_BITS_AS_SECONDARY,                      =
 \
>                 .oac1.a =3D 1,                                           =
 \
>         };                                                              \
> -       int __rc;                                                       \
> +       int rc;                                                         \
>                                                                         \
>         asm volatile(                                                   \
>                 "       lr      0,%[spec]\n"                            \
> @@ -93,12 +104,28 @@ int __noreturn __put_user_bad(void);
>                 "2:\n"                                                  \
>                 EX_TABLE_UA_STORE(0b, 2b, %[rc])                        \
>                 EX_TABLE_UA_STORE(1b, 2b, %[rc])                        \
> -               : [rc] "=3D&d" (__rc), [_to] "+Q" (*(to))                =
 \
> +               : [rc] "=3D&d" (rc), [_to] "+Q" (*(to))                  =
 \
>                 : [_size] "d" (size), [_from] "Q" (*(from)),            \
>                   [spec] "d" (__oac_spec.val)                           \
>                 : "cc", "0");                                           \
> -       __rc;                                                           \
> -})
> +       return rc;                                                      \
> +}                                                                      \
> +                                                                       \
> +static __always_inline int                                             \
> +__put_user_##type(unsigned type __user *to, unsigned type *from,       \
> +                 unsigned long size)                                   \
> +{                                                                      \
> +       int rc;                                                         \
> +                                                                       \
> +       rc =3D __put_user_##type##_noinstr(to, from, size);              =
 \
> +       instrument_put_user(*from, to, size);                           \
> +       return rc;                                                      \
> +}
> +
> +DEFINE_PUT_USER(char);
> +DEFINE_PUT_USER(short);
> +DEFINE_PUT_USER(int);
> +DEFINE_PUT_USER(long);
>
>  static __always_inline int __put_user_fn(void *x, void __user *ptr, unsi=
gned long size)
>  {
> @@ -106,24 +133,24 @@ static __always_inline int __put_user_fn(void *x, v=
oid __user *ptr, unsigned lon
>
>         switch (size) {
>         case 1:
> -               rc =3D __put_user_asm((unsigned char __user *)ptr,
> -                                   (unsigned char *)x,
> -                                   size);
> +               rc =3D __put_user_char((unsigned char __user *)ptr,
> +                                    (unsigned char *)x,
> +                                    size);
>                 break;
>         case 2:
> -               rc =3D __put_user_asm((unsigned short __user *)ptr,
> -                                   (unsigned short *)x,
> -                                   size);
> +               rc =3D __put_user_short((unsigned short __user *)ptr,
> +                                     (unsigned short *)x,
> +                                     size);
>                 break;
>         case 4:
> -               rc =3D __put_user_asm((unsigned int __user *)ptr,
> +               rc =3D __put_user_int((unsigned int __user *)ptr,
>                                     (unsigned int *)x,
>                                     size);
>                 break;
>         case 8:
> -               rc =3D __put_user_asm((unsigned long __user *)ptr,
> -                                   (unsigned long *)x,
> -                                   size);
> +               rc =3D __put_user_long((unsigned long __user *)ptr,
> +                                    (unsigned long *)x,
> +                                    size);
>                 break;
>         default:
>                 __put_user_bad();
> @@ -134,13 +161,17 @@ static __always_inline int __put_user_fn(void *x, v=
oid __user *ptr, unsigned lon
>
>  int __noreturn __get_user_bad(void);
>
> -#define __get_user_asm(to, from, size)                                 \
> -({                                                                     \
> +#define DEFINE_GET_USER(type)                                          \
> +static get_put_user_noinstr_attributes int                             \
> +__get_user_##type##_noinstr(unsigned type *to,                         \
> +                           unsigned type __user *from,                 \
> +                           unsigned long size)                         \
> +{                                                                      \
>         union oac __oac_spec =3D {                                       =
 \
>                 .oac2.as =3D PSW_BITS_AS_SECONDARY,                      =
 \
>                 .oac2.a =3D 1,                                           =
 \
>         };                                                              \
> -       int __rc;                                                       \
> +       int rc;                                                         \
>                                                                         \
>         asm volatile(                                                   \
>                 "       lr      0,%[spec]\n"                            \
> @@ -149,13 +180,29 @@ int __noreturn __get_user_bad(void);
>                 "2:\n"                                                  \
>                 EX_TABLE_UA_LOAD_MEM(0b, 2b, %[rc], %[_to], %[_ksize])  \
>                 EX_TABLE_UA_LOAD_MEM(1b, 2b, %[rc], %[_to], %[_ksize])  \
> -               : [rc] "=3D&d" (__rc), "=3DQ" (*(to))                    =
   \
> +               : [rc] "=3D&d" (rc), "=3DQ" (*(to))                      =
   \
>                 : [_size] "d" (size), [_from] "Q" (*(from)),            \
>                   [spec] "d" (__oac_spec.val), [_to] "a" (to),          \
>                   [_ksize] "K" (size)                                   \
>                 : "cc", "0");                                           \
> -       __rc;                                                           \
> -})
> +       return rc;                                                      \
> +}                                                                      \
> +                                                                       \
> +static __always_inline int                                             \
> +__get_user_##type(unsigned type *to, unsigned type __user *from,       \
> +                 unsigned long size)                                   \
> +{                                                                      \
> +       int rc;                                                         \
> +                                                                       \
> +       rc =3D __get_user_##type##_noinstr(to, from, size);              =
 \
> +       instrument_get_user(*to);                                       \
> +       return rc;                                                      \
> +}
> +
> +DEFINE_GET_USER(char);
> +DEFINE_GET_USER(short);
> +DEFINE_GET_USER(int);
> +DEFINE_GET_USER(long);
>
>  static __always_inline int __get_user_fn(void *x, const void __user *ptr=
, unsigned long size)
>  {
> @@ -163,24 +210,24 @@ static __always_inline int __get_user_fn(void *x, c=
onst void __user *ptr, unsign
>
>         switch (size) {
>         case 1:
> -               rc =3D __get_user_asm((unsigned char *)x,
> -                                   (unsigned char __user *)ptr,
> -                                   size);
> +               rc =3D __get_user_char((unsigned char *)x,
> +                                    (unsigned char __user *)ptr,
> +                                    size);
>                 break;
>         case 2:
> -               rc =3D __get_user_asm((unsigned short *)x,
> -                                   (unsigned short __user *)ptr,
> -                                   size);
> +               rc =3D __get_user_short((unsigned short *)x,
> +                                     (unsigned short __user *)ptr,
> +                                     size);
>                 break;
>         case 4:
> -               rc =3D __get_user_asm((unsigned int *)x,
> +               rc =3D __get_user_int((unsigned int *)x,
>                                     (unsigned int __user *)ptr,
>                                     size);
>                 break;
>         case 8:
> -               rc =3D __get_user_asm((unsigned long *)x,
> -                                   (unsigned long __user *)ptr,
> -                                   size);
> +               rc =3D __get_user_long((unsigned long *)x,
> +                                    (unsigned long __user *)ptr,
> +                                    size);
>                 break;
>         default:
>                 __get_user_bad();
> --
> 2.45.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20240619154530.163232-34-iii%40linux.ibm.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
