Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78079C433B4
	for <linux-s390@archiver.kernel.org>; Sun,  9 May 2021 02:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5776B613EE
	for <linux-s390@archiver.kernel.org>; Sun,  9 May 2021 02:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhEICy6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 8 May 2021 22:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhEICy6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 May 2021 22:54:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B435C061573
        for <linux-s390@vger.kernel.org>; Sat,  8 May 2021 19:53:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y26so14792997eds.4
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c00F5gdQd8J96Q6xsAfPKXtIOJ12DymA7I1VC+ABJMI=;
        b=ZXbbWzGH/eL1fUAgVLnCJUUj6r+YqzdqdDMv0ikvcdMmVSBjVlBU3527+tNRCUaiSM
         7m8ZTZPhoRTWkoXcymBN+P2y/Luf4xF3yzPt9VOXchyeMYTKTr57ivdXERQucDgeqYM2
         ShoIySWR1fYr4SscaXtb78xNk5uidMng7rfzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c00F5gdQd8J96Q6xsAfPKXtIOJ12DymA7I1VC+ABJMI=;
        b=rkp14Idq/w3bot8H+vNaXlrXb4L++n6UIBXfutlwUVR/aOAnDFi9NH4fdR8pEqu0OO
         xzwveJhHq8jUBvddghCqHxVWZ7H3llf/O8wxtJLTvKrM3AYjlJRWjwqE5vvDPy0tgI5c
         obzeOKeQq9dO8jWi3e1VKc6Fjcn8OB7w0EF/loe8gFv/6C8soZFXamNKAf3TU5U7Yyrw
         AqmiRkvSm0NrY8qzE2x5iAWT6UI5oHf+3mrdztj0RdZ7wuWcBHsGCq53CkyjlCNWe7wj
         0aKc46+i8qe/QneYaJdKmT0YpEUZjuNPst06J0z/SNH1cnhuH99zQZXt09X+m4vh/aWd
         Oj0Q==
X-Gm-Message-State: AOAM531Kb/G7+rNTQDN52u12XAWFFJa0RoR7QlLOUtIA97T3RqtU3o0j
        47ssa8FdAd/d8d5szc/XlDutx2Pkxw69+uJzju0=
X-Google-Smtp-Source: ABdhPJzsFt6e/4HnHgmVA7rsaeW2TM90SteNiI2tN4Sth7kgK19vAuMgg7CI7lgE1svo4Uyb3QQi4w==
X-Received: by 2002:a05:6402:4305:: with SMTP id m5mr20973710edc.143.1620528833186;
        Sat, 08 May 2021 19:53:53 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id j8sm7610723edq.67.2021.05.08.19.53.53
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 19:53:53 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id m9so13063469wrx.3
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 19:53:53 -0700 (PDT)
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr11470223lfr.201.1620528822658;
 Sat, 08 May 2021 19:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
 <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com> <YJdIx6iiU9YwnQYz@zeniv-ca.linux.org.uk>
In-Reply-To: <YJdIx6iiU9YwnQYz@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 19:53:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
Message-ID: <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
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

On Sat, May 8, 2021 at 7:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Re READ_ONCE() - we are wrapped into
> read_seqbegin_or_lock(&rename_lock, &seq) there, so it's more about
> being explicit than about correctness considerations.

Well, part of this all is that the next step is that "vsnprintf()"
with '%pD' would basically use prepend_entries() with just the RCU
lock.

That said, even with the rename lock, that will only cause a retry on
rename - it won't necessarily fix any confusion that comes from the
compiler possibly silently re-loading 'parent' multiple times, and
getting different pointers due to a concurrent rename.

Now, those different results should all be individually ok, due to RCU
freeing, but it's _really_ confusing if 'parent' might be two
different things within the same iteration of the loop.

I don't see anything truly horrible that would happen - mainly "we'll
prefetch one parent, and then due to reloading the pointer we might
actually _use_ another parent entirely for the next iteration", but it
really is best to avoid that kind of confusion.

                Linus
