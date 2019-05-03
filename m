Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 3 May 2019 16:25:45 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 1/4] s390: only build for new CPUs with clang
References: <20190415083605.2560074-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415083605.2560074-1-arnd@arndb.de>
Message-Id: <20190503142545.GC5602@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Vasily Gorbik <gor@linux.ibm.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 15, 2019 at 10:35:51AM +0200, Arnd Bergmann wrote:
> llvm does does not understand -march=z9-109 and older target
> specifiers, so disable the respective Kconfig settings and
> the logic to make the boot code work on old systems when
> building with clang.
> 
> Part of the early boot code is normally compiled with -march=z900
> for maximum compatibility. This also has to get changed with
> clang to the oldest supported ISA, which is -march=z10 here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Kconfig       |  6 ++++++
>  arch/s390/boot/Makefile | 18 ++++++++++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)

Applied, thanks.
