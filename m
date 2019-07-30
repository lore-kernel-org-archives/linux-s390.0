Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45254 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfG3Q7F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Jul 2019 12:59:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so30147080pfq.12
        for <linux-s390@vger.kernel.org>; Tue, 30 Jul 2019 09:59:04 -0700 (PDT)
Date: Tue, 30 Jul 2019 09:59:02 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] s390/net: Mark expected switch fall-throughs
Message-ID: <201907300959.12D21B6F09@keescook>
References: <20190730001715.GA20706@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730001715.GA20706@embeddedor>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 07:17:15PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: s390):
> 
> drivers/s390/net/ctcm_fsms.c: In function ‘ctcmpc_chx_attnbusy’:
> drivers/s390/net/ctcm_fsms.c:1703:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (grp->changed_side == 1) {
>       ^
> drivers/s390/net/ctcm_fsms.c:1707:2: note: here
>   case MPCG_STATE_XID0IOWAIX:
>   ^~~~
> 
> drivers/s390/net/ctcm_mpc.c: In function ‘ctc_mpc_alloc_channel’:
> drivers/s390/net/ctcm_mpc.c:358:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (callback)
>       ^
> drivers/s390/net/ctcm_mpc.c:360:2: note: here
>   case MPCG_STATE_XID0IOWAIT:
>   ^~~~
> 
> drivers/s390/net/ctcm_mpc.c: In function ‘mpc_action_timeout’:
> drivers/s390/net/ctcm_mpc.c:1469:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if ((fsm_getstate(rch->fsm) == CH_XID0_PENDING) &&
>       ^
> drivers/s390/net/ctcm_mpc.c:1472:2: note: here
>   default:
>   ^~~~~~~
> drivers/s390/net/ctcm_mpc.c: In function ‘mpc_send_qllc_discontact’:
> drivers/s390/net/ctcm_mpc.c:2087:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (grp->estconnfunc) {
>       ^
> drivers/s390/net/ctcm_mpc.c:2092:2: note: here
>   case MPCG_STATE_FLOWC:
>   ^~~~
> 
> drivers/s390/net/qeth_l2_main.c: In function ‘qeth_l2_process_inbound_buffer’:
> drivers/s390/net/qeth_l2_main.c:328:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (IS_OSN(card)) {
>        ^
> drivers/s390/net/qeth_l2_main.c:337:3: note: here
>    default:
>    ^~~~~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/s390/net/ctcm_fsms.c    | 1 +
>  drivers/s390/net/ctcm_mpc.c     | 3 +++
>  drivers/s390/net/qeth_l2_main.c | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
> index 1b4ee570b712..4a8a5373cb35 100644
> --- a/drivers/s390/net/ctcm_fsms.c
> +++ b/drivers/s390/net/ctcm_fsms.c
> @@ -1704,6 +1704,7 @@ static void ctcmpc_chx_attnbusy(fsm_instance *fsm, int event, void *arg)
>  			grp->changed_side = 2;
>  			break;
>  		}
> +		/* Else, fall through */
>  	case MPCG_STATE_XID0IOWAIX:
>  	case MPCG_STATE_XID7INITW:
>  	case MPCG_STATE_XID7INITX:
> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> index e02f295d38a9..1534420a0243 100644
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c
> @@ -357,6 +357,7 @@ int ctc_mpc_alloc_channel(int port_num, void (*callback)(int, int))
>  		/*fsm_newstate(grp->fsm, MPCG_STATE_XID2INITW);*/
>  		if (callback)
>  			grp->send_qllc_disc = 1;
> +		/* Else, fall through */
>  	case MPCG_STATE_XID0IOWAIT:
>  		fsm_deltimer(&grp->timer);
>  		grp->outstanding_xid2 = 0;
> @@ -1469,6 +1470,7 @@ static void mpc_action_timeout(fsm_instance *fi, int event, void *arg)
>  		if ((fsm_getstate(rch->fsm) == CH_XID0_PENDING) &&
>  		   (fsm_getstate(wch->fsm) == CH_XID0_PENDING))
>  			break;
> +		/* Else, fall through */
>  	default:
>  		fsm_event(grp->fsm, MPCG_EVENT_INOP, dev);
>  	}
> @@ -2089,6 +2091,7 @@ static int mpc_send_qllc_discontact(struct net_device *dev)
>  			grp->estconnfunc = NULL;
>  			break;
>  		}
> +		/* Else, fall through */
>  	case MPCG_STATE_FLOWC:
>  	case MPCG_STATE_READY:
>  		grp->send_qllc_disc = 2;
> diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
> index fd64bc3f4062..cbead3d1b2fd 100644
> --- a/drivers/s390/net/qeth_l2_main.c
> +++ b/drivers/s390/net/qeth_l2_main.c
> @@ -333,7 +333,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
>  				card->osn_info.data_cb(skb);
>  				break;
>  			}
> -			/* else unknown */
> +			/* Else, fall through */
>  		default:
>  			dev_kfree_skb_any(skb);
>  			QETH_CARD_TEXT(card, 3, "inbunkno");
> -- 
> 2.22.0
> 

-- 
Kees Cook
