Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1452177226.1081.6.camel@BR9GV9YG.de.ibm.com>
Subject: Re: [PATCH 1/2] 390/qeth: Delete an unnecessary variable
 initialisation in qeth_core_set_online()
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 07 Jan 2016 15:33:46 +0100
In-Reply-To: <5688F198.4040109@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	 <5688F13A.70601@users.sourceforge.net>
	 <5688F198.4040109@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2016-01-03 at 11:02 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 3 Jan 2016 10:48:05 +0100
> 
> Omit explicit initialisation at the beginning for one local variable
> that is redefined before its first use.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/s390/net/qeth_core_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index 7871537..54fde2e 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -5637,7 +5637,7 @@ static void qeth_core_remove_device(struct ccwgroup_device *gdev)
>  static int qeth_core_set_online(struct ccwgroup_device *gdev)
>  {
>  	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
> -	int rc = 0;
> +	int rc;
>  	int def_discipline;
> 
>  	if (!card->discipline) {

As Heiko already answered, you could propose a lot of this kind of
changes with just minor benefit. I do not want to push them in single
patches. Either there is a cleanup patch for explicit initialisation of
local variables in the whole qeth driver, or we take care about such
minor changes, once we touch the code anyway due to other reasons.
