Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF0EC432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE986103A
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 17:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhHaRtG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbhHaRtF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Aug 2021 13:49:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B391A610D1;
        Tue, 31 Aug 2021 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630432088;
        bh=FQhT4voOXSGn5CqQjRmxbe6MV9pTwA1BDm62Ac/YtAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5sIhqEgn6qoEOgcoz62ZNo93cV4lQCFydN3JR+VsX1d6DjrErCQzyUspUIvqvFSB
         n1/kZlzCQdmZXJ5QjLE1wwheXwdjiLqI1sosLOFEzLpwyXn8FKdHZkhHKEAqSN5uNT
         UbyqjiRfYUM6Sg9wnZ3fZzL+d1mDK115MLo7CZ+VBbhBt76BoU9CbVm0XxFQFIY3H9
         a8tIiS4yW2QAjjOmLB+6CSvv/SzKXhBpTuQrCCV5LSA1cJmJfY1IbhslMYQlX+rI9v
         0utXk8jYmzNqLIkB9mDWX1fhYjL+LpubEFH+sFujK4Id0fzyGoyR2ZvqmT/5jIMxgW
         xJfeb3VZGcZ9Q==
Date:   Tue, 31 Aug 2021 10:48:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
Message-ID: <YS5rVpFXe4w/D7BN@MSI.localdomain>
References: <YSzZFgBt6nMvpVgc@osiris>
 <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
 <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com>
 <YS4AufXrOCa4rzN0@osiris>
 <CANpmjNPp3dAcr+WfYxM6_uQOmFmDf60aL-LbXF12NCzP6P3-6Q@mail.gmail.com>
 <YS5Ed4Cyf+rOf9MR@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS5Ed4Cyf+rOf9MR@elver.google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 31, 2021 at 05:02:15PM +0200, Marco Elver wrote:
> On Tue, Aug 31, 2021 at 12:46PM +0200, Marco Elver wrote:
> > On Tue, 31 Aug 2021 at 12:13, Heiko Carstens <hca@linux.ibm.com> wrote:
> > [...]
> > > I really don't think this is QEMU related. The test fails are sort of
> > > expected: we've seen KCSAN reports when the kernel boots and wanted to
> > > fix them later.
> > > However I have to admit that I wasn't aware of the KCSAN KUNIT tests,
> > > and wouldn't have sent the s390 KCSAN enablement upstream if I would
> > > have been aware of failing self tests.
> > >
> > > We'll fix them, and I let you know if things are supposed to work.
> > >
> > > Thanks a lot for making aware of this!
> > 
> > Note: Set `CONFIG_KCSAN_REPORT_ONCE_IN_MS=100` (or smaller) instead of
> > the default to make the test complete faster.
> > 
> > The pattern I see from what Nathan reported is that all test cases
> > that expect race reports don't observe them ("not ok" cases), and all
> > those where no races are meant to be reported are fine ("ok" cases).
> > Without actually seeing the log, I'm guessing that no races are
> > reported at all, which is certainly not working as intended.
> 
> I repro'd, and the problem is part QEMU TCG and a minor problem with
> stack_trace_save() on s390:
> 
> 1. QEMU TCG doesn't seem to want to execute threads concurrently,
>    resulting in no "value changes" being observed. This is probably just
>    a limitation of TCG, and if run on a real CPU, shouldn't be a problem.
>    On QEMU, most test cases will pass with CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
>    (There's one left that requires value changes to be observable)

Is this just a limitation of s390's TCG implementation or in general?
Our CI runs on GitHub Actions, which does not support virtualization so
I believe that all of our tests are being done with TCG and x86_64
passes just fine:

https://github.com/ClangBuiltLinux/continuous-integration2/runs/3473222334?check_suite_focus=true

Good to hear that it is working on bare metal now though, we could still
enable build testing of it at a minimum but it would be nice to see the
tests pass even in QEMU :)

Cheers,
Nathan
