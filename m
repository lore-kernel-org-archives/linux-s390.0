Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F926C432BE
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DE960ED4
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhG2M1r (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhG2M1r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Jul 2021 08:27:47 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B558C0613C1
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 05:27:43 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 13-20020a4ae1ad0000b029024b19a4d98eso1524045ooy.5
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAeYpTpD86gcaq0fp6AOwIIDB2L6QnWwp67+iHCveIY=;
        b=ml7Q/Yn+L1JNrhw7y+0CfmimrYs8yNnxEQL5SIK39c4Q4kU9hmEqtqiUIj7p0lualS
         0vl5sVIyOjyzAJs3BAYo00cW5Xuzev16ok5ctZ1VenR5k5EXd9Hs4EhZnOyoCHNxd2e8
         h6gi/8lbU8DnWXPHHV9lzdhTWrNGRNs/TgW0907rIkBQJgmhpBfuZUCcl9P5uAbSbudl
         6PY2SQe37ZnHdElfZ4fPaT+GKxN2JRT/bytQfZ5pkpMxa5xqutvqEJQNyuWCQq3v8OZD
         uIvrWImjE/wtpdzv+NDPzLdp+rslqBSRMHRTF3PRKSl0ihPR9C/7MqQwEX3Gsd5sw7Nl
         5txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAeYpTpD86gcaq0fp6AOwIIDB2L6QnWwp67+iHCveIY=;
        b=DrwSYoQSwPsPQSuxhqrXLGB5VBzIstNNwrfbtPDZyWaSS9w+4bnseosr3WJjoiOo2j
         udXMor2jrhLIX4BEJVrnk45xNsPp4/MTCEryjDG5KJi6KHzrU1vjE96mRus/RO/cYbYq
         pUalzG3eq6Pb2DNp7x7KURB7aQ9wO9ypdPm3wngW1citWptg1bzPVZmYTiCMkyN7O/En
         4ZsoXtpuZgkyH8QiaSvUIW13SFXnfLIuEKfbDX7BiQE4sWDoSoH/UlATV8lLoMKEkHSA
         MlvCFfC6SgQ4maa9LJ7AKytCM0tqxfby3N17uVfC2zW+N8bXnTMIoPzg+NkjqJ6VepTv
         OwZA==
X-Gm-Message-State: AOAM532usdxLTLbxaqZN5jw1t1IdiAldA+IGOde08cqYAc/+7pG9U+YY
        8WHKaa4IAdoC6mA9Qfzs7qZLfp4L9F7+3V5QGriAtA==
X-Google-Smtp-Source: ABdhPJzdZqCMYw/artCLUUOUtHTdZ/eyCd1qEAfxK53RlOp+/u7kO6WD0K9TwsO2g5IRhUr+gY/uSniuVTaTdFDFO3w=
X-Received: by 2002:a4a:e502:: with SMTP id r2mr2827562oot.36.1627561662128;
 Thu, 29 Jul 2021 05:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210728190254.3921642-1-hca@linux.ibm.com> <20210728190254.3921642-3-hca@linux.ibm.com>
 <YQJdarx6XSUQ1tFZ@elver.google.com> <YQKeNbU4HJhFP8kn@osiris>
In-Reply-To: <YQKeNbU4HJhFP8kn@osiris>
From:   Marco Elver <elver@google.com>
Date:   Thu, 29 Jul 2021 14:27:30 +0200
Message-ID: <CANpmjNPWj2vjNd2V-Wqgh1+AvmKQEbg=Qh43DQ_5P2vNv7+JDw@mail.gmail.com>
Subject: Re: [PATCH 2/4] kfence: add function to mask address bits
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 29 Jul 2021 at 14:25, Heiko Carstens <hca@linux.ibm.com> wrote:
> On Thu, Jul 29, 2021 at 09:48:58AM +0200, Marco Elver wrote:
> > On Wed, Jul 28, 2021 at 09:02PM +0200, Heiko Carstens wrote:
> > > From: Sven Schnelle <svens@linux.ibm.com>
> > >
> > > s390 only reports the page address during a translation fault.
> > > To make the kfence unit tests pass, add a function that might
> > > be implemented by architectures to mask out address bits.
> > >
> > > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> >
> > I noticed this breaks on x86 if CONFIG_KFENCE_KUNIT_TEST=m, because x86
> > conditionally declares some asm functions if !MODULE.
> >
> > I think the below is the simplest to fix, and if you agree, please carry
> > it as a patch in this series before this patch.
>
> Will do.
>
> > With the below, you can add to this patch:
> >
> >       Reviewed-by: Marco Elver <elver@google.com>
>
> Done - Thank you! I silently assume this means also you have no
> objections if we carry this via the s390 tree for upstreaming.

I think that's reasonable. I'm not aware of any conflicts, nor am I
expecting any for the upcoming cycle.

Thanks,
-- Marco
