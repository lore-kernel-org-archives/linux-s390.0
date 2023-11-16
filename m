Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74793C54FB9
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 09:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjKPJFa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 04:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjKPJF3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 04:05:29 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57BD8
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:05:25 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6705379b835so3180006d6.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700125524; x=1700730324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXPXLemzi7uHNP/MTyau/JmrJz+5u7EITKeIMDjwkIM=;
        b=G98mj1O6jsu5oWEiHkUqGM7Mp3cpyiRoSZAD7KjuIoqUvtUHTir3IuIt0EEBi6SL5d
         JEW3nNOnCdDo8UAKT0GEGsOc+RSchCp1X4Z7a5mbF3Ev+aeoS/X5c9kwh512GCkmFjYW
         t/1WNP7mjjDc/szmskNBE4pIccfuioNurNWviFrIG0RXiehfiseKEv2aVUhav4Kp5282
         GkVp7v2EmNVTr0vGHDyK0+QX3EhDntsoS//Cy4QwgTh94VcQQJVCXV25HqUK17LCDoYK
         4G9E4NJurQyMLAUyS06a9Gy+FaJA+lFRKH49n+RFP8KmbY30XQK5bUXQ9BCUq7ETvhEg
         vKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125524; x=1700730324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXPXLemzi7uHNP/MTyau/JmrJz+5u7EITKeIMDjwkIM=;
        b=jRgM53ZZ93+OuWbKD+mJxN6luvSzu3tMjkxO6KNJXs1tumkby42yA9FT3gQj78Q4Tq
         /yo/lk3mL/vBtuifxiJBLQRR2mlprIdLBQ32RlvwtmO20oXLIDHC7LErlPN+aqHpJZYz
         iKqD+WzXzVnxB73pcHut8EECOfop+MPKLH0c6dD5zw2EEwnK3KGgrxxcPx+qOgYFrk9A
         kc020nKE/BGNmkd1PQfQRTLBBZxmoT2vzYJ1BwapYuOala7qxtWTVfvTlZTUlywxUbcC
         VyNGf83d70jpjjdQD4Cvr+u6A+DjZIVBbutuVchPSx9036az085nL3ptconT1ZfRjw8O
         G/cQ==
X-Gm-Message-State: AOJu0Yw6DjZvLi7TRKISsrm498jyUwZTF6jvslxhTqdKaWeA+3R+0uKp
        iy86SA0r5ftAnQFw1CoU98IMoq9DyTyu40NIoYcf5A==
X-Google-Smtp-Source: AGHT+IHddErKTqV4KijE3wEGB/TnURY3hJK1ZchMOpg9Tlo/CQeiuG3UfOCJN+/HGm4+fCBft1ypy5Rr2W0BdMl7sgc=
X-Received: by 2002:a05:6214:d1:b0:675:b8ff:b5e2 with SMTP id
 f17-20020a05621400d100b00675b8ffb5e2mr7955988qvs.50.1700125524454; Thu, 16
 Nov 2023 01:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-31-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-31-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:04:48 +0100
Message-ID: <CAG_fn=WW1BUehMSsbjtPb4gKpakLGi3bF2KFEPxE4dV7n1ToSQ@mail.gmail.com>
Subject: Re: [PATCH 30/32] s390/unwind: Disable KMSAN checks
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
> The unwind code can read uninitialized frames. Furthermore, even in
> the good case, KMSAN does not emit shadow for backchains. Therefore
> disable it for the unwinding functions.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/kernel/unwind_bc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.c
> index 0ece156fdd7c..7ecaab24783f 100644
> --- a/arch/s390/kernel/unwind_bc.c
> +++ b/arch/s390/kernel/unwind_bc.c
> @@ -49,6 +49,7 @@ static inline bool is_final_pt_regs(struct unwind_state=
 *state,
>                READ_ONCE_NOCHECK(regs->psw.mask) & PSW_MASK_PSTATE;
>  }
>
> +__no_kmsan_checks

Please add some comments to the source file to back this annotation,
so that the intent is not lost in git history.
