Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6B3C7EE32
	for <linux-s390@archiver.kernel.org>; Thu, 25 May 2023 18:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbjEYSgQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 May 2023 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241815AbjEYSfx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 May 2023 14:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0210C7;
        Thu, 25 May 2023 11:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D518560A47;
        Thu, 25 May 2023 18:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48350C433D2;
        Thu, 25 May 2023 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039660;
        bh=fpqoULnVRtw5Y0dDZwpIfs4sYiENDoFspuX+MK4wXMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfJLQNe2BQrjWRUFBMtNkeAasROe8CHI4B6QYB11rBu68MtFIIPPDGUBN3TxEejRV
         o9ryTeFTsGIG0+OTM8lB4R2KIPfqgF10qHhKM/XG04Ri81B/fPMJqj36PD/VbyudHH
         DJ2wlZfYeS7vfxdWMoBXhJW6VwlxxXdnbFUfuimucNuiL0Ed7g6D+1P2PtoJ2ml1Sk
         1PbFYdJdB6+Rrr+WJsCGQjwrV+nS4+FDjsaEtoHEo3Sr2Qltp2bp3PfbDrxNhxshX/
         htC5mhD4kMqA5S1GfHdR36EHAYZ6gvTEG0J79nWMuIMUV/QUpky6MuMfXXOHGORpHE
         66Q5jCttt7Aaw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, gor@linux.ibm.com,
        svens@linux.ibm.com, christophe.jaillet@wanadoo.fr,
        nrb@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 38/67] s390/ipl: fix IPIB virtual vs physical address confusion
Date:   Thu, 25 May 2023 14:31:15 -0400
Message-Id: <20230525183144.1717540-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 2facd5d3980f3a26c04fe6ec8689a1d019a5812c ]

The pointer to IPL Parameter Information Block is stored
in the absolute lowcore for later use by dump tools. That
pointer is a virtual address, though it should be physical
instead.

Note, this does not fix a real issue, since virtual and
physical addresses are currently the same.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/ipl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 5f0f5c86963a9..e43ee9becbbb9 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1936,14 +1936,13 @@ static struct shutdown_action __refdata dump_action = {
 
 static void dump_reipl_run(struct shutdown_trigger *trigger)
 {
-	unsigned long ipib = (unsigned long) reipl_block_actual;
 	struct lowcore *abs_lc;
 	unsigned int csum;
 
 	csum = (__force unsigned int)
 	       csum_partial(reipl_block_actual, reipl_block_actual->hdr.len, 0);
 	abs_lc = get_abs_lowcore();
-	abs_lc->ipib = ipib;
+	abs_lc->ipib = __pa(reipl_block_actual);
 	abs_lc->ipib_checksum = csum;
 	put_abs_lowcore(abs_lc);
 	dump_run(trigger);
-- 
2.39.2

