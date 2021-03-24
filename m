Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A378C433DB
	for <linux-s390@archiver.kernel.org>; Wed, 24 Mar 2021 05:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1653A619E4
	for <linux-s390@archiver.kernel.org>; Wed, 24 Mar 2021 05:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhCXFyG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 Mar 2021 01:54:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233049AbhCXFxt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Mar 2021 01:53:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12O5Ypor076741;
        Wed, 24 Mar 2021 01:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4+cSc96YcRxRzZ7aZ2mOQW5cMX3LRkurhBOyaSDT2a8=;
 b=INObakLCcwp6nD4jUETDRf7zX6sNqbNyKA9D4k96B1SshCHKHLfhjT+lOP2sQ3rbnthF
 3G/m5iGqGKFPAAXQmBfOYT65CWitGvjcq4EGb5mjwM9MKvd4aOA3Qm2pL6nWgHecBRcN
 Wsxs+v7ijxdRYBVT+6ZJ1qwPkj5aHKnk0YLJMt5Sj5sRNkJFJqrMaLwMo1e21m73T9n9
 uA64dqdKK7a+tirnYkcVBtqP7M2HdcQxEa59DmNN9JS46IFl1eCuQjSayWJiEzxlpA12
 uWfdv9p/MOJ0EWN2G42/lHpCJnM1Tkc5xgo4sUaMMOa/fUNgeC/i9Wm+LVGiqExaSTcc 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fsm0fedq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 01:53:42 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12O5baVx087499;
        Wed, 24 Mar 2021 01:53:42 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fsm0feda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 01:53:42 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12O5r9Mm031490;
        Wed, 24 Mar 2021 05:53:40 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 37d9a6j33c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 05:53:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12O5rbPF32178588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 05:53:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D72AA404D;
        Wed, 24 Mar 2021 05:53:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECD55A4053;
        Wed, 24 Mar 2021 05:53:36 +0000 (GMT)
Received: from osiris (unknown [9.171.26.18])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Mar 2021 05:53:36 +0000 (GMT)
Date:   Wed, 24 Mar 2021 06:53:35 +0100
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
Subject: Re: [PATCH 2/3] s390/vdso: fix arch_data access for
 __arch_get_hw_counter()
Message-ID: <YFrT3x7sa49EPYFx@osiris>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
 <20210323215819.4161164-3-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323215819.4161164-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_04:2021-03-23,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240044
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 23, 2021 at 10:58:18PM +0100, Heiko Carstens wrote:
> Li Wang reported that clock_gettime(CLOCK_MONOTONIC_RAW, ...) returns
> incorrect values when time is provided via vdso instead of system call:
> 
> vdso_ts_nsec = 4484351380985507, vdso_ts.tv_sec = 4484351, vdso_ts.tv_nsec = 380985507
> sys_ts_nsec  = 1446923235377, sys_ts.tv_sec  = 1446, sys_ts.tv_nsec  = 923235377
> 
> Within the s390 specific vdso function __arch_get_hw_counter() tries
> to read tod clock steering values from the arch_data member of the
> passed in vdso_data structure.
> However only the arch_data member of the first clock source base
> (CS_HRES_COARSE) is initialized. For CS_RAW arch_data is not at all
> initialized, which explains the incorrect returned values.
> 
> It is a bit odd to provide the required tod clock steering parameters
> only within the first element of the _vdso_data array. However for
> time namespaces even no member of the _timens_data array contains the
> required data, which would make fixing __arch_get_hw_counter() quite
> complicated.
> 
> Therefore simply add an s390 specific vdso data page which contains
> the tod clock steering parameters. Everything else seems to be
> unnecessary complex.
> 
> Reported-by: Li Wang <liwang@redhat.com>
> Fixes: 1ba2d6c0fd4e ("s390/vdso: simplify __arch_get_hw_counter()")
> Fixes: eeab78b05d20 ("s390/vdso: implement generic vdso time namespace support")
> Link: https://lore.kernel.org/linux-s390/YFnxr1ZlMIOIqjfq@osiris
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Kconfig                         |  1 -
>  arch/s390/include/asm/vdso.h              |  4 +++-
>  arch/s390/include/asm/vdso/data.h         | 13 ------------
>  arch/s390/include/asm/vdso/datapage.h     | 17 +++++++++++++++
>  arch/s390/include/asm/vdso/gettimeofday.h | 11 ++++++++--
>  arch/s390/kernel/time.c                   |  6 +++---
>  arch/s390/kernel/vdso.c                   | 25 ++++++++++++++++++++---
>  arch/s390/kernel/vdso64/vdso64.lds.S      |  3 ++-
>  8 files changed, 56 insertions(+), 24 deletions(-)
>  delete mode 100644 arch/s390/include/asm/vdso/data.h
>  create mode 100644 arch/s390/include/asm/vdso/datapage.h

FWIW, alternatively to this and the third patch we could also do the
much shorter and simpler variant below. What I personally don't like
is that data is duplicated.
But on the other hand it is much shorter, and the more I think of it
this seems to be the way to go.
Opinions?

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index e37285a5101b..fa095ecf0349 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -80,10 +80,12 @@ void __init time_early_init(void)
 {
 	struct ptff_qto qto;
 	struct ptff_qui qui;
+	int i;
 
 	/* Initialize TOD steering parameters */
 	tod_steering_end = tod_clock_base.tod;
-	vdso_data->arch_data.tod_steering_end = tod_steering_end;
+	for (i = 0; i < CS_BASES; i++)
+		vdso_data[i].arch_data.tod_steering_end = tod_steering_end;
 
 	if (!test_facility(28))
 		return;
@@ -366,6 +368,7 @@ static void clock_sync_global(unsigned long delta)
 {
 	unsigned long now, adj;
 	struct ptff_qto qto;
+	int i;
 
 	/* Fixup the monotonic sched clock. */
 	tod_clock_base.eitod += delta;
@@ -381,8 +384,10 @@ static void clock_sync_global(unsigned long delta)
 		panic("TOD clock sync offset %li is too large to drift\n",
 		      tod_steering_delta);
 	tod_steering_end = now + (abs(tod_steering_delta) << 15);
-	vdso_data->arch_data.tod_steering_end = tod_steering_end;
-	vdso_data->arch_data.tod_steering_delta = tod_steering_delta;
+	for (i = 0; i < CS_BASES; i++) {
+		vdso_data[i].arch_data.tod_steering_end = tod_steering_end;
+		vdso_data[i].arch_data.tod_steering_delta = tod_steering_delta;
+	}
 
 	/* Update LPAR offset. */
 	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
