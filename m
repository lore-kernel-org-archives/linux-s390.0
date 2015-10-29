From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/3] KVM: s390: SCA must not cross page boundaries
Date: Thu, 29 Oct 2015 16:08:27 +0100
Message-ID: <1446131309-176770-2-git-send-email-borntraeger@de.ibm.com>
References: <1446131309-176770-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1446131309-176770-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, v3.15+@tuxmaker.boeblingen.de.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We seemed to have missed a few corner cases in commit f6c137ff00a4
("KVM: s390: randomize sca address").

The SCA has a maximum size of 2112 bytes. By setting the sca_offset to
some unlucky numbers, we exceed the page.

0x7c0 (1984) -> Fits exactly
0x7d0 (2000) -> 16 bytes out
0x7e0 (2016) -> 32 bytes out
0x7f0 (2032) -> 48 bytes out

One VCPU entry is 32 bytes long.

For the last two cases, we actually write data to the other page.
1. The address of the VCPU.
2. Injection/delivery/clearing of SIGP externall calls via SIGP IF.

Especially the 2. happens regularly. So this could produce two problems:
1. The guest losing/getting external calls.
2. Random memory overwrites in the host.

So this problem happens on every 127 + 128 created VM with 64 VCPUs.

Cc: stable@vger.kernel.org # v3.15+
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 618c854..3559617 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1098,7 +1098,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (!kvm->arch.sca)
 		goto out_err;
 	spin_lock(&kvm_lock);
-	sca_offset = (sca_offset + 16) & 0x7f0;
+	sca_offset += 16;
+	if (sca_offset + sizeof(struct sca_block) > PAGE_SIZE)
+		sca_offset = 0;
 	kvm->arch.sca = (struct sca_block *) ((char *) kvm->arch.sca + sca_offset);
 	spin_unlock(&kvm_lock);
 
-- 
2.4.3
