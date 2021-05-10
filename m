Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7072C43460
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5D760FE3
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhEJRGd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 10 May 2021 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhEJRGZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 10 May 2021 13:06:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F4C061348
        for <linux-s390@vger.kernel.org>; Mon, 10 May 2021 10:03:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w4so21678359ljw.9
        for <linux-s390@vger.kernel.org>; Mon, 10 May 2021 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1eiob8yefqeM/4lQ3qAm9Yi0Ncpt48q5ul29v+Xq2c=;
        b=F5KPsThm+B/hNJwfEfSsphP6+tJzOvUUoyRJDzDPpWJ5+M81YHmp5q6kc3NHXwI+NX
         Mc6fNZ9gODek4bDptwj3D+Ka+Ar0jPnltod+iKxngn/yVax6lIBjujOZoyRHkKXW1rdK
         ijaTUd6bNrV69ZmFpNnh7JIb7M++aRgC7xK14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1eiob8yefqeM/4lQ3qAm9Yi0Ncpt48q5ul29v+Xq2c=;
        b=h+BSr7nzcVl/VJK85l43dZ53c3R/dew3sDBc1izU+D4zMmY5hXgKt3XOIN8FzUmTbI
         ifVG2w1cpoHtf53ja6yKeiv766iBgT8LhTmcYnBGoaqX9a3V4beVLl+CdyswxfpMzyWA
         +w3aSQhH6GRWrTE3LiuhG8kgi1yt+7DyvzdHDjQSPX2d6tbvLO7JpLsTbjCTwNZLjNR+
         IygNUJTxQ3BsBwHq2060RHaY7c64wxsLvYEt6sO+L/kihYbXt4oTZS2UsZ4SNPkvxd7c
         JYAu1lrn6slVW18rjWaa7j3mjsnHujW32GErTKr7hGkiTTH+uqdLAREDKHeurpYZuzn5
         FrWw==
X-Gm-Message-State: AOAM531q0GB3eAZNvDjMfvbjvMm6eEjO8oYhnoX0fiQGgroHB/OzIJVq
        4w44rlHc24fyJPWXITiNj/9yYxuTpCe2sKpY
X-Google-Smtp-Source: ABdhPJzNANajrso0Z/90V3afDcVFS1MtRjnTvra7OEQjdW+YML/3NPAmlcK2yrSPw22QKt2cbotkoQ==
X-Received: by 2002:a2e:7505:: with SMTP id q5mr20774000ljc.322.1620666229513;
        Mon, 10 May 2021 10:03:49 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id k18sm2326255lfg.200.2021.05.10.10.03.49
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 10:03:49 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id t11so24368541lfl.11
        for <linux-s390@vger.kernel.org>; Mon, 10 May 2021 10:03:49 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr17210794lfs.377.1620666218738;
 Mon, 10 May 2021 10:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <AM6PR08MB43763B43D0965E36937022F2F7549@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB43763B43D0965E36937022F2F7549@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 May 2021 10:03:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5G9yZxd9rrNvfZPmVdGW2=2jznD9r8+Xjjz0zQSCUuw@mail.gmail.com>
Message-ID: <CAHk-=wi5G9yZxd9rrNvfZPmVdGW2=2jznD9r8+Xjjz0zQSCUuw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
To:     Justin He <Justin.He@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Petr Mladek <pmladek@suse.com>,
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

On Mon, May 10, 2021 at 8:08 AM Justin He <Justin.He@arm.com> wrote:
>
> >
> > char *dentry_path(const struct dentry *dentry, char *buf, int buflen)
> > {
> >-      char *p = NULL;
> >+      struct prepend_buffer b = { buf + buflen, buflen };
> >       char *retval;
> >+      char *p = NULL;
> >
> >       if (d_unlinked(dentry)) {
> >-              p = buf + buflen;
> >-              if (prepend(&p, &buflen, "//deleted", 10) != 0)
> >+              if (prepend(&b, "//deleted", 10) != 0)
> >                       goto Elong;
> >-              buflen++;
> >+
> >+              // save away beginning of "//deleted" string
> >+              // and let "__dentry_path()" overwrite one byte
> >+              // with the terminating NUL that we'll restore
> >+              // below.
> >+              p = b.ptr;
> >+              b.ptr++;
> >+              b.len++;
> >       }
> >-      retval = __dentry_path(dentry, buf, buflen);
> >+      retval = __dentry_path(dentry, b.ptr, b.len);
>
> I didn't quite understand the logic here. Seems it is not equal to
> the previous. Should it be s/b.ptr/buf here? Otherwise, in __dentry_path,
> it will use the range [b.ptr, b.ptr+b.len] instead of [buf, buf+b.len].
> Am I missing anything here?

No, you're right. That __dentry_path() call should get "buf, b.len" as
arguments.

I knew it was squirrelly, but didn't think it through. I actually
wanted to change "__dentry_path()" to take a "struct prepend_buffer",
and not add the NUL at the end (so that the caller would have to do it
first), because that would have made the logic much more
straightforward (and made the semantics the same as the other internal
helpers).

And that would have fixed that bug of mine too. But then I didn't do
it, and just mentioned it  as a later cleanup.

Good catch.

                  Linus
