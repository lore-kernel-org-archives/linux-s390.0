From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 11 Sep 2009 08:53:29 +0000
Subject: Re: [PATCH] s390: kmalloc failure ignored in smp_get_save_area()
Message-Id: <20090911085329.GA4748@osiris.boeblingen.de.ibm.com>
In-Reply-To: <4AA7C64E.7080404@gmail.com>
References: <4AA7C64E.7080404@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 09, 2009 at 05:14:22PM +0200, Roel Kluin wrote:
> Prevent NULL dereference if kmalloc() fails.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Found with sed: http://kernelnewbies.org/roelkluin
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index be2cae0..dfeac28 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -247,6 +247,8 @@ static void __init smp_get_save_area(unsigned int cpu, unsigned int phy_cpu)
>  		return;
>  	}
>  	zfcpdump_save_areas[cpu] = kmalloc(sizeof(union save_area), GFP_KERNEL);
> +	if (zfcpdump_save_areas[cpu] == NULL)
> +		return;

If that allocation would fail that early in the boot process the only
sane answer would be panic().
But if that allocation would fail the system is useless anyway so it
really doesn't matter if we have a NULL pointer dereference just a
few lines below. The result would be the same ;)
