Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726394AbfHEHZc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Aug 2019 03:25:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x757NSq1025262
        for <linux-s390@vger.kernel.org>; Mon, 5 Aug 2019 03:25:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u6dv55faf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 05 Aug 2019 03:25:30 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 5 Aug 2019 08:25:28 +0100
Subject: Re: [PATCH] s390/net: Mark expected switch fall-throughs
References: <20190730001715.GA20706@embeddedor>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon, 5 Aug 2019 09:25:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190730001715.GA20706@embeddedor>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9d2534f3-246b-ad01-6cae-b9c461b28bac@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ursula Braun <ubraun@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>

On 30.07.19 02:17, Gustavo A. R. Silva wrote:
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
> ---
>  drivers/s390/net/ctcm_fsms.c    | 1 +
>  drivers/s390/net/ctcm_mpc.c     | 3 +++
>  drivers/s390/net/qeth_l2_main.c | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 

Applied, thanks.
