From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/9] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
Date: Fri, 13 May 2011 18:55:09 +0200
Message-ID: <201105131855.10195.arnd@arndb.de>
References: <1305244212-19183-1-git-send-email-sboyd@codeaurora.org> <1305244212-19183-10-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1305244212-19183-10-git-send-email-sboyd@codeaurora.org>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Chris Metcalf <cmetcalf@tilera.com>
List-ID: <linux-s390.vger.kernel.org>

On Friday 13 May 2011, Stephen Boyd wrote:
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

Thanks for following up on this

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
