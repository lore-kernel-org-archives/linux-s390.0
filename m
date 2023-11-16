Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077CBC197A0
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 09:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjKPJVP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 04:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjKPJVM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 04:21:12 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BC31AE
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:21:08 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-677a12f1362so3022906d6.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700126468; x=1700731268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL39H6t6bxsTD+ztOctS1932vRb+QRkl89FhLK7eO2w=;
        b=JNMw6s5rSK6aDd8SMSh4RhDcGyigZuz9BGcs5euMtWaKZYpBFWJD9J0ev1egp29pKe
         SGQF5rg70UdOFExlx88rrV7MABEQ3bFyUCPIhHFKgQGkNL07/jlovj4Px5uPZQK0Ju7m
         eNg3uxTFz7+N/FblKvu9aosTHZYKPhbPmq4hFlqNJaEwXpAwHmkuu1qCWV3U0KVsz+cx
         7TdMAa7e0gQRsSynqYYqmu44P0RpwxqDJBfh1lLb6HPRD9a7olrhNg8XYy1ap7JFnRjf
         GB5FIL0RiQMtZ+cZqBnerjQHNWQOkZGAcP25SZbHD6RF3nkI6RG/FtSyTBQ9EqP1f1S0
         gK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126468; x=1700731268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL39H6t6bxsTD+ztOctS1932vRb+QRkl89FhLK7eO2w=;
        b=GeVUuscQAk++Y2sZFPE7zfsIdtkWTtKxg+Pgw4Kj9Ap5WIWTu1XKbhjwWkVk6Svx4y
         pCLVDE2NAQRSzAjI9BtBj2vA0TLLNQ3U3MLjVRAVdcmDEk97UB98fMWaNDumtaChF9LN
         /GJVFhUa1DtXToF5C80Ocb65FKcskjHfnBaxpYMNahgv8Z1QbXGap72rFSeckJL+9Cqe
         5xnuKPQ8YoZ7FrQuvKn0+mFDPDq2Jt9YNYGcpTlFkZteDWnoYBlQPKj+Y42c7qPxRNSW
         UV3NBC4ouf/9tL6r242h8W7ARL7unMqAklsYgBO5v9lzmuZCuXe7QIjN3Yo7quyvZ0Fx
         S2pw==
X-Gm-Message-State: AOJu0YzWiVXL8rgCLQS7sHLV9kNOEfw7qigH6GoS8lvfjXnmkzNkj5HC
        zmD2e2m4wNvuOrbwXByEubC7ka1NXtV/x0NERXKUdg==
X-Google-Smtp-Source: AGHT+IHC6nwGkpF/PSyV/svhCqIi/GYkWrnJGNLPzykP9GcOVpjYZIb5GpU44Ibf43ZB0BLs7Gg4kVobl5xh6hb3jWM=
X-Received: by 2002:ad4:5cc6:0:b0:66d:15de:329c with SMTP id
 iu6-20020ad45cc6000000b0066d15de329cmr11619912qvb.43.1700126467765; Thu, 16
 Nov 2023 01:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-21-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-21-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:20:31 +0100
Message-ID: <CAG_fn=UhFURUGqFXCrWym98PLzSR9oYfVDFvLpoaRO91_CMenw@mail.gmail.com>
Subject: Re: [PATCH 20/32] s390: Turn off KMSAN for boot, vdso and purgatory
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
> All other sanitizers are disabled for these components as well.
>
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
(see a nit below)

> ---
>  arch/s390/boot/Makefile          | 1 +
>  arch/s390/kernel/vdso32/Makefile | 1 +
>  arch/s390/kernel/vdso64/Makefile | 1 +
>  arch/s390/purgatory/Makefile     | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index c7c81e5f9218..5a05c927f703 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -8,6 +8,7 @@ GCOV_PROFILE :=3D n
>  UBSAN_SANITIZE :=3D n
>  KASAN_SANITIZE :=3D n
>  KCSAN_SANITIZE :=3D n
> +KMSAN_SANITIZE :=3D n

Nit: I think having even a one-line comment before this block
(something similar to
https://elixir.bootlin.com/linux/latest/source/arch/x86/boot/Makefile#L12)
will make it more clear.

But given that the comment wasn't there before, leaving this up to you.
