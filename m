Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2B2C48BE6
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 06:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116066101B
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 06:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhFNGGr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 02:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhFNGGp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Jun 2021 02:06:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E2C061574
        for <linux-s390@vger.kernel.org>; Sun, 13 Jun 2021 23:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=e+UgGfflOWlS3eD6i3//x2B9D/RWYEOeToBI0v3X9jQ=; b=0P68QNMiU89x95yDhv2XNIncNM
        wLHxE1o43EHWflxjFsv6hgMQW4Fd8XuzJ/WMRBgAR1+jhVP8Uea3lksqjd2dwvPrIcTp+TOoHSnag
        tWUbTXQzGhnHi3sEOZiIPrtsoaO5sKV3qzae6iv7hbLHe1aR+RAz4R+rodHlqoJ47nk7uIYY7KsgF
        8oD++BAZy9Qp6zOuKIkyGeD8mNMhWubvCT404F8l2YZtGVzZxXNv02SNDw6zF4L0zca2/H5eYp+iJ
        gD+TPXb4nKxxqaOaDO0EPAfCKKy7SUNDCXvzt//ICEauLF7N/Ruz4bV+BNdDfmyvmIUQS9R+OCD8U
        szX5xoMw==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsfiE-00CfxX-2t; Mon, 14 Jun 2021 06:04:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     sth@linux.ibm.com, hoeppner@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Subject: [PATCH] dasd: unexport dasd_set_target_state
Date:   Mon, 14 Jun 2021 08:04:40 +0200
Message-Id: <20210614060440.3965603-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

dasd_set_target_state is only used inside of dasd_mod.ko, so don't
export it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index c8df75e99f4c..e34c6cc61983 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -621,7 +621,6 @@ void dasd_set_target_state(struct dasd_device *device, int target)
 	mutex_unlock(&device->state_mutex);
 	dasd_put_device(device);
 }
-EXPORT_SYMBOL(dasd_set_target_state);
 
 /*
  * Enable devices with device numbers in [from..to].
-- 
2.30.2

