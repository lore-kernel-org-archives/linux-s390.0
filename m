From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 12:38:24 +0000
Subject: Re: [bug report] smc: connection and link group creation
Message-Id: <5a3b2dbd-f2ba-c840-ff38-6e7f4e6ad2d8@linux.vnet.ibm.com>
In-Reply-To: <20170112080823.GA27977@mwanda>
References: <20170112080823.GA27977@mwanda>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


On 01/12/2017 09:08 AM, Dan Carpenter wrote:
> Hello Ursula Braun,
> 
> The patch 0cfdd8f92cac: "smc: connection and link group creation"
> from Jan 9, 2017, leads to the following static checker warning:
> 
> 	net/smc/smc_clc.c:202 smc_clc_send_confirm()
> 	error: __memcpy() '&cclc.lcl.mac' too small (6 vs 12)
Thanks for reporting this. I will come up with a fix.
> 
> net/smc/smc_clc.c
>    181  /* send CLC CONFIRM message across internal TCP socket */
>    182  int smc_clc_send_confirm(struct smc_sock *smc)
>    183  {
>    184          struct smc_connection *conn = &smc->conn;
>    185          struct smc_clc_msg_accept_confirm cclc;
>    186          struct smc_link *link;
>    187          int reason_code = 0;
>    188          struct msghdr msg;
>    189          struct kvec vec;
>    190          int len;
>    191  
>    192          link = &conn->lgr->lnk[SMC_SINGLE_LINK];
>    193          /* send SMC Confirm CLC msg */
>    194          memset(&cclc, 0, sizeof(cclc));
>    195          memcpy(cclc.hdr.eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
>    196          cclc.hdr.type = SMC_CLC_CONFIRM;
>    197          cclc.hdr.length = htons(sizeof(cclc));
>    198          cclc.hdr.version = SMC_CLC_V1;          /* SMC version */
>    199          memcpy(cclc.lcl.id_for_peer, local_systemid, sizeof(local_systemid));
>    200          memcpy(&cclc.lcl.gid, &link->smcibdev->gid[link->ibport - 1],
>    201                 SMC_GID_SIZE);
>    202          memcpy(&cclc.lcl.mac, &link->smcibdev->mac[link->ibport - 1],
>    203                 sizeof(link->smcibdev->mac));
> 
> We are corrupting the top bits of link here.  Or maybe there is padding?
Not the top bits of link are overwritten, but the following field "qpn" in struct
smc_clc_msg_accept_confirm. "qpn" is set later on anyway; that's why the code
works, even though the memcpy length is wrong (and will be fixed).
> 
>    204          hton24(cclc.qpn, link->roce_qp->qp_num);
>    205          cclc.rmb_rkey =
>    206                  htonl(conn->rmb_desc->mr_rx[SMC_SINGLE_LINK]->rkey);
> 
> regards,
> dan carpenter
> 
Regards, Ursula Braun
