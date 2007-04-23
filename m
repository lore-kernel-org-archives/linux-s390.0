Return-Path: <linux-kernel-owner+w=401wt.eu-S1752347AbXDWOkq@vger.kernel.org>
From: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 9/9] Kconfig: broadcom 4400 dependency.
Date: Mon, 23 Apr 2007 16:39:43 +0200
References: <20070423141427.GJ21174@skybase>
In-Reply-To: <20070423141427.GJ21174@skybase>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704231639.43592.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Monday 23 April 2007 16:14, Martin Schwidefsky wrote:
> [PATCH 9/9] Kconfig: broadcom 4400 dependency.
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Add HAS_IOMEM dependency to the B44 "Broadcom 4400 ethernet support"
> config option. This hides the option for s390.
> Goes on top of git-wireless.patch.
> 
> Cc: Michael Buesch <mb@bu3sch.de>
> Cc: John W. Linville <linville@tuxdriver.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Acked-by: Michael Buesch <mb@bu3sch.de>

> ---
> 
>  drivers/net/Kconfig |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -urpN linux-2.6/drivers/net/Kconfig linux-2.6-patched/drivers/net/Kconfig
> --- linux-2.6/drivers/net/Kconfig	2007-04-23 15:51:44.000000000 +0200
> +++ linux-2.6-patched/drivers/net/Kconfig	2007-04-23 15:53:16.000000000 +0200
> @@ -1432,6 +1432,7 @@ config APRICOT
>  
>  config B44
>  	tristate "Broadcom 4400 ethernet support"
> +	depends on HAS_IOMEM
>  	select SSB
>  	select MII
>  	help
> 
> 

-- 
Greetings Michael.
