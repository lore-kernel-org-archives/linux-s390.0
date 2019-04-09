Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 9 Apr 2019 15:13:38 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 07/12] s390: cio: fix cio_irb declaration
In-Reply-To: <20190408212648.2407234-7-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1904091512530.2591@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 8 Apr 2019, Arnd Bergmann wrote:
> clang points out that the declaration of cio_irb does not match the
> definition exactly, it is missing the alignment attribute:
> 
> ../drivers/s390/cio/cio.c:50:1: warning: section does not match previous declaration [-Wsection]
> DEFINE_PER_CPU_ALIGNED(struct irb, cio_irb);
> ^
> ../include/linux/percpu-defs.h:150:2: note: expanded from macro 'DEFINE_PER_CPU_ALIGNED'
>         DEFINE_PER_CPU_SECTION(type, name, PER_CPU_ALIGNED_SECTION)     \
>         ^
> ../include/linux/percpu-defs.h:93:9: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
>         extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
>                ^
> ../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
>         __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
>                                 ^
> ../drivers/s390/cio/cio.h:118:1: note: previous attribute is here
> DECLARE_PER_CPU(struct irb, cio_irb);
> ^
> ../include/linux/percpu-defs.h:111:2: note: expanded from macro 'DECLARE_PER_CPU'
>         DECLARE_PER_CPU_SECTION(type, name, "")
>         ^
> ../include/linux/percpu-defs.h:87:9: note: expanded from macro 'DECLARE_PER_CPU_SECTION'
>         extern __PCPU_ATTRS(sec) __typeof__(type) name
>                ^
> ../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
>         __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
>                                 ^
> Use DECLARE_PER_CPU_ALIGNED() here, to make the two match.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch! Applied.
Sebastian
