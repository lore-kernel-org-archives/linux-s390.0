Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E4C433F5
	for <linux-s390@archiver.kernel.org>; Sat, 16 Oct 2021 09:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A96611C1
	for <linux-s390@archiver.kernel.org>; Sat, 16 Oct 2021 09:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhJPJ20 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:28:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235334AbhJPJ2Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 16 Oct 2021 05:28:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19G6VVTo018492;
        Sat, 16 Oct 2021 05:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=A1QFUZA8FIZUm4T1e9afBnGeJxCh69/IKBKragus8ZE=;
 b=FBCaC2bbIJbrTFA7c4sOd6Rj8X1iYoVKSKswgPrNctfM7ctmsh4JHUf6lmNjSwN0V0ko
 qpkXWEBDfi3StgEJ6Nz7NwYRCTvRIdKBsEt03+3zQ4VKN5Na+XNNe5dGG7PxyeH0sLOQ
 D92QRUiGLYtvZraTXlWM9XhRqI/eiOULTJeUVpQsueT6O7INFx+rouhwRvcZBJEd5iMg
 tbFKFUzOFXTOAtWcsOq7Q3QjshdvQ9s3Etr1IR6q/bLMmY9OxytfnnT9gWFLtFwdSHMX
 kqr1+bECGvvEfZJ9wdan9TrvTAq6QC3suvr045n5a0ZGpSIpIa60Zz/Jeh13hsTAJ2Dh Yw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bqshxabb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Oct 2021 05:26:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19G9FrPX023408;
        Sat, 16 Oct 2021 09:26:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3bqpc9s9eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Oct 2021 09:26:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19G9KQnL49021290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 09:20:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67716AE051;
        Sat, 16 Oct 2021 09:26:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E410AE04D;
        Sat, 16 Oct 2021 09:26:10 +0000 (GMT)
Received: from localhost (unknown [9.171.95.117])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 16 Oct 2021 09:26:10 +0000 (GMT)
Date:   Sat, 16 Oct 2021 11:26:08 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.15-rc6
Message-ID: <your-ad-here.call-01634376368-ext-7035@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -Pjt6unlN9SIW-Bvbd44IdfO2Sg71Hw_
X-Proofpoint-GUID: -Pjt6unlN9SIW-Bvbd44IdfO2Sg71Hw_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-16_02,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110160058
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.15-rc6.

Thank you,
Vasily

The following changes since commit a46044a92add6a400f4dada7b943b30221f7cc80:

  s390/pci: fix zpci_zdev_put() on reserve (2021-10-04 09:49:10 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-6

for you to fetch changes up to 8b7216439e2e2128f6f1a19ad4b6be94d8b0e23d:

  s390: add Alexander Gordeev as reviewer (2021-10-13 14:37:44 +0200)

----------------------------------------------------------------
s390 update for v5.15-rc6

- Maintainers and reviewers changes:
  - Cornelia decided to free up her time and step down from vfio-ccw
    maintainer and s390 kvm reviewer duties.
  - Add Alexander Gordeev as s390 arch code reviewer.

- Fix broken strrchr implementation.

----------------------------------------------------------------
Cornelia Huck (2):
      KVM: s390: remove myself as reviewer
      vfio-ccw: step down as maintainer

Heiko Carstens (1):
      s390: add Alexander Gordeev as reviewer

Roberto Sassu (1):
      s390: fix strrchr() implementation

 MAINTAINERS            |  3 +--
 arch/s390/lib/string.c | 15 +++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcfef73d..888b329413d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10275,7 +10275,6 @@ KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
 M:	Christian Borntraeger <borntraeger@de.ibm.com>
 M:	Janosch Frank <frankja@linux.ibm.com>
 R:	David Hildenbrand <david@redhat.com>
-R:	Cornelia Huck <cohuck@redhat.com>
 R:	Claudio Imbrenda <imbrenda@linux.ibm.com>
 L:	kvm@vger.kernel.org
 S:	Supported
@@ -16297,6 +16296,7 @@ S390
 M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
 M:	Christian Borntraeger <borntraeger@de.ibm.com>
+R:	Alexander Gordeev <agordeev@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
@@ -16375,7 +16375,6 @@ F:	drivers/s390/crypto/vfio_ap_ops.c
 F:	drivers/s390/crypto/vfio_ap_private.h
 
 S390 VFIO-CCW DRIVER
-M:	Cornelia Huck <cohuck@redhat.com>
 M:	Eric Farman <farman@linux.ibm.com>
 M:	Matthew Rosato <mjrosato@linux.ibm.com>
 R:	Halil Pasic <pasic@linux.ibm.com>
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index cfcdf76d6a95..a95ca6df4e5e 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -259,14 +259,13 @@ EXPORT_SYMBOL(strcmp);
 #ifdef __HAVE_ARCH_STRRCHR
 char *strrchr(const char *s, int c)
 {
-       size_t len = __strend(s) - s;
-
-       if (len)
-	       do {
-		       if (s[len] == (char) c)
-			       return (char *) s + len;
-	       } while (--len > 0);
-       return NULL;
+	ssize_t len = __strend(s) - s;
+
+	do {
+		if (s[len] == (char)c)
+			return (char *)s + len;
+	} while (--len >= 0);
+	return NULL;
 }
 EXPORT_SYMBOL(strrchr);
 #endif
