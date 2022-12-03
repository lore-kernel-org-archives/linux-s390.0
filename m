Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FBBC4321E
	for <linux-s390@archiver.kernel.org>; Sat,  3 Dec 2022 03:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiLCDFo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 2 Dec 2022 22:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLCDFn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Dec 2022 22:05:43 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45646F4EA3
        for <linux-s390@vger.kernel.org>; Fri,  2 Dec 2022 19:05:42 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 62so5854810pgb.13
        for <linux-s390@vger.kernel.org>; Fri, 02 Dec 2022 19:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=MlD/Jt4lEh7hCsdG4GrZC5S+VkhD7NzUj5refRzoYlM=;
        b=izvAm0VDDUI8l/g0FySHjcna49MAYiOl2i2nsHUCSKpwH56Ir0FhArtL4lxajgpkXU
         q1iMarjU2+4l78dL0ag6d1NvQOqww04i5UnypzOB7uiJNMdv6ZNzb7EMxtmw5MZyE7FS
         bThPfxkT785nXJba2CClXZ8fuV2fw9cigmtlu8HPoTnQiyjsAVLVsY+Z6ZgI5QpnZlNS
         ohghGfzoUn9u90kZ6rVg/9evUP6bC3tPDT6pLi+TdYbrAm2TFz5GcZZc1u/bdGibPp/B
         2n2b2AfXkggu33bWgZZ5liaNgIt/NwMzjqmw4UnUUdoXbVq6av/nJ7otAE/nEGEaYUqj
         79LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlD/Jt4lEh7hCsdG4GrZC5S+VkhD7NzUj5refRzoYlM=;
        b=LAbLJtWjd6Zjj/Df7zeDYo3PUARdq0oktB0AOsALZbY7rNZxENOTCFnupT8BEiw2Wx
         7M6iKle1neiBSQhGWuN/8zgvrLBcclb4Np01yqdgcQFZAsD3L8J8s2AjWH2y/G8kWE7w
         yTKrJMUNlWu8Zj4XNL6tfUwfSPejHJkvuROu9xqWJLpEKabZMtNnD2SJQGxEzhUb+TGs
         w/HBaKkoWyUx0YFv/t81fFipsKYW408Af4A4D1Qi3VJjXJUCfnCG8/PKGVXwfZeV+DUE
         EVmnJ87YJsAZWC1Gr0EbVWGLmuel7CUp1dJmpziCnv8RQYJF9MX3nbx/7XFpaAYB45CZ
         2Hdg==
X-Gm-Message-State: ANoB5pnXEKR69mdeM+PjlUgRxGAfQxpb7aNXpjUm+N4hNR0Ib27LM00y
        mSB6iPKU1rfWg345ov9Ge9hZEQ==
X-Google-Smtp-Source: AA0mqf64+QPycPCkazRrryQxpdG0UWxw0OahAJX32vqLElr+emlYUBPO7ldr1//HTp+r6hNM6u2ung==
X-Received: by 2002:a63:d34e:0:b0:477:650a:705c with SMTP id u14-20020a63d34e000000b00477650a705cmr46384100pgi.588.1670036741697;
        Fri, 02 Dec 2022 19:05:41 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q24-20020aa78438000000b00576984617b1sm287450pfn.60.2022.12.02.19.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:41 -0800 (PST)
Subject: [PATCH 0/5] mm: Stop alaising VM_FAULT_HINDEX_MASK in arch code
Date:   Fri,  2 Dec 2022 19:03:51 -0800
Message-Id: <20221203030356.3917-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
           linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When reviewing
<https://lore.kernel.org/r/20221029084715.3669204-1-tongtiangen@huawei.com>
I noticed that the arch-specific VM_FAULT flags used by arm and s390
alias with VM_FAULT_HINDEX_MASK.  I'm not sure if it's possible to
manifest this as a bug, but it certainly seems fragile.

The RISC-V patch is on top of the linked patch above, which isn't in any
proper tree yet.  Everything else should apply to 6.1-rc1, but I'm in no
particular rush to get that cleanup in so rush on my end for 6.2.  That
said I figured it would be easier to send along this now, just in case
someone who knows the MM code better thinks it can manifest as a bug.

