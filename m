From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Tue, 31 Aug 2010 13:00:35 +0000
Subject: Re: [PATCH] [S390] Kconfig: have CCWGROUP depend on CLAW
Message-Id: <1283259635.22033.6.camel@braunu-laptop>
In-Reply-To: <1283065344-4963-1-git-send-email-vapier@gentoo.org>
References: <1283065344-4963-1-git-send-email-vapier@gentoo.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


> From: 
> Mike Frysinger <vapier@gentoo.org> 
> To: 
> linux-s390@vger.kernel.org,
> BOEBLINGEN
> LINUX390/Germany/IBM@IBMDE,
> mschwid2@linux.vnet.ibm.com,
> heicars2@linux.vnet.ibm.com 
> Date: 
> 29.08.2010 08:53 
> Subject: 
> [PATCH] [S390] Kconfig: have
> CCWGROUP depend on CLAW 
> Sent by: 
> linux-s390-owner@vger.kernel.org
> 
> 
> ______________________________________________________________________
> 
> 
> 
> Since the claw code calls ccwgroup_remove_ccwdev(), we need to make
> sure
> CCWGROUP is enabled when CLAW is enabled.  Otherwise we hit fun
> undefined
> references at build time:
> ERROR: "ccwgroup_remove_ccwdev" [drivers/s390/net/claw.ko] undefined!
> ERROR: "ccwgroup_probe_ccwdev" [drivers/s390/net/claw.ko] undefined!
> ERROR: "ccwgroup_driver_register" [drivers/s390/net/claw.ko]
> undefined!
> ERROR: "ccwgroup_driver_unregister" [drivers/s390/net/claw.ko]
> undefined!
> ERROR: "ccwgroup_create_from_string" [drivers/s390/net/claw.ko]
> undefined!
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> drivers/s390/net/Kconfig |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> index 977bb4d..456b187 100644
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -100,6 +100,6 @@ config QETH_IPV6
> 
> config CCWGROUP
>                  tristate
> -                 default (LCS || CTCM || QETH)
> +                 default (LCS || CTCM || QETH || CLAW)
> 
> endmenu
> -- 

Ack - thanks Mike!

We have added your patch to our local repository. It will be part of
our next patch collection submitted to Dave Miller for upstream
integration.

Regards, Ursula
