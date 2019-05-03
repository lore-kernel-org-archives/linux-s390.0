Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 3 May 2019 16:26:17 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 3/4] s390: drop CONFIG_VIRT_TO_BUS
References: <20190415083605.2560074-1-arnd@arndb.de>
 <20190415083605.2560074-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415083605.2560074-3-arnd@arndb.de>
Message-Id: <20190503142617.GE5602@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Vasily Gorbik <gor@linux.ibm.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 15, 2019 at 10:35:53AM +0200, Arnd Bergmann wrote:
> VIRT_TO_BUS is only used for legacy device PCI and ISA drivers using
> virt_to_bus() instead of the streaming DMA mapping API, and the
> remaining drivers generally don't work on 64-bit architectures.
> 
> Two of these drivers also cause a build warning on s390, so instead
> of trying to fix that, let's just disable the option as we do on
> most architectures now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
