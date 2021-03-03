Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E22C43331
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 22:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCACC64EF9
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 22:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354131AbhCCWet (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:34:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57794 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbhCCMgI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Mar 2021 07:36:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123BF8gh057868;
        Wed, 3 Mar 2021 11:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VxmJbjkZxOuabEIWqUDFawYN3xgFKhOUYeS13Npa9tw=;
 b=cAPRxwjY898jzZNcjfmeixZAH3f2viwlwRokTNfAFGzpEqc6Z9UReNILvcjEKle+mPiR
 jAOGsZLA1BYFQPqxbLas9lm1KB1gSiffgb8hCjEsaCbhwTR363bpTeKmQNTyq7baGoSX
 UPL68t5+ObCEWjKCcr9JZmbczE+QYWv5risiTgrebpGrf5ZnbfBe7rliL0l1bcJ1Nyyt
 v+Xmnw9lZdhnGCMh6YTmCQbJHUM0c7WpGrbVelSg5+4WLaUP127J/gs2wp26NBANrNTD
 WwS9Xdmx2E81PwYzaLzKhNhKKNaKBWTtXwSMoZ8A0Uw9tFaDNd2fu7nCA7KOEMYrbPlJ KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3726v78hdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 11:20:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123BFCt4046900;
        Wed, 3 Mar 2021 11:20:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 36yynqe7p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 11:20:55 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 123BKrkK016818;
        Wed, 3 Mar 2021 11:20:53 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Mar 2021 03:20:53 -0800
Date:   Wed, 3 Mar 2021 14:20:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     linux-s390@vger.kernel.org, smatch@vger.kernel.org
Subject: Re: smatch and copy_{to,from}_user return values
Message-ID: <20210303112046.GB2222@kadam>
References: <b57b4f40-d67c-d57c-c5b2-077b623ed4ed@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kuk/n493crKO4rgR"
Content-Disposition: inline
In-Reply-To: <b57b4f40-d67c-d57c-c5b2-077b623ed4ed@prevas.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030088
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


--Kuk/n493crKO4rgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 03, 2021 at 08:50:19AM +0100, Rasmus Villemoes wrote:
> Hi Dan
> 
> If you look at vfio_ccw_mdev_ioctl() in drivers/s390/cio/vfio_ccw_ops.c,
> and vfio_ap_mdev_get_device_info() in drivers/s390/crypto/vfio_ap_ops.c,
> there are examples of functions that can both return -Esomething as well
> as may return the return value of a copy_{to,from}_user directly (i.e.,
> in case of error some positive number).
> 
> [Those "return copy_to_user();" should probably all be changed to
> "return copy_to_user() ? -EFAULT : 0;" - cc'ing the s390 list in case
> the maintainers want to do that.]
> 
> Can smatch detect such cases? I seem to recall it has some concept of
> tagging a function as "returning -Efoo or 0", so it would also need to
> know that copy_{to,from}_user does not return -Efoo. And it also needs
> to follow the control flow, so
> 
>  ret = copy_to_user();
>  if (ret)
>     return -EIO;
>  something_else;
>  return ret; /* this is 0 */
> 
> doesn't trigger. And there's gonna be some false positives around signal
> frame setup, which do a lot of "err |= foo(); err |= bar()" where foo()
> report errors as -Exxx and bar can be a copy_to_user(), but in the end
> err is only checked against 0.
> 
> Rasmus

Yeah.  There is already a check for if you propagate the return from
copy_from_user()...  The problem is that this is s390 code and I don't
have a cross compiler set up so this was never reported or fixed.

When I first saw your email, I didn't read it carefully and I thought
you were complaining about code that returns -EIO where -EFAULT is
intended.  Anyway, I wrote that check before re-reading the email.  LOL.
Attached.

I did a quick "git grep |= copy_" and I see that's mostly used in
signal code where the caller doesn't care about the error code, only
whether it's zero vs non-zero.  I considered about excluding "arch/"
from the check but then there are only two instances where this is used
and both are correct.

regards,
dan carpenter


--Kuk/n493crKO4rgR
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_return_efault2.c"

/*
 * Copyright (C) 2021 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_extra.h"

static int my_id;

static const sval_t ulong_one	= { .type = &ulong_ctype, .value = 1 };
static const sval_t ulong_INT_MAX = { .type = &ulong_ctype, .value = INT_MAX };

STATE(copy_failed);

static void match_copy_failed(const char *fn, struct expression *call_expr,
			      struct expression *expr, void *_unused)
{
	set_state(my_id, "path", NULL, &copy_failed);
}

static void match_return(struct expression *expr)
{
	char *macro = NULL;
	sval_t ret;

	if (!get_value(expr, &ret))
		return;
	if (ret.value == -14)
		return;
	if (get_state(my_id, "path", NULL) != &copy_failed)
		return;

	if (expr->type == EXPR_PREOP && expr->op == '-')
		macro = get_macro_name(expr->unop->pos);

	if (macro)
		sm_warning("return -EFAULT instead of '-%s'", macro);
	else
		sm_warning("return -EFAULT instead of '%s'", sval_to_str(ret));
}

void check_return_efault2(int id)
{
	if (option_project != PROJ_KERNEL)
		return;

	my_id = id;

	return_implies_state_sval("copy_to_user", ulong_one, ulong_INT_MAX, &match_copy_failed, NULL);
	return_implies_state_sval("copy_from_user", ulong_one, ulong_INT_MAX, &match_copy_failed, NULL);
	return_implies_state_sval("__copy_to_user", ulong_one, ulong_INT_MAX, &match_copy_failed, NULL);
	return_implies_state_sval("__copy_from_user", ulong_one, ulong_INT_MAX, &match_copy_failed, NULL);

	add_hook(&match_return, RETURN_HOOK);
}

--Kuk/n493crKO4rgR--
