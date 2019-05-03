Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 3 May 2019 16:27:18 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 4/4] s390: fix clang -Wpointer-sign warnigns in boot
 code
References: <20190415083605.2560074-1-arnd@arndb.de>
 <20190415083605.2560074-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415083605.2560074-4-arnd@arndb.de>
Message-Id: <20190503142718.GF5602@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 15, 2019 at 10:35:54AM +0200, Arnd Bergmann wrote:
> The arch/s390/boot directory is built with its own set of compiler
> options that does not include -Wno-pointer-sign like the rest of
> the kernel does, this causes a lot of harmess but correct warnings
> when building with clang.
> 
> For the atomics, we can add type casts to avoid the warnings, for
> everything else the easiest way is to slightly adapt the types
> to be more consistent.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/boot/ipl_parm.c       |  2 +-
>  arch/s390/include/asm/bitops.h  | 12 ++++++------
>  arch/s390/include/asm/ebcdic.h  |  2 +-
>  arch/s390/include/asm/lowcore.h |  2 +-
>  drivers/s390/char/sclp.h        |  4 ++--
>  5 files changed, 11 insertions(+), 11 deletions(-)

Applied, with typo fix and a simple coding style issue.
Thanks!
