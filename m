Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 May 2014 10:30:10 +0200
From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390: net: qeth_core_main.c:  Fix for possible null
	pointer dereference
Message-ID: <20140519083010.GA44089@tuxmaker.boeblingen.de.ibm.com>
References: <1400429068-10607-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400429068-10607-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Ursula Braun <ursula.braun@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, May 18, 2014 at 06:04:27PM +0200, Rickard Strandqvist wrote:
> There is otherwise a risk of a possible null pointer dereference.
> 
> Was largely found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Added to my patch queue. Thx!

> ---
>  drivers/s390/net/qeth_core_main.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index 22470a3..5562665 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -1012,7 +1012,7 @@ static long __qeth_check_irb_error(struct ccw_device *cdev,
> 
>  	card = CARD_FROM_CDEV(cdev);
> 
> -	if (!IS_ERR(irb))
> +	if (!card || !IS_ERR(irb))
>  		return 0;
> 
>  	switch (PTR_ERR(irb)) {
> @@ -1028,7 +1028,7 @@ static long __qeth_check_irb_error(struct ccw_device *cdev,
>  		QETH_CARD_TEXT(card, 2, "ckirberr");
>  		QETH_CARD_TEXT_(card, 2, "  rc%d", -ETIMEDOUT);
>  		if (intparm == QETH_RCD_PARM) {
> -			if (card && (card->data.ccwdev == cdev)) {
> +			if (card->data.ccwdev == cdev) {
>  				card->data.state = CH_STATE_DOWN;
>  				wake_up(&card->wait_q);
>  			}
> -- 
> 1.7.10.4
> 
