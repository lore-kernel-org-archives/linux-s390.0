Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-7-hch@lst.de>
In-Reply-To: <20190213174005.28785-7-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 16:16:49 +0900
Message-ID: <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
Subject: Re: [PATCH 06/11] lockdep: consolidate the LOCKDEP_SUPPORT symbol
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

+CC Greentime Hu
+CC Vincent Chen


On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add one definition to lib/Kconfig.debug and let the architectures
> select if it supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


This changes the behavior of nds32.

So please leave a note in the commit description.
(Ideally, we want Ack of a NDS32 maintainer)

Also, please do compile test for NDS32.


-------------------------
This commit changes CONFIG_LOCKDEP_SUPPORT to y for nds32.

NDS32 selects LOCKEP_SUPPORT, but there was previously
no config entry of LOCKDEP_SUPPORT in nds32.

It is now available in lib/Kconfig.debug,
so this commit enables LOCKDEP_SUPPORT for nds32.
-------------------------






--
Best Regards
Masahiro Yamada
