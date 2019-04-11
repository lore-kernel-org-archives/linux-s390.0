Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de> <CAKwvOdnZjj_FRQkAqmmmMcG=s+TGFXqQS5-ZhT2E9fcGu-nm8w@mail.gmail.com>
In-Reply-To: <CAKwvOdnZjj_FRQkAqmmmMcG=s+TGFXqQS5-ZhT2E9fcGu-nm8w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Apr 2019 12:18:33 +0200
Message-ID: <CAK8P3a3bn8yWHfhwppXdTfkyy7_uM=_OySKahoQtOyBxBT5QoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] s390: only build for new CPUs with clang
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 11, 2019 at 12:20 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > llvm does does not understand -march=z9-109 and older target
>
> Please file bugs for these in LLVM's issue tracker.  It might be
> possible to enable these additional architecture variants if they're
> similar to existing ones and simply unrecognized.  IIRC, we had this
> issue with armv7 variants.

I really don't see that as necessary here. While generally speaking,
it would be nice to support the widest possible range of hardware,
and it would not be hard to add this support, it seems highly unlikely
that anyone would actually want to use that in case of s390.

The last enterprise distros to support z9 were SLES11 (end of life as
of last month) and RHEL6 (ending its 10 year life next year). Anyone
who is still on those releases will probably not install a brand new
compiler, and anyone who is on newer releases won't run on prehistoric
hardware.

Debian still runs on very old hardware in theory, but even there you'd
have a hard time finding someone to test the output of the compiler
on an old machine.

       Arnd
