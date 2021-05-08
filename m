Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333F2C43462
	for <linux-s390@archiver.kernel.org>; Sat,  8 May 2021 22:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073A961415
	for <linux-s390@archiver.kernel.org>; Sat,  8 May 2021 22:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhEHWnh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 8 May 2021 18:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhEHWnc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 May 2021 18:43:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4CBC061760
        for <linux-s390@vger.kernel.org>; Sat,  8 May 2021 15:42:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j26so10788005edf.9
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qvrf78C1VckxwN+Rd5iRKXM/TVBAx3SQ0yt8T9W1XI=;
        b=DHL714aYp4X3y/ZDPD/BxJq1zv4WKtKia+ktMgIzEElXklJlzicJbZPsvSVxT/1xq/
         ll2tgIA7+11guksgQhLfWHypKFmuq96HS2x73V3P8fR1NgWiz+KeFKOCZmlgoTLzSEA6
         tLX8U9qAEO26/nlzd5qfUVlzthZNMMtHZNWBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qvrf78C1VckxwN+Rd5iRKXM/TVBAx3SQ0yt8T9W1XI=;
        b=ucjzcOm87nBuXsZHOELA4jLzDv3Q5RoAofZRXuOMn5QPbQNYXY4PRcsI0CUZyRPck4
         vzFltxfUo6nouduPh35XSHIS7oPWW3pqnsQzQ8IK3PSIXEqUdvGGw3uykbAUTcldLSpO
         ZkYesEZWxWgWjbWBBdCawG3Cwb6d+vuHC89VJ1KcIogQ+TJ4wNc43xjvGRYvWiSCTJuR
         BWegfInTOUTR2p0Ed806hvcRwmTU+LjSpCer+zDvsbk0c8eqO6TVgFjy2eQLvf5i/mPp
         gfXp1Jo5sUiSltXe42cieW7B/rNxrQ8I1brlP+r5KGhww6tXeNuiqKfSsD1BloUN0Q9/
         jrAQ==
X-Gm-Message-State: AOAM530WTWi1xD0Aq4zV8CMtcaqVNFhtlXULvy+8rUXKCbeGCBQkRSIB
        Oouzt7G0tNcafcmZHA3rsTZU/+ONJDDp770KQ/4=
X-Google-Smtp-Source: ABdhPJzlZx+L4Ohqv72j85PG7q21QOLdJHFVC6+krf7CS+QmKvkzWxi3ZkrvDcbEFhvvzRNnht2bsA==
X-Received: by 2002:a05:6402:177c:: with SMTP id da28mr19674386edb.135.1620513746732;
        Sat, 08 May 2021 15:42:26 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id p18sm5888110ejb.19.2021.05.08.15.42.26
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:42:26 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id l13so12747437wru.11
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 15:42:26 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr11039558lff.421.1620513735912;
 Sat, 08 May 2021 15:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
In-Reply-To: <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:42:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
Message-ID: <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
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
> FWIW, if we go that way, I would make that
>
>         while (dentry != root->dentry || &mnt->mnt != root->mnt) {
>                 int error;
>                 struct dentry *parent = READ_ONCE(dentry->d_parent);

Side note: you've added that READ_ONCE() to the parent reading, and I
think that's a bug-fix regardless. The old code does that plain

                parent = dentry->d_parent;

(after doing the mountpoint stuff). And d_parent isn't actually
guaranteed stable here.

It probably does not matter - we are in a RCU read-locked section, so
it's not like parent will go away, but in theory we might end up with
(for example) pre-fetching a different parent than the one we then
walk down.

But your READ_ONCE() is definitely the right thing to do (whether we
do your re-org or not, and whether we do this "prepend_buffer" thing
or not).

Do you want to do a final version with your fixes?

               Linus
