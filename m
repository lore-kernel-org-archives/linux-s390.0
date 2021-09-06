Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C2C43219
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 09:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F2B60F3A
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 09:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbhIFJus (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Sep 2021 05:50:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241477AbhIFJuq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Sep 2021 05:50:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1869dwB0055849;
        Mon, 6 Sep 2021 05:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IoaI0gLLdeTrrv0kati9/G8AoEFbwqq4KrIAr9r6bYo=;
 b=KIxQg+3tVdkbFRHEvg8Qn0N3L6o2MLGmHLSDQeAc2ObqmznxBANt9JgjQQLhxT1uSMLL
 0EtYyKrXXllxGowEmK0HFugHQpozG58YfZB1epY9IYSos6PssrVkDoNEcmeF6yrstD6u
 dq4lfE4ZscDkGRgp//U+B6MAeeZPA/yaJsqSVc+7FsoosUdpOs3zWtQb48iuMA2LxU48
 ZIIPpTAw6vzpBV9s0QgfXyGRup8V3ojBew4E2v9wwcjf2dq6VOpKR9mjMtRAtvh3mK/I
 /qM4Id46Vh+e4eWKmSyt5oo8QEoA453nR9xMwwypZVy741CC+4JlxOfdPM1of1AuH3yK 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3awenbausw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 05:49:37 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1869eBdT056444;
        Mon, 6 Sep 2021 05:49:36 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3awenbaus8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 05:49:36 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1869lOhT019224;
        Mon, 6 Sep 2021 09:49:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3av0e997dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 09:49:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1869jHpP59900186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Sep 2021 09:45:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F25B242042;
        Mon,  6 Sep 2021 09:49:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E1344203F;
        Mon,  6 Sep 2021 09:49:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Sep 2021 09:49:29 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH 4/5] PCI: Export pci_dev_lock()
Date:   Mon,  6 Sep 2021 11:49:26 +0200
Message-Id: <20210906094927.524106-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210906094927.524106-1-schnelle@linux.ibm.com>
References: <20210906094927.524106-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2DaHxa5mlW6nga3S2LEuNbBP_3zPybvU
X-Proofpoint-ORIG-GUID: 0vgPXSu0UHWnk3xl_GzIubLnLB0WPGeJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-06_05:2021-09-03,2021-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109060060
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit e3a9b1212b9d ("PCI: Export pci_dev_trylock() and pci_dev_unlock()")
already exported pci_dev_trylock()/pci_dev_unlock() however in some
circumstances such as during error recovery it makes sense to block
waiting to get full access to the device so also export pci_dev_lock().

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/pci.c   | 3 ++-
 include/linux/pci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..3f416c6d3b0b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5040,12 +5040,13 @@ static int pci_reset_bus_function(struct pci_dev *dev, int probe)
 	return pci_parent_bus_reset(dev, probe);
 }
 
-static void pci_dev_lock(struct pci_dev *dev)
+void pci_dev_lock(struct pci_dev *dev)
 {
 	pci_cfg_access_lock(dev);
 	/* block PM suspend, driver probe, etc. */
 	device_lock(&dev->dev);
 }
+EXPORT_SYMBOL_GPL(pci_dev_lock);
 
 /* Return 1 on successful lock, 0 on contention */
 int pci_dev_trylock(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ea0e23dbc8ec..efc78b8d4696 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1639,6 +1639,7 @@ void pci_cfg_access_lock(struct pci_dev *dev);
 bool pci_cfg_access_trylock(struct pci_dev *dev);
 void pci_cfg_access_unlock(struct pci_dev *dev);
 
+void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
 
-- 
2.25.1

