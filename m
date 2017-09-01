From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/3] KVM: s390: vsie: cleanup mcck reinjection
Date: Fri,  1 Sep 2017 09:46:48 +0200
Message-ID: <1504252008-102471-4-git-send-email-borntraeger@de.ibm.com>
References: <1504252008-102471-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1504252008-102471-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

The machine check information is part of the vsie_page.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170830160603.5452-4-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d471910..fbe46dd 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -809,8 +809,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
-	struct mcck_volatile_info *mcck_info;
-	struct sie_page *sie_page;
 	int rc;
 
 	handle_last_fault(vcpu, vsie_page);
@@ -834,9 +832,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	if (rc == -EINTR) {
 		VCPU_EVENT(vcpu, 3, "%s", "machine check");
-		sie_page = container_of(scb_s, struct sie_page, sie_block);
-		mcck_info = &sie_page->mcck_info;
-		kvm_s390_reinject_machine_check(vcpu, mcck_info);
+		kvm_s390_reinject_machine_check(vcpu, &vsie_page->mcck_info);
 		return 0;
 	}
 
-- 
2.7.4
