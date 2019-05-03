Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 3 May 2019 16:26:04 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 2/4] s390: boot, purgatory: pass $(CLANG_FLAGS) where
 needed
References: <20190415083605.2560074-1-arnd@arndb.de>
 <20190415083605.2560074-2-arnd@arndb.de>
 <20190415161206.GA6928@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415161206.GA6928@archlinux-i9>
Message-Id: <20190503142604.GD5602@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Philipp Rudo <prudo@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 15, 2019 at 09:12:06AM -0700, Nathan Chancellor wrote:
> On Mon, Apr 15, 2019 at 10:35:52AM +0200, Arnd Bergmann wrote:
> > The purgatory and boot Makefiles do not inherit the original cflags,
> > so clang falls back to the default target architecture when building it,
> > typically this would be x86 when cross-compiling.
> > 
> > Add $(CLANG_FLAGS) everywhere so we pass the correct --target=s390x-linux
> > option when cross-compiling.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> > ---
> >  arch/s390/Makefile           | 4 ++--
> >  arch/s390/purgatory/Makefile | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.
