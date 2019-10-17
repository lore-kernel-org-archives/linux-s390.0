Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408396AbfJQI73 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Oct 2019 04:59:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H8vA7X062637
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 04:59:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vpmvfrtt1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 04:59:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 17 Oct 2019 09:59:24 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] scripts/gdb: fix debugging modules on s390
Date: Thu, 17 Oct 2019 10:59:17 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191017085917.81791-1-iii@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>

Currently lx-symbols assumes that module text is always located at
module->core_layout->base, but s390 uses the following layout:

+------+  <- module->core_layout->base
| GOT  |
+------+  <- module->core_layout->base + module->arch->plt_offset
| PLT  |
+------+  <- module->core_layout->base + module->arch->plt_offset +
| TEXT |     module->arch->plt_size
+------+

Therefore, when trying to debug modules on s390, all the symbol
addresses are skewed by plt_offset + plt_size.

Fix by adding plt_offset + plt_size to module_addr in
load_module_symbols().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1 -> v2: print the adjusted address.

 scripts/gdb/linux/symbols.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index f0d8f2ecfde7..df4c810de663 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -15,7 +15,7 @@ import gdb
 import os
 import re
 
-from linux import modules
+from linux import modules, utils
 
 
 if hasattr(gdb, 'Breakpoint'):
@@ -111,6 +111,12 @@ lx-symbols command."""
             module_file = self._get_module_file(module_name)
 
         if module_file:
+            if utils.is_target_arch('s390'):
+                # Module text is preceded by PLT stubs on s390.
+                module_arch = module['arch']
+                plt_offset = int(module_arch['plt_offset'])
+                plt_size = int(module_arch['plt_size'])
+                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
             gdb.write("loading @{addr}: {filename}\n".format(
                 addr=module_addr, filename=module_file))
             cmdline = "add-symbol-file {filename} {addr}{sections}".format(
-- 
2.23.0
