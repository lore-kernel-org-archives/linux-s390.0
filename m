Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C1BC433FE
	for <linux-s390@archiver.kernel.org>; Thu,  6 Oct 2022 12:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJFMSU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Oct 2022 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFMST (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Oct 2022 08:18:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D69E0C3
        for <linux-s390@vger.kernel.org>; Thu,  6 Oct 2022 05:18:19 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296BniNH017560
        for <linux-s390@vger.kernel.org>; Thu, 6 Oct 2022 12:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=Kaz2SCQNiroWcFeGlhv3HSUxbZ7Q4o2u7XC0JJG6vFA=;
 b=mMmCkJC17vNkFpqa9D8k3thW5QdirP1MLAkWE/X7JP4LFbhHwT7v/E1/juxv0trgNGT3
 F4pst3c81sWQbfPRjdLriv5vSaHa+KhzcB5jStMD7PTEfMHWRhweEJ7fLkirQUAZ9cbx
 P9Vlt54pmLGeO1XU40GKG3ehpmsfQ/dBGwiApgJw+AsO5KN4toTqMcFRkoXgbVzQetpw
 7kuaWmew9Wbovqz9nzCe9+Y88b/z9bCAa551VXwxTNmXZW1NM6XeeP6PnOeqa/PyvBvP
 NKP8eQK0C3JdJqqic3DGRqDWhkbPhL/QjaPpn3JeW0k9jPdSQkYcWYSbnD/Djey80i41 tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1xg5ru0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Oct 2022 12:18:18 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 296BrxkW000639
        for <linux-s390@vger.kernel.org>; Thu, 6 Oct 2022 12:18:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1xg5rtym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 12:18:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296CCMAC024058;
        Thu, 6 Oct 2022 12:18:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3jxd6970u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 12:18:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296CIDsi53018994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 12:18:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FC28A4051;
        Thu,  6 Oct 2022 12:18:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EEB7A404D;
        Thu,  6 Oct 2022 12:18:13 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Oct 2022 12:18:13 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: remove the last remnants of cputime_t
References: <20221006105635.115775-1-npiggin@gmail.com>
Date:   Thu, 06 Oct 2022 14:18:13 +0200
In-Reply-To: <20221006105635.115775-1-npiggin@gmail.com> (Nicholas Piggin's
        message of "Thu, 6 Oct 2022 20:56:35 +1000")
Message-ID: <yt9dpmf5ywl6.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gNZLuBjANSbtC9wEWkAeMOx9Ac3hIZoD
X-Proofpoint-GUID: NuMIqiRoW5Pu7Ffk5WA-fGjGSv4WxVIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_01,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=929
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060072
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:

> cputime_t was a core kernel type, removed by commits
> ed5c8c854f2b..b672592f0221. As explained in commit b672592f0221
> ("sched/cputime: Remove generic asm headers"), the final cleanup is for
> the arch to provide cputime_to_nsec[s](). Commit e53051e757d6
> ("s390/cputime: provide archicture specific cputime_to_nsecs") did that,
> but just didn't remove the then-unused cputime_to_usecs() and associated
> remnants.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Sorry this isn't build or compile tested, I'm doing the same for powerpc
> then we can remove the cputime_to_nsecs fallback from core code too.

I just tested this, looks good. Thanks!

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>

>
>  arch/s390/include/asm/cputime.h | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
> index 1d389847b588..7f9284e2a7db 100644
> --- a/arch/s390/include/asm/cputime.h
> +++ b/arch/s390/include/asm/cputime.h
> @@ -11,21 +11,6 @@
>  #include <linux/types.h>
>  #include <asm/timex.h>
>  
> -#define CPUTIME_PER_USEC 4096ULL
> -#define CPUTIME_PER_SEC (CPUTIME_PER_USEC * USEC_PER_SEC)
> -
> -/* We want to use full resolution of the CPU timer: 2**-12 micro-seconds. */
> -
> -#define cmpxchg_cputime(ptr, old, new) cmpxchg64(ptr, old, new)
> -
> -/*
> - * Convert cputime to microseconds.
> - */
> -static inline u64 cputime_to_usecs(const u64 cputime)
> -{
> -	return cputime >> 12;
> -}
> -
>  /*
>   * Convert cputime to nanoseconds.
>   */
