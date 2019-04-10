Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Apr 2019 17:58:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 04/12] s390: qeth: address type mismatch warning
In-Reply-To: <20190408212648.2407234-4-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410175819.106f30b3@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Apr 2019 23:26:17 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> clang produces a harmless warning for each use for the qeth_adp_supported
> macro:
> 
> drivers/s390/net/qeth_l2_main.c:559:31: warning: implicit conversion from enumeration type 'enum qeth_ipa_setadp_cmd' to
>       different enumeration type 'enum qeth_ipa_funcs' [-Wenum-conversion]
>         if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
>             ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/s390/net/qeth_core.h:179:41: note: expanded from macro 'qeth_adp_supported'
>         qeth_is_ipa_supported(&c->options.adp, f)
>         ~~~~~~~~~~~~~~~~~~~~~                  ^
> 
> Add a version of this macro that uses the correct types, and
> remove the unused qeth_adp_enabled() macro that has the same
> problem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have added this to our internal tree for Julian to pick up.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
