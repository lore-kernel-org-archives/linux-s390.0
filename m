From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 21/23] KVM: s390: don't load kvm without virtualization support
Date: Wed,  2 Dec 2015 12:06:22 +0100
Message-ID: <1449054384-76374-22-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If we don't have support for virtualization (SIE), e.g. when running under
a hypervisor not supporting execution of the SIE instruction, we should
immediately abort loading the kvm module, as the SIE instruction cannot
be enabled dynamically.

Currently, the SIE instructions fails with an exception on a non-SIE
host, resulting in the guest making no progress, instead of failing hard.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 539d385..49d3319 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2859,6 +2859,11 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 
 static int __init kvm_s390_init(void)
 {
+	if (!sclp.has_sief2) {
+		pr_info("SIE not available\n");
+		return -ENODEV;
+	}
+
 	return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 }
 
-- 
2.3.0
