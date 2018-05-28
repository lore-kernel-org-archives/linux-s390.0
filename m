Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 28 May 2018 20:27:19 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] kbuild: add endianness flag to CHEKCFLAGS
Message-ID: <20180528182718.7mdr66wp4xmg55lo@ltop.local>
References: <20180528170048.16595-1-luc.vanoostenryck@gmail.com>
 <7ce087bc-dd52-bae8-96f2-fad91f5a345e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce087bc-dd52-bae8-96f2-fad91f5a345e@infradead.org>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 28, 2018 at 10:31:58AM -0700, Randy Dunlap wrote:
> On 05/28/2018 10:00 AM, Luc Van Oostenryck wrote:
> > +# insure the checker run with the right endianness
> > +CHECKFLAGS += $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig,-mlittle)
> 
> Does this need to be                           -mbig-endian,-mlittle-endian)

Of course it does. *sigh*
Thanks for noticing that. Correct patch is on the fly.

-- Luc 
