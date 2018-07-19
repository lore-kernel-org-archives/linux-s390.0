Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 21/26] x86/tsc: use tsc early
Date: Thu, 19 Jul 2018 16:55:40 -0400
Message-Id: <20180719205545.16512-22-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

get timestamps and high resultion clock available to us as early as
possible.

native_sched_clock() outputs time based either on tsc after tsc_init() is
called later in boot, or using jiffies when clock interrupts are enabled,
which is also happens later in boot.

On the other hand, tsc frequency is known from as early as when
tsc_early_init() is called.

Use the early tsc calibration to output timestamps early.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/tsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7ea0718a4c75..9277ae9b68b3 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1408,6 +1408,7 @@ void __init tsc_early_init(void)
 	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
 	tsc_store_and_check_tsc_adjust(true);
 	cyc2ns_init_boot_cpu();
+	static_branch_enable(&__use_tsc);
 }
 
 void __init tsc_init(void)
-- 
2.18.0
