Return-Path: <SRS0=qujA=TB=vger.kernel.org=kvm-owner@kernel.org>
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v4 1/2] s390/setup: diag318: refactor struct
Date: Wed,  1 May 2019 18:51:02 -0400
In-Reply-To: <1556751063-21835-1-git-send-email-walling@linux.ibm.com>
References: <1556751063-21835-1-git-send-email-walling@linux.ibm.com>
Message-Id: <1556751063-21835-2-git-send-email-walling@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: cohuck@redhat.com, david@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The diag318 struct introduced in include/asm/diag.h can be
reused in KVM, so let's condense the version code fields in the
diag318_info struct for easier usage and simplify it until we
can determine how the data should be formatted.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 arch/s390/include/asm/diag.h | 6 ++----
 arch/s390/kernel/setup.c     | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 19562be..2155162 100644
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
index 2c642af..cb88062 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1011,8 +1011,7 @@ static void __init setup_control_program_code(void)
 {
 	union diag318_info diag318_info = {
 		.cpnc = CPNC_LINUX,
-		.cpvc_linux = 0,
-		.cpvc_distro = {0},
+		.cpvc = 0,
 	};
 
 	if (!sclp.has_diag318)
-- 
2.7.4
