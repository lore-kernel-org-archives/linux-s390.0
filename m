Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94021C433FE
	for <linux-s390@archiver.kernel.org>; Fri, 14 Oct 2022 15:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJNP6u (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJNP6t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Oct 2022 11:58:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3DF10A7FC
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:58:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id 13so11479231ejn.3
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W5eO6i8yGqM/Qk/helghde+sK2B6uuy7iGWdi59LQv0=;
        b=m5i1o0Ap34XB2wlP21XgYIqsVDRRQOqNgXMX5tJzWsaI6hGrAZN9MXRzGc93zF2XPA
         8L/SLRgslFncCk0nXLKfro+LvVAuBiIJEkGi+kku5MAuwTr4Av+VkPDyus9j5yCxKY0e
         YOtAgl4m9DWHQK3UYRyVu1beWyQGVeOVcZD55vwQwp4fSb0QhgMCnZzRu0uhrRUo1Tvq
         XZgdlHZK3gCz7g4TIGW4i3ZvbPG7Gm3XysvcL00yJwc2GO4L3l9DhN608jkbddOb/W9j
         f6nCuDr1Hx3UpL7i6FB65/PdJkLsqhTn6pdhYB+vtA5dMZT/TwoMfVhWXkBkx0/mc7XG
         dKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5eO6i8yGqM/Qk/helghde+sK2B6uuy7iGWdi59LQv0=;
        b=DsPpOC7LltNwipV2ItJxLNXo0AbRxmuvf8EcX7EDa09StkqnSSBisj2+Hv6ijcprfh
         KTtlSI3YHKtYqwA2WBaQxawSzmqqJjUhMKsQTYuDPhH0j40guRxwd1EVn5UIDc5jnEj0
         VEGVdC5jq4rZTkBDAP63mM19yRdqPWuwR9h3fT9ez9j8HYCeNs+CnnZWCthgURrdy482
         7eAEjw5yEN16QphslWNaaGi4neQ1sdAranewOx0d73VcuDxNzcZgPweUAlFce+29v70C
         33TzU7jq/m8zcGY7DDCndhrU7gPD0KmdkYC0EFh6CLgr/DfuQyBA2iW0KpmxnjsitaYf
         HHTA==
X-Gm-Message-State: ACrzQf0YiqIBeFYVvX9MTYibeUQVQ3TN3tBm05WeL7MoSpNUBo5KryCi
        BuiUO1N+Jp92K8PIa8wF/92IOw==
X-Google-Smtp-Source: AMsMyM7W6+fPu+mWcsl2mA5mLUmVxJY6ZAokGeJNv3DvlB68CliPDKXds+EoUBatPkHWx2Y7U7pt8g==
X-Received: by 2002:a17:907:94c9:b0:78d:3544:ff0a with SMTP id dn9-20020a17090794c900b0078d3544ff0amr3984138ejc.386.1665763126950;
        Fri, 14 Oct 2022 08:58:46 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id z5-20020a170906944500b007262a5e2204sm1693950ejx.153.2022.10.14.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:58:46 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 0/2] Fix /proc/cpuinfo cpumask warning
Date:   Fri, 14 Oct 2022 17:58:43 +0200
Message-Id: <20221014155845.1986223-1-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
start and next seq operations implement a pattern like

  n = cpumask_next(n - 1, mask);
  show(n);
  while (1) {
      ++n;
      n = cpumask_next(n - 1, mask);
      if (n >= nr_cpu_ids)
          break;
      show(n);
  }
    
which will issue the warning when reading /proc/cpuinfo.

[*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.

This series address the issue for x86 and riscv, but from a quick
grep of cpuinfo seq operations, I think at least openrisc, powerpc,
and s390 also need an equivalent patch. While the test is simple (see
next paragraph) I'm not equipped to test on each architecture.

To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to
a shell, do 'cat /proc/cpuinfo', and look for a kernel warning.

While the patches are being posted together in a series since they're
for two different architectures they don't necessarily need to go
through the same tree.

v3:
  - Change condition from >= to == in order to still get a warning
    for > as that's unexpected. [Yury]
  - Picked up tags on the riscv patch

v2:
  - Added all the information I should have in the first place
    to the commit message [Boris]
  - Changed style of fix [Boris]

Andrew Jones (2):
  RISC-V: Fix /proc/cpuinfo cpumask warning
  x86: Fix /proc/cpuinfo cpumask warning

 arch/riscv/kernel/cpu.c    | 3 +++
 arch/x86/kernel/cpu/proc.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.37.3

