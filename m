Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3B4C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 02:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE14861364
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 02:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhESCl3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 22:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbhESCl0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 22:41:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC18C06175F
        for <linux-s390@vger.kernel.org>; Tue, 18 May 2021 19:40:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lz27so17636521ejb.11
        for <linux-s390@vger.kernel.org>; Tue, 18 May 2021 19:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtmNJLU/dhQ9ELu/k2h5VHa5Rzw2bCS2zmPu0hLax+8=;
        b=BVvY6dfBpTLG0lCmqHmrDJcT+SrZNvl2aUJRRzUMfSXvRfy+O8EXPnnwQahXMdao6o
         ADK4xqT8fNsbM2m33sQnw4i2uQ0JMU5+vr1tAi+7ZAg8S9HHsObzS/enEivmT4rgIsLZ
         ILiKKP3sz7olT1g3KLaQqtWqIyrwYxRu/fSqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtmNJLU/dhQ9ELu/k2h5VHa5Rzw2bCS2zmPu0hLax+8=;
        b=ojZXkWtfYdklKl7pV58dHMB5ar1w6rym8pv/RO8V+ipZ+3rkJS/cHy5IOCIBsLPUll
         +87ThYnI2q6KZTzDySsIx2FdtKLTne1j3KM04Bd3nBPundEOs7UVoog+VoAFiiVlCU6v
         dNaZqMTuoQT+apFUkaRQALMdzll+NeSf/Nejw3r0Qd2VCKOjMvrZMTNkyH91t6/l85Y5
         k3GJuCaQuqVv2hhuBtoIfgDGS26fgQgdcEUxXO+38w/yp+m1kGk/2yY/pt5NOApS9dvE
         2Yk+jhCDbwqM3ctMrp7zgzdzz1WQIeeTw4if9Qg4xX06ukfRuEWTEnFdUr3blmhukuja
         MCFQ==
X-Gm-Message-State: AOAM532D9gR/YB1FxrIivLraPc/1ITtQJmptiVvzaLTnBdYcuCAdYp0i
        PQisa6o8sIDQpZf+nnbUeIUtSAbsmrteoach
X-Google-Smtp-Source: ABdhPJyM2qBNCS1SvSoQyY0pxOJeAFnPIG11delOwwI9RhqJ+Nu5Bascl0SWcnSUivCWZYdpi7fDOA==
X-Received: by 2002:a17:906:d922:: with SMTP id rn2mr7519161ejb.469.1621392005365;
        Tue, 18 May 2021 19:40:05 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id k21sm763910ejp.23.2021.05.18.19.40.05
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 19:40:05 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id o5so4554144edc.5
        for <linux-s390@vger.kernel.org>; Tue, 18 May 2021 19:40:05 -0700 (PDT)
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr6863723ljq.220.1621391994583;
 Tue, 18 May 2021 19:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
 <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com>
 <YJdIx6iiU9YwnQYz@zeniv-ca.linux.org.uk> <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
 <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
In-Reply-To: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 May 2021 16:39:38 -1000
X-Gmail-Original-Message-ID: <CAHk-=whJkHMtf4RYiE3PLTEo8fM_vU6BG43TNJLbHsGYPsSJfQ@mail.gmail.com>
Message-ID: <CAHk-=whJkHMtf4RYiE3PLTEo8fM_vU6BG43TNJLbHsGYPsSJfQ@mail.gmail.com>
Subject: Re: [PATCHSET] d_path cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 18, 2021 at 2:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Here's what I've got for carve-up of cleanups.

Thanks, these all look logical to me.

I only read through the individual patches, I didn't test or check the
end result, but it all looked like good sane cleanups.

              Linus
