From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/20] KVM: s390: Zero out current VMDB of STSI before including level3 data.
Date: Fri,  6 Mar 2015 14:16:38 +0100
Message-ID: <1425647812-61838-7-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, stable@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>

s390 documentation requires words 0 and 10-15 to be reserved and stored as
zeros. As we fill out all other fields, we can memset the full structure.

Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 3511169..c7fee9d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -467,6 +467,7 @@ static void handle_stsi_3_2_2(struct kvm_vcpu *vcpu, struct sysinfo_3_2_2 *mem)
 	for (n = mem->count - 1; n > 0 ; n--)
 		memcpy(&mem->vm[n], &mem->vm[n - 1], sizeof(mem->vm[0]));
 
+	memset(&mem->vm[0], 0, sizeof(mem->vm[0]));
 	mem->vm[0].cpus_total = cpus;
 	mem->vm[0].cpus_configured = cpus;
 	mem->vm[0].cpus_standby = 0;
-- 
2.3.0
