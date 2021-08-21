Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A4C4338F
	for <linux-s390@archiver.kernel.org>; Sat, 21 Aug 2021 09:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEEC6108F
	for <linux-s390@archiver.kernel.org>; Sat, 21 Aug 2021 09:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhHUJCT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:02:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232802AbhHUJCT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 21 Aug 2021 05:02:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17L8Xd6h072734;
        Sat, 21 Aug 2021 05:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=/ppwdrIZvWqoBpVpD+YZrWNWlgW2mEGx190V7dl3dGc=;
 b=Vd5fHIvUa/momlfeoh7+zEdYbeiU46c4R3QjxQ5mI7mGxqa+B266IRIDCj5jTb7GASg5
 YGtTBkapG5hXqfJE/zCc20M5Nwu4NNEupF2hVxckYC0fULOSdNW2G7pKk8O1d2IvNeN1
 zuZuWcUOyiLOrUSp76VctvCbEoZ8yQtjkE1WFH8VhUqgvp9ooQMpL1nUOhKSwRLhJTab
 1O+DHcBT111YXoiBua0c18arTGs8yvxG5fbGL2RXKjARBJ4EnolzseYGQO+2hzhsX0fW
 Kg8UCJzGiRk/O/cpSn+4y4uObzw3jzv1K4xExCJhOydwP9qDxNuHRjKyVFaKP7gj68gO /A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ajwmygu70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Aug 2021 05:01:38 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17L8x1nO018260;
        Sat, 21 Aug 2021 09:01:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3ajs48893f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Aug 2021 09:01:36 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17L8vwCu27853096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Aug 2021 08:57:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DFEEA4064;
        Sat, 21 Aug 2021 09:01:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C32CA4066;
        Sat, 21 Aug 2021 09:01:32 +0000 (GMT)
Received: from localhost (unknown [9.171.52.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 21 Aug 2021 09:01:31 +0000 (GMT)
Date:   Sat, 21 Aug 2021 11:01:30 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.14-rc7
Message-ID: <your-ad-here.call-01629536490-ext-4991@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N9u4L4OgwVXqh1tcbfY-83dcV_CDGNEA
X-Proofpoint-ORIG-GUID: N9u4L4OgwVXqh1tcbfY-83dcV_CDGNEA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-21_03:2021-08-20,2021-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=909 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108210050
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 fix for 5.14-rc7.

Thank you,
Vasily

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-5

for you to fetch changes up to 2a671f77ee49f3e78997b77fdee139467ff6a598:

  s390/pci: fix use after free of zpci_dev (2021-08-18 10:12:42 +0200)

----------------------------------------------------------------
s390 updates for 5.14-rc7

- fix use after free of zpci_dev in pci code

----------------------------------------------------------------
Niklas Schnelle (1):
      s390/pci: fix use after free of zpci_dev

 arch/s390/pci/pci.c     | 6 ++++++
 arch/s390/pci/pci_bus.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index b0993e05affe..8fcb7ecb7225 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -560,9 +560,12 @@ static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
 
 int pcibios_add_device(struct pci_dev *pdev)
 {
+	struct zpci_dev *zdev = to_zpci(pdev);
 	struct resource *res;
 	int i;
 
+	/* The pdev has a reference to the zdev via its bus */
+	zpci_zdev_get(zdev);
 	if (pdev->is_physfn)
 		pdev->no_vf_scan = 1;
 
@@ -582,7 +585,10 @@ int pcibios_add_device(struct pci_dev *pdev)
 
 void pcibios_release_device(struct pci_dev *pdev)
 {
+	struct zpci_dev *zdev = to_zpci(pdev);
+
 	zpci_unmap_resources(pdev);
+	zpci_zdev_put(zdev);
 }
 
 int pcibios_enable_device(struct pci_dev *pdev, int mask)
diff --git a/arch/s390/pci/pci_bus.h b/arch/s390/pci/pci_bus.h
index b877a97e6745..e359d2686178 100644
--- a/arch/s390/pci/pci_bus.h
+++ b/arch/s390/pci/pci_bus.h
@@ -22,6 +22,11 @@ static inline void zpci_zdev_put(struct zpci_dev *zdev)
 	kref_put(&zdev->kref, zpci_release_device);
 }
 
+static inline void zpci_zdev_get(struct zpci_dev *zdev)
+{
+	kref_get(&zdev->kref);
+}
+
 int zpci_alloc_domain(int domain);
 void zpci_free_domain(int domain);
 int zpci_setup_bus_resources(struct zpci_dev *zdev,
