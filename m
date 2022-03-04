Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95646C433F5
	for <linux-s390@archiver.kernel.org>; Fri,  4 Mar 2022 09:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiCDJLk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiCDJLj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Mar 2022 04:11:39 -0500
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 01:10:52 PST
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FEA154D35
        for <linux-s390@vger.kernel.org>; Fri,  4 Mar 2022 01:10:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3B04C3200F81;
        Fri,  4 Mar 2022 04:01:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 04 Mar 2022 04:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=czeIJA+xHkaPMWCkdr5P2DiGZn8PO/7uB8ivo1GrJ8I=; b=yLMVm
        DvfLWjfFlMgBgwGnor5CQfc6BdLBxNSYrhpLBG8jN4RIgKcP0AsElJXX9slO/6KK
        Pau9mGDCgjOyj9/rTLsSKWoE8ZbZNCOEo19ZqqexeF7XCoW+QB3vB1LxATN0idN/
        xWWOaH4tZ0N0CTSMTaoOkb71q34IIurUxaal7R3F5U+pRmsP/e0bcikMTJlWuizD
        723l/257ElCJMzXFnL6uybWvCsoYcSJ+RhNh/FaDE/ml5kEDtStFXfv86f0lliit
        4cuwqnzEsTb3rxQoE1stPiPSzADpESkOYGc0y6YuDUrLjPyT0MuESTT1G1mpR3JD
        hRa1rFe0Q2tjMFDfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=czeIJA+xHkaPMWCkdr5P2DiGZn8PO
        /7uB8ivo1GrJ8I=; b=m8ZWyrjmHF5WjiXTQvl+USm9OxbVyvwg6MkUHNUH4XwEP
        hzOx99Vnj8oC51TdhkKsWmEgcdqGavKwuCnE5CD77Arb46sqPr7rgigQvMakssOc
        h3LSjCmZW6u826SsRAh2SHmfXHDqTallPztG/RL8H8Ph/fekFU5X4CSMo4uTuug+
        rPo5+qJrATZxGEJf87VDBAYQW9Jsg17W/QZ8K9pYmI94qxz98jwRQBsdYgDt5Yfh
        1Aa6cjXP4EJ3TdEknS/e4/OTpftsnUFgvJHuqRh8i+i1kahyLBPdVDZTkXgwZDV9
        X+zSZRO1oDMAJbSGoQSWZYY4ItNaS7vUSRcI4d9YA==
X-ME-Sender: <xms:dNUhYm_4YT67k-g0HdZacVoFYx04D40JuTSD_l7EJnYzkpwyegkzQg>
    <xme:dNUhYmudNCV-2LLYwGxI7DgFUiC13Z10H_65zPy3oBxpMGpCne0oJ6XFBEKWcJ4RH
    08C-ymTQRbyRCcrsA>
X-ME-Received: <xmr:dNUhYsCA2fwfCOPmrjPPv26z0Wma5tEVprz8sr1bvmQ5tubC5zh7cgvKwyfs5RA7-iMrD5N3Liq8SJhwSEqZVR2sjBK5LMxB4kEjOdK-26ARWBNYjJ7tZLPY1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtjedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgv
    hicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpeelge
    elfedvffekgeevfeelveeftdeilefgudegkeeuhefhvefgffekuefgffekfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrh
    hushhsvghllhdrtggt
X-ME-Proxy: <xmx:dNUhYue9K4i2G25cdZDGftYbfrUDYF87fvjJrTAA9UMILMN1_rHlKw>
    <xmx:dNUhYrMpdebmpdDqaLPv6akUTY9oCN7yPG1Lr3fq8Q_9aI-D88m1hQ>
    <xmx:dNUhYokvRI8dDV0Zivu33OqnUOF77AL39W_ihhYqliLHfRstVNMm3A>
    <xmx:dNUhYh3_T780qNP_DalRA49MGkIoFqygSRTyUTcBzsV2XyC_va8zcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 04:01:39 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linux-s390@vger.kernel.org
Cc:     svens@linux.ibm.com, Russell Currey <ruscur@russell.cc>
Subject: [PATCH] s390: Fix typo in syscall_wrapper.h
Date:   Fri,  4 Mar 2022 19:01:09 +1000
Message-Id: <20220304090109.29386-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Looks like this endif comment was erroneously unchanged when copied over
from the x86 version.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/s390/include/asm/syscall_wrapper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index ad2c996e7e93..fde7e6b1df48 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -162,4 +162,4 @@
 	__diag_pop();									\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
-#endif /* _ASM_X86_SYSCALL_WRAPPER_H */
+#endif /* _ASM_S390_SYSCALL_WRAPPER_H */
-- 
2.35.1

