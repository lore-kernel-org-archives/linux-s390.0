Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
References: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Apr 2018 12:19:49 +0200
Message-ID: <CAK8P3a0Ahf9uuXYy0fxdC5_O84gmSqTUsP6xjpGQFE8n1Tw7HA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] io: define several IO & PIO barrier types for the
 asm-generic version
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180406101949.jpPqfc1-inpGNHf8IPHNGATyIN-QZTUErOrIo2CssXU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ley Foon Tan <lftan@altera.com>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 5, 2018 at 3:09 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Getting ready to harden readX()/writeX() and inX()/outX() semantics for the
> generic implementation.
>
> Defining two set of macros as __io_br() and __io_ar() to indicate actions
> to be taken before and after MMIO read.
>
> Defining two set of macros as __io_bw() and __io_aw() to indicate actions
> to be taken before and after MMIO write.
>
> Defining two set of macros as __io_pbw() and __io_paw() to indicate actions
> to be taken before and after Port IO write.
>
> Defining two set of macros as __io_pbr() and __io_par() to indicate actions
> to be taken before and after Port IO read.
>
> If rmb() is available for the architecture, prefer rmb() as the default
> implementation of __io_ar()/__io_par().
>
> If wmb() is available for the architecture, prefer wmb() as the default
> implementation of __io_bw()/__io_pbw().
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

I've applied the series to my asm-generic tree now, I will give it a few days
in linux-next to see if any obvious regressions happen, and then send
a pull request.

Checking the list of architectures that are affected by this, I see
h8300, microblaze, nios2, openrisc, s390, sparc, um, unicore32,
and xtensa, all of which use asm-generic/io.h without overriding
the default readl/writel.

I would guess that at least s390 doesn't need the barriers
(maintainers on Cc now), but there may be others that want to
override the new barriers with weaker ones where an MMIO
access is guaranteed to serialize against DMA, or where
a specialized barrier for this case exists.

Looking over the asm-generic implementation once more now,
I wonder if we should change the relaxed accessors to not have
any barriers (back to the version before your series) rather than
defaulting them to having the same barriers as the regular
readl/writel.

     Arnd
