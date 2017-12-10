Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Subject: [PATCH 39/45] arch/s390: remove duplicate includes
Date: Sun, 10 Dec 2017 23:56:57 +0530
Message-Id: <1512930417-4796-1-git-send-email-pravin.shedge4linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org, mingo@kernel.org, labbott@redhat.com, tglx@linutronix.de, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pravin.shedge4linux@gmail.com
List-ID: <linux-s390.vger.kernel.org>

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 arch/s390/kernel/kprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index af3722c..943d13e 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -20,7 +20,6 @@
 #include <linux/ftrace.h>
 #include <asm/set_memory.h>
 #include <asm/sections.h>
-#include <linux/uaccess.h>
 #include <asm/dis.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe);
-- 
2.7.4
