Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C25EC433F5
	for <linux-s390@archiver.kernel.org>; Fri,  7 Oct 2022 15:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJGPp6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJGPp5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Oct 2022 11:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C27D61D5B
        for <linux-s390@vger.kernel.org>; Fri,  7 Oct 2022 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665157554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMgaXogbXPhOabUcxt7UADYdICMU0udr545Ze04p+j4=;
        b=QMhcXAyIv65abDqObu6am37pXo5onpRU8rusO1cam+6FPdzOQcv942DZarpOIqWjcPpPFS
        xDYIB0H56udzBmjlyqYIAnxJzkBL3f8cWLKU5ieuuFtAkczaLeXr08GS5dWec8aurd+DF8
        fByHYjIZH8vbNsb3BIQAdlyFbk3jgH0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-ORlUyfJbNoiWer6bGtJsgg-1; Fri, 07 Oct 2022 11:45:53 -0400
X-MC-Unique: ORlUyfJbNoiWer6bGtJsgg-1
Received: by mail-wm1-f70.google.com with SMTP id v191-20020a1cacc8000000b003bdf7b78dccso2852646wme.3
        for <linux-s390@vger.kernel.org>; Fri, 07 Oct 2022 08:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMgaXogbXPhOabUcxt7UADYdICMU0udr545Ze04p+j4=;
        b=jtVjc395yVSoe0OLn2sCKEUOOYhs3clf0f5PzpjUuWzelOz1Tc12JnXWJmfQRdFPEH
         WSoL/ZThs4/HdcAAR+RcAnQO4qVyTEoZ4GeBuh9Iobti0uBrOmwR/l9H1SAPl6dngEIp
         sxX8KDm30Lrmy/p+3Ndf6scWrnn0Y7MOnUYJcNsZm1zHqCD+DBLHr24aEcqMQmLZV4mh
         El4T2IDjJbOSHVhoPSbmrdo8twrBxJFQviNMortE42jp6j//4mhj0Gug1zbH0HN6A794
         KjU41jUwLBGdDURqopQJp/oKPf/Cp5SP8KHZ/DxYWiqzO2Po9eyXuzXRX00Xc7PQ+bcc
         +kvg==
X-Gm-Message-State: ACrzQf3mEajy3SEVyOcOuQFbkgJ4bLBF3j32NA2Gcops4ZhLOQtfUhru
        Rzr1CyZhx58FoY1QTG74vRaLT6ZMrJnRzLe/UbG1RuZnsiTsysVH0oyPia7E+HGPl1cuD5QmIM4
        KGOiqnD88EepxF/Jj7stEGw==
X-Received: by 2002:a05:600c:458d:b0:3c3:bf4e:5c60 with SMTP id r13-20020a05600c458d00b003c3bf4e5c60mr1331385wmo.189.1665157552452;
        Fri, 07 Oct 2022 08:45:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM53pm8pDMF8tAvcpsQYCd9DEpAeQROExvsQCCHMjVMrngwHmXq+ii3h5Ne2OaugbAyINh7v6Q==
X-Received: by 2002:a05:600c:458d:b0:3c3:bf4e:5c60 with SMTP id r13-20020a05600c458d00b003c3bf4e5c60mr1331352wmo.189.1665157552172;
        Fri, 07 Oct 2022 08:45:52 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id i18-20020adfb652000000b0022e38c93195sm2339428wre.34.2022.10.07.08.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 08:45:51 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH 1/5] trace: Add trace_ipi_send_{cpu, cpumask}
Date:   Fri,  7 Oct 2022 16:45:29 +0100
Message-Id: <20221007154533.1878285-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221007154145.1877054-1-vschneid@redhat.com>
References: <20221007154145.1877054-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

trace_ipi_raise is unsuitable for generically tracing IPI sources; add a
variant of it that takes a callsite and a CPU. Define a macro helper for
handling IPIs sent to multiple CPUs.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/trace/events/ipi.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/trace/events/ipi.h b/include/trace/events/ipi.h
index 0be71dad6ec0..fd2f2aeb36fe 100644
--- a/include/trace/events/ipi.h
+++ b/include/trace/events/ipi.h
@@ -35,6 +35,33 @@ TRACE_EVENT(ipi_raise,
 	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
 );
 
+TRACE_EVENT(ipi_send_cpu,
+
+	TP_PROTO(unsigned long callsite, unsigned int cpu),
+
+	TP_ARGS(callsite, cpu),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, callsite)
+		__field(unsigned int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->callsite = callsite;
+		__entry->cpu      = cpu;
+	),
+
+	TP_printk("callsite=%pS target_cpu=%d", (void *)__entry->callsite, __entry->cpu)
+);
+
+#define trace_ipi_send_cpumask(callsite, mask) do {		\
+	if (static_key_false(&__tracepoint_ipi_send_cpu.key)) { \
+		int cpu;					\
+		for_each_cpu(cpu, mask)				\
+			trace_ipi_send_cpu(callsite, cpu);	\
+	}							\
+} while (0)
+
 DECLARE_EVENT_CLASS(ipi_handler,
 
 	TP_PROTO(const char *reason),
-- 
2.31.1

