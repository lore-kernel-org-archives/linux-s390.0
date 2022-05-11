Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E7FC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 11 May 2022 20:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbiEKUwV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 May 2022 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiEKUwU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 May 2022 16:52:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C50E4D624;
        Wed, 11 May 2022 13:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBB24B82617;
        Wed, 11 May 2022 20:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C670FC340EE;
        Wed, 11 May 2022 20:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652302335;
        bh=hcTWqS1/6JNEKbDUnWjOFRHI/i50sXfXkf41lVpBiUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQ6kXVe3mk9WbijP8yialUY26FPJdZZek0VQ97glkAophocZ78ag+Z+cbqXRkCud3
         t/IJkpTKXPiSeyKFX6zDv2NQPeqP5hp5TlJt6NsPEFZgJ6clX5DndoZpGYXZJK7zWr
         NLwvowhEoNMsnvxZOX9T928N41cLWyh6R86/yPz960nVtV9B8YP3Vz8Is8KjgTwRZ4
         wyF9uru+cjyo3ByvguTNiMIYU/v0RUoSulCuLeiqlDdi+tXuTejPwiaVmNw8kRvy2E
         dF1fiENoX8j5IwmuKnM441MnHbxU+3+IezmHa5GzPLjCkzEQDAWZ5WMfvX7AJ41VSw
         9LZUpfiR6dSbA==
Date:   Wed, 11 May 2022 13:52:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/8] s390: allow to build with llvm's integrated assembler
Message-ID: <Ynwh/Uk3IyiyRzO3@dev-arch.thelio-3990X>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511120532.2228616-1-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Heiko,

On Wed, May 11, 2022 at 02:05:24PM +0200, Heiko Carstens wrote:
> A couple of patches which in result make it finally possible to build the
> kernel for s390 with llvm's integrated assembler. Several configs build
> without errors or warnings, and the kernel also works as expected.
> 
> Note that patch 6 ("s390/boot: workaround llvm IAS bug") reveals a
> miscompile. This looks like a bug in the instruction definitions of the mvc
> and clc instructions(?). I'd like to ask people to look into this, since
> this silently generated broken code.

I think it should be pretty simple to file a bug report for this since
it occurs in a standalone assembly file? I agree with Nick that there
should be a bug report filed and linked to in patch 6 so that we don't
lose track of it.

> This patch series is based on linux-next, which contains two additional
> required s390 specific patches to make llvm's IAS work.
> 
> Thanks,
> Heiko
> 
> Heiko Carstens (8):
>   s390/alternatives: provide identical sized orginal/alternative sequences
>   s390/alternatives: remove padding generation code
>   s390/entry: shorten OUTSIDE macro
>   s390/entry: workaround llvm's IAS limitations
>   s390/purgatory: workaround llvm's IAS limitations
>   s390/boot: workaround llvm IAS bug
>   s390/boot: do not emit debug info for assembly with llvm's IAS
>   scripts/min-tool-version.sh: raise minimum clang version to 14.0.0 for s390
> 
>  arch/s390/Makefile                      |  2 +
>  arch/s390/boot/head.S                   | 34 +++++----
>  arch/s390/include/asm/alternative-asm.h | 76 +++-----------------
>  arch/s390/include/asm/alternative.h     | 93 ++++++-------------------
>  arch/s390/include/asm/spinlock.h        |  2 +-
>  arch/s390/kernel/alternative.c          | 61 +---------------
>  arch/s390/kernel/entry.S                | 39 +++++++----
>  arch/s390/lib/spinlock.c                |  4 +-
>  arch/s390/purgatory/head.S              | 29 ++++++--
>  scripts/min-tool-version.sh             |  3 +-
>  10 files changed, 104 insertions(+), 239 deletions(-)

I applied this series to the latest s390 for-next branch (c4fb15578802)
and built a few in-tree and distribution configurations with clang-14
and clang-15 then boot tested them in QEMU with a simple buildroot
userspace. I did not see any new warnings or errors. This is awesome, I
am excited to get this wired up in our CI!

In case it is worthwhile:

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan
