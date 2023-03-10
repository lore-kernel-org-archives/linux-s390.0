Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E5DC6FA99
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 12:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCJMeg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 07:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCJMef (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 07:34:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED58E10BA7E
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 04:34:34 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ABwQBv020771
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=QRlJcmkkie+mP8rzZxu/mBFOYFQiBUqHZ9M/Vl05iaY=;
 b=NyPvQK/INAeu07vbPEBS/IHoZAah7XYcjnj/TQ0o1eRr+Mw4Pmsisyao+kOgG456AoRj
 GhTdQJfUVUWviYJdDBtQitNfNcb2Ox/pvLlP4zIZ6FX3kaOkIvrbvwPRMJol8Ua60077
 rTeDLgXsSUTY2+r/SGe5gC3i58xYxZxMi5kYroszmEJj8qbXxxUlZBK0xJKPbY3xItAO
 0gWK3/sdBXFWmBjhm//xa6mDYAt6RoH9qoFw9nu9B6mtan8FJ+cjbrRKCz8PoJwjU8pt
 rp+CBTYmkaETotJ/zsM/1NmcuzU0AsQn9i/FIvHvGJxB6jL2iJMSIfNuqSRkNKAre7R5 EA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7va7mtvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:34:34 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A7uanG023013
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:34:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p6fysuu5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:34:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ACYRRX50266566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 12:34:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 710F32004E;
        Fri, 10 Mar 2023 12:34:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EEE320043;
        Fri, 10 Mar 2023 12:34:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Mar 2023 12:34:27 +0000 (GMT)
Date:   Fri, 10 Mar 2023 13:34:22 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
Subject: Re: [PATCH v1] s390: ipl: fix physical-virtual confusion for diag308
Message-ID: <ZAsjzoA07NTYENku@tuxmaker.boeblingen.de.ibm.com>
References: <20230310122204.1898-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310122204.1898-1-nrb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xXAI_AK3WelB59W_fWw5gcm6DboKGfTK
X-Proofpoint-GUID: xXAI_AK3WelB59W_fWw5gcm6DboKGfTK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=968
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100100
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Mar 10, 2023 at 01:22:04PM +0100, Nico Boehr wrote:
> Diag 308 subcodes expect a physical address as their parameter.
> 
> This currently is not a bug, but in the future physical and virtual
> addresses might differ.
> 
> Fix the confusion by doing a virtual-to-physical conversion in the
> exported diag308() and leave the assembly wrapper __diag308() alone.
> 
> Note that several callers pass NULL as addr, this is fine since
> virt_to_phys(0) == 0.
> 
> Suggested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>  arch/s390/kernel/ipl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 5f0f5c86963a..5611ba8f68b9 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -176,7 +176,7 @@ static bool reipl_fcp_clear;
>  static bool reipl_ccw_clear;
>  static bool reipl_eckd_clear;
>  
> -static inline int __diag308(unsigned long subcode, void *addr)
> +static inline int __diag308(unsigned long subcode, u64 addr)
>  {
>  	union register_pair r1;
>  
> @@ -195,7 +195,7 @@ static inline int __diag308(unsigned long subcode, void *addr)
>  int diag308(unsigned long subcode, void *addr)
>  {
>  	diag_stat_inc(DIAG_STAT_X308);
> -	return __diag308(subcode, addr);
> +	return __diag308(subcode, virt_to_phys(addr));
>  }
>  EXPORT_SYMBOL_GPL(diag308);

Please note diag308() is called with NULL a lot.
I think a proper fix would be like this:

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 0f91cd401eef..43de939b7af1 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -176,11 +176,11 @@ static bool reipl_fcp_clear;
 static bool reipl_ccw_clear;
 static bool reipl_eckd_clear;
 
-static inline int __diag308(unsigned long subcode, void *addr)
+static inline int __diag308(unsigned long subcode, unsigned long addr)
 {
 	union register_pair r1;
 
-	r1.even = (unsigned long) addr;
+	r1.even = addr;
 	r1.odd	= 0;
 	asm volatile(
 		"	diag	%[r1],%[subcode],0x308\n"
@@ -195,7 +195,7 @@ static inline int __diag308(unsigned long subcode, void *addr)
 int diag308(unsigned long subcode, void *addr)
 {
 	diag_stat_inc(DIAG_STAT_X308);
-	return __diag308(subcode, addr);
+	return __diag308(subcode, addr ? virt_to_phys(addr) : 0);
 }
 EXPORT_SYMBOL_GPL(diag308);
