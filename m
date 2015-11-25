Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1448444246.15843.2.camel@BR9GV9YG.de.ibm.com>
Subject: Re: [PATCH] s390-ctcm: Delete unnecessary checks before the
 function call "channel_remove"
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2015 10:37:26 +0100
In-Reply-To: <564B7DEF.6050005@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
	 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
	 <530A086E.8010901@users.sourceforge.net>
	 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
	 <530A72AA.3000601@users.sourceforge.net>
	 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
	 <530B5FB6.6010207@users.sourceforge.net>
	 <alpine.DEB.2.10.1402241710370.2074@hadrien>
	 <530C5E18.1020800@users.sourceforge.net>
	 <alpine.DEB.2.10.1402251014170.2080@hadrien>
	 <530CD2C4.4050903@users.sourceforge.net>
	 <alpine.DEB.2.10.1402251840450.7035@hadrien>
	 <530CF8FF.8080600@users.sourceforge.net>
	 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
	 <530DD06F.4090703@users.sourceforge.net>
	 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
	 <5317A59D.4@users.sourceforge.net> <564B7DEF.6050005@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

Applied to our local git. Thanks. It will be part of my next patch
submission for net-next.

Kind regards, Ursula Braun, IBM Germany

On Tue, 2015-11-17 at 20:20 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 17 Nov 2015 20:10:02 +0100
> 
> The channel_remove() function tests whether its argument is NULL
> and then returns immediately. Thus the test around the calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/s390/net/ctcm_main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 05c37d6..c3e2252 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -1677,11 +1677,8 @@ static int ctcm_shutdown_device(struct ccwgroup_device *cgdev)
> 
>  	ccw_device_set_offline(cgdev->cdev[1]);
>  	ccw_device_set_offline(cgdev->cdev[0]);
> -
> -	if (priv->channel[CTCM_READ])
> -		channel_remove(priv->channel[CTCM_READ]);
> -	if (priv->channel[CTCM_WRITE])
> -		channel_remove(priv->channel[CTCM_WRITE]);
> +	channel_remove(priv->channel[CTCM_READ]);
> +	channel_remove(priv->channel[CTCM_WRITE]);
>  	priv->channel[CTCM_READ] = priv->channel[CTCM_WRITE] = NULL;
> 
>  	return 0;
