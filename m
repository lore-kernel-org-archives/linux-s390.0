Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B6AC2B9F4
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 14:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDD461361
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 14:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhFVOTt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Jun 2021 10:19:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231592AbhFVOTr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Jun 2021 10:19:47 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MEBGk7171573;
        Tue, 22 Jun 2021 10:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Gz9uJEytLVm5WXbBekh5wtGUfyEdU0H2nVgqtlUQe8M=;
 b=K++WOoPQnGxNndhwItK2O3iXi+OiG6kTJGScO6sYvAZzQXs89EMQSB9MIzGaL6C5GBga
 4bsMIC2h2PUf/2TJD+zI63XLlJau5FZV2PVNq4FyGMeOPptMk6nYfPVvjH/NC4sUfFt3
 y/b5x/TMUvXI4CRw0QweO+6qeZu2Z3PRJm+zFNKOLkQ7KeCkebikvjpjrHXLjMjWyX6B
 +/2ClSvMSSgFktlpcMvLrAzzyFJDviAJhK7MPACgKgWj57fLchvEMgXR4IkMjEasC8V+
 5N7LyrAi3su5e1xxS+c5lobIpPVWK7PU20/XJH78ly6gKj4pi1w70YhRAGvLXsSQhcIa dA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39bh0w8uen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 10:17:30 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15MEDQ93020230;
        Tue, 22 Jun 2021 14:17:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3998788u7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 14:17:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15MEG3qW38011386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:16:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C17CA4065;
        Tue, 22 Jun 2021 14:17:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FA43A4062;
        Tue, 22 Jun 2021 14:17:23 +0000 (GMT)
Received: from localhost (unknown [9.171.76.220])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Jun 2021 14:17:22 +0000 (GMT)
Date:   Tue, 22 Jun 2021 16:17:21 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/zcrypt: Switch to flexible array member
Message-ID: <your-ad-here.call-01624371441-ext-6851@work.hours>
References: <20210616201903.1245949-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210616201903.1245949-1-keescook@chromium.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gn0S_LhBECgfY0Qqhg4inXZQ2r3pdcoC
X-Proofpoint-ORIG-GUID: Gn0S_LhBECgfY0Qqhg4inXZQ2r3pdcoC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_08:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106220088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 16, 2021 at 01:19:02PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally reading/writing across neighboring array fields.
> 
> Switch from zero-element arrays to flexible arrays so the compiler will
> perform appropriate bounds checking, avoiding these future warnings:
> 
> In function '__fortify_memcpy',
>     inlined from 'cca_sec2protkey' at drivers/s390/crypto/zcrypt_ccamisc.c:645:2:
> ./include/linux/fortify-string.h:244:4: error: call to '__write_overflow_field' declared with attribute error: detected write beyond size of field (1st parameter)
> 
> In function '__fortify_memcpy',
>     inlined from 'cca_clr2seckey' at drivers/s390/crypto/zcrypt_ccamisc.c:568:3:
> ./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)
> 
> In function '__fortify_memcpy',
>     inlined from 'cca_genseckey' at drivers/s390/crypto/zcrypt_ccamisc.c:429:2:
> ./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/s390/crypto/zcrypt_ccamisc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks!
