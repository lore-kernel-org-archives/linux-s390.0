Return-Path: <SRS0=5+JM=T5=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] kvm: fix compile on s390 part 2
Date: Wed, 29 May 2019 14:50:44 +0200
In-Reply-To: <20190529125045.42935-1-borntraeger@de.ibm.com>
References: <20190529125045.42935-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190529125045.42935-2-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

We also need to fence the memunmap part.

Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
Fixes: d30b214d1d0a (kvm: fix compilation on s390)
Cc: Michal Kubecek <mkubecek@suse.cz>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 virt/kvm/kvm_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 134ec0283a8a..301089a462c4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1795,8 +1795,10 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map,
 
 	if (map->page)
 		kunmap(map->page);
+#ifdef CONFIG_HAS_IOMEM
 	else
 		memunmap(map->hva);
+#endif
 
 	if (dirty) {
 		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
-- 
2.21.0
