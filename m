Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725922AbfHYNgR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 25 Aug 2019 09:36:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7PDWdLF052176
        for <linux-s390@vger.kernel.org>; Sun, 25 Aug 2019 09:36:16 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ukj7y5856-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sun, 25 Aug 2019 09:36:16 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Sun, 25 Aug 2019 14:36:14 +0100
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_s390/ctcm=3a_Delete_unnecessary_checks_?=
 =?UTF-8?B?YmVmb3JlIHRoZSBtYWNybyBjYWxsIOKAnGRldl9rZnJlZV9za2LigJ0=?=
References: <84733436-46d1-8f43-780e-7b3ab9f2a0ae@web.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Sun, 25 Aug 2019 21:36:08 +0800
MIME-Version: 1.0
In-Reply-To: <84733436-46d1-8f43-780e-7b3ab9f2a0ae@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9b655bf1-8565-d768-04ee-bc286a7e9efe@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 22.08.19 17:04, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 22 Aug 2019 10:55:33 +0200
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Applied, thanks.

>  drivers/s390/net/ctcm_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index f63c5c871d3d..90025d1923d2 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -1074,10 +1074,8 @@ static void ctcm_free_netdevice(struct net_device *dev)
>  		if (grp) {
>  			if (grp->fsm)
>  				kfree_fsm(grp->fsm);
> -			if (grp->xid_skb)
> -				dev_kfree_skb(grp->xid_skb);
> -			if (grp->rcvd_xid_skb)
> -				dev_kfree_skb(grp->rcvd_xid_skb);
> +			dev_kfree_skb(grp->xid_skb);
> +			dev_kfree_skb(grp->rcvd_xid_skb);
>  			tasklet_kill(&grp->mpc_tasklet2);
>  			kfree(grp);
>  			priv->mpcg = NULL;
> --
> 2.23.0
> 
