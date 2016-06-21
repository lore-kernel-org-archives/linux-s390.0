From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 31/51] KVM: s390: vsie: support edat1 / edat2
Date: Tue, 21 Jun 2016 15:13:09 +0200
Message-ID: <1466514809-146638-32-git-send-email-borntraeger@de.ibm.com>
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

If guest 2 is allowed to use edat 1 / edat 2, it can also set it up for
guest 3, so let's properly check and forward the edat cpuflags.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 1165baf..7c9835b 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -97,6 +97,13 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	/* intervention requests will be set later */
 	newflags = CPUSTAT_ZARCH;
+	if (cpuflags & CPUSTAT_GED && test_kvm_facility(vcpu->kvm, 8))
+		newflags |= CPUSTAT_GED;
+	if (cpuflags & CPUSTAT_GED2 && test_kvm_facility(vcpu->kvm, 78)) {
+		if (cpuflags & CPUSTAT_GED)
+			return set_validity_icpt(scb_s, 0x0001U);
+		newflags |= CPUSTAT_GED2;
+	}
 
 	atomic_set(&scb_s->cpuflags, newflags);
 	return 0;
-- 
2.5.5
