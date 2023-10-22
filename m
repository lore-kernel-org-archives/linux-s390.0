Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB93C25B41
	for <linux-s390@archiver.kernel.org>; Sun, 22 Oct 2023 14:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjJVOyg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 22 Oct 2023 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVOyf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 22 Oct 2023 10:54:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BB1A4
        for <linux-s390@vger.kernel.org>; Sun, 22 Oct 2023 07:54:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a6190af24aso390962366b.0
        for <linux-s390@vger.kernel.org>; Sun, 22 Oct 2023 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697986472; x=1698591272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G0Ah1cO2lJiXDFUGG0RJnDjIa5urZ8iO5hsK/cwibK4=;
        b=NJKWCVIy51ZTwTHQqF5jfYrcDdZKwkB0KAYLw6tqRg0K99e0Mie6WwsUuRcr95oJrN
         SELDi2/iS9ji6LLDy2QrB2QqtQgEKoJ1O2bW+BxT/ByuWgfcFJ6xDVbVHBTrxpZ96mwj
         MsmzkV4trP/eOjA8omwKwOKCCQ48xLjhxnK9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697986472; x=1698591272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0Ah1cO2lJiXDFUGG0RJnDjIa5urZ8iO5hsK/cwibK4=;
        b=ORc4sSNYIjXVTDmES9sR/Mebemfdhq9aTl9tcE7cG78OHEZIPocPWfstrk/ml0/39P
         5AWsAoMf3Njr4q1jFQluMV5uENkkFnfRRgVYmJW8LTiuf+l5hL3l651lsmMFtu0OM4Ij
         d1FTgsXEMBV4URD/TJ4vJqAOSsx5oM/u9iqvn8dgmamjWh3j0WqdYW9n2wbRpuLD7Znb
         YXubQcqNaysaYb7Cn02WLsPMar78bsnEkWeyUqcZzm7pml6FzahTyVy5BEJVgWRQ16GW
         lUeDe7QQTopaxV9k8Cm5o4S9UY4OK//05Mq7K3T/Eq1b2LPX/oZIKHuevQj94BXQERtx
         hx2g==
X-Gm-Message-State: AOJu0YwZHO8ONRjz7dyl8fat9KieRHZPBamPTTUl2J8ZgwHWMBVfKWqD
        JLCf27dPdzBPDJgKgnIqbBIVp2UQEcW+0Uqu1w9J6Q==
X-Google-Smtp-Source: AGHT+IFDvHuOktRdh4vFt1gTncFYiM5DoeTL2O1FCbdRmjhXWGfDEtprH1x9kRYqAKqQArpNc1qj4w==
X-Received: by 2002:a17:907:1b0a:b0:9a6:1446:852c with SMTP id mp10-20020a1709071b0a00b009a61446852cmr6435921ejc.27.1697986472247;
        Sun, 22 Oct 2023 07:54:32 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906051400b009bf7a4d591dsm5128957eja.32.2023.10.22.07.54.31
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 07:54:31 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso3486592a12.1
        for <linux-s390@vger.kernel.org>; Sun, 22 Oct 2023 07:54:31 -0700 (PDT)
X-Received: by 2002:a50:9318:0:b0:53e:3d9f:3c74 with SMTP id
 m24-20020a509318000000b0053e3d9f3c74mr4973803eda.14.1697986470852; Sun, 22
 Oct 2023 07:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01697881440-ext-2458@work.hours>
 <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
 <CAHk-=wjxAk=PQBX4OvscNfGKfc+M8iKmNd6D39wOZzXV0k729w@mail.gmail.com> <your-ad-here.call-01697980674-ext-9589@work.hours>
In-Reply-To: <your-ad-here.call-01697980674-ext-9589@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Oct 2023 07:54:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizgxqjSk7fhyqPuW7Nkt3qwCkr-WKE2DsRu8tK7CC2Tw@mail.gmail.com>
Message-ID: <CAHk-=wizgxqjSk7fhyqPuW7Nkt3qwCkr-WKE2DsRu8tK7CC2Tw@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.6-rc7
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, 22 Oct 2023 at 06:18, Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> This might work.

Hmm. Yes.

But let's fix __KERNEL_DIV_ROUND_UP itself while at it.

(And perhaps move it out of the odd location it is in now - its in
<uapi/linux/const.h> for some unfathomable reason)

And maybe we could do a helper like

    #define __if_constexpr(x, a, b) \
        __builtin_choose_expr(__is_constexpr(x), a, b)

since that is one of the main reasons for that __is_constexpr macro
(and _that_ makes sense in the const.h header file).

                 Linus
