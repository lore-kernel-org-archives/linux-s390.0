From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: select CONFIG_TTY for use of tty in unconditional
 keyboard driver
Date: Thu, 27 Feb 2014 08:07:46 +0100
Message-ID: <20140227070746.GA4343@osiris>
References: <20140226191627.9adf3c8e1548e2016c16557c@canb.auug.org.au>
 <20140226100234.GA23064@thin>
 <20140227100026.1cc909f2722b16b6d11a7b91@canb.auug.org.au>
 <20140226231916.GB17589@jtriplet-mobl1>
 <20140227104211.b2a4a5a1066fcf8ac2640ce3@canb.auug.org.au>
 <20140227021305.GA23659@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140227021305.GA23659@thin>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 26, 2014 at 06:13:06PM -0800, Josh Triplett wrote:
> The unconditionally built keyboard driver, drivers/s390/char/keyboard.c,
> requires CONFIG_TTY, so select it from CONFIG_S390 to prevent a build
> error.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>  arch/s390/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!
