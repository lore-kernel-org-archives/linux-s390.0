Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E44C6FD1F
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 03:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCODF2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Mar 2023 23:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCODF1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Mar 2023 23:05:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E524B5D771
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id iw3so1802117plb.6
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678849525;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=6StZGYfoZTn12V1gc6oBX/6Y2DvQg0Jy/UiSWe5dt5k=;
        b=3V0Bb6iTGxYmKPdsmVVjb5YDGt0UOAUN+A63mxQz3ZYfjTdMu6saa1R9Gh/rv2eu3b
         IqZWD+VN2oPSDYDCUvatQ4pau1AA/Sd/BYem1kyIblQ/5fKzJ8LxZrvAcO76NkyEBg2A
         5eHppBwHYa29Ssst5SUa4NtXUgz7L8tVp7rEyvOYiKl/M/GVTjbcxYl3tZ3PQnBtljyw
         /AMdtGyiBpRg3TQgYbXAgKkKQg/Mur2bMI/JRQ4dCGxKp8XAUqhAE6RXdjIyeznreE/Z
         k6dw7jlQGLWe+FMvQrwiPB/7+1y/tkZpFmWQwn4XUut9T5VSQQbLMwvqLJVGFOsxSzi1
         APDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849525;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6StZGYfoZTn12V1gc6oBX/6Y2DvQg0Jy/UiSWe5dt5k=;
        b=OTlo7bYqWTy/EcvLGD2ZHOjvWJZeoUewCIVq0B/nFB7N15jOjsx7IgPWj9Yp9BRcyg
         BB6FgJB0+kuLPvvRTxlcoYBEcd6qpvL8zi/8uFXxNr3E5s2QkyQUNEvjAaO5enDUO5Xq
         g2uoSOTFVjs6iIOWiCzguyW6f+X9JdvNWDJaCGwFM/oudcf6n0rucLgkd85O9eQhrUtW
         GFR6egobIBWC7OCkCiC6HNRAU3OR6KVTf5EISUoXKShf5f77x5p1V/d8SheQqXxmgb1w
         +7oNWFvYlkWLfnjAhL6lK5kNmftyFMObey947vhCHofWj9G1CDHTbuZXlXP8VM8brZSy
         gxrg==
X-Gm-Message-State: AO0yUKURUHhZZ3tmptVY/N8+f9hfinIFRYoMykWLW05ueIyLFnDDpFBj
        4yS9t0BF9HuVU8YPcx9DqY1oCA==
X-Google-Smtp-Source: AK7set/ZRFjpxyImRiC63oPA7QR8aY+ZSsRYZkScRh+gExeQbc7hhNGg61z3G7A+k1lQU+zBzKMA7w==
X-Received: by 2002:a17:903:112:b0:19f:30be:e9fb with SMTP id y18-20020a170903011200b0019f30bee9fbmr877545plc.19.1678849525353;
        Tue, 14 Mar 2023 20:05:25 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id kz8-20020a170902f9c800b0019f3cc463absm2469104plb.0.2023.03.14.20.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:05:24 -0700 (PDT)
Subject: [PATCH v2 0/6] mm: Stop alaising VM_FAULT_HINDEX_MASK in arch code
Date:   Tue, 14 Mar 2023 20:03:53 -0700
Message-Id: <20230315030359.14162-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     akpm@linux-foundation.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When reviewing
<https://lore.kernel.org/r/20221029084715.3669204-1-tongtiangen@huawei.com>
I noticed that the arch-specific VM_FAULT flags used by arm and s390
alias with VM_FAULT_HINDEX_MASK.  I'm not sure if it's possible to
manifest this as a bug, but it certainly seems fragile.

I'm including that original patch this time in the hope that makes it
easier for folks to review.  There were some boring conflicts so I
figured I'd rebase rather than pinging again.

Changes since v1 <20221203030356.3917-1-palmer@rivosinc.com>:

* Add the original patch, and reorder the RISC-V stuff first.
* Rebased on v6.3-rc2
* Moved the comment about VM_FAULT_ARCH_* to the patch that adds those,
  rather than the patch that adds 0s.


