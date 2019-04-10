Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Apr 2019 18:02:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 11/12] s390: make chkbss work with clang
In-Reply-To: <20190408212648.2407234-11-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-11-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410180224.45db1055@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Apr 2019 23:26:24 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> llvm skips an empty .bss section entirely, which makes
> the check fail with an unexpected error:
> 
> /tmp/binutils-multi-test/bin/s390x-linux-gnu-objdump: section '.bss' mentioned in a -j option, but not found in any input file
> error: arch/s390/boot/compressed/decompressor.o .bss section is not empty
> ../arch/s390/scripts/Makefile.chkbss:20: recipe for target 'arch/s390/boot/compressed/decompressor.o.chkbss' failed
> 
> Change the check so we first see if a .bss section exists
> before trying to read its size.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to s390/linux:features for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
