Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ECFC48BE6
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 20:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF38613B9
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 20:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhFPUVv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhFPUVv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Jun 2021 16:21:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E588C061574
        for <linux-s390@vger.kernel.org>; Wed, 16 Jun 2021 13:19:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so4704379pjz.3
        for <linux-s390@vger.kernel.org>; Wed, 16 Jun 2021 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+KfHfR5+t0EnVDipxN8Cyuc0KkUY5m0xDUxbL/YVUKI=;
        b=M2M05GwAjHTM0WwuFWCLIJBXc7Mhmzduj5N8rkDWyWW7Bq+aM40Y5v6k5+kPQ4tecA
         YePfJMATp4pNXHeVunU8k8CCS3tNkZLexRP4nVx82umJkEDmIeIbwfBAqljx4nnxwFrE
         /9uTkaEqkwVn++hUMZzVnQ30+9Uy7Qe5wo0A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+KfHfR5+t0EnVDipxN8Cyuc0KkUY5m0xDUxbL/YVUKI=;
        b=HCzve/Ck7yu+4gpFv0tb/iFtuFhAVHiOYRsKuQQhE5had0Q0AX+I/Ehz0M76Hc4mWY
         SZnTjjdAdl8cLjTtWiqvora4G6zj9M2f1I2b84R0Qkhp5o3GGFA3se/RhOYj4SomIKiN
         zrys+YxfnMqvVADqWaV5x+dEoHwll001kW/aRj7r8kTm0m9ZJusahYsppF0wEyFD9R8B
         mYzWyRnA15+fX1WhZXvPfrUL1rm38D9p7gL0CN3VeG+9LDbKOA6uUGFYkb5/Gwm8tjHr
         8tDlH1+7CyPlii+zp2nVLWceJlrt48LSBs9C0PygYouScoSgK6selvD/uV1scKHhuGs0
         vjkg==
X-Gm-Message-State: AOAM531ioemAHkph9rkt+J12mWmxZ0oHYfC+8Caj2qazBushxdDtazcr
        TyiYZ7ZhXl5eJID8QRVJsqAaiQ==
X-Google-Smtp-Source: ABdhPJxpXazaGEOtfXB0QagaHQxcdZPLoAGZ+6NYzn4yC2kbuf+G6USVmDjKV6ANQyL87954djWnVg==
X-Received: by 2002:a17:90a:aa8e:: with SMTP id l14mr1206561pjq.27.1623874784217;
        Wed, 16 Jun 2021 13:19:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c5sm3111954pfn.144.2021.06.16.13.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:19:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] s390: iucv: Avoid field over-reading memcpy()
Date:   Wed, 16 Jun 2021 13:19:42 -0700
Message-Id: <20210616201942.1246211-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=0981c4eb75dd427d7d91cd99c36bf53addbcfc5d; i=YZOtmOq/sZVNbtRsnkBMD2Kw6M6DcNHBXTl6zJRUyvI=; m=CVqI9jG6YZ9jf8f1ED3Ps1ANOEjrAU1kS6Hl4wF6mU4=; p=5tZ5+WKosX4UV7nN9rSQBm46PiXYBFh/e0B4ynthelY=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKXN0ACgkQiXL039xtwCaSnA/+Pcj H3UWanMJVaOTGAEIdXDCjPackgZXSABrZgBCld484XkzWVdo8GRuckbZCt4017+wGCvmoBES96pze OOJzXiG14jyAgv/c7zi6Q6Pdt8zVC+J9syB8vpovW/BYd3WRWbJWet+vyiVwXCFwLteMypdVQjSbD vPqlwtEIhLRIgQJWi7apUcKznj8cupOGcY6fDHrMXjqvk7Ef9nvM5D5I2mfZSjhxvQ6kSciJFTE90 3JNIuLnTh2L4FHQzf2aCR+6uzC6sveKa7LECGTT89TPiGvD0BqBRXfEvhz/gj5gS9iOKVPyUweUhk jV/Ix7tV7MrNl80eNRBtE1wGiGMRkMxckSrp4rWCyPYMLGvV3KszaQY7kwfRh6hOryEGqQifabHUR coGMga1jVG13xKwmqEpcgGJu6+RJ/MWXsw9uMWaV1NZefjZGmqd6x9zOv1SItCyqRceMSoPEQZeC0 VOlihXZ65qlXyXPdJDDWoe0sYlTTxZqhBSgJpnARCCwopTkG5ULwvaR5rXl/W+MUSlVOU/V4/SDn0 Yoo1ryNQjEIdhP7FsUcFA4ywbxOHPfqSW4AiFx3AlhJVDXnaMJtCopNV5jyCFsKSF0xJ45I61WG8L 3cVbIqTzvgqJ4IJcEwrYPdoVeKxae24fWQxBzwGeyIDrzrpSdHxqHSUGFesVyUP4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally reading across neighboring array fields.

Add a wrapping struct to serve as the memcpy() source so the compiler
can perform appropriate bounds checking, avoiding this future warning:

In function '__fortify_memcpy',
    inlined from 'iucv_message_pending' at net/iucv/iucv.c:1663:4:
./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/iucv/iucv.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 349c6ac3313f..e6795d5a546a 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -1635,14 +1635,16 @@ struct iucv_message_pending {
 	u8  iptype;
 	u32 ipmsgid;
 	u32 iptrgcls;
-	union {
-		u32 iprmmsg1_u32;
-		u8  iprmmsg1[4];
-	} ln1msg1;
-	union {
-		u32 ipbfln1f;
-		u8  iprmmsg2[4];
-	} ln1msg2;
+	struct {
+		union {
+			u32 iprmmsg1_u32;
+			u8  iprmmsg1[4];
+		} ln1msg1;
+		union {
+			u32 ipbfln1f;
+			u8  iprmmsg2[4];
+		} ln1msg2;
+	} rmmsg;
 	u32 res1[3];
 	u32 ipbfln2f;
 	u8  ippollfg;
@@ -1660,10 +1662,10 @@ static void iucv_message_pending(struct iucv_irq_data *data)
 		msg.id = imp->ipmsgid;
 		msg.class = imp->iptrgcls;
 		if (imp->ipflags1 & IUCV_IPRMDATA) {
-			memcpy(msg.rmmsg, imp->ln1msg1.iprmmsg1, 8);
+			memcpy(msg.rmmsg, &imp->rmmsg, 8);
 			msg.length = 8;
 		} else
-			msg.length = imp->ln1msg2.ipbfln1f;
+			msg.length = imp->rmmsg.ln1msg2.ipbfln1f;
 		msg.reply_size = imp->ipbfln2f;
 		path->handler->message_pending(path, &msg);
 	}
-- 
2.25.1

