Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E27C433DB
	for <linux-s390@archiver.kernel.org>; Wed, 24 Mar 2021 09:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB23619B4
	for <linux-s390@archiver.kernel.org>; Wed, 24 Mar 2021 09:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhCXJut (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 Mar 2021 05:50:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55910 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234802AbhCXJu2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Mar 2021 05:50:28 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12O9YYGk087922;
        Wed, 24 Mar 2021 05:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PQUFBI17hkQKnhOZi9dMY84rHMyxdyJlb/kRrb0N7Gs=;
 b=P1+efJBntXRx1jyrBR6iTwJwF0H6yDl/GRcI5GPirL+lYy2kvr9f34M+ZkWoObks0dTP
 GuO5lVQFxvqjh5VsF2M3N7A9D6ToXTPatd3v5rkcWpDOGq4KgGjQI5EsukLDOi/toGIE
 3Gm34nmsnem2UMDjE441+fI3xZYrV4MEzwugclJOfFGg01rU3fQ2AH06Jiu+4XOojF55
 kTPnQ2YnzCrF3pCNz81VeG+XXKwwPjuVb77pJ9NSB9LEpH6NbkV19gtffmIaUs3tf6hI
 5dLMP7NyNOcbruJ3f0eekuuARsP+7IeWEU0BCY0gXBj5jA4MraUqQrPuGfOAqoxrKc2y IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fw2u15sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 05:50:18 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12O9Yak6088070;
        Wed, 24 Mar 2021 05:50:18 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fw2u15s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 05:50:17 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12O9nF5j011226;
        Wed, 24 Mar 2021 09:50:16 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99rc6k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 09:50:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12O9oDWZ30409208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 09:50:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F41FBAE04D;
        Wed, 24 Mar 2021 09:50:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 838DEAE058;
        Wed, 24 Mar 2021 09:50:12 +0000 (GMT)
Received: from osiris (unknown [9.171.50.73])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Mar 2021 09:50:12 +0000 (GMT)
Date:   Wed, 24 Mar 2021 10:50:11 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Li Wang <liwang@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, ltp@lists.linux.it,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/vdso: fix tod clock steering
Message-ID: <YFsLU2k/h3WPDrJz@osiris>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
 <20210323215819.4161164-2-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323215819.4161164-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_05:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240073
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 23, 2021 at 10:58:17PM +0100, Heiko Carstens wrote:
> The s390 specific vdso function __arch_get_hw_counter() is supposed to
> consider tod clock steering.
> 
> If a tod clock steering event happens and the tod clock is set to a
> new value __arch_get_hw_counter() will not return the real tod clock
> value but slowly drift it from the old delta until the returned value
> finally matches the real tod clock value again.
> 
> When converting the assembler code to C it was forgotten to tell user
> space in which direction the clock has to be adjusted.
> 
> Worst case is now that instead of drifting the clock slowly it will
> jump into the opposite direction by a factor of two.
> 
> Fix this by simply providing the missing value to user space.
> 
> Fixes: 4bff8cb54502 ("s390: convert to GENERIC_VDSO")
> Cc: <stable@vger.kernel.org> # 5.10
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/time.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
> index 165da961f901..e37285a5101b 100644
> --- a/arch/s390/kernel/time.c
> +++ b/arch/s390/kernel/time.c
> @@ -382,6 +382,7 @@ static void clock_sync_global(unsigned long delta)
>  		      tod_steering_delta);
>  	tod_steering_end = now + (abs(tod_steering_delta) << 15);
>  	vdso_data->arch_data.tod_steering_end = tod_steering_end;
> +	vdso_data->arch_data.tod_steering_delta = tod_steering_delta;

..and yet another bug: __arch_get_hw_counter() tests if
tod_steering_delta is negative.
It makes sense to give tod_steering_delta the correct type:

diff --git a/arch/s390/include/asm/vdso/data.h b/arch/s390/include/asm/vdso/data.h
index 7b3cdb4a5f48..73ee89142666 100644
--- a/arch/s390/include/asm/vdso/data.h
+++ b/arch/s390/include/asm/vdso/data.h
@@ -6,7 +6,7 @@
 #include <vdso/datapage.h>
 
 struct arch_vdso_data {
-	__u64 tod_steering_delta;
+	__s64 tod_steering_delta;
 	__u64 tod_steering_end;
 };
 
