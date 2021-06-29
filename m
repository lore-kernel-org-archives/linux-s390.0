Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FD8C11F68
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C145061D3D
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 14:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhF2O0g (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:26:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234300AbhF2O0g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Jun 2021 10:26:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TE4JhQ078971;
        Tue, 29 Jun 2021 10:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9H/pQ04FCs/tQ0avegBXhMmlE+E+8CGDVZnid+F/UX0=;
 b=EyYgyu1u3lSzNqjxXV7HPXd/IlxdktxE3sFp6FNwl8ku1B2FfAKFQM8CawEmdTlAOpR2
 YPWdx6FRrizyYy2Pc0kTuWbXNNuWgT9zrvS55KclB8XnzYlfQipYUnZoZMzV9VCNEZrj
 fcBCEJXsE0st1l7QoxwrpN3QuPO01h7Yd8raOZ6B8mTGLydj4KmE4Dhgh9gOjmQHMXGj
 X9Rw0E01smzOdIrzbafPEXY9w5NxOjzvzx/oBjna7ccvQAh47ebbzs+bqULEJg+4/MyH
 zzhlpGSB0kczvoOtkJHbZuBn2U9ynVhY0BmNetWZ5j05Dhbz6+2gpy1s24u4iaOmM2/L Cg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g4e3spa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 10:24:07 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TEF5or000800;
        Tue, 29 Jun 2021 14:24:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 39duv8gpqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 14:24:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TEO1dv22020582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 14:24:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA8A2A4D76;
        Tue, 29 Jun 2021 14:24:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AB46A4D67;
        Tue, 29 Jun 2021 14:24:01 +0000 (GMT)
Received: from osiris (unknown [9.145.27.87])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Jun 2021 14:24:01 +0000 (GMT)
Date:   Tue, 29 Jun 2021 16:24:00 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/dasd: Avoid field over-reading memcpy()
Message-ID: <YNstANuJWSprSefl@osiris>
References: <20210616201917.1246079-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616201917.1246079-1-keescook@chromium.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tsp18nn4WU_Zg5zCKmyk3cC-XCkPbsY2
X-Proofpoint-ORIG-GUID: tsp18nn4WU_Zg5zCKmyk3cC-XCkPbsY2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_06:2021-06-28,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=735 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290095
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 16, 2021 at 01:19:17PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field array bounds checking for memcpy(), memmove(), and memset(),
> avoid intentionally reading across neighboring array fields.
> 
> Add a wrapping structure to serve as the memcpy() source, so the compiler
> can do appropriate bounds checking, avoiding this future warning:
> 
> In function '__fortify_memcpy',
>     inlined from 'create_uid' at drivers/s390/block/dasd_eckd.c:749:2:
> ./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/s390/block/dasd_eckd.c | 2 +-
>  drivers/s390/block/dasd_eckd.h | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

I'll leave it up to Stefan Haberland and Jan Hoeppner to handle this one.
