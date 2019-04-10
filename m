Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Apr 2019 17:57:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 02/12] s390: don't build vdso32 with clang
In-Reply-To: <20190408212648.2407234-2-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410175743.034963a1@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Vasily Gorbik <gor@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Apr 2019 23:26:15 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> clang does not support 31 bit object files on s390, so skip
> the 32-bit vdso here, and only build it when using gcc to compile
> the kernel.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to s390/linux:features for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
