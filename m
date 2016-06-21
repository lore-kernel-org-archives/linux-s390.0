From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 49/51] KVM: s390: vsie: correctly set and handle guest TOD
Date: Tue, 21 Jun 2016 15:13:27 +0200
Message-ID: <1466514809-146638-50-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Guest 2 sets up the epoch of guest 3 from his point of view. Therefore,
we have to add the guest 2 epoch to the guest 3 epoch. We also have to take
care of guest 2 epoch changes on STP syncs. This will work just fine by
also updating the guest 3 epoch when a vsie_block has been set for a VCPU.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 arch/s390/kvm/vsie.c     | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8ba7a98..6fdf1f7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -176,6 +176,8 @@ static int kvm_clock_sync(struct notifier_block *notifier, unsigned long val,
 			vcpu->arch.sie_block->epoch -= *delta;
 			if (vcpu->arch.cputm_enabled)
 				vcpu->arch.cputm_start += *delta;
+			if (vcpu->arch.vsie_block)
+				vcpu->arch.vsie_block->epoch -= *delta;
 		}
 	}
 	return NOTIFY_OK;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 90781ba..6895e7b 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -843,12 +843,21 @@ static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
 static void register_shadow_scb(struct kvm_vcpu *vcpu,
 				struct vsie_page *vsie_page)
 {
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+
 	WRITE_ONCE(vcpu->arch.vsie_block, &vsie_page->scb_s);
 	/*
 	 * External calls have to lead to a kick of the vcpu and
 	 * therefore the vsie -> Simulate Wait state.
 	 */
 	atomic_or(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
+	/*
+	 * We have to adjust the g3 epoch by the g2 epoch. The epoch will
+	 * automatically be adjusted on tod clock changes via kvm_sync_clock.
+	 */
+	preempt_disable();
+	scb_s->epoch += vcpu->kvm->arch.epoch;
+	preempt_enable();
 }
 
 /*
-- 
2.5.5
