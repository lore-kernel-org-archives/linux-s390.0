Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1510831373-31768-1-git-send-email-geert@linux-m68k.org>
References: <1510831373-31768-1-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Nov 2017 12:35:12 +0100
Message-ID: <CAK8P3a3wfVpabQHOOpZ-XCqkar+U49rT=MHGrMdEQiVw+KdNHA@mail.gmail.com>
Subject: Re: [PATCH] net/smc: Fix preinitialization of buf_desc in __smc_buf_create()
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>, "David S . Miller" <davem@davemloft.net>, linux-s390 <linux-s390@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 16, 2017 at 12:22 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> With gcc-4.1.2:
>
>     net/smc/smc_core.c: In function ‘__smc_buf_create’:
>     net/smc/smc_core.c:567: warning: ‘bufsize’ may be used uninitialized in this function
>
> Indeed, if the for-loop is never executed, bufsize is used
> uninitialized.  In addition, buf_desc is stored for later use, while it
> is still a NULL pointer.
>
> Before, error handling was done by checking if buf_desc is non-NULL.
> The cleanup changed this to an error check, but forgot to update the
> preinitialization of buf_desc to an error pointer.
>
> Update the preinitializatin of buf_desc to fix this.
>
> Fixes: b33982c3a6838d13 ("net/smc: cleanup function __smc_buf_create()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> I don't know if this can ever happen, but the old code handled it.

Acked-by: Arnd Bergmann <arnd@arndb.de>

This one I could reproduce with gcc-4.1 on x86, but not gcc-4.2 or higher.
