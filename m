Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832B6C11F66
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 14:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688F161DBF
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 14:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhF2O2d (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:28:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41860 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234018AbhF2O2d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Jun 2021 10:28:33 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TE3uKv027571;
        Tue, 29 Jun 2021 10:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4XHdTDx+f1fuX9iH8cUMgK1N4wwfAyYJN1OtpzY0PJQ=;
 b=QPdtv7FVlz+Pv/i7jvwlP89vsb7Z7ofj+H4EePBc7cFzn7d7O0DQqYHdaCxtlVVYhmFm
 JCcZgjdL0JCGWqd9QhkIwEcj6tRpy+VQd9shsqmHe6E4u4tGbbFtt/0y8rZf0ncETw+i
 3dDY7TRWyF9jwPGb/e4+cZCz3r+QvYZzd6dwCkOly8P+FMF5d27lxD3ZLU+N+4np51x6
 0HdfSBFsKMbFCDvYmIcNxVxi9PC32MtXmZc5b0IU2fC99bDJLLEhU7LiotjII7dRukr1
 hxH2dXb3gFtWiQl+UKEwhM9accY438SsjQytY76DJmRXZ4syD+UIch5LF5D/fMgFD9Sf uw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g4bv1ub2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 10:26:01 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TEPx2g009736;
        Tue, 29 Jun 2021 14:25:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 39duv89b5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 14:25:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TEPuWL34472348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 14:25:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F99FA4D59;
        Tue, 29 Jun 2021 14:25:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45E0DA4D67;
        Tue, 29 Jun 2021 14:25:56 +0000 (GMT)
Received: from osiris (unknown [9.145.27.87])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Jun 2021 14:25:56 +0000 (GMT)
Date:   Tue, 29 Jun 2021 16:25:54 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390: iucv: Avoid field over-reading memcpy()
Message-ID: <YNstcvvzHKnrvW3d@osiris>
References: <20210616201942.1246211-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616201942.1246211-1-keescook@chromium.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0N5-G2kN8AAM3oReH1CNRvNPphV9_ntC
X-Proofpoint-GUID: 0N5-G2kN8AAM3oReH1CNRvNPphV9_ntC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_06:2021-06-28,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxlogscore=610 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290095
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 16, 2021 at 01:19:42PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally reading across neighboring array fields.
> 
> Add a wrapping struct to serve as the memcpy() source so the compiler
> can perform appropriate bounds checking, avoiding this future warning:
> 
> In function '__fortify_memcpy',
>     inlined from 'iucv_message_pending' at net/iucv/iucv.c:1663:4:
> ./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  net/iucv/iucv.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

This one is for Julian Wiedmann and Karsten Graul.
