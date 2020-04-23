Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727071AbgDWMBW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 08:01:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NB2diu021650
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 08:01:22 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30k7rkwm2j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 08:01:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 23 Apr 2020 13:01:14 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 1/1] s390/protvirt: fix compilation issue
Date: Thu, 23 Apr 2020 14:01:14 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, gor@linux.ibm.com, cohuck@redhat.com, david@redhat.com, kbuild test robot <lkp@intel.com>, Philipp Rudo <prudo@linux.ibm.com>

The kernel fails to compile with CONFIG_PROTECTED_VIRTUALIZATION_GUEST
set but CONFIG_KVM unset.

This patch fixes the issue by making the needed variable always available.

Fixes: a0f60f8431999bf5 ("s390/protvirt: Add sysfs firmware interface for Ultravisor information")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Philipp Rudo <prudo@linux.ibm.com>
Suggested-by: Philipp Rudo <prudo@linux.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/boot/uv.c   | 2 --
 arch/s390/kernel/uv.c | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index 8fde561f1d07..f887a479cdc7 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -7,9 +7,7 @@
 #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
 int __bootdata_preserved(prot_virt_guest);
 #endif
-#if IS_ENABLED(CONFIG_KVM)
 struct uv_info __bootdata_preserved(uv_info);
-#endif
 
 void uv_query_info(void)
 {
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index c86d654351d1..4c0677fc8904 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -23,10 +23,11 @@
 int __bootdata_preserved(prot_virt_guest);
 #endif
 
+struct uv_info __bootdata_preserved(uv_info);
+
 #if IS_ENABLED(CONFIG_KVM)
 int prot_virt_host;
 EXPORT_SYMBOL(prot_virt_host);
-struct uv_info __bootdata_preserved(uv_info);
 EXPORT_SYMBOL(uv_info);
 
 static int __init prot_virt_setup(char *val)
-- 
2.25.3
