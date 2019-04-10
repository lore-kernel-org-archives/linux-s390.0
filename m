Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-2-arnd@arndb.de>
 <CAKwvOdmRVK8t=CL5h0MXykm00R39e17dy8EkgFrLuhg1Yr0HJQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmRVK8t=CL5h0MXykm00R39e17dy8EkgFrLuhg1Yr0HJQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Apr 2019 21:00:52 +0200
Message-ID: <CAK8P3a3ytjz5KarSPyk4G=HOGopBMN65j0eYaWZanUbGoe=wXw@mail.gmail.com>
Subject: Re: [PATCH 02/12] s390: don't build vdso32 with clang
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Vasily Gorbik <gor@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 10, 2019 at 6:26 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Mon, Apr 8, 2019 at 2:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > clang does not support 31 bit object files on s390, so skip
> > the 32-bit vdso here, and only build it when using gcc to compile
> > the kernel.
>
> What's the build failure?  Would you mind filing a bug against LLVM's
> issue tracker for it, please?

As far as I can tell, llvm does only supports 64-bit output for s390, so this
is not a bug but rather a missing feature that seems highly unlikely to
ever get added.

32-bit (31-bit) mode on s390 is only used for very old existing binaries,
and the vdso support is optional there.

      Arnd
