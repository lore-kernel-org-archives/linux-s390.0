Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390: scsi, use setup_timer instead of init_timer
References: <20170303124600.30225-1-jslaby@suse.cz>
From: Steffen Maier <maier@linux.vnet.ibm.com>
Date: Tue, 7 Mar 2017 14:06:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170303124600.30225-1-jslaby@suse.cz>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Message-Id: <3ec42259-4968-6cf6-a460-b656af541aa5@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?B?THVrw6HFoSBLb3JlbsSNaWs=?= <xkorenc1@fi.muni.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Thanks, Lukáš, Jiri, queued for next zfcp feature submission to 
linux-scsi as:

"zfcp: use setup_timer instead of init_timer"

On 03/03/2017 01:46 PM, Jiri Slaby wrote:
> From: Lukáš Korenčik <xkorenc1@fi.muni.cz>
>
> Use inicialization with setup_timer function instead of using
> init_timer function and data fields. It improves readability.
>
> Signed-off-by: Lukáš Korenčik <xkorenc1@fi.muni.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Steffen Maier <maier@linux.vnet.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: <linux-s390@vger.kernel.org>
> ---
>  drivers/s390/scsi/zfcp_erp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
> index 7ccfce559034..14c0cbe335b3 100644
> --- a/drivers/s390/scsi/zfcp_erp.c
> +++ b/drivers/s390/scsi/zfcp_erp.c
> @@ -572,9 +572,8 @@ static void zfcp_erp_memwait_handler(unsigned long data)
>
>  static void zfcp_erp_strategy_memwait(struct zfcp_erp_action *erp_action)
>  {
> -	init_timer(&erp_action->timer);
> -	erp_action->timer.function = zfcp_erp_memwait_handler;
> -	erp_action->timer.data = (unsigned long) erp_action;
> +	setup_timer(&erp_action->timer, zfcp_erp_memwait_handler,
> +		(unsigned long) erp_action);
>  	erp_action->timer.expires = jiffies + HZ;
>  	add_timer(&erp_action->timer);
>  }
>

-- 
Mit freundlichen Grüßen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
