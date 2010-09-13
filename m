Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 13 Sep 2010 10:04:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] drivers: s390: remove custom implementation of
 hex_to_bin()
Message-ID: <20100913080427.GA2310@osiris.boeblingen.de.ibm.com>
References: <1284212198-25849-1-git-send-email-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1284212198-25849-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Sep 11, 2010 at 04:36:38PM +0300, Andy Shevchenko wrote:
> diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
> index 13cb601..76058a5 100644
> --- a/drivers/s390/cio/blacklist.c
> +++ b/drivers/s390/cio/blacklist.c
> @@ -79,17 +79,15 @@ static int pure_hex(char **cp, unsigned int *val, int min_digit,
>  		    int max_digit, int max_val)
>  {
>  	int diff;
> -	unsigned int value;
> 
>  	diff = 0;
>  	*val = 0;
> 
> -	while (isxdigit(**cp) && (diff <= max_digit)) {
> +	while (diff <= max_digit) {
> +		int value = hex_to_bin(**cp);
> 
> -		if (isdigit(**cp))
> -			value = **cp - '0';
> -		else
> -			value = tolower(**cp) - 'a' + 10;
> +		if (value < 0)
> +			break;
>  		*val = *val * 16 + value;
>  		(*cp)++;
>  		diff++;

Applied, thanks!
