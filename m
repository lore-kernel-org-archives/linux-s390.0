Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33151C433B4
	for <linux-s390@archiver.kernel.org>; Sat,  8 May 2021 22:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0770F61400
	for <linux-s390@archiver.kernel.org>; Sat,  8 May 2021 22:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhEHWTQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 8 May 2021 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEHWTQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 May 2021 18:19:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A801C06175F
        for <linux-s390@vger.kernel.org>; Sat,  8 May 2021 15:18:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gx5so18951641ejb.11
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHc9UIBjTxYwQ2qdPehUPMXva9JHKCzKPwFeTF9Fa94=;
        b=heC0caQARc4D7+OqUNzmbrsEYq2uK5KdJ/cWF8iq0+1cYFFdyg+INwvRb25pkTTOsr
         7x7TQNNF36nD2Gmf+fvnO9HRiTdBVsNWjLMZ5jQJk1oktUnPxFyM43QdMrl0YfvfSk9Y
         k9cDINYHtih4EAW+qlMGno1XJVtz6+rOIKDt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHc9UIBjTxYwQ2qdPehUPMXva9JHKCzKPwFeTF9Fa94=;
        b=f8rjMyCiLjd2l3aZN4ibthaS89eofoYn2BoyuQHEYOO1kwMXwlAahIuD60VJS8jVCr
         WEl8LOlHznLC3c0c+7xMTa4MxBAKmABH5d3sBEAZIky5rdkG53B9yNZRnx/hN9hYXKpf
         1GjUAKHFRMuF7k3GV7UtcmPyWxL+2tMXEuhos2R+jFuyAOrAeBBT+Ot58aQQr0/K1J3e
         Mh4TfQpiBDp44SWr7cK2VRL4vMz09YCuyr2Iaaw7HGVJPRf7bixETIZ1M9z3X9Grp6cT
         YLIr90KEmUez0DqE8KADyp3Y5Xzb6lUe4K3mo+EjWfSsLcWrIjX2RFfHiq8TIxxzkpIY
         UhNg==
X-Gm-Message-State: AOAM531Y86qjRQ6JWBv0LYQai/Us2Gmlzl358YuMWIGMFHBNqSWXLn6b
        ky9b8KDMcCxl7I2gIcgNSnLbsbVuhrbVjzqj9ZI=
X-Google-Smtp-Source: ABdhPJzsZXMilnd8Lm+wGqMc530uxUFGn+Ih7mR46BUhKxGnFbn0TbtzQjjFD9w0sS+Eeb5NMOMB7A==
X-Received: by 2002:a17:906:2dc6:: with SMTP id h6mr17766000eji.477.1620512291602;
        Sat, 08 May 2021 15:18:11 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id re26sm5911182ejb.3.2021.05.08.15.18.11
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:18:11 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id s8so12750523wrw.10
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 15:18:11 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr10956114lfs.377.1620512280216;
 Sat, 08 May 2021 15:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
In-Reply-To: <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:17:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
Message-ID: <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
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

On Sat, May 8, 2021 at 2:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, May 08, 2021 at 01:39:45PM -0700, Linus Torvalds wrote:
>
> > +static inline int prepend_entries(struct prepend_buffer *b, const struct path *path, const struct path *root, struct mount *mnt)
>
> If anything, s/path/dentry/, since vfsmnt here will be equal to &mnt->mnt all along.

Too subtle for me.

And is it? Because mnt is from

     mnt = real_mount(path->mnt);

earlier, while vfsmount is plain "path->mnt".

> > +                     return 2;               // detached or not attached yet
> > +                     break;
>
> ?

Leftover. Good catch.

> > +             parent = dentry->d_parent;
> > +             prefetch(parent);
> > +             error = prepend_name(b, &dentry->d_name);
> > +             if (error)
> > +                     break;
>
> return error, surely?

Surely. Bad conversion to the separate function where I missed one of
the "break" statements.

> FWIW, if we go that way, I would make that

No arguments against that - I tried to keep it with the same structure
it had when it was inside prepend_path().

Which I obviously wasn't very good at (see your fixes above ;), but it
was *meant* to be a minimal patch with no structural change.

                      Linus
