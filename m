From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUILD-FAILURE] linux-next: next-20081210 - s390x - lcs
	drivers breaks with !CONFIG_IP_MULTICAST
Date: Wed, 10 Dec 2008 22:01:39 +0530
Message-ID: <20081210163139.GB6391@linux.vnet.ibm.com>
References: <20081210164659.9ebb8158.sfr@canb.auug.org.au> <20081210111740.GA6107@linux.vnet.ibm.com> <20081210120833.GA4586@osiris.boeblingen.de.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081210120833.GA4586@osiris.boeblingen.de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Frank Blaschka <frank.blaschka@de.ibm.com>, Ursula Braun <braunu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

* Heiko Carstens <heiko.carstens@de.ibm.com> [2008-12-10 13:08:33]:

> On Wed, Dec 10, 2008 at 04:47:40PM +0530, Kamalesh Babulal wrote:
> > Hi,
> > 
> > 	next-20081210 randconfig kernel builds fails with !CONFIG_IP_MULTICAST
> > 
> > drivers/s390/net/lcs.c: In function 'lcs_new_device':
> > drivers/s390/net/lcs.c:2179: error: implicit declaration of function 'lcs_set_multicast_list'
> > make[2]: *** [drivers/s390/net/lcs.o] Error 1
> > make[1]: *** [drivers/s390/net] Error 2
> > make: *** [drivers/s390] Error 2
> 
> Thanks for reporting!
> 
> This should do the trick:

Hi Heiko,

	Thanks, the patch did the trick.

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> 
> ---
>  drivers/s390/net/lcs.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/s390/net/lcs.c
> ===================================================================
> --- linux-2.6.orig/drivers/s390/net/lcs.c
> +++ linux-2.6/drivers/s390/net/lcs.c
> @@ -69,7 +69,9 @@ static char debug_buffer[255];
>  static void lcs_tasklet(unsigned long);
>  static void lcs_start_kernel_thread(struct work_struct *);
>  static void lcs_get_frames_cb(struct lcs_channel *, struct lcs_buffer *);
> +#ifdef CONFIG_IP_MULTICAST
>  static int lcs_send_delipm(struct lcs_card *, struct lcs_ipm_list *);
> +#endif /* CONFIG_IP_MULTICAST */
>  static int lcs_recovery(void *ptr);
> 
>  /**
> @@ -1280,6 +1282,8 @@ out:
>  	lcs_clear_thread_running_bit(card, LCS_SET_MC_THREAD);
>  	return 0;
>  }
> +#endif /* CONFIG_IP_MULTICAST */
> +
>  /**
>   * function called by net device to
>   * handle multicast address relevant things
> @@ -1287,6 +1291,7 @@ out:
>  static void
>  lcs_set_multicast_list(struct net_device *dev)
>  {
> +#ifdef CONFIG_IP_MULTICAST
>          struct lcs_card *card;
> 
>          LCS_DBF_TEXT(4, trace, "setmulti");
> @@ -1294,9 +1299,9 @@ lcs_set_multicast_list(struct net_device
> 
>          if (!lcs_set_thread_start_bit(card, LCS_SET_MC_THREAD))
>  		schedule_work(&card->kernel_thread_starter);
> +#endif /* CONFIG_IP_MULTICAST */
>  }
> 
> -#endif /* CONFIG_IP_MULTICAST */
> 
>  static long
>  lcs_check_irb_error(struct ccw_device *cdev, struct irb *irb)

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
