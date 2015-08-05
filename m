Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 5 Aug 2015 09:15:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH -next] s390: lib: Export __delay
Message-ID: <20150805071506.GC4163@osiris>
References: <1438756703-2586-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438756703-2586-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Radha Mohan Chintakuntla <rchintakuntla@cavium.com>, David Daney <david.daney@cavium.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 04, 2015 at 11:38:23PM -0700, Guenter Roeck wrote:
> __delay is exported by most architectures, and may be used in modules.
> Since it is not exported for s390, s390:allmodconfig currently fails
> to build with
> 
> ERROR: "__delay" [drivers/net/phy/mdio-octeon.ko] undefined!
> 
> Fixes: a6d678645210 ("net: mdio-octeon: Modify driver to work on both
> 	ThunderX and Octeon")
> Cc: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/s390/lib/delay.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
