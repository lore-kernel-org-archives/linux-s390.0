Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF31C25AEB
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 23:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB29760C3E
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 23:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhIAXjA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 1 Sep 2021 19:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbhIAXi6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Sep 2021 19:38:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E7BC0617A8
        for <linux-s390@vger.kernel.org>; Wed,  1 Sep 2021 16:38:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id n18so9627pgm.12
        for <linux-s390@vger.kernel.org>; Wed, 01 Sep 2021 16:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tl7TywVZic9PhfHq2BmWEfnSDIUToLj1FPGq3mOdgmw=;
        b=amPN+xrpXeCcUvsXZ2d7UHDE2nH9GBoGfLpr/Zq1IJmdo/pqCdlZwLqKWbBbEKvD4u
         ryvzcTzvvpj8VE22IBXoux6mnmBeTmz8rQKRLRvtp3fCsCNSoA5vuIX5ioGrz3CexbzP
         1YShB1JcwaoXaca8CoKe5VbjNjK+gCCwbTCO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tl7TywVZic9PhfHq2BmWEfnSDIUToLj1FPGq3mOdgmw=;
        b=Ud8U/siRbc1yiVYM7IpjzxOwJBIh54sRqrHzMNTGI3LFF7RTTx5OciI7wH2EH9EYez
         xmAZwq+EUQnlxrpSOLQntoK9jsGLkJ/a5qRx8w6RsYL8tgknra8kYyXOLpuV3W9NkIKy
         2YINFTqbMzneahXiDFQc6q6Vvw5EhZayabDt0zwheLIo72MFVteZz/edPlB06OZHGjOm
         14GpvupKV5R7WKbWxULVtBe6/2tGMEramPNeBvO+bVj+338VSvtmHGhRm2ob4YGHi6HK
         XsS7kdfcHbScRRy1RMYJBIF/KSrawAKSNsIuJMUfiZNv8fy3cHh4F3EO+52FSAce6pRq
         gXTw==
X-Gm-Message-State: AOAM532KdNLOFlxBvF0tFhkLysRYR+fppUHOU/Pz11xSAcFiu+ocFLFR
        qpfnjuX/B185YEVCBHFYxwZqPQ==
X-Google-Smtp-Source: ABdhPJw6iwsYq9xnv36qxIxw0UUdgDQijR/zSF04ZL0MjVxWr8jae0SafkiRcENHLnowa/XoNb6S0A==
X-Received: by 2002:a63:f80a:: with SMTP id n10mr187132pgh.303.1630539480763;
        Wed, 01 Sep 2021 16:38:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u24sm87353pfm.81.2021.09.01.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:37:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/4] Fix ro_after_init vs static_call
Date:   Wed,  1 Sep 2021 16:37:53 -0700
Message-Id: <20210901233757.2571878-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=751; h=from:subject; bh=LMtX30+lHx9d1AiyntE3juWOs+vNiZc4QnLUTVqvMfk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMA7UmpG1QrLCXLyjRwNizAoMH23KjhJdgmQwH3oR fiBTMdOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTAO1AAKCRCJcvTf3G3AJhMUD/ 9jCNxxAKmyPneQY5gEfnpbv479Oor6moPazSiSEojXx1xulI+ViTPAcS/XqzP98X8/14oKEKVBdpq0 DlK1bjtgs4o3rVcMsHQ/8aH+JeLqzL0IHYCqQeZkB9D0Ruan0SJuN/3elxAWK1MdODurM1SW1Feosd QkHHg589WJdFLo9KzxnxSlmZlW/neMOKqguXhv0lRLc39NmcGjPCp5eN9koPYOi0GH+aa6g/uPu5fv jQm4KGT2KSMSGFZVs3fa8c9BLw9Tk60/PozJshlh9CG8nR16A9Eg6warfWkjjN+sLOXgT6XTjbHCZo TmE1ZRi5Gb1Jn1ySSYanQCvGyiAhsLCKNhJgy+BlGDw6t7J4ZysUEkroOU787UAdsCDZ+LViu6nFkB YKiBo1rrsPhz4+mJlhQp3o/s7qZuBuT+gpC45Y7AqUcl8ZqqTDsc8pUgeUcfx459NIUwPeOmilyoV4 kbyPdmETgDf/qGm0/t1Eef6/Rjcp8nwFg8heK5Dm47NTTm4vzAuCfjqm/GykG7ACHNG2+I5j5s7RX2 n3TmSWONZve8dL2xQjoIkgjICM7bIbdiu8wSfukzjyZSkFzA80GtNt0lMBJoBY67XrOBq2EvztxOpW gX1jQZR2Yg5Dee5YMMqC/hyntgUM5gSGnnjaHB82XdikWFP0FiDFwot8eFXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

It seems the .static_call_sites section was not being marked as
ro-after-init in modules. Adjust the macro names, add comments, refactor
the module section list, and fix .static_call_sites.

Thanks!

-Kees

Kees Cook (4):
  vmlinux.lds.h: Use regular *RODATA and *RO_AFTER_INIT_DATA suffixes
  vmlinux.lds.h: Split .static_call_sites from .static_call_tramp_key
  module: Use a list of strings for ro_after_init sections
  module: Include .static_call_sites in module ro_after_init

 arch/s390/kernel/vmlinux.lds.S    |  2 +-
 include/asm-generic/vmlinux.lds.h | 22 +++++++++++++++-------
 kernel/module.c                   | 29 +++++++++++++++++------------
 3 files changed, 33 insertions(+), 20 deletions(-)

-- 
2.30.2

