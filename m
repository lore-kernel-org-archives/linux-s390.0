Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 2 Oct 2018 08:46:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH net 2/5] net/smc: remove duplicate mutex_unlock
References: <20180920091243.xgansymg6a4dfixg@mwanda>
 <c0fe2ae3-38b4-5023-9140-20f7acac6028@linux.ibm.com>
In-Reply-To: <c0fe2ae3-38b4-5023-9140-20f7acac6028@linux.ibm.com>
Message-Id: <20181002064640.GA16762@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org, kbuild-all@01.org, davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 01, 2018 at 05:22:22PM +0200, Ursula Braun wrote:
> 
> > 3b2dec260 Hans Wippel   2018-05-18  1282  	/* finish worker */
> > c69342ef9 Ursula Braun  2018-09-18  1283  	if (!ism_supported) {
> > c69342ef9 Ursula Braun  2018-09-18  1284  		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact))
> > c69342ef9 Ursula Braun  2018-09-18  1285  			return;
> >                                                                 ^^^^^^
> > We need to mutex_unlock(&smc_create_lgr_pending); before the return.
> >
> 
> The smatch warning is not necessary, since the mutex_unlock(&smc_create_lgr_pending)
> for this case is done within smc_listen_rdma_finish().
> 
> > c69342ef9 Ursula Braun  2018-09-18  1286  	}
> > 3b2dec260 Hans Wippel   2018-05-18  1287  	smc_conn_save_peer_info(new_smc, &cclc);
> > 3b2dec260 Hans Wippel   2018-05-18  1288  	mutex_unlock(&smc_create_lgr_pending);
> > 3b2dec260 Hans Wippel   2018-05-18 @1289  	smc_listen_out_connected(new_smc);
> > a046d57da Ursula Braun  2017-01-09  1290  }
> > a046d57da Ursula Braun  2017-01-09  1291  
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> > 
> 
> But you could argue the code confuses smatch and other readers. Thus I could improve
> readability with a patch like this:

Yes, please.

> ---
>  net/smc/af_smc.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1184,7 +1184,6 @@ static int smc_listen_rdma_finish(struct
>  	return 0;
>  
>  decline:
> -	mutex_unlock(&smc_create_lgr_pending);
>  	smc_listen_decline(new_smc, reason_code, local_contact);
>  	return reason_code;
>  }

The lonely mutex_unlock() also _looks_ like a bug ;)
