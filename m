Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DB2C43460
	for <linux-s390@archiver.kernel.org>; Sat,  8 May 2021 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF2961402
	for <linux-s390@archiver.kernel.org>; Sat,  8 May 2021 22:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhEHWtJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 8 May 2021 18:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhEHWtI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 May 2021 18:49:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB25C06175F
        for <linux-s390@vger.kernel.org>; Sat,  8 May 2021 15:48:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so19031821ejy.7
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 15:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uU2C84LxLUzQFwZElgypUBzdpgy1KMmCT9LOJvhbML4=;
        b=RAYIrloAyTI0escC4FJrZEqff58mGNKpKYKPCWyfaq6tPSVX7E0HvbEpZICexuWOJl
         cTb8VTtrxxvNrokrOEsTOilRR8r0Du+gtbA27yAia0bgOluq1xb1ES21ZBT6x5owDQfQ
         d+VnnukbT/eYVV1K8DnY34CmcMlPrprr6+vgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uU2C84LxLUzQFwZElgypUBzdpgy1KMmCT9LOJvhbML4=;
        b=A3PpCtWvMU3wN54xQN99A1uuDLIGf6IRjnDMHmiDbnB7B885IcFrZassnu+PgFwsd+
         bEieCHP3N92+H+5KzKRq63GqU1pb8wWxutt96dvbzb7y+qK5kOPL9HqomY745nZPw6Fp
         nByDuc/JkxljIpuCqX6Aw+f8FTJoxc4iRKJeuaXqy7toRJx3E4dmzJHSLF9WkxF0qYyf
         7ezWC61fGkvWDVt8XSzNc3q7WoOufx88Z7/ThDvvfsa5QRR9H5CpahB9Ze3oln5BXLzD
         juEFY+RYOah9XoFcJTZ7oFkVsWcnm7puMEfx21zwOOtVSeLkh8lW+V59Mbga06xJ+Qbk
         6tjA==
X-Gm-Message-State: AOAM532euXv65rlaGrUqMieHChtpjJWpmsKU/gPPzuF2jyRQVMCQV94E
        G96Grm2xlSt/TjX3g+JxXz1UTyzKuC152JJ/SHY=
X-Google-Smtp-Source: ABdhPJwRgxZIgLReAbAy5AYeaPfeVQgd+jWjv3TWMRLtsPpcXgVfvj0fVdBNyzj8Yfy5djNdWnT+0A==
X-Received: by 2002:a17:906:454:: with SMTP id e20mr17864841eja.17.1620514085201;
        Sat, 08 May 2021 15:48:05 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id j8sm7266540edq.67.2021.05.08.15.48.04
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:48:05 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id t4so19120213ejo.0
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 15:48:04 -0700 (PDT)
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr10765354lfg.40.1620514074003;
 Sat, 08 May 2021 15:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
In-Reply-To: <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:47:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com>
Message-ID: <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com>
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

On Sat, May 8, 2021 at 3:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But your READ_ONCE() is definitely the right thing to do (whether we
> do your re-org or not, and whether we do this "prepend_buffer" thing
> or not).

Oh, and looking at it some more, I think it would probably be a good
thing to make __dentry_path() take a

       struct prepend_buffer *orig

argument, the same way prepend_path() does. Also, like prepend_path(),
the terminating NUL should probably be done by the caller.

Doing those two changes would simplify the hackery we now have in
"dentry_path()" due to the "//deleted" games. The whole "restore '/'
that was overwritten by the NUL added by __dentry_path() is
unbelievably ugly.

            Linus
