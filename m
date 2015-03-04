From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/5] KVM: s390/cpacf: Fix kernel bug under z/VM
Date: Wed,  4 Mar 2015 12:41:51 +0100
Message-ID: <1425469314-48913-3-git-send-email-borntraeger@de.ibm.com>
References: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Under z/VM PQAP might trigger an operation exception if no crypto cards
are defined via APVIRTUAL or APDEDICATED.

[  386.098666] Kernel BUG at 0000000000135c56 [verbose debug info unavailable]
[  386.098693] illegal operation: 0001 ilc:2 [#1] SMP
[...]
[  386.098751] Krnl PSW : 0704c00180000000 0000000000135c56 (kvm_s390_apxa_installed+0x46/0x98)
[...]
[  386.098804]  [<000000000013627c>] kvm_arch_init_vm+0x29c/0x358
[  386.098806]  [<000000000012d008>] kvm_dev_ioctl+0xc0/0x460
[  386.098809]  [<00000000002c639a>] do_vfs_ioctl+0x332/0x508
[  386.098811]  [<00000000002c660e>] SyS_ioctl+0x9e/0xb0
[  386.098814]  [<000000000070476a>] system_call+0xd6/0x258
[  386.098815]  [<000003fffc7400a2>] 0x3fffc7400a2

Lets add an extable entry and provide a zeroed config in that case.

Reported-by: Stefan Zimmermann <stzi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Tested-by: Stefan Zimmermann <stzi@linux.vnet.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b4d2030..18965f9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -778,15 +778,18 @@ long kvm_arch_vm_ioctl(struct file *filp,
 static int kvm_s390_query_ap_config(u8 *config)
 {
 	u32 fcn_code = 0x04000000UL;
-	u32 cc;
+	u32 cc = 0;
 
+	memset(config, 0, 128);
 	asm volatile(
 		"lgr 0,%1\n"
 		"lgr 2,%2\n"
 		".long 0xb2af0000\n"		/* PQAP(QCI) */
-		"ipm %0\n"
+		"0: ipm %0\n"
 		"srl %0,28\n"
-		: "=r" (cc)
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: "+r" (cc)
 		: "r" (fcn_code), "r" (config)
 		: "cc", "0", "2", "memory"
 	);
-- 
2.3.0
