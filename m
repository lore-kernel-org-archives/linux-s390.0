From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [BUILD-FAILURE] next-20081230 - S390 - tape drive fails to
	build with !CONFIG_BLOCK
Date: Fri, 2 Jan 2009 11:01:59 +0100
Message-ID: <20090102100159.GA4730@osiris.boeblingen.de.ibm.com>
References: <20081231033039.f203b59c.sfr@canb.auug.org.au> <20081231112132.GA4268@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081231112132.GA4268@linux.vnet.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Dec 31, 2008 at 04:51:32PM +0530, Kamalesh Babulal wrote:
> 	next-20081230 randconfig build fails on S390, with CONFIG_BLOCK=n
> 
>  Adding the dependency of CONFIG_BLOCK to CONFIG_S390_TAPE_BLOCK
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com
>
> --- a/drivers/s390/char/Kconfig
> +++ b/drivers/s390/char/Kconfig
> @@ -100,7 +100,7 @@ comment "S/390 tape interface support"
> 
>  config S390_TAPE_BLOCK
>  	bool "Support for tape block devices"
> -	depends on S390_TAPE
> +	depends on S390_TAPE && BLOCK

Thank you, added it to our patch queue.
