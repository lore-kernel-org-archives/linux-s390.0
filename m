From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 9/9] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
Date: Fri, 13 May 2011 09:31:01 +0200
Message-ID: <20110513073101.GD10584@elte.hu>
References: <1305244212-19183-1-git-send-email-sboyd@codeaurora.org>
 <1305244212-19183-10-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1305244212-19183-10-git-send-email-sboyd@codeaurora.org>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Chris Metcalf <cmetcalf@tilera.com>, Arjan van de Ven <arjan@infradead.org>
List-ID: <linux-s390.vger.kernel.org>


* Stephen Boyd <sboyd@codeaurora.org> wrote:

> The help text for this config is duplicated across the x86,
> parisc, and s390 Kconfig.debug files. Arnd Bergman noted that the
> help text was slightly misleading and should be fixed to state
> that enabling this option isn't a problem when using pre 4.4 gcc.
> 
> To simplify the rewording, consolidate the text into
> lib/Kconfig.debug and modify it there to be more explicit about
> when you should say N to this config.
> 
> Also, make the text a bit more generic by stating that this
> option enables compile time checks so we can cover architectures
> which emit warnings vs. ones which emit errors. The details of
> how an architecture decided to implement the checks isn't as
> important as the concept of compile time checking of
> copy_from_user() calls.
> 
> While we're doing this, remove all the copy_from_user_overflow()
> code that's duplicated many times and place it into lib/ so that
> any architecture supporting this option can get the function for
> free.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: x86@kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/parisc/Kconfig             |    1 +
>  arch/parisc/Kconfig.debug       |   14 --------------
>  arch/s390/Kconfig               |    1 +
>  arch/s390/Kconfig.debug         |   14 --------------
>  arch/s390/lib/Makefile          |    1 -
>  arch/s390/lib/usercopy.c        |    8 --------
>  arch/sparc/lib/Makefile         |    1 -
>  arch/sparc/lib/usercopy.c       |    8 --------
>  arch/tile/Kconfig               |    8 +-------
>  arch/tile/include/asm/uaccess.h |    7 ++++++-
>  arch/tile/lib/uaccess.c         |    8 --------
>  arch/x86/Kconfig                |    1 +
>  arch/x86/Kconfig.debug          |   14 --------------
>  arch/x86/lib/usercopy_32.c      |    6 ------
>  arch/x86/lib/usercopy_64.c      |    6 ------
>  lib/Kconfig.debug               |   18 ++++++++++++++++++
>  lib/Makefile                    |    1 +
>  lib/usercopy.c                  |    8 ++++++++
>  18 files changed, 37 insertions(+), 88 deletions(-)
>  delete mode 100644 arch/s390/lib/usercopy.c
>  delete mode 100644 arch/sparc/lib/usercopy.c
>  create mode 100644 lib/usercopy.c

Very nice!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
