From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/9] KVM: s390: optimize round trip time in request handling
Date: Mon, 11 May 2015 10:44:30 +0200
Message-ID: <1431333877-28700-3-git-send-email-borntraeger@de.ibm.com>
References: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The fast path for a sie exit is that no kvm reqest is pending.
Make an early check to skip all single bit checks.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8cd8e7b..f5282e6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1720,6 +1720,8 @@ static bool ibs_enabled(struct kvm_vcpu *vcpu)
 
 static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 {
+	if (!vcpu->requests)
+		return 0;
 retry:
 	s390_vcpu_unblock(vcpu);
 	/*
-- 
2.3.0
