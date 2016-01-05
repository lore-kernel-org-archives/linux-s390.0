From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] kvm/s390: drop unpaired smp_mb
Date: Tue, 5 Jan 2016 18:20:24 +0200
Message-ID: <1452010811-25486-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

smp_mb on vcpu destroy isn't paired with anything, violating pairing
rules, and seems to be useless.

Drop it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Untested.

 arch/s390/kvm/kvm-s390.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8465892..7305d2c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1195,7 +1195,6 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 		    (__u64) vcpu->arch.sie_block)
 			vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sda = 0;
 	}
-	smp_mb();
 
 	if (kvm_is_ucontrol(vcpu->kvm))
 		gmap_free(vcpu->arch.gmap);
-- 
MST
