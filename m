Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-3-arnd@arndb.de>
 <20190408220312.GA18333@archlinux-i9> <CAK8P3a39NqQOp+0=WYuWh0UmpH=kEFLKyymNYm8DH-0gx9XaaQ@mail.gmail.com>
 <20190409163049.GA2046@archlinux-i9>
In-Reply-To: <20190409163049.GA2046@archlinux-i9>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 9 Apr 2019 11:11:57 -0700
Message-ID: <CAKwvOd=BGeCoRVDQ7WgMZ0rGXfTawm507_JMC7dMM90Vg1Tr7g@mail.gmail.com>
Subject: Re: [PATCH 03/12] s390: purgatory: pass --target option to clang
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, linux-s390 <linux-s390@vger.kernel.org>, Philipp Rudo <prudo@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 9, 2019 at 9:30 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> It did just occur to me that we added the --target and --gcc-toolchain
> flags to a clang specific variable, CLANG_FLAGS, that has already been
> used by powerpc in commit 813af51f5d30 ("powerpc/boot: Set target when
> cross-compiling for clang"). I assume that could be used here?

I think reusing CLANG_FLAGS is a better approach.

-- 
Thanks,
~Nick Desaulniers
