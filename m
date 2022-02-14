Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8B2C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 14 Feb 2022 20:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiBNUMH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:12:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiBNUMG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Feb 2022 15:12:06 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C28120F69
        for <linux-s390@vger.kernel.org>; Mon, 14 Feb 2022 12:11:50 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id h8so13240224ejy.4
        for <linux-s390@vger.kernel.org>; Mon, 14 Feb 2022 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgwPr3jWEXZiHeYJRBUfKrH3C5wLRAnP7Z6R5s1EJ5U=;
        b=ZcumWtnhggjMFDUHhywZOsPSWocj5WFiFD4wxX4meGi3Jv+FEek8bAx8wm544tPFuD
         FZMy/4sQc4BwvneObDdXEv1mNtlI8GPACMt1JW8whp1hkRcRU1/uCicaO7g7UXSaSO+q
         JQ0jz81cHBjFl3QlKdIkLJ7hR07DlS4kmaNNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgwPr3jWEXZiHeYJRBUfKrH3C5wLRAnP7Z6R5s1EJ5U=;
        b=yUWT2E1zyyG6BM2fS7HBrk8ngxq6dDojXEuL7o/RVlvy+PwKr1gIRgo73f+j8rX77v
         Xqx7J14j/yXh/Y4GH2P9Vp+gnLxJWoMCpbThSDgx+VVoORyfW9sLDTm4clH5KmiQ6rSx
         Bc5+A8dYNYmto4XCyWK/hzJDogyl9D5XXrVrPcvySivLdejDvss4rwyuuj276sv2qGrQ
         7rz4Wq4XvT0oZJpqT6WPWg9pdP4e4SZKhg7+t3ucb/lSk/bBySiRPe7ChwCqixbbn19Q
         Rglze4yuySETe+APwwBN1cE7oy6KPSYwOivYtBoY+4f9l3ewRNM1M+e9SubqT6TP9cxd
         dm2g==
X-Gm-Message-State: AOAM532ljsfMeqQK6r5/vrmbD7utbnA3HmsEiuhS+vcUAEWAXU6wL+TQ
        bd7R2UyEm6OjscIR3+wMv/9ws1fsbptuOMlPRwk=
X-Google-Smtp-Source: ABdhPJygMicOUdiIdYn7v1RY2NjZ3vVlsPvkepUcesSfRXLWwR8Me1dcZg2akeCNrv77V8W15nUl1g==
X-Received: by 2002:a17:906:5349:: with SMTP id j9mr356287ejo.412.1644869224585;
        Mon, 14 Feb 2022 12:07:04 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id x22sm8251282edd.63.2022.02.14.12.07.04
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:07:04 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id k1so28665074wrd.8
        for <linux-s390@vger.kernel.org>; Mon, 14 Feb 2022 12:07:04 -0800 (PST)
X-Received: by 2002:a2e:a231:: with SMTP id i17mr205093ljm.443.1644868881602;
 Mon, 14 Feb 2022 12:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-5-arnd@kernel.org>
 <YgqLFYqIqkIsNC92@infradead.org> <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
In-Reply-To: <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Feb 2022 12:01:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
Message-ID: <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
Subject: Re: [PATCH 04/14] x86: use more conventional access_ok() definition
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Feb 14, 2022 at 11:46 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> As Al pointed out, they turned out to be necessary on sparc64, but the only
> definitions are on sparc64 and x86, so it's possible that they serve a similar
> purpose here, in which case changing the limit from TASK_SIZE to
> TASK_SIZE_MAX is probably wrong as well.

x86-64 has always(*) used TASK_SIZE_MAX for access_ok(), and the
get_user() assembler implementation does the same.

I think any __range_not_ok() users that use TASK_SIZE are entirely
historical, and should be just fixed.

                 Linus

(*) And by "always" I mean "as far back as I bothered to go". In the
2.6.12 git import, we had

    #define USER_DS          MAKE_MM_SEG(PAGE_OFFSET)

so the user access limit was actually not really TASK_SIZE_MAX at all,
but the beginning of the kernel mapping, which on x86-64 is much much
higher.
