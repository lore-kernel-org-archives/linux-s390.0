From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: save link group ptr before calling
 smc_buf_unuse
Date: Tue, 23 Oct 2018 11:00:57 -0700 (PDT)
Message-ID: <20181023.110057.1998437403503010569.davem@davemloft.net>
References: <20181023134805.2429-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181023134805.2429-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Tue, 23 Oct 2018 15:48:05 +0200

> @@ -315,6 +314,8 @@ static void smc_buf_unuse(struct smc_connection *conn)
>  /* remove a finished connection from its link group */
>  void smc_conn_free(struct smc_connection *conn)
>  {
> +	struct smc_link_group *lgr;
> +
>  	if (!conn->lgr)
>  		return;
>  	if (conn->lgr->is_smcd) {
> @@ -323,8 +324,9 @@ void smc_conn_free(struct smc_connection *conn)
>  	} else {
>  		smc_cdc_tx_dismiss_slots(conn);
>  	}
> +	lgr = conn->lgr; /* smc_lgr_unregister_conn() unsets lgr */
>  	smc_lgr_unregister_conn(conn);
> -	smc_buf_unuse(conn);
> +	smc_buf_unuse(conn, lgr);
>  }

This doesn't make any sense.

smc_lgr_unregister_conn() can free the memory and release the object,
albeit sometimes asynchronously via a workqueue.

It is not safe, therefore, to refrence the lgr object after that
function call.

I'm not applying this, sorry.
