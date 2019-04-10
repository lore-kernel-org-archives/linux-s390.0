Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Apr 2019 18:00:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 06/12] s390: ctcm: fix ctcm_new_device error return code
In-Reply-To: <20190408212648.2407234-6-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410180007.4255ee21@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Apr 2019 23:26:19 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> clang points out that the return code from this function is
> undefined for one of the error paths:
> 
> ../drivers/s390/net/ctcm_main.c:1595:7: warning: variable 'result' is used uninitialized whenever 'if' condition is true
>       [-Wsometimes-uninitialized]
>                 if (priv->channel[direction] == NULL) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/s390/net/ctcm_main.c:1638:9: note: uninitialized use occurs here
>         return result;
>                ^~~~~~
> ../drivers/s390/net/ctcm_main.c:1595:3: note: remove the 'if' if its condition is always false
>                 if (priv->channel[direction] == NULL) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/s390/net/ctcm_main.c:1539:12: note: initialize the variable 'result' to silence this warning
>         int result;
>                   ^
> 
> Make it return -ENODEV here, as in the related failure cases.
> gcc has a known bug in underreporting some of these warnings
> when it has already eliminated the assignment of the return code
> based on some earlier optimization step.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to our internal tree for Julian to pick up.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
