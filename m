Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19156C6FD1C
	for <linux-s390@archiver.kernel.org>; Thu, 23 Mar 2023 12:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjCWMIE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjCWMHi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Mar 2023 08:07:38 -0400
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Mar 2023 05:06:48 PDT
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBDCC21
        for <linux-s390@vger.kernel.org>; Thu, 23 Mar 2023 05:06:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679572846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PPCDJ/LTlfpDLEP+1PxEm8cw9BZfvQzfInAOwtqZhSE=;
        b=dSZ4xPSLxI/M2te8gMs/gl7qipP3r5uAZNYWgDwZpuUFMxzqkw/5q9qTVwCio9zjo+z25c
        swEOhxYZInWvPVhA7RvGqUuCdqx5DtG8BUwKyNdoMTr0lwdPMCnjrthDdDf+d4UH405jyR
        VUYTaVxX7wO7X9aP4ZeSW144spQ4Gfc=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/ism: Remove redundant pci_clear_master
Date:   Thu, 23 Mar 2023 20:00:43 +0800
Message-Id: <20230323120043.15081-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Remove pci_clear_master to simplify the code,
the bus-mastering is also cleared in do_pci_disable_device,
like this:
./drivers/pci/pci.c:2197
static void do_pci_disable_device(struct pci_dev *dev)
{
	u16 pci_command;

	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
	if (pci_command & PCI_COMMAND_MASTER) {
		pci_command &= ~PCI_COMMAND_MASTER;
		pci_write_config_word(dev, PCI_COMMAND, pci_command);
	}

	pcibios_disable_device(dev);
}.
And dev->is_busmaster is set to 0 in pci_disable_device.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/s390/net/ism_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 05749c877990..8acb9eba691b 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -675,7 +675,6 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_resource:
-	pci_clear_master(pdev);
 	pci_release_mem_regions(pdev);
 err_disable:
 	pci_disable_device(pdev);
@@ -738,7 +737,6 @@ static void ism_remove(struct pci_dev *pdev)
 	ism_dev_exit(ism);
 	mutex_unlock(&ism_dev_list.mutex);
 
-	pci_clear_master(pdev);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 	device_del(&ism->dev);
-- 
2.34.1

