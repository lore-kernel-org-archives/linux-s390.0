Return-Path: <linux-kernel-owner+w=401wt.eu-S1751306AbXDWOkT@vger.kernel.org>
From: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 8/9] Kconfig: silicon backplane dependency.
Date: Mon, 23 Apr 2007 16:39:13 +0200
References: <20070423141412.GI21174@skybase>
In-Reply-To: <20070423141412.GI21174@skybase>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704231639.14236.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Monday 23 April 2007 16:14, Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Add HAS_IOMEM dependency to the "Sonics Silicon Backplane" menu.
> This hides the menu for s390.
> Goes on top of git-wireless.patch.
> 
> Cc: Michael Buesch <mb@bu3sch.de>
> Cc: John W. Linville <linville@tuxdriver.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Acked-by: Michael Buesch <mb@bu3sch.de>

> ---
> 
>  drivers/ssb/Kconfig |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -urpN linux-2.6/drivers/ssb/Kconfig linux-2.6-patched/drivers/ssb/Kconfig
> --- linux-2.6/drivers/ssb/Kconfig	2007-04-23 15:51:57.000000000 +0200
> +++ linux-2.6-patched/drivers/ssb/Kconfig	2007-04-23 15:53:15.000000000 +0200
> @@ -1,4 +1,5 @@
>  menu "Sonics Silicon Backplane"
> +	depends on HAS_IOMEM
>  
>  config SSB
>  	tristate "Sonics Silicon Backplane support"
> 
> 

-- 
Greetings Michael.
