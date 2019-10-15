Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfJOKxY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 06:53:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9FAqL3F056865
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 06:53:23 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnc5j983t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 06:53:22 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 15 Oct 2019 11:53:19 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] scripts/gdb: fix debugging modules on s390
Date: Tue, 15 Oct 2019 12:53:13 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191015105313.12663-1-iii@linux.ibm.com>
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
 scripts/gdb/linux/symbols.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index f0d8f2ecfde7..41c6d1a55b03 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -15,7 +15,7 @@ import gdb
 import os
 import re
 
-from linux import modules
+from linux import modules, utils
 
 
 if hasattr(gdb, 'Breakpoint'):
@@ -113,6 +113,12 @@ lx-symbols command."""
         if module_file:
             gdb.write("loading @{addr}: {filename}\n".format(
                 addr=module_addr, filename=module_file))
+            if utils.is_target_arch('s390'):
+                # Module text is preceded by PLT stubs on s390.
+                module_arch = module['arch']
+                plt_offset = int(module_arch['plt_offset'])
+                plt_size = int(module_arch['plt_size'])
+                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
             cmdline = "add-symbol-file {filename} {addr}{sections}".format(
                 filename=module_file,
                 addr=module_addr,
-- 
2.23.0
