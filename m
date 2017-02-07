From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 07 Feb 2017 09:26:01 +0000
Subject: Re: [bug report] zfcp: trace on request for open and close of WKA port
Message-Id: <20170207092601.GG11103@mwanda>
In-Reply-To: <20170207092211.GA26324@mwanda>
References: <20170207092211.GA26324@mwanda>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Same thing for zfcp_fsf_close_wka_port() as well.

regards,
dan carpenter

On Tue, Feb 07, 2017 at 12:22:11PM +0300, Dan Carpenter wrote:
> Hello Steffen Maier,
> 
> The patch d27a7cb91960: "zfcp: trace on request for open and close of
> WKA port" from Aug 10, 2016, leads to the following static checker
> warning:
> 
> 	drivers/s390/scsi/zfcp_fsf.c:1615 zfcp_fsf_open_wka_port()
> 	warn: 'req' was already freed.
> 
> drivers/s390/scsi/zfcp_fsf.c
>   1609          zfcp_fsf_start_timer(req, ZFCP_FSF_REQUEST_TIMEOUT);
>   1610          retval = zfcp_fsf_req_send(req);
>   1611          if (retval)
>   1612                  zfcp_fsf_req_free(req);
>                                           ^^^
> Freed.
> 
>   1613  out:
>   1614          spin_unlock_irq(&qdio->req_q_lock);
>   1615          if (req && !IS_ERR(req))
>   1616                  zfcp_dbf_rec_run_wka("fsowp_1", wka_port, req->req_id);
>                                                                   ^^^^^^^^^^^
> Use after free.
> 
>   1617          return retval;
>   1618  }
> 
> regards,
> dan carpenter
