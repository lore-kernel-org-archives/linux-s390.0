Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD84C3DA79
	for <linux-s390@archiver.kernel.org>; Tue, 20 Dec 2022 06:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiLTG3j (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Dec 2022 01:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiLTG3h (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Dec 2022 01:29:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5789B13E93
        for <linux-s390@vger.kernel.org>; Mon, 19 Dec 2022 22:29:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u5so11411368pjy.5
        for <linux-s390@vger.kernel.org>; Mon, 19 Dec 2022 22:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsZFVfyCFnv9tesPs+08hUwpiapeBSGcP8owkX/MLGQ=;
        b=CU2AdnhWo8+dQqT2PZGeVzI9jvivEAXyV7KbnK9fFEs5fFHuNccZU9p8uHieOiH/va
         jwKCKmkKJpdJ5TZO7h1MvJ/OtKOIzuyv1hbSFy4DJFfV7CD/neLpJDixon0FF3PpQt7n
         eURtZpQdaLLgqJco86mvX1U1NyUZk/F5jztwzA98AVt6np5mmw0DMIbBfBdNlyY2jh5w
         N+2Gs6/e/knoUK0hqGMKa7ER8JzJU9fENb/kIybnmrdTtKVI6rNA3FGzQWxIP2q0YpKW
         IiBaLKVEUZGMB7xK8L38GUEcee+a6rPclElyeFAE5KnfkDmPTm6boYb0I65FzNOO7f+1
         m2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AsZFVfyCFnv9tesPs+08hUwpiapeBSGcP8owkX/MLGQ=;
        b=Kg4sOEQfVeeOkz5bS8h3UcLYL1eI30QeebRMJUEGCi/Gh0JU+Jp2hU7ARRZskCgEX0
         8UqiOQJg/kbk1OvQN8MqESUwnoFRFxO7GIAaDU59xPH2KRJjiCC0udtv+NLQ6hFcFeio
         VYZHSue0KkD9ROU6RjRjmRENGe13lQq01LbCEpucjqYVGlgdTDjumaOVAjZ3DINLAPlC
         R6b/e0DvcJzKlQu2Eg4yKbH69QfNGW3+vuuFI0UttH+RFKghg9dUc/VUVCkNv2rM/DoY
         mSfpQuxf6SzcPX7qUN42u2uUZjrBH262qykpo2xWEmt03D7IknyM+H5RPwRKC0Sazp0t
         aUNA==
X-Gm-Message-State: AFqh2koriYuH4LpDHLzbhGYuPM5oRreNln1FuTL8BEVY9rKtG232U791
        7bLvYuukxiGaWL99g5UiG7c9wuxUJPDCGg==
X-Google-Smtp-Source: AMrXdXvWxIYe9KMMo31lcm/gM2wUVpFnU9O8cVDhAAy0Sgj9TRiUN4WaoRAOc9O8b4WpH0L9/jcoBQ==
X-Received: by 2002:a05:6a20:671d:b0:af:7762:3c29 with SMTP id q29-20020a056a20671d00b000af77623c29mr15051117pzh.10.1671517776797;
        Mon, 19 Dec 2022 22:29:36 -0800 (PST)
Received: from localhost (203-219-149-28.tpgi.com.au. [203.219.149.28])
        by smtp.gmail.com with ESMTPSA id k10-20020a63ff0a000000b0047048c201e3sm7503020pgi.33.2022.12.19.22.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 22:29:35 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Dec 2022 16:29:31 +1000
Message-Id: <CP6FLJIUUT95.3NPVEMSCSRA28@bobo>
Subject: Re: [PATCH] s390: remove the last remnants of cputime_t
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Sven Schnelle" <svens@linux.ibm.com>
Cc:     <linux-s390@vger.kernel.org>
X-Mailer: aerc 0.13.0
References: <20221006105635.115775-1-npiggin@gmail.com>
 <yt9dpmf5ywl6.fsf@linux.ibm.com>
In-Reply-To: <yt9dpmf5ywl6.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu Oct 6, 2022 at 10:18 PM AEST, Sven Schnelle wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > cputime_t was a core kernel type, removed by commits
> > ed5c8c854f2b..b672592f0221. As explained in commit b672592f0221
> > ("sched/cputime: Remove generic asm headers"), the final cleanup is for
> > the arch to provide cputime_to_nsec[s](). Commit e53051e757d6
> > ("s390/cputime: provide archicture specific cputime_to_nsecs") did that=
,
> > but just didn't remove the then-unused cputime_to_usecs() and associate=
d
> > remnants.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Sorry this isn't build or compile tested, I'm doing the same for powerp=
c
> > then we can remove the cputime_to_nsecs fallback from core code too.
>
> I just tested this, looks good. Thanks!
>
> Reviewed-by: Sven Schnelle <svens@linux.ibm.com>

Thanks Sven. I think the core code fallback can be removed independently
of this s390 change, so it can go via s390 tree in your own good time.

Thanks,
Nick

>
> >
> >  arch/s390/include/asm/cputime.h | 15 ---------------
> >  1 file changed, 15 deletions(-)
> >
> > diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cp=
utime.h
> > index 1d389847b588..7f9284e2a7db 100644
> > --- a/arch/s390/include/asm/cputime.h
> > +++ b/arch/s390/include/asm/cputime.h
> > @@ -11,21 +11,6 @@
> >  #include <linux/types.h>
> >  #include <asm/timex.h>
> > =20
> > -#define CPUTIME_PER_USEC 4096ULL
> > -#define CPUTIME_PER_SEC (CPUTIME_PER_USEC * USEC_PER_SEC)
> > -
> > -/* We want to use full resolution of the CPU timer: 2**-12 micro-secon=
ds. */
> > -
> > -#define cmpxchg_cputime(ptr, old, new) cmpxchg64(ptr, old, new)
> > -
> > -/*
> > - * Convert cputime to microseconds.
> > - */
> > -static inline u64 cputime_to_usecs(const u64 cputime)
> > -{
> > -	return cputime >> 12;
> > -}
> > -
> >  /*
> >   * Convert cputime to nanoseconds.
> >   */

