Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16048C433E1
	for <linux-s390@archiver.kernel.org>; Tue, 23 Mar 2021 21:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E3561931
	for <linux-s390@archiver.kernel.org>; Tue, 23 Mar 2021 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhCWV6x (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:58:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233745AbhCWV6m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Mar 2021 17:58:42 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NLXMps074109;
        Tue, 23 Mar 2021 17:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4LVjkSJOzytLD6tJY6/ZRad6GE00ydx04Yfw+LE5C78=;
 b=SOzokrfjApCXTcZYsDSg6iBJzPpAf2L7VnN0/ePDR9DANpEpwrQe+4/ookCQudx4hbiy
 0HcP1CMGi0WjjIbSkIwsZsffNwkL3LHp3S8B8gygJthfcN2FbYmcu2tQ/y3YeE6GI91n
 ZzCVQ5LeaX+f+mMMGr7sK280PYTfVOimgHlQCNBYic9OaRgHIzemH4L3jPrBeog6Joqi
 4Q4xwyOhfgq1P233cFfVyVJ2SpssutMYjEEe6/DSSZO/k8s0JHyzStlErqKZWSZO01ym
 HOy/bLsI0W/4hi+dol6wGY6TPDK5n6Kj+KTaOTKg8o4f8KbMJzI1N+gukddeqgtghTP2 IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fkx8r9g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 17:58:25 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NLYVqU077008;
        Tue, 23 Mar 2021 17:58:25 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fkx8r9fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 17:58:25 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NLwNpH001166;
        Tue, 23 Mar 2021 21:58:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 37d9a61y5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 21:58:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NLwJqM36241892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 21:58:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C65024C044;
        Tue, 23 Mar 2021 21:58:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 713904C040;
        Tue, 23 Mar 2021 21:58:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Mar 2021 21:58:19 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Li Wang <liwang@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 0/3] s390 vdso fixes
Date:   Tue, 23 Mar 2021 22:58:16 +0100
Message-Id: <20210323215819.4161164-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YFmUrVOyX4q+8Dy9@osiris>
References: <YFmUrVOyX4q+8Dy9@osiris>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_11:2021-03-23,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=872
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230159
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Li Wang reported that clock_gettime(CLOCK_MONOTONIC_RAW, ...) does not
work correctly on s390 via vdso. Debugging this also revealed an
unrelated bug (first patch).

The second patch fixes the problem: the tod clock steering parameters
required by __arch_get_hw_counter() are only present within the first
element of the _vdso_data array and not at all within the _timens_data
array.

Instead of working around this simply provide an s390 specific vdso
data page which contains the tod clock steering parameters.

This allows also to remove ARCH_HAS_VDSO_DATA again.

Heiko Carstens (3):
  s390/vdso: fix tod clock steering
  s390/vdso: fix arch_data access for __arch_get_hw_counter()
  lib/vdso: remove struct arch_vdso_data from vdso data struct

 arch/Kconfig                              |  3 ---
 arch/s390/Kconfig                         |  1 -
 arch/s390/include/asm/vdso.h              |  4 +++-
 arch/s390/include/asm/vdso/data.h         | 13 ------------
 arch/s390/include/asm/vdso/datapage.h     | 17 +++++++++++++++
 arch/s390/include/asm/vdso/gettimeofday.h | 11 ++++++++--
 arch/s390/kernel/time.c                   |  5 +++--
 arch/s390/kernel/vdso.c                   | 25 ++++++++++++++++++++---
 arch/s390/kernel/vdso64/vdso64.lds.S      |  3 ++-
 include/vdso/datapage.h                   | 10 ---------
 10 files changed, 56 insertions(+), 36 deletions(-)
 delete mode 100644 arch/s390/include/asm/vdso/data.h
 create mode 100644 arch/s390/include/asm/vdso/datapage.h

-- 
2.25.1

