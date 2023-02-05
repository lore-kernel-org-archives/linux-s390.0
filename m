Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F6C636D4
	for <linux-s390@archiver.kernel.org>; Sun,  5 Feb 2023 23:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjBEXR6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 5 Feb 2023 18:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBEXR5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 5 Feb 2023 18:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D0E19692
        for <linux-s390@vger.kernel.org>; Sun,  5 Feb 2023 15:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675639032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5/Ww/5/bhqPqutkGRybIHLtU9jqdfakTNy4g0j2iQk=;
        b=Q2IrcXKinh5UW/cS5BHwRhE7QHpgFMfdia8drwNkRJuUqGLqoLQQzK49ao6JT8ezXocSWb
        Hv4VmnzirRr62mNFcdLgodGI1TncMhPQD7PgO3l+Mf9K94soxq6F/ba/SVdIv2aEBVK0Dn
        r2FQzJ8RiQLk8vF9Gpr+RSqCJ65YGb8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-YEcZdnGHOcStgoRqpKdNDg-1; Sun, 05 Feb 2023 18:17:11 -0500
X-MC-Unique: YEcZdnGHOcStgoRqpKdNDg-1
Received: by mail-qv1-f69.google.com with SMTP id l6-20020ad44446000000b00537721bfd2dso5109595qvt.11
        for <linux-s390@vger.kernel.org>; Sun, 05 Feb 2023 15:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5/Ww/5/bhqPqutkGRybIHLtU9jqdfakTNy4g0j2iQk=;
        b=NJYfp/02M28bvvLRGUmcM3iJgLjWEJqFiNUDPdsJqmxbRQ39+lIiECBT56FkVfb5pS
         5B+Ukfl6njI4dNDuot354V3zNfc7za6C1Du3lJm/xSV5NXQyvc29VOeFz0guwVPsq9tb
         F7+KFlw84mQL+sn7Xek+4ZS2zliOglE4nCSySEc6afDfxZKPjXS5P+rRquRnIzzv66E1
         2hdn1BRBFMHXt/XrT6/L/+b+x4ZViTAmcL2qkzgw+3Pt49wgpZdR0h0JmeyXkVcWP/Oc
         7itBHbWi/4K+j6dLwbZD66Lu7yB/Z9h3h38ZMMohnY2NqM2bhGnp/nY+WXG5bYikz0OZ
         w1Pg==
X-Gm-Message-State: AO0yUKWTfx7hl6FvODZMyaRg1gToKQ9OhsD48Mwd9ABawlmKeXB12rxc
        LZmo2m/SFD5nJMnDqO9Ukeuk/MbLOgIuyD6loQbudpP7VKA+f0xIBCKSzNNrsImjl6W3JFSEXuG
        5HPDvKcCHL3i3ZaMBwG4FjA==
X-Received: by 2002:ac8:5813:0:b0:3b9:a4d4:7f37 with SMTP id g19-20020ac85813000000b003b9a4d47f37mr37363478qtg.3.1675639030437;
        Sun, 05 Feb 2023 15:17:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8mrnK+ikirixTmDtvR78/fRtminiJLSrpX/G80o7vhvBjyiJhn1+xWU/af4TGpWMpz/q/ScQ==
X-Received: by 2002:ac8:5813:0:b0:3b9:a4d4:7f37 with SMTP id g19-20020ac85813000000b003b9a4d47f37mr37363454qtg.3.1675639030152;
        Sun, 05 Feb 2023 15:17:10 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8515a000000b003b82cb8748dsm5986545qtn.96.2023.02.05.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:17:09 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/3] mm/arm64: Define private VM_FAULT_* reasons from top bits
Date:   Sun,  5 Feb 2023 18:17:03 -0500
Message-Id: <20230205231704.909536-3-peterx@redhat.com>
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
 arch/arm64/mm/fault.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 596f46dabe4e..44fd16f58f94 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -480,8 +480,12 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 	}
 }
 
-#define VM_FAULT_BADMAP		0x010000
-#define VM_FAULT_BADACCESS	0x020000
+/*
+ * Allocate private vm_fault_reason from top.  Please make sure it won't
+ * collide with vm_fault_reason.
+ */
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x80000000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x40000000)
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
-- 
2.37.3

