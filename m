Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgIXNu0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Sep 2020 09:50:26 -0400
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 24 Sep 2020 15:50:14 +0200
Message-ID: <CA+icZUX+AX4GAG0z2PAnvJSEmKozYLa7oHjxGkjv2_9Rcs0J7A@mail.gmail.com>
Subject: [PATCH] kbuild: explicitly specify the build id style
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Andy Lutomirski <luto@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Catalin Marinas <catalin.marinas@arm.com>, "David S . Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <natechancellor@gmail.com>, Sami Tolvanen <samitolvanen@google.com>

[ Please CC me I am not subscribed to all MLs ]
[ CC Sami ]

Hi Bill,

I have tested your patch on top of Sami's latest clang-cfi Git branch.

Feel free to add...

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM toolchain
version 11.0.0-rc3 on x86-64

Thanks for the patch.

Regards,
- Sedat -
