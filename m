Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Apr 2019 18:01:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 09/12] s390: make __load_psw_mask work with clang
In-Reply-To: <20190408212648.2407234-9-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410180147.043de60c@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Apr 2019 23:26:22 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> clang fails to use the %O and %R inline assembly modifiers
> the same way as gcc, leading to build failures with every use
> of __load_psw_mask():
> 
> /tmp/nmi-4a9f80.s: Assembler messages:
> /tmp/nmi-4a9f80.s:571: Error: junk at end of line: `+8(160(%r11))'
> /tmp/nmi-4a9f80.s:626: Error: junk at end of line: `+8(160(%r11))'
> 
> Replace these with a more conventional way of passing the addresses
> that should work with both clang and gcc.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to s390/linux:features for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
