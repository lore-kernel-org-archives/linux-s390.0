Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740AC433EF
	for <linux-s390@archiver.kernel.org>; Sat, 16 Oct 2021 16:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E573260200
	for <linux-s390@archiver.kernel.org>; Sat, 16 Oct 2021 16:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbhJPQYk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 16 Oct 2021 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhJPQYk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 16 Oct 2021 12:24:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFDAC061765
        for <linux-s390@vger.kernel.org>; Sat, 16 Oct 2021 09:22:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y26so56139479lfa.11
        for <linux-s390@vger.kernel.org>; Sat, 16 Oct 2021 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOYjIwrVZxhUbNWSGTQPnQPa/h8wJ1cvVqLz000cP50=;
        b=RnZYNq5deahqF01JorNo22IZo2i8ysNNiNOa7QuqWi+bPIs1TQECok+eoWk5bxsUFr
         nG3rC4+Zz9gNN6vy6x8T1639Koh+kjmu4maD7WJMZ7JbO1SyKYRirbyxzpqoc+tkXtus
         PXV704d2Amol+dm+IepBLYoQ39r9DR9bpVeqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOYjIwrVZxhUbNWSGTQPnQPa/h8wJ1cvVqLz000cP50=;
        b=jvG01xAqPIiQyZalzL6mOg7MJ1qTYnZ6riOyeYbn0G1GwZDAOhyTkmzBtmwpQj4RE0
         TOf4kXkYUqqBMHORrH4RZiOFLIfsXsOT07HUK6IsHUN+Mk7N8Fnx5VfGCl1xwyskl1jr
         /ebGcFuSMaLhWY24ryzm5QTADlCRMBabUc6dhEo+6G/5de6lK9/IMuM9TXiSVGEYsQ6P
         /Bem9oQOuP/bRmJjVGYjU6C8nbDESsvcq8BRPsE3X2HEn+iWk6UtHKVfQZCuxsqBzheJ
         n9gikQYboPTsCoS/Psj+TiL1szVv1IdQ78QaBJgMMOE64fXTNDfB0o+yIhx1YU0hOfGE
         7iSA==
X-Gm-Message-State: AOAM531w0oWhgH6Heh5wIsuxxmGwkapVXpkvixQlgI8F3M8ynGgN4nbA
        OBtl6g26bIE+Tt2zTuj7Y81csisUX/6UELMO
X-Google-Smtp-Source: ABdhPJxr7P6/oPyw7R3DvBjfT8LthYLMHq+YUua6zqv+Rl5GZfQA1d0DIZ/flFDkwQVG0vLBgUmWKQ==
X-Received: by 2002:a2e:b888:: with SMTP id r8mr21340032ljp.196.1634401349570;
        Sat, 16 Oct 2021 09:22:29 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id z5sm894653lfr.96.2021.10.16.09.22.28
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 09:22:29 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id z11so54642178lfj.4
        for <linux-s390@vger.kernel.org>; Sat, 16 Oct 2021 09:22:28 -0700 (PDT)
X-Received: by 2002:a2e:934d:: with SMTP id m13mr16917423ljh.191.1634401348513;
 Sat, 16 Oct 2021 09:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01634376368-ext-7035@work.hours>
In-Reply-To: <your-ad-here.call-01634376368-ext-7035@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Oct 2021 09:22:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoe211F8ND-9hZvfnib0UA4gga8DZJ+YaBZNbE4fubdg@mail.gmail.com>
Message-ID: <CAHk-=whoe211F8ND-9hZvfnib0UA4gga8DZJ+YaBZNbE4fubdg@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 5.15-rc6
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Oct 16, 2021 at 2:26 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> - Fix broken strrchr implementation.

I pulled this, but had to look at this commit just because it struck me as odd.

Is the generic strrchr() implementation so bad for s390 that it shows
up? It looks like the s390 implementation wants to avoid checking
separately against the final NUL character and basically uses the
optimized strlen function to do so, but when strrchr has to walk the
string _anyway_ this all looks a bit odd.

Not a big deal. I just get the feeling that s390 (and probably other
architectures) might be a bit too eager to make their own helper
string functions for reasons that may be historical ("we didn't have
generic string functions at all long ago") or misguided ("we'll do an
architecture-optimized version even for things that don't matter").

          Linus
