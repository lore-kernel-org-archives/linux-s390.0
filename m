Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A383C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 17:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285D2608FB
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 17:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhJKRdc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Oct 2021 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhJKRdb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Oct 2021 13:33:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF9C061570
        for <linux-s390@vger.kernel.org>; Mon, 11 Oct 2021 10:31:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u18so76420041lfd.12
        for <linux-s390@vger.kernel.org>; Mon, 11 Oct 2021 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OT203vnjB7/zUlFzlItVKI17MBCGdyaAlk+HzafniWc=;
        b=Irz3Tcxj1xe1q8LLa/BtO916dIui2Sq+1sBTNiyk8aBXvZyEOJt03BLDAGjpvrBrZD
         1UUz4TersnrZsmjO89yk4htL/czSDG5g9yiJMsHxYmCH7qnbqyK2E36v12Ab0NAuwvxY
         UYwcu/4VzzK9WVS96I4YX4MliKGpFXCnT7qgbxTVFHH/UxZ6AKxbo09QhVLOOI5q/DC0
         GJh+OWEd/TM+v/NbMcNlogrxda5KuUu43gt2/Ij5BVYW3E27d82umUin+p8eSDPWJu9r
         YZ+BsTP0cQjBSA+7Cyiee//LpdupyUMR7NtzhHVaZP9qPYpLdCdd6ZiGyAtHv5qsmhlJ
         u77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OT203vnjB7/zUlFzlItVKI17MBCGdyaAlk+HzafniWc=;
        b=HYxTnTdrPvoHNtZlFchbEwemw48lxfGN77GHpUow9Xvgbr3mZPIa7FON6+3VOjorfV
         He3T1zYreY00T/8MuZZJKnwhInpgvVNA7PuT1xqXByRECWQatL8eMr7G8y/j9LOp0kxu
         5Y+PS3oFffBllVQP+xj52noysfZXL6j3kQy2BpA+jnhF0jYmKT4FF5qcR/zWqvnPfarF
         XjRso7YtofitmoDuNVSRHmQH7fDdV70AqgwUwuR6hLjBxHjIHm5dMthCJdgOBtoTAnoy
         JQ5gRnCWdXsafOHZTWlNNVZufZyc3brnzciNnE1JWH221apWfD/NtNSwd+/aRnoRaioY
         nwBQ==
X-Gm-Message-State: AOAM531r26/Tuh/Lhgn8L7HWYeBPRIkk4x9bDgzgYHgwajcl9L/zrDQ9
        bMuxIB4sdspSr/glSDLKIn3ouGFkxeiGu3hbKNEavg==
X-Google-Smtp-Source: ABdhPJyzVgthy6KpGM2XZvlREfCX58/w84OF82adREJoZf1l+wVrm5xDU7/iQQLFAjCAgnWrfdkUyBj6bLAZXFjApdY=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr24899757lja.198.1633973489480;
 Mon, 11 Oct 2021 10:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuqwJD5bFO74vG6Mvbbt1G8rxzd_NDHg-gtOZ6rPjeu3A@mail.gmail.com>
 <YWQLUd+BQ1Cc88HG@osiris>
In-Reply-To: <YWQLUd+BQ1Cc88HG@osiris>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Oct 2021 10:31:17 -0700
Message-ID: <CAKwvOdmrqqqMRLuJ3VLk5K+3Z=qaAbuYkMAo=u1UdfjX=7muAw@mail.gmail.com>
Subject: Re: clang-13: s390/kernel/head64.S:24:17: error: invalid operand for instruction
To:     Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        nemanja.i.ibm@gmail.com
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, llvm@lists.linux.dev,
        linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

+ Nemanja


On Mon, Oct 11, 2021 at 3:01 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Mon, Oct 11, 2021 at 11:47:42AM +0530, Naresh Kamboju wrote:
> > [Please ignore this email if it is already reported ]
> >
> > Following s390 builds failed due to warnings / errors.
> >
> > metadata:
> >     git_describe: v5.15-rc5
> >     git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >     git_short_log: 64570fbc14f8 (\"Linux 5.15-rc5\")
> >     target_arch: s390
> >     toolchain: clang-13
> >
> >
> > Fail (2861 errors) s390 (tinyconfig) with clang-nightly
> >   @ https://builds.tuxbuild.com/1zL35IUSGhDGeVuyIrAp7eyzEUi/
> > Fail (2861 errors) s390 (tinyconfig) with clang-13
> >   @ https://builds.tuxbuild.com/1zL35Hn7wjErKsLDM6zAgh27BYJ/
> > Fail (4112 errors) s390 (allnoconfig) with clang-13
> >   @ https://builds.tuxbuild.com/1zL35HR60hSFvBmAcYJvKHm8Lko/
> > Fail (4112 errors) s390 (allnoconfig) with clang-nightly
> >   @ https://builds.tuxbuild.com/1zL35DTlrX9qRGCtGqgtmmMDjnQ/
> > Fail (23048 errors) s390 (defconfig) with clang-13
> >   @ https://builds.tuxbuild.com/1zL35DE2KWQUPxbbXeTbwIJaWXS/
> > Fail (23045 errors) s390 (defconfig) with clang-nightly
> >   @ https://builds.tuxbuild.com/1zL35EgeQfWQDXDupp4itkUO5At/
> >
> >
> > Build errors log:
> > ----------------
> > arch/s390/kernel/head64.S:24:17: error: invalid operand for instruction
> >  lctlg %c0,%c15,.Lctl-.LPG1(%r13) # load control registers
> >                 ^
> > arch/s390/kernel/head64.S:40:8: error: invalid operand for instruction
> >  lpswe .Ldw-.(%r13) # load disabled wait psw
>
> You need to pass LLVM_IAS=0 on the make command line on s390 since
> commit f12b034afeb3 ("scripts/Makefile.clang: default to LLVM_IAS=1").
>
> LLVM's integrated assembler doesn't seem to work well when compiling
> the kernel for s390 yet.

Dunno if you folks have cycles to work on it, but if you do, we have
just a handful of bugs left in Clang's assembler (or kernel source
issues) preventing us from assembling the kernel with clang for
SystemZ and PPC.

s390:
https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+s390%22+label%3A%22%5BTOOL%5D+integrated-as%22

ppc:
https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BTOOL%5D+integrated-as%22+label%3A%22%5BARCH%5D+powerpc%22

I'm happy to hop on a call to discuss these more.  We have all other
architectures working here, in the sense that if we can build them
with clang, we're using the integrated assembler by default.
-- 
Thanks,
~Nick Desaulniers
