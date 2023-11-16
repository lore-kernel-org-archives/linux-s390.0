Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF785C197A0
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 09:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjKPJF4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 04:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjKPJFz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 04:05:55 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D551B8
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:05:51 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7eef0b931so6075127b3.0
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700125551; x=1700730351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJvcy5OQThQMBzLC/CmhcyXSfL+uAyptQQ2e5phxAM4=;
        b=oWrSP1IlUTG1W8C2Vn3MDQRkcOkQC47jhTsbJE/syle+x2E7pLk8YH73UqsmtyCF5X
         wjMY1VnB609yWCdmQTbYSx6hEvgz9PlngiYT2pBwgpQSS1+4lNcph9dOwAmspD512EoA
         DyHUWd9wOherKtEvRiHolu3BRIZ9y9+IRZIIiP2S57xykxHFJkkVZyhOesC0+tL4jxIN
         7wgNrnGeECevzbZc3Us2+uMI2bErIcqBxMq8Kz8bYRmxIj97dJbe22z0hEPSYaSEBXbh
         w2FcIamjnoB00s5iy8eJtvDXW8ynQlsWRawCX7xBaPUoQ6LguUMaS3AavD7Q9sUsyuBD
         oB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125551; x=1700730351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJvcy5OQThQMBzLC/CmhcyXSfL+uAyptQQ2e5phxAM4=;
        b=kUYbYHng+f67dr87uyX0i8QriousdAP+JEb9kIMnBal04/a01qmZxVPPRaud8XsE+o
         g0tTLGaaKG6+30m1TdZAF+Xf5altI5167GxWF8msoCHuLeoWSb+dG5FZYA9vCjddFDFD
         EAVGPtuGlsERykLBNIyjeVRpFWy0lele/4tFiGLgNGEDMNiOQlx3ZasvNOxN72BoyMP1
         1C4pB+/8JkVK299CR+aPi2SDdJdexiF+AZdlbu+SoHjaPpqCfxhGXVgNrHR6NztsiQ8j
         ickjEZlbRVPp4fpysBEykEhizUBV/HB2mLbWcNQlbHk1WQU7m03rq6W9Ji9MuflNfp3h
         tihg==
X-Gm-Message-State: AOJu0YxFi3OGTcqLblmcOhdEsX6TTfkc+S1uSojCk47WLAyySSTpfLxP
        5+/Cd3AHPElGEsDF8xnE4l5dtOISliylma1ibWL6DA==
X-Google-Smtp-Source: AGHT+IGJR4QLM16FKTPZT3Tz/J1QFBPNhj+bwePlZEFgi7iCb5pKMX+w3+XgoMz2yIXIyLcBCWd/7G270rmy6YIVNjQ=
X-Received: by 2002:a81:8a41:0:b0:5a8:3f0a:618e with SMTP id
 a62-20020a818a41000000b005a83f0a618emr16007472ywg.37.1700125550745; Thu, 16
 Nov 2023 01:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-31-iii@linux.ibm.com>
 <CAG_fn=WW1BUehMSsbjtPb4gKpakLGi3bF2KFEPxE4dV7n1ToSQ@mail.gmail.com>
In-Reply-To: <CAG_fn=WW1BUehMSsbjtPb4gKpakLGi3bF2KFEPxE4dV7n1ToSQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:05:14 +0100
Message-ID: <CAG_fn=XftAnT0=kxkjGrtn9QEye1Xayg_jw3Fk_cy6SforMTpg@mail.gmail.com>
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

On Thu, Nov 16, 2023 at 10:04=E2=80=AFAM Alexander Potapenko <glider@google=
.com> wrote:
>
> On Wed, Nov 15, 2023 at 9:35=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om> wrote:
> >
> > The unwind code can read uninitialized frames. Furthermore, even in
> > the good case, KMSAN does not emit shadow for backchains. Therefore
> > disable it for the unwinding functions.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  arch/s390/kernel/unwind_bc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.=
c
> > index 0ece156fdd7c..7ecaab24783f 100644
> > --- a/arch/s390/kernel/unwind_bc.c
> > +++ b/arch/s390/kernel/unwind_bc.c
> > @@ -49,6 +49,7 @@ static inline bool is_final_pt_regs(struct unwind_sta=
te *state,
> >                READ_ONCE_NOCHECK(regs->psw.mask) & PSW_MASK_PSTATE;
> >  }
> >
> > +__no_kmsan_checks
>
> Please add some comments to the source file to back this annotation,
> so that the intent is not lost in git history.

Apart from that,

Reviewed-by: Alexander Potapenko <glider@google.com>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
