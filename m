Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F42C636CD
	for <linux-s390@archiver.kernel.org>; Sun,  5 Feb 2023 23:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBEXR5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 5 Feb 2023 18:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBEXR5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 5 Feb 2023 18:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150961968D
        for <linux-s390@vger.kernel.org>; Sun,  5 Feb 2023 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675639034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+iHbljQE4cWri51QLXa4Xz+3mOqMYYEFGlGW+CbZSY=;
        b=giBLeADofNBsEn/9IGPmGL2U740K7ljwTVwEro3l99Lb5jsf6uaMCeshgQJKyn0ebFjVc+
        WGbcz/noMtyobTviPRhrDnsQIoKO75FJdPFLKWieQJ4glu6R7C3khh2RFnNlUNhNq2gfgt
        T1C07V5opa8R7EVnSgKtWAfQ/+UBXBQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-NSIUmjMPMRKOmQjG3YVGXA-1; Sun, 05 Feb 2023 18:17:12 -0500
X-MC-Unique: NSIUmjMPMRKOmQjG3YVGXA-1
Received: by mail-qv1-f70.google.com with SMTP id kd28-20020a056214401c00b0053cd4737a42so5126532qvb.22
        for <linux-s390@vger.kernel.org>; Sun, 05 Feb 2023 15:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+iHbljQE4cWri51QLXa4Xz+3mOqMYYEFGlGW+CbZSY=;
        b=Y1r1KbWWSgfkm8AmKSEj1cHSWuhYGOHIGPXkwZzP0lVqgrX/MPUPqwNYMWWvYlt0L3
         5cgonLqoVQGyiigm3ZvdBaUc0/JSoy/kEyDib1UzqjTkjpkcBbSpScD4RtfFoqNerc7n
         4uTtQ55N9OaJyw+cTCap5W6hqUPi7qJw1SqN2KBH/YBfuVKmp5Lawkv9mciRPeMyZQUW
         w3xy2EuDrBm2OhpNphGvz8/4VMd+e/zfkwsqraalzCQHUfTU2Vr4iq4u5L19EuGRLGuV
         2tmnWfU/CwJAklDCbI0TnH1rv4wSjwF3QH1tGZMU1fcS8j01g+PW1e+v3ufFz1jcfZHo
         qnBg==
X-Gm-Message-State: AO0yUKU71QdkUd+DjsJM/JSg02vx4vQ7LqEtPdoiUqUaqfv2yPpnypk8
        H5bujYskW4Yublk8dOyjCLrtOqkAZRMMJk0lQAWM0BFVKSjJn3tgK6ApW1DmaMefWT9UwhdJUPK
        2yESGzbT5U+x77kS+oag+1A==
X-Received: by 2002:ac8:5a0c:0:b0:3b5:87db:f979 with SMTP id n12-20020ac85a0c000000b003b587dbf979mr36968151qta.5.1675639032210;
        Sun, 05 Feb 2023 15:17:12 -0800 (PST)
X-Google-Smtp-Source: AK7set8/HJ9ylfEnCGuGjHiBabf9O5KRa6hhSOUhT6sDqtmC260VVR8y98Nl2i/0VhE4BCc93ILrBA==
X-Received: by 2002:ac8:5a0c:0:b0:3b5:87db:f979 with SMTP id n12-20020ac85a0c000000b003b587dbf979mr36968130qta.5.1675639031977;
        Sun, 05 Feb 2023 15:17:11 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8515a000000b003b82cb8748dsm5986545qtn.96.2023.02.05.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:17:10 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/3] mm/s390: Define private VM_FAULT_* reasons from top bits
Date:   Sun,  5 Feb 2023 18:17:04 -0500
Message-Id: <20230205231704.909536-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230205231704.909536-1-peterx@redhat.com>
References: <20230205231704.909536-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The current definition already collapse with the generic definition of
vm_fault_reason.  Move the private definitions to allocate bits from the
top of uint so they won't collapse anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 9649d9382e0a..cebfbd6dcbaf 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -46,11 +46,15 @@
 #define __SUBCODE_MASK 0x0600
 #define __PF_RES_FIELD 0x8000000000000000ULL
 
-#define VM_FAULT_BADCONTEXT	((__force vm_fault_t) 0x010000)
-#define VM_FAULT_BADMAP		((__force vm_fault_t) 0x020000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t) 0x040000)
-#define VM_FAULT_SIGNAL		((__force vm_fault_t) 0x080000)
-#define VM_FAULT_PFAULT		((__force vm_fault_t) 0x100000)
+/*
+ * Allocate private vm_fault_reason from top.  Please make sure it won't
+ * collide with vm_fault_reason.
+ */
+#define VM_FAULT_BADCONTEXT	((__force vm_fault_t) 0x80000000)
+#define VM_FAULT_BADMAP		((__force vm_fault_t) 0x40000000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t) 0x20000000)
+#define VM_FAULT_SIGNAL		((__force vm_fault_t) 0x10000000)
+#define VM_FAULT_PFAULT		((__force vm_fault_t) 0x8000000)
 
 enum fault_type {
 	KERNEL_FAULT,
-- 
2.37.3

