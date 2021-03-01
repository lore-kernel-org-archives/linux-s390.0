Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A98C433E0
	for <linux-s390@archiver.kernel.org>; Mon,  1 Mar 2021 13:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB39364E09
	for <linux-s390@archiver.kernel.org>; Mon,  1 Mar 2021 13:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhCANPC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 Mar 2021 08:15:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235521AbhCANOV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Mar 2021 08:14:21 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121D44tH154301;
        Mon, 1 Mar 2021 08:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mUHX0OdekiPeVkj4z0QODKN3mlJJPyK/azho+6myROk=;
 b=pkwkX3R6G1wxMTRim/gdBz1HQjSJkKaEeg7jOlUnLI68VxOESr6r7754wode3rx+zPob
 FCaP7deUcS6noJpjQyv0PDlZr+6s91CQOI0ySi+WxueuPyRH7kQbt4/+rmf9/i7piSlb
 gCVy2XBgx9mRvdUWXcgbRVMqZt69n7cvr9Ydhx0HdOJ1eO+7VYsu97kBjCmdbILllASQ
 52wsAbvApx9yJtP6xCEtU04fzs3Cu7YF9ENClKx5KJCJLL2iYvIMxFSO3oHj3IOGRJCz
 SVevC+LyIifRwlQ2a2CK7rtCHi6LT+ekW5JJHnvPmEB3AZNatdXEZweu8FcOV6RoGYHv Kg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3710tk0cfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 08:13:40 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121DCkuQ022779;
        Mon, 1 Mar 2021 13:13:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 36ydq8hwnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 13:13:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121DDYaq3015256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 13:13:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC021A405B;
        Mon,  1 Mar 2021 13:13:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60712A4054;
        Mon,  1 Mar 2021 13:13:34 +0000 (GMT)
Received: from osiris (unknown [9.171.28.2])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  1 Mar 2021 13:13:34 +0000 (GMT)
Date:   Mon, 1 Mar 2021 14:13:32 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: crypto: Return -EFAULT if copy_to_user() fails
Message-ID: <YDzofESgA7RCnyI2@osiris>
References: <1614600502-16714-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614600502-16714-1-git-send-email-wangqing@vivo.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_08:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=943 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010108
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Mar 01, 2021 at 08:08:21PM +0800, Wang Qing wrote:
> The copy_to_user() function returns the number of bytes remaining to be
> copied, but we want to return -EFAULT if the copy doesn't complete.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!
