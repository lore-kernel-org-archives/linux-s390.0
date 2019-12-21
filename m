Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41822 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLUGO3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 21 Dec 2019 01:14:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so6040195pgk.8
        for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2019 22:14:29 -0800 (PST)
From: maholova <maholova.wda@gmail.com>
Subject: [PATCH] s390: IEEE FPU emulation error in Kernel-3.16.y
Date: Sat, 21 Dec 2019 15:12:54 +0900
Message-Id: <20191221061253.31997-1-maholova.wda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, maholova <maholova.wda@gmail.com>

Signed-off-by: maholova <maholova.wda@gmail.com>
---
 arch/s390/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index c5762324d9ee..fda8b571466e 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -19,6 +19,8 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include "entry.h"
+#include <asm/mathemu.h>
+
 
 int show_unhandled_signals = 1;
 
-- 
2.20.1
