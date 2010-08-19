From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 2/1] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
Date: Thu, 19 Aug 2010 13:04:11 +0200
Message-ID: <201008191304.11190.arnd@arndb.de>
References: <201008181428.45029.arnd@arndb.de> <1282184898-30599-1-git-send-email-sboyd@codeaurora.org> <20100819144719.e690c674.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20100819144719.e690c674.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>
List-ID: <linux-s390.vger.kernel.org>

On Thursday 19 August 2010, Stephen Rothwell wrote:
>   On Wed, 18 Aug 2010 19:28:18 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:
> >
> > +config ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
> > +     def_bool y
> 
> Why not just have
> 
> config ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
>         bool
> 
> in lib/Kconfig.debug
> 
> and select that in each arch that want it?
> 

Yes, that would be even easier, thanks for the suggestion!

	Arnd
