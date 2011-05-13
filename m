From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 9/9] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
Date: Thu, 12 May 2011 20:55:25 -0400
Message-ID: <4DCC817D.3090005@tilera.com>
References: <1305244212-19183-1-git-send-email-sboyd@codeaurora.org> <1305244212-19183-10-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1305244212-19183-10-git-send-email-sboyd@codeaurora.org>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-ID: <linux-s390.vger.kernel.org>

On 5/12/2011 7:50 PM, Stephen Boyd wrote:
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
> ---
>  arch/tile/Kconfig               |    8 +-------
>  arch/tile/include/asm/uaccess.h |    7 ++++++-
>  arch/tile/lib/uaccess.c         |    8 --------

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
