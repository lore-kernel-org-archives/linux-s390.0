Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC89C433DB
	for <linux-s390@archiver.kernel.org>; Fri,  5 Mar 2021 10:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8644465018
	for <linux-s390@archiver.kernel.org>; Fri,  5 Mar 2021 10:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCEKPO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Mar 2021 05:15:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhCEKOw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Mar 2021 05:14:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125A8xDW069543;
        Fri, 5 Mar 2021 10:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yelKnsHpxqV3KJ4nsuvTDUoBJHixZnZ8Hw5llBdWxf0=;
 b=RkxlwgXrr1WelePW7vV8XPCFiT+9d4a4A7mp28lxk0lV7FRhM/4znJc6vQJmahnP1f32
 NcN5BjZWkeIJYwjia4gjCI87Ca2+PcBDtFJE/y2wRsOcPjTHtuPvTcjYhzIotKHnMRtc
 FIZq887myvp47exUvJE08sRUiN1oJlr41kDPjckKvP4DStbqjc1gLdRJuV7XK+6RNkIY
 CGB6HluHT/1IW/9HQWxPg8yqUXzkegfec8+9oHQTCTwFQUDTuNlu9cgqtgLLtMd8s0O2
 AwdvW7jCQtOAKWrfPrGbC3cjj4zSpzIajiPAp58h8AV/nCAJ9rqIyRDldG9e+24UeXRb BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36yeqn9ydx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 10:14:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125ABD6L103660;
        Fri, 5 Mar 2021 10:14:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 370003teys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 10:14:45 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 125AEe2T019681;
        Fri, 5 Mar 2021 10:14:41 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Mar 2021 02:14:40 -0800
Date:   Fri, 5 Mar 2021 13:14:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     linux-s390@vger.kernel.org, smatch@vger.kernel.org
Subject: Re: smatch and copy_{to,from}_user return values
Message-ID: <20210305101434.GI2222@kadam>
References: <b57b4f40-d67c-d57c-c5b2-077b623ed4ed@prevas.dk>
 <20210303112046.GB2222@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303112046.GB2222@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050049
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050049
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

It turns out that my check for returning -EIO instead of -EFAULT doesn't
work at all...  :/  How the cross function DB works is that it tries to
figure out groups of states which should go together.  Most of the time
you could combine all the failure paths together and combine the success
paths together, for example.

But with copy_from_user() there is only one set of states recorded.

sound/pci/rme9652/hdspm.c | copy_from_user | 1093 | 0-u32max[<=$2]|        INTERNAL | -1 |                      | ulong(*)(void*, void*, ulong) | 
sound/pci/rme9652/hdspm.c | copy_from_user | 1093 | 0-u32max[<=$2]|     CAPPED_DATA | -1 |                    $ |                      | 
sound/pci/rme9652/hdspm.c | copy_from_user | 1093 | 0-u32max[<=$2]| UNTRACKED_PARAM |  0 |                    $ |                      | 
sound/pci/rme9652/hdspm.c | copy_from_user | 1093 | 0-u32max[<=$2]| UNTRACKED_PARAM |  1 |                    $ |                      | 
sound/pci/rme9652/hdspm.c | copy_from_user | 1093 | 0-u32max[<=$2]|     PARAM_LIMIT |  2 |                    $ |             1-u64max | 
sound/pci/rme9652/hdspm.c | copy_from_user | 1093 | 0-u32max[<=$2]| NO_OVERFLOW_SIMPLE |  0 |                    $ |                      | 
sound/pci/rme9652/hdspm.c | copy_from_user | 1093 | 0-u32max[<=$2]|        STMT_CNT | -1 |                      |                   16 |

I could modify smatch_data/db/fixup_kernel.sh to hard code the desired
split, which is sort of awkward and also this in inlined so that makes
even more awkward.  Or I could create a new table with a manual way of
forcing splits in return states with entries like:

copy_from_user 0-u32max[<=$2] 0 1-u32max[<=$2]

That's probably the way to go, actually.

The check for propagating the return from copy_from_user() only looks
at assignments.  It sets the state to &remaining intialialy and then
if it sees a comparison with "if (ret) " it set the false path to &ok.
Then if we "return ret;" and "ret" is in state &remaining then complain.


static void match_copy(const char *fn, struct expression *expr, void *unused)
{
        if (expr->op == SPECIAL_SUB_ASSIGN)
                return;
        set_state_expr(my_id, expr->left, &remaining);
}

static void match_condition(struct expression *expr)
{
        if (!get_state_expr(my_id, expr))
                return;
        /* If the variable is zero that's ok */
        set_true_false_states_expr(my_id, expr, NULL, &ok);
}

regards,
dan carpenter
