Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3408C4332F
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDAC6113B
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhINPnC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhINPnA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Sep 2021 11:43:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B6EC061766
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 08:41:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x11so30002698ejv.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgZDRvewpIcHvEl+aClDgx6dxTBkhTg+5FlC2P6kQVc=;
        b=BpcuMcoHH1B5L3A9rysqIc0UNfq5noiLE14zKeR1TSa0gFC85lOw2Beo8dO5honWby
         rYyCHFnHkKNi7MCpw7JrIjMcXxBeTw1cz/rDSABmNfOTKR6Ymn6YfZNGpWuykLc9dauc
         iTDBkLKWwlR9RhIlCft6lceQmUvWAku/ar3t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgZDRvewpIcHvEl+aClDgx6dxTBkhTg+5FlC2P6kQVc=;
        b=OiRHvx9oTLn7snAjqH2XtU5c3aomvhc8QktKjiCN6hx/CjvM7hTJOgRRjUe7ijQkx+
         khueXkIxUFxuvcMIKla/HQh5TCLs8+SztP9Csctq9RlXGqIR+yj0aHI85jqB0ZKZ1Wxp
         oQi4pCbEcSnhrENpbA5XwBwibjhnXsHYvVPRSFlIQUHUnx6h4Ote1NSNrsbdWPGxiBg5
         +VNBdg/2tXFZ5HJxOv5nSGpeHyodlLcyLYFndpU/8gXW2J1j5zLC2iM2Kqd7dWe80b/C
         NvqLXh7HB36YkVGuMfqNccUUZrHFnSVtXMn9Lh18Vq2BT/Y88iY5xW0Bj4+1iZZhwOlD
         Jc3g==
X-Gm-Message-State: AOAM530f5jXbXuXLlkzYkDW+M9gayEjXc7fVa5T18ZJHLy4tyg080bha
        piJvD09qBuoCdVAygVud3SQPmDiKGAu8UgrLftE=
X-Google-Smtp-Source: ABdhPJxb/kteOE3kwsHVcAbCS9DQrD3UrY6OVHt7ACDPsEUY21xzHyly8jVFDlTmGl3FbM5rKwsGKg==
X-Received: by 2002:a17:906:35d8:: with SMTP id p24mr19350067ejb.292.1631634100633;
        Tue, 14 Sep 2021 08:41:40 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id f22sm5178239ejz.122.2021.09.14.08.41.40
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 08:41:40 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id x6so20936415wrv.13
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 08:41:40 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr15637818ljp.494.1631634089537;
 Tue, 14 Sep 2021 08:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-2-ardb@kernel.org>
In-Reply-To: <20210914121036.3975026-2-ardb@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 08:41:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkCzP-wyZ08r9RDJRx9cbANVHy-jy=vJAGTkSbXm50iA@mail.gmail.com>
Message-ID: <CAHk-=whkCzP-wyZ08r9RDJRx9cbANVHy-jy=vJAGTkSbXm50iA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] arm64: add CPU field to struct thread_info
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 14, 2021 at 5:10 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The CPU field will be moved back into thread_info even when
> THREAD_INFO_IN_TASK is enabled, so add it back to arm64's definition of
> struct thread_info.

The series looks sane to me, but it strikes me that it's inconsistent
- here for arm64, you make it unconditional, but for the other
architectures you end up putting it inside a #ifdef CONFIG_SMP.

Was there some reason for this odd behavior?

           Linus
