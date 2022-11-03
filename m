Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6BBC43219
	for <linux-s390@archiver.kernel.org>; Thu,  3 Nov 2022 14:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKCOZJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 3 Nov 2022 10:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiKCOZI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Nov 2022 10:25:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00AAE7A
        for <linux-s390@vger.kernel.org>; Thu,  3 Nov 2022 07:25:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j15so3047992wrq.3
        for <linux-s390@vger.kernel.org>; Thu, 03 Nov 2022 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyXCEm+SN4JTuAX2T0R90Ie6jT6YR0PIuexybyKvkXE=;
        b=WTZ/fhxMJ71jLlitDHXKYaXGnn95ODQizEyx4pjZLu/FU2YdbKeNAo0B/NktNH9Hif
         0ihHLDxTp8U29NT+XMIjwbpXih+rDpGbzPso+IRrM4OQEis6MRNHdhg2+L+2iQ5ZiErf
         H2C2UNKqEdpYeg1ou6yBgu5uGp5t6In0MkSQENq2IWAYTPdvvddzhf9M2SUHCjdkNqlP
         pTfB+d1W2bpoY+NqsMD0CmY3+w2XyTZf6ZrvG8psupb3sY6BjQWTaeaT9RFdOarIdWjn
         Jj663Dqz2gYFZNCYKSrBaU2MDDJrY91RmxP0f4HXzCqrYeVlqsItUMv2dSlq4XkDrWmi
         x2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyXCEm+SN4JTuAX2T0R90Ie6jT6YR0PIuexybyKvkXE=;
        b=bjAwKPl9/Oyc8R/cmQ5RdUWjYgS383TW5FPQS4oom95bjj9pukC7ShJUnO08TcPM7T
         SwnaMLAnJxotcq0Ek0JQa8xKR/ppR7Ls6LBum+DY4dN0snPBZUV4A3N6LmjGbqxXRjgD
         fkQQJcRSvZ2g8AXwILnXsM01bHA4p9+zPyWw/zq8HjTUkJPoY8I7z9xT9bvc1JMn9bix
         1wCh6hG8JDaQ3Y8V9NqTLfSGHkzQldZs2anFmK3bOTZOsysyL4O3mFURtrScRMPlRxZW
         0JOxt2AKe4Mhp87ptj8MoM5Mwm2uiaVR+xmjm1dmf3T8xSUapm8MyAowQHqMDb53YfTA
         FjIg==
X-Gm-Message-State: ACrzQf0xDvl9Qz/rQfocelwaAatrimHNC80nSK3xXsKPZy7v6DAHqio9
        vW8CjqDVHfiXItysTu03Qbfjag==
X-Google-Smtp-Source: AMsMyM5hdXBUu8yo8VO7zyELnZCeDW54TPy5bvl1rmzeZB7u0GPP01rGpP4zIsPcikd5aOtl3C5pdw==
X-Received: by 2002:a5d:654d:0:b0:235:197d:72d1 with SMTP id z13-20020a5d654d000000b00235197d72d1mr18800468wrv.680.1667485505908;
        Thu, 03 Nov 2022 07:25:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d6547000000b0023662245d3csm992994wrv.95.2022.11.03.07.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:25:05 -0700 (PDT)
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
Subject: [PATCH v4 0/1] Fix /proc/cpuinfo cpumask warning
Date:   Thu,  3 Nov 2022 15:25:03 +0100
Message-Id: <20221103142504.278543-1-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") started
issuing warnings[1] when cpu indices equal to nr_cpu_ids - 1 were passed
to cpumask_next* functions. The commit has since been reverted with
commit 80493877d7d0 ("Revert "cpumask: fix checking valid cpu range"."),
which raises the question as to how much this proposed patch is needed.
Additionally, there's some discussion as to whether or not cpumask_next()
should even be validating its inputs[2]. So, with that in mind, I'm fine
with the patch being dropped. However, it may still be reasonable to add
the checking to /proc/cpuinfo until cpumask_next has made changes and
better documented its API.

[1] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
[2] https://lore.kernel.org/all/CAHk-=wihz-GXx66MmEyaADgS1fQE_LDcB9wrHAmkvXkd8nx9tA@mail.gmail.com/

This series addresses the issue for x86. riscv has already merged an
equivalent patch (v3 of this series). Also, from a quick grep of cpuinfo
seq operations, I think at least openrisc, powerpc, and s390 could get an
equivalent patch. While the test is simple (see next paragraph) I'm not
equipped to test on each architecture.

To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to
a shell, do 'cat /proc/cpuinfo', and look for a kernel warning.

v4:
  - The riscv patch has already been merged.
  - Mostly rewrote the cover letter as the situation has changed since
    78e5a3399421 was reverted.
  - Rewrote the commit message in order to try an better clarify things
    and also to add the reference to the revert commit, which results in
    the commit no longer claiming its a 'fix' in its summary. [Boris]

v3:
  - Change condition from >= to == in order to still get a warning
    for > as that's unexpected. [Yury]
  - Picked up tags on the riscv patch

v2:
  - Added all the information I should have in the first place
    to the commit message [Boris]
  - Changed style of fix [Boris]

Andrew Jones (1):
  x86: cpuinfo: Ensure inputs to cpumask_next are valid

 arch/x86/kernel/cpu/proc.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.37.3

