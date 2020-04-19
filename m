Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] KVM: X86: Fix compile error in svm/sev.c
Date: Sun, 19 Apr 2020 15:30:47 +0800
Message-Id: <20200419073047.14413-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com

The compiler reported the following compilation errors:

arch/x86/kvm/svm/sev.c: In function ‘sev_pin_memory’:
arch/x86/kvm/svm/sev.c:361:3: error: implicit declaration of function
‘release_pages’ [-Werror=implicit-function-declaration]
   release_pages(pages, npinned);
   ^~~~~~~~~~~~~

The reason is that the 'pagemap.h' header file is not included.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/x86/kvm/svm/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0e3fc311d7da..3ef99e87c1db 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -13,6 +13,7 @@
 #include <linux/highmem.h>
 #include <linux/psp-sev.h>
 #include <linux/swap.h>
+#include <linux/pagemap.h>
 
 #include "x86.h"
 #include "svm.h"
-- 
2.17.1
