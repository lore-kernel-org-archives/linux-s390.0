Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C933C636CC
	for <linux-s390@archiver.kernel.org>; Sun,  5 Feb 2023 23:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjBEXRy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 5 Feb 2023 18:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBEXRx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 5 Feb 2023 18:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC919689
        for <linux-s390@vger.kernel.org>; Sun,  5 Feb 2023 15:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675639028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hczbFL+ar/tk/IYpzPCczVyi3teFQZrB1wxKh73TL0g=;
        b=gLAF8qii/iuEwBLmyjF0T1Y6jdTmzsBC9JuY0dGdh0wfaJT5S3EVu2dbG1NVRhRY5s3/qE
        N9oJQO4aR+tuSd4Tv5avZh18HY12a1KQrdBvMwzPxV/1bAT0qOGIqGET5XMhUQDeqVv7Qx
        TiHo+i9cLl60RIy6ikPdU2GrH0/l5dA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-3ZlnnMhxPfeKfGbRt3bWaQ-1; Sun, 05 Feb 2023 18:17:06 -0500
X-MC-Unique: 3ZlnnMhxPfeKfGbRt3bWaQ-1
Received: by mail-qk1-f199.google.com with SMTP id ay10-20020a05620a178a00b0072db6346c39so5529471qkb.16
        for <linux-s390@vger.kernel.org>; Sun, 05 Feb 2023 15:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hczbFL+ar/tk/IYpzPCczVyi3teFQZrB1wxKh73TL0g=;
        b=qDUQfIRv8YCunPTePKMWCF20OKAUR3u/+eOi7kcDXOyvhWqoryYt+wx7pMWPE6ibzt
         rqJrM/K/h2FxFgqMmGH6SQNzkiSymPfca3k4pHUFCwl82E+5S97Z6GoZ1+1CEHeKyg0y
         Z6S+cCUTq8/G1VYFqJysBOOT/dO6g8xuIetKOL/63fCXkFiDsj81CUDn1S8ylsrhvyPG
         bBeD4+Ma1vl4y/dIOVh573h40EMMW4MChmElF5lFQaRRNebrkorN2PQCAWn65HtSwwsq
         uuwrqbKXwU97K/Sm9wHC/NtQs4NG5qUNRlv5tV2wrOu1R89wX7oYqqArEc89pPjCvwfU
         fuSQ==
X-Gm-Message-State: AO0yUKVkNFHPzi/Xe4KJHZZXbR8OCMdGGGSl9MjzHXB/esyibM8c7rOo
        LQOQ/oYztMG31GF21jVvZEN6dktyLQCfqzPlShTZm9BXbmvHLOXBQDNcXSljANMaYvV1KkV+3Sq
        pNOC24Uuv3tm6X1MA94/7FQ==
X-Received: by 2002:a05:622a:a15:b0:3b8:695b:aad1 with SMTP id bv21-20020a05622a0a1500b003b8695baad1mr31166804qtb.1.1675639026387;
        Sun, 05 Feb 2023 15:17:06 -0800 (PST)
X-Google-Smtp-Source: AK7set/sbA75b0Czo2TaDI7H5+UellOBQzwBIsx8AnsLPSQNhM0IiyfwrSSGN0x0tfL39bKfeNgbnw==
X-Received: by 2002:a05:622a:a15:b0:3b8:695b:aad1 with SMTP id bv21-20020a05622a0a1500b003b8695baad1mr31166787qtb.1.1675639026141;
        Sun, 05 Feb 2023 15:17:06 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8515a000000b003b82cb8748dsm5986545qtn.96.2023.02.05.15.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:17:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/3] mm/arch: Fix a few collide definition on private use of VM_FAULT_*
Date:   Sun,  5 Feb 2023 18:17:01 -0500
Message-Id: <20230205231704.909536-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

I noticed a few collision usage on VM_FAULT_* definition in the page fault
path on arm/arm64/s390 where the VM_FAULT_* can overlap with the generic
definition of vm_fault_reason.

The major overlapped part being VM_FAULT_HINDEX_MASK which is used only by
the hugetlb hwpoisoning.

I'm not sure whether any of them can have a real impact, but that does not
look like to be expected.  I didn't copy stable, if anyone thinks it should
please shoot.  Nor did I test them in any form - I just changed the
allocations from top bits and added a comment for each of them.

Please have a look, thanks.

Peter Xu (3):
  mm/arm: Define private VM_FAULT_* reasons from top bits
  mm/arm64: Define private VM_FAULT_* reasons from top bits
  mm/s390: Define private VM_FAULT_* reasons from top bits

 arch/arm/mm/fault.c   |  8 ++++++--
 arch/arm64/mm/fault.c |  8 ++++++--
 arch/s390/mm/fault.c  | 14 +++++++++-----
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.37.3

