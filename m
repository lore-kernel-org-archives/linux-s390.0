Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621B7C47097
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 06:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A59A6140F
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 06:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFDG7m (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 4 Jun 2021 02:59:42 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4347 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhFDG7l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Jun 2021 02:59:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FxD5B749vz63gb;
        Fri,  4 Jun 2021 14:54:06 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:57:53 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:57:52 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-csky@vger.kernel.org>,
        <uclinux-h8-devel@lists.sourceforge.jp>,
        <linux-m68k@lists.linux-m68k.org>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-sh@vger.kernel.org>, <linux-s390@vger.kernel.org>
Subject: [PATCH v2 00/15] init_mm: cleanup ARCH's text/data/brk setup code
Date:   Fri, 4 Jun 2021 15:06:18 +0800
Message-ID: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add setup_initial_init_mm() helper, then use it
to cleanup the text, data and brk setup code.

v2:
- change argument from "char *" to "void *" setup_initial_init_mm()
  suggested by Geert Uytterhoeven
- use NULL instead of (void *)0 on h8300 and m68k
- collect ACKs

Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-m68k@lists.linux-m68k.org
Cc: openrisc@lists.librecores.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-sh@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Kefeng Wang (15):
  mm: add setup_initial_init_mm() helper
  arc: convert to setup_initial_init_mm()
  arm: convert to setup_initial_init_mm()
  arm64: convert to setup_initial_init_mm()
  csky: convert to setup_initial_init_mm()
  h8300: convert to setup_initial_init_mm()
  m68k: convert to setup_initial_init_mm()
  nds32: convert to setup_initial_init_mm()
  nios2: convert to setup_initial_init_mm()
  openrisc: convert to setup_initial_init_mm()
  powerpc: convert to setup_initial_init_mm()
  riscv: convert to setup_initial_init_mm()
  s390: convert to setup_initial_init_mm()
  sh: convert to setup_initial_init_mm()
  x86: convert to setup_initial_init_mm()

 arch/arc/mm/init.c                 | 5 +----
 arch/arm/kernel/setup.c            | 5 +----
 arch/arm64/kernel/setup.c          | 5 +----
 arch/csky/kernel/setup.c           | 5 +----
 arch/h8300/kernel/setup.c          | 5 +----
 arch/m68k/kernel/setup_mm.c        | 5 +----
 arch/m68k/kernel/setup_no.c        | 5 +----
 arch/nds32/kernel/setup.c          | 5 +----
 arch/nios2/kernel/setup.c          | 5 +----
 arch/openrisc/kernel/setup.c       | 5 +----
 arch/powerpc/kernel/setup-common.c | 5 +----
 arch/riscv/kernel/setup.c          | 5 +----
 arch/s390/kernel/setup.c           | 5 +----
 arch/sh/kernel/setup.c             | 5 +----
 arch/x86/kernel/setup.c            | 5 +----
 include/linux/mm_types.h           | 8 ++++++++
 16 files changed, 23 insertions(+), 60 deletions(-)

-- 
2.26.2

