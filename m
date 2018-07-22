Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sun, 22 Jul 2018 19:11:09 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] arch/s390: Use new return type vm_fault_t
Message-ID: <20180722134109.GA31840@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: willy@infradead.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org, keescook@chromium.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
List-ID: <linux-s390.vger.kernel.org>

use new return type vm_fault_t for fault handler vdso_fault.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/s390/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 09abae4..3031cc6 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -47,7 +47,7 @@
  */
 unsigned int __read_mostly vdso_enabled = 1;
 
-static int vdso_fault(const struct vm_special_mapping *sm,
+static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	struct page **vdso_pagelist;
-- 
1.9.1
