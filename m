Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0310DC43217
	for <linux-s390@archiver.kernel.org>; Thu,  3 Nov 2022 14:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKCOZK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 3 Nov 2022 10:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiKCOZJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Nov 2022 10:25:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9595F15838
        for <linux-s390@vger.kernel.org>; Thu,  3 Nov 2022 07:25:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o4so3023536wrq.6
        for <linux-s390@vger.kernel.org>; Thu, 03 Nov 2022 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj/ZFbn3Zm8rxzcKsJGd6yFucy8YocyT0mV+oXpe7Do=;
        b=jMtJfzvsVyM2XNkO7dOnrzsj5bFsNMWPr9qRIuRvfNs1tOIvR8I1IP8JVx8tLG7Dep
         v7Un2NZW58xBtWmwuCjYH772AaiwgcpVC21xqkhn0o/tmaNi7buIljvNSAt6F+cUJUMm
         ty0TFwUWGldw91R8cET10BSTY/z5J4prX7tkwNyHo6zddMYQimrfEvNM/sLXJ4IbkhDZ
         m9cFvv72Li0sU8oIZulB0WLbKf4nulNrh7pWjefMCTf4HMlXuiYiEY3FH49w0tZgWXlu
         BN1Vbu6K5RGrqIIVUiu2VYCjwuaaGz/52VTavOGbRx053ikoFEVXHhj2bCgUlI2OBbQL
         U+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fj/ZFbn3Zm8rxzcKsJGd6yFucy8YocyT0mV+oXpe7Do=;
        b=OUKHfNBtiESl9SpklsAPhPn3WIeBLIUbal0vxx3oTBkyniF+1zNchrkez4ymWaLtQy
         /TZGyFRT9xDV2X5t2S3xqfI1rKKBdlLLUdpNJKuZx9O96TZi+6c5Tk7Ov+vVsE+ykVv4
         8Czyd9Bm80OQipK9lwUbpfE3a2nEXsfbBC/Z2hTd5nEhS4MNLCdP184WdWX9LdyOKlns
         1MNcO5jQ3NQfB9xr72n79y4GZM8GmgC/bF6EOKFKEmObdYy+x/Z13PywDQANdLHnAT3M
         IcR+IjiTp+X5n7/ZOaSYV3C/Lr6ciGR9ASWJ2dK3FfnN6iflWraH1wSU87MK2iMFq1zW
         NDrQ==
X-Gm-Message-State: ACrzQf1gYA7n37EVqU5kn0qCTIx6DF7AU1vNtL5VtYrgqV0kyTe+YhoQ
        ozhz0KWX3BTHlzi2+tvMVA7ImQ==
X-Google-Smtp-Source: AMsMyM7Fd10uROzTNx7lsAW66oPjI1uph9DNvAe559a3qkiRN8acm3Iyt5ChbLPnm5wfe14jlQcTjQ==
X-Received: by 2002:a05:6000:170d:b0:236:6aa1:8a56 with SMTP id n13-20020a056000170d00b002366aa18a56mr18858226wrc.302.1667485507181;
        Thu, 03 Nov 2022 07:25:07 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b003c21ba7d7d6sm1348138wmq.44.2022.11.03.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:25:06 -0700 (PDT)
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
Subject: [PATCH v4 1/1] x86: cpuinfo: Ensure inputs to cpumask_next are valid
Date:   Thu,  3 Nov 2022 15:25:04 +0100
Message-Id: <20221103142504.278543-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103142504.278543-1-ajones@ventanamicro.com>
References: <20221103142504.278543-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The valid cpumask range is [0, nr_cpu_ids) and cpumask_next()
currently calls find_next_bit() with its input CPU ID number plus one
for the bit number, giving cpumask_next() the range [-1, nr_cpu_ids - 1).
seq_read_iter() and cpuinfo's start and next seq operations implement a
pattern like

  n = cpumask_next(n - 1, mask);
  show(n);
  while (1) {
      ++n;
      n = cpumask_next(n - 1, mask);
      if (n >= nr_cpu_ids)
          break;
      show(n);
  }

which will eventually result in cpumask_next() being called with
nr_cpu_ids - 1. A kernel compiled with commit 78e5a3399421 ("cpumask:
fix checking valid cpu range"), but not its revert, commit
80493877d7d0 ("Revert "cpumask: fix checking valid cpu range"."),
will generate a warning when DEBUG_PER_CPU_MAPS is enabled each time
/proc/cpuinfo is read. Future-proof cpuinfo by checking its input to
cpumask_next() is valid.

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

