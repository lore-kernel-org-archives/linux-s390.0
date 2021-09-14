Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811EEC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D646112D
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhINPoS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234946AbhINPoJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 11:44:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4502861165;
        Tue, 14 Sep 2021 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631634172;
        bh=mvuoWRdgyktEZkP8N46MKfVzy+eYPbk3NccSIQmsP8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gK0FQ0PeB1KGKVjpD5I41SxP9q8BFZaSC+H7vWUQc2cIT20MSm9xvhKv6pyt0mNTd
         6O533Ly5bVq86kr0pBEQ/vIPu1uqN9VDhd+B4VIzfvT/ppnoIfc6IJmyL4RW0INh0K
         FlsnFgNG6A1fytjL7XSqHPZmIrxLvcUKqq+Sqh0H/nMor/MViwxnn06YitMP3yezWQ
         TN3ANOdhdt6yxekfuAyXroQuvKHGtC49QVWow6crQ/PnKtr2phSkMBAwIhuKJxJnkt
         ElPTmVrMq8iJhIKPaIy3OAgW8thjy28PYrwZiOODliPKmPIyHEBUoOWT6e1H5UxDRM
         WVqvdiswrtBhQ==
Received: by mail-ot1-f41.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso19077932ots.5;
        Tue, 14 Sep 2021 08:42:52 -0700 (PDT)
X-Gm-Message-State: AOAM533N2FkzVXKwB8A96KxdL0CAW4ZE8iIt0IAZ7oyqYf8CmIYv3Xon
        /866c/X/ABpGVtOOSuJfCADoV16Sq1BtmgzkbJk=
X-Google-Smtp-Source: ABdhPJwx57mZePF/+fKNrTKtnKV+7kzFgjzys0SKRPzR4omYEyny9bMvp54Zq3YK48l3ZGnV9SP3mhoLYT9teXG8qeY=
X-Received: by 2002:a9d:200b:: with SMTP id n11mr15190375ota.30.1631634171520;
 Tue, 14 Sep 2021 08:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-2-ardb@kernel.org>
 <CAHk-=whkCzP-wyZ08r9RDJRx9cbANVHy-jy=vJAGTkSbXm50iA@mail.gmail.com>
In-Reply-To: <CAHk-=whkCzP-wyZ08r9RDJRx9cbANVHy-jy=vJAGTkSbXm50iA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Sep 2021 17:42:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHK74XKWWs4C9zckOZsJP4cD+=B8gMx8QoohYVN61CJ-g@mail.gmail.com>
Message-ID: <CAMj1kXHK74XKWWs4C9zckOZsJP4cD+=B8gMx8QoohYVN61CJ-g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] arm64: add CPU field to struct thread_info
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Tue, 14 Sept 2021 at 17:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Sep 14, 2021 at 5:10 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > The CPU field will be moved back into thread_info even when
> > THREAD_INFO_IN_TASK is enabled, so add it back to arm64's definition of
> > struct thread_info.
>
> The series looks sane to me, but it strikes me that it's inconsistent
> - here for arm64, you make it unconditional, but for the other
> architectures you end up putting it inside a #ifdef CONFIG_SMP.
>
> Was there some reason for this odd behavior?
>

Yes. CONFIG_SMP is a 'def_bool y' on arm64.
