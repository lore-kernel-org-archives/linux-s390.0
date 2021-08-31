Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DF1C432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 10:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAA660F4B
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 10:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbhHaKrJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241248AbhHaKrH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 31 Aug 2021 06:47:07 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BFFC06175F
        for <linux-s390@vger.kernel.org>; Tue, 31 Aug 2021 03:46:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso22139553ota.8
        for <linux-s390@vger.kernel.org>; Tue, 31 Aug 2021 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/7V7+7rWRxslepcC696+4LLIXt+f9974ayEMgxKj90=;
        b=f1+eAA8Bbvw1rIg30yw2PdmVyf5r85w0D9NUeAlDymmLxEBoMAlQ13y3IXGQd115DW
         cBm1S4pxH9D6dMlRZyRmQw4M7EwDL+pMVV6nFejpqyEoWaN+3pY+MzjCOb2GCvNT5N/y
         rqi8+OlO8j89JgGZT2I9vO+FqnELe1sz7rUSqsXBc10qvbtKBO6EDPEvLykpqWk7AjAP
         Dd8UNQMSdIAHbH4qQ6QHJFoVED0gpuaR1FAIWDDpla0pjIyFgOVmuv/SNIcqtBl0BCs1
         3b2cLtZltEmjgG4xM1OAN8eXE3ZRciaG2j2EQgJrAopYNowJxbKz0TfyIMQev1jZxjmo
         +9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/7V7+7rWRxslepcC696+4LLIXt+f9974ayEMgxKj90=;
        b=ZhorJIAgOiW8vv+DO9n8wYq0UCCTwanhhMzYHdtd8A1/lI/Sj00XfO4BY0AK4QGXls
         E6kZbyIQlzxFhBITqVS1R83SfRBIufSf+R7V5iDe3HTvNYBE8IVj4aJ56cR0bkhu1IOh
         yPb5JdkBPNu2FIPZih6FEclFYOxmXVP5FC9lRfshRlyqVXLkmXhoSwHbXfieoQ1koi6t
         hHO2rwP14sLFab6TLTlGRdYBHYl6e/woO4Rx+BxlWXiWiaT+TWGb/pXRTSkHvJkvIaWu
         lpZhT/P0n/2CYgwtoXsQZ6o9o7HqXK7B6yTYtVYoC81Aks2fZLumubwA/CZwwdOKZxii
         f7bg==
X-Gm-Message-State: AOAM531H+Y87pv1O2RsRiHGU9oLsiQ3bLGO1wkcJCmX9ezYnSdhGYFwo
        vk+3vDgBBTsg/FaQVb1ejA3+uN3qBYTAHNEHKWZRwQ==
X-Google-Smtp-Source: ABdhPJyu+Z8Xkx3NWpgNa22ldJTrqozVi6Vovf8TudABz9dYWV/rDq5QZYR7OYHQuMz5qke81X/dIh+qVB3Dt5Nw+vk=
X-Received: by 2002:a9d:4104:: with SMTP id o4mr13616099ote.251.1630406771875;
 Tue, 31 Aug 2021 03:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <YSzZFgBt6nMvpVgc@osiris> <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
 <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com> <YS4AufXrOCa4rzN0@osiris>
In-Reply-To: <YS4AufXrOCa4rzN0@osiris>
From:   Marco Elver <elver@google.com>
Date:   Tue, 31 Aug 2021 12:46:00 +0200
Message-ID: <CANpmjNPp3dAcr+WfYxM6_uQOmFmDf60aL-LbXF12NCzP6P3-6Q@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 31 Aug 2021 at 12:13, Heiko Carstens <hca@linux.ibm.com> wrote:
[...]
> I really don't think this is QEMU related. The test fails are sort of
> expected: we've seen KCSAN reports when the kernel boots and wanted to
> fix them later.
> However I have to admit that I wasn't aware of the KCSAN KUNIT tests,
> and wouldn't have sent the s390 KCSAN enablement upstream if I would
> have been aware of failing self tests.
>
> We'll fix them, and I let you know if things are supposed to work.
>
> Thanks a lot for making aware of this!

Note: Set `CONFIG_KCSAN_REPORT_ONCE_IN_MS=100` (or smaller) instead of
the default to make the test complete faster.

The pattern I see from what Nathan reported is that all test cases
that expect race reports don't observe them ("not ok" cases), and all
those where no races are meant to be reported are fine ("ok" cases).
Without actually seeing the log, I'm guessing that no races are
reported at all, which is certainly not working as intended.
