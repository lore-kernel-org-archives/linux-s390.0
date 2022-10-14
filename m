Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7415C433FE
	for <linux-s390@archiver.kernel.org>; Fri, 14 Oct 2022 15:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJNP6y (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJNP6w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Oct 2022 11:58:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3004122771
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:58:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s30so7473188eds.1
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBIOqGjmdzThiZsnnbTdUiYSPQXS/qp/QRUJHndogxY=;
        b=de2qcklml8jKYdhJlyXqmJXoz8FYGzMVRLfN9JcOUqf4UOLuKCrWZr59qwP/CI15i8
         9ZEYt9iqHJUORqeLDasCpf2TvKXJ2eNiOMML8Fk+bz7YKFJbV57Ez3yS2OMYxbifi8aU
         80V2z5mOPzJ5j+SPiaK/ExtA7pvzSXkVFgQy9BgPDzmgfE18Klp1ebv/IKnNb6TVl3x7
         K0gO3P8T9E6LTR2oS1WZnI3pbS2vkD6iCSFlqd/rinFyB9u6Ftb/GsYDL097UX4vn1na
         X5w9kGup7pabQp9pwZ84Krxhofd+fyywuWkx0d61FPGLmHqmWuc2PbVNpdjodZPMfLJV
         6NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBIOqGjmdzThiZsnnbTdUiYSPQXS/qp/QRUJHndogxY=;
        b=mbP1zm6KrNMEJZfm/coREvXY0lpqBrHwTM6TAagy0HvTomgRAYGqFCBQgv5tQPT6H8
         TrlK4yoyfSJ0A5Lk2SlnztrLdhl6EHao+awzb5RCcybUiJ5rHmlgw05O7+678BHKpPCe
         ed9Bo7jfukihFOqkPo/S+Ol2ppKH79pT53qlOKP/jA60CjFtEMqAw2ANazzwel3ZYmye
         eUHnynVRRN/JOomWH42Q37raSevDzV8epRLXP/pjDkUBUtc3Zccn/LkRxShpypWWgb9n
         /uCADwtRSxEA4E8TBlLFBKTEBhkh2l4Pd89slQsOKjpeO2M033plJyvCtu3SRvq3WmbH
         OQTg==
X-Gm-Message-State: ACrzQf27WIWUFzOAL4IIZwK6OuoqnCbDsfF4cbMnA6/PGeQX0XKXhIqq
        gJkYObzD+QQKCrrrhqCRQPHd+Q==
X-Google-Smtp-Source: AMsMyM7AeOygOXkM1z/GTKaGU+3a1Uh1fQyGWBmDx0oj1luEK/7mcX83iQG4d2XLgbn9xXhJP10WDg==
X-Received: by 2002:a05:6402:3485:b0:45c:d688:6848 with SMTP id v5-20020a056402348500b0045cd6886848mr4672473edc.279.1665763129826;
        Fri, 14 Oct 2022 08:58:49 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906300c00b0077a1dd3e7b7sm1746796ejz.102.2022.10.14.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:58:49 -0700 (PDT)
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
Subject: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Date:   Fri, 14 Oct 2022 17:58:45 +0200
Message-Id: <20221014155845.1986223-3-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014155845.1986223-1-ajones@ventanamicro.com>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
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

which will issue the warning when reading /proc/cpuinfo. Ensure no
warning is generated by validating the cpu index before calling
cpumask_next().

[*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Cc: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/cpu/proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..de3f93ac6e49 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -153,6 +153,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
+	if (*pos == nr_cpu_ids)
+		return NULL;
+
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
 	if ((*pos) < nr_cpu_ids)
 		return &cpu_data(*pos);
-- 
2.37.3

