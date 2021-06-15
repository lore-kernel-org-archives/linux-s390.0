Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF5C48BDF
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 23:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E3861245
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 23:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhFOXWL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Jun 2021 19:22:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhFOXWK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Jun 2021 19:22:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FNESC7130849;
        Tue, 15 Jun 2021 19:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=qkDrRL+kFAdywKSAgJ0+Gvc/rzwjrV+zPz4PbZ+zNSQ=;
 b=JvZF6dUU8BuX394b4Y5NUK3zhFrOunn07TAua2mlsun5i8FF/h77zq4AQvHWRw3dYMVT
 Ji+jH7i5odeVLfhtxMgd0mjlAB9DW3x6ltIr4UmvzK2atA8aas53pP8Wc/B/NR5Iupzx
 xE0x9W5+rP5U0B/5VLNYblYqqYvMrFAhZk8eFbYlFsHvBO84Sy6U3mDo36tlNxpo2UTI
 rJPysUwjYfnnp0IP5lYg2QtUC1Dr/hF9SYdF6XQ71oMGYuZPR78w8U4OHuuvwbrxhoYr
 VnKejuY/sJVz7u38QaBLN05CYbfa3BSPaianmGyiZho7YDG5gGNtOkm5SBljUqvX8jRB UA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3975py843y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 19:20:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15FNCN8O029818;
        Tue, 15 Jun 2021 23:20:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 394mj8gyg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 23:20:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15FNIt0V36176222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 23:18:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5DE552050;
        Tue, 15 Jun 2021 23:19:57 +0000 (GMT)
Received: from localhost (unknown [9.171.72.121])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 7BD0C5204F;
        Tue, 15 Jun 2021 23:19:57 +0000 (GMT)
Date:   Wed, 16 Jun 2021 01:19:56 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/boot: add zstd support
Message-ID: <your-ad-here.call-01623799196-ext-1245@work.hours>
References: <20210615114150.325080-1-dimitri.ledkov@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210615114150.325080-1-dimitri.ledkov@canonical.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vOivXIbsRptxIZXNrURxeVztOAwS0VpU
X-Proofpoint-ORIG-GUID: vOivXIbsRptxIZXNrURxeVztOAwS0VpU
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_07:2021-06-15,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106150142
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 15, 2021 at 12:41:50PM +0100, Dimitri John Ledkov wrote:
> Enable ztsd support in s390/boot, to enable booting with zstd
> compressed kernel when configured with CONFIG_KERNEL_ZSTD=y.
> 
> BugLink: https://bugs.launchpad.net/bugs/1931725
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> cc: Heiko Carstens <hca@linux.ibm.com>
> cc: Vasily Gorbik <gor@linux.ibm.com>
> cc: Christian Borntraeger <borntraeger@de.ibm.com>
> cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/Kconfig                        | 1 +
>  arch/s390/boot/compressed/Makefile       | 4 ++++
>  arch/s390/boot/compressed/decompressor.c | 4 ++++
>  3 files changed, 9 insertions(+)

Reviewing your patch I noticed that we use wrong condition to
define BOOT_HEAP_SIZE. So I made a tiny fix:

diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
index 3061b11c4d27..cf2571050c68 100644
--- a/arch/s390/boot/compressed/decompressor.c
+++ b/arch/s390/boot/compressed/decompressor.c
@@ -29,5 +29,5 @@ extern unsigned char _compressed_start[];
 extern unsigned char _compressed_end[];
 
-#ifdef CONFIG_HAVE_KERNEL_BZIP2
+#ifdef CONFIG_KERNEL_BZIP2
 #define BOOT_HEAP_SIZE 0x400000
 #else

And applied your patch with the following changes:
Added to the commit message:
"""
BOOT_HEAP_SIZE is defined to 0x30000 in this case. Actual decompressor
memory usage with allyesconfig is currently 0x26150.
"""

diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
index cf2571050c68..37a4a8d33c6c 100644
--- a/arch/s390/boot/compressed/decompressor.c
+++ b/arch/s390/boot/compressed/decompressor.c
@@ -31,4 +31,6 @@ extern unsigned char _compressed_end[];
 #ifdef CONFIG_KERNEL_BZIP2
 #define BOOT_HEAP_SIZE 0x400000
+#elif CONFIG_KERNEL_ZSTD
+#define BOOT_HEAP_SIZE 0x30000
 #else
 #define BOOT_HEAP_SIZE 0x10000

I hope you are ok with that, thanks!
