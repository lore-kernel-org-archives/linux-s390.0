Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502EEC43334
	for <linux-s390@archiver.kernel.org>; Sat,  9 Jul 2022 16:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiGIQLd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 9 Jul 2022 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGIQLd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 9 Jul 2022 12:11:33 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3812C644
        for <linux-s390@vger.kernel.org>; Sat,  9 Jul 2022 09:11:32 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id AD3JoHrjCJXxRAD3Kol9tD; Sat, 09 Jul 2022 18:11:30 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 09 Jul 2022 18:11:30 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/pci: Use the bitmap API to allocate bitmaps
Date:   Sat,  9 Jul 2022 18:11:28 +0200
Message-Id: <8d35e482f710889a45d46f808155738ef87d46c4.1657383052.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I don't know why commit c506fff3d3a8 ("s390/pci: resize iomap") has turned
this bitmap from a statically defined bitmap to a runtime-allocated one.

Going back to a:
	static DECLARE_BITMAP(zpci_iomap_bitmap, ZPCI_IOMAP_ENTRIES);
would slightly simply code.
---
 arch/s390/pci/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index bc980fd313d5..b965553de143 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -1059,8 +1059,7 @@ static int zpci_mem_init(void)
 	if (!zpci_iomap_start)
 		goto error_iomap;
 
-	zpci_iomap_bitmap = kcalloc(BITS_TO_LONGS(ZPCI_IOMAP_ENTRIES),
-				    sizeof(*zpci_iomap_bitmap), GFP_KERNEL);
+	zpci_iomap_bitmap = bitmap_zalloc(ZPCI_IOMAP_ENTRIES, GFP_KERNEL);
 	if (!zpci_iomap_bitmap)
 		goto error_iomap_bitmap;
 
@@ -1078,7 +1077,7 @@ static int zpci_mem_init(void)
 
 static void zpci_mem_exit(void)
 {
-	kfree(zpci_iomap_bitmap);
+	bitmap_free(zpci_iomap_bitmap);
 	kfree(zpci_iomap_start);
 	kmem_cache_destroy(zdev_fmb_cache);
 }
-- 
2.34.1

