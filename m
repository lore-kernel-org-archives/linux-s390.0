Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD400C433C1
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8426B619C7
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 17:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhC3R3U (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:29:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232208AbhC3R2z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Mar 2021 13:28:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UH3m6A101960;
        Tue, 30 Mar 2021 13:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=hgl7d0Vt9u0uKJm0M21CYVDjD3pbNw2wArWhIvLUTp0=;
 b=I+5uhF9ktgmdkgW1b4pc3RWjzgf6SGkvsWvsGEI3JfYkjy8tnNi8nHJ1HWP7Yq0tRwAL
 hqcHmVEdxfjprtic+AtKI3hKQ3vW1cQp/gekYYwdev9tEcXAwczAq0qzcvcffYlcekcB
 IRiNfzNBMtgmyhb51e6w/jbX24CFy3a7BsY7oN4f1aUffDJTL+rYjNTyQZPTVSqgv9pW
 TUbaii//wZFZt/vY3WbHL48+XBSW39rTi72HV61rx6GFImD2uEhqqFkmVBLdt4lTSZl9
 19Fczj17lUYoHHB+cevTtDlo3H6CKgPtLjGCK++ga9Q6lSEdYTx/uFE5rUKJ1FwUH+FK 1w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37m81k8ush-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 13:28:54 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UHSqY9025575;
        Tue, 30 Mar 2021 17:28:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 37hvb81hgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 17:28:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UHSnRX39059804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 17:28:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38291A4051;
        Tue, 30 Mar 2021 17:28:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E46B2A404D;
        Tue, 30 Mar 2021 17:28:48 +0000 (GMT)
Received: from osiris (unknown [9.171.44.55])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Mar 2021 17:28:48 +0000 (GMT)
Date:   Tue, 30 Mar 2021 19:28:47 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.12-rc6
Message-ID: <YGNfz4Qr7ikSEn+j@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DTX_d79MbM11HG_2XbVnIpAEeeK2ti8V
X-Proofpoint-ORIG-GUID: DTX_d79MbM11HG_2XbVnIpAEeeK2ti8V
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_08:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300122
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull a couple of small updates for s390.

Thanks,
Heiko

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-5

for you to fetch changes up to 84d572e634e28827d105746c922d8ada425e2d8b:

  MAINTAINERS: add backups for s390 vfio drivers (2021-03-28 20:20:33 +0200)

----------------------------------------------------------------
s390 updates for 5.12-rc6

- fix incorrect initialization and update of vdso data pages, which
  results in incorrect tod clock steering, and that
  clock_gettime(CLOCK_MONOTONIC_RAW, ...) returns incorrect values.

- update MAINTAINERS for s390 vfio drivers

----------------------------------------------------------------
Heiko Carstens (3):
      s390/vdso: copy tod_steering_delta value to vdso_data page
      s390/vdso: fix tod_steering_delta type
      s390/vdso: fix initializing and updating of vdso_data

Matthew Rosato (1):
      MAINTAINERS: add backups for s390 vfio drivers

 MAINTAINERS                       |  4 +++-
 arch/s390/include/asm/vdso/data.h |  2 +-
 arch/s390/kernel/time.c           | 10 ++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e876927c60d..68a562374b85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15634,8 +15634,8 @@ F:	Documentation/s390/pci.rst
 
 S390 VFIO AP DRIVER
 M:	Tony Krowiak <akrowiak@linux.ibm.com>
-M:	Pierre Morel <pmorel@linux.ibm.com>
 M:	Halil Pasic <pasic@linux.ibm.com>
+M:	Jason Herne <jjherne@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
@@ -15647,6 +15647,7 @@ F:	drivers/s390/crypto/vfio_ap_private.h
 S390 VFIO-CCW DRIVER
 M:	Cornelia Huck <cohuck@redhat.com>
 M:	Eric Farman <farman@linux.ibm.com>
+M:	Matthew Rosato <mjrosato@linux.ibm.com>
 R:	Halil Pasic <pasic@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
@@ -15657,6 +15658,7 @@ F:	include/uapi/linux/vfio_ccw.h
 
 S390 VFIO-PCI DRIVER
 M:	Matthew Rosato <mjrosato@linux.ibm.com>
+M:	Eric Farman <farman@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
 S:	Supported
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
 
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 165da961f901..326cb8f75f58 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -80,10 +80,12 @@ void __init time_early_init(void)
 {
 	struct ptff_qto qto;
 	struct ptff_qui qui;
+	int cs;
 
 	/* Initialize TOD steering parameters */
 	tod_steering_end = tod_clock_base.tod;
-	vdso_data->arch_data.tod_steering_end = tod_steering_end;
+	for (cs = 0; cs < CS_BASES; cs++)
+		vdso_data[cs].arch_data.tod_steering_end = tod_steering_end;
 
 	if (!test_facility(28))
 		return;
@@ -366,6 +368,7 @@ static void clock_sync_global(unsigned long delta)
 {
 	unsigned long now, adj;
 	struct ptff_qto qto;
+	int cs;
 
 	/* Fixup the monotonic sched clock. */
 	tod_clock_base.eitod += delta;
@@ -381,7 +384,10 @@ static void clock_sync_global(unsigned long delta)
 		panic("TOD clock sync offset %li is too large to drift\n",
 		      tod_steering_delta);
 	tod_steering_end = now + (abs(tod_steering_delta) << 15);
-	vdso_data->arch_data.tod_steering_end = tod_steering_end;
+	for (cs = 0; cs < CS_BASES; cs++) {
+		vdso_data[cs].arch_data.tod_steering_end = tod_steering_end;
+		vdso_data[cs].arch_data.tod_steering_delta = tod_steering_delta;
+	}
 
 	/* Update LPAR offset. */
 	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
