From: Ursula Braun <ubraun@linux.ibm.com>
Date: Tue, 16 Apr 2019 13:53:16 +0000
Subject: Re: [PATCH] net/smc: hold conns_lock before calling smc_lgr_register_conn()
Message-Id: <511c2219-30e8-c43d-085d-ff3dc81efef2@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 4/15/19 10:25 AM, Huaping Zhou wrote:
> After smc_lgr_create(), the newly created link group is added
> to smc_lgr_list, thus is accessible from other context.
> Although link group creation is serialized by
> smc_create_lgr_pending, the new link group may still be accessed
> concurrently. For example, if ib_device is no longer active,
> smc_ib_port_event_work() will call smc_port_terminate(), which
> in turn will call __smc_lgr_terminate() on every link group of
> this device. So conns_lock is required here.
> 

Thanks, looks good. Your patch will be part of our next patch
submission for the net-tree.

Regards, Ursula


> Signed-off-by: Huaping Zhou <zhp@smail.nju.edu.cn>
> ---
>  net/smc/smc_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 53a17cf..c4c3be4 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -653,7 +653,10 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
>  				    lcl->id_for_peer, vlan_id, smcd, peer_gid);
>  		if (rc)
>  			goto out;
> +		lgr = conn->lgr;
> +		write_lock_bh(&lgr->conns_lock);
>  		smc_lgr_register_conn(conn); /* add smc conn to lgr */
> +		write_unlock_bh(&lgr->conns_lock);
>  	}
>  	conn->local_tx_ctrl.common.type = SMC_CDC_MSG_TYPE;
>  	conn->local_tx_ctrl.len = SMC_WR_TX_SIZE;
> 
