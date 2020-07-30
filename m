Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47508 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729532AbgG3JtJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 05:49:09 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] s390/setup: diag 318: refactor struct
Date: Thu, 30 Jul 2020 11:48:56 +0200
Message-Id: <20200730094857.175501-2-borntraeger@de.ibm.com>
In-Reply-To: <20200730094857.175501-1-borntraeger@de.ibm.com>
References: <20200730094857.175501-1-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

From: Collin Walling <walling@linux.ibm.com>

The diag 318 struct introduced in include/asm/diag.h can be
reused in KVM, so let's condense the version code fields in the
diag318_info struct for easier usage and simplify it until we
can determine how the data should be formatted.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Link: https://lore.kernel.org/r/20200622154636.5499-2-walling@linux.ibm.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/diag.h | 6 ++----
 arch/s390/kernel/setup.c     | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 0036eab14391..ca8f85b53a90 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -298,10 +298,8 @@ struct diag26c_mac_resp {
 union diag318_info {
 	unsigned long val;
 	struct {
-		unsigned int cpnc : 8;
-		unsigned int cpvc_linux : 24;
-		unsigned char cpvc_distro[3];
-		unsigned char zero;
+		unsigned long cpnc : 8;
+		unsigned long cpvc : 56;
 	};
 };
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 5853c9872dfe..878cacfc9c3e 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1021,8 +1021,7 @@ static void __init setup_control_program_code(void)
 {
 	union diag318_info diag318_info = {
 		.cpnc = CPNC_LINUX,
-		.cpvc_linux = 0,
-		.cpvc_distro = {0},
+		.cpvc = 0,
 	};
 
 	if (!sclp.has_diag318)
-- 
2.25.4
