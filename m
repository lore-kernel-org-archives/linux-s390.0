Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727429AbgBXLlR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 06:41:17 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v4 20/36] KVM: s390/mm: handle guest unpin events
Date: Mon, 24 Feb 2020 06:40:51 -0500
Message-Id: <20200224114107.4646-21-borntraeger@de.ibm.com>
In-Reply-To: <20200224114107.4646-1-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

The current code tries to first pin shared pages, if that fails (e.g.
because the page is not shared) it will export them. For shared pages
this means that we get a new intercept telling us that the guest is
unsharing that page. We will make the page secure at that point in time
and revoke the host access. This is synchronized with other host events,
e.g. the code will wait until host I/O has finished.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index b6b7d4b0e26c..c06599939541 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -16,6 +16,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/irq.h>
 #include <asm/sysinfo.h>
+#include <asm/uv.h>
 
 #include "kvm-s390.h"
 #include "gaccess.h"
@@ -484,12 +485,35 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int handle_pv_uvc(struct kvm_vcpu *vcpu)
+{
+	struct uv_cb_share *guest_uvcb = (void *)vcpu->arch.sie_block->sidad;
+	struct uv_cb_cts uvcb = {
+		.header.cmd	= UVC_CMD_UNPIN_PAGE_SHARED,
+		.header.len	= sizeof(uvcb),
+		.guest_handle	= kvm_s390_pv_get_handle(vcpu->kvm),
+		.gaddr		= guest_uvcb->paddr,
+	};
+	int rc;
+
+	if (guest_uvcb->header.cmd != UVC_CMD_REMOVE_SHARED_ACCESS) {
+		WARN_ONCE(1, "Unexpected UVC 0x%x!\n", guest_uvcb->header.cmd);
+		return 0;
+	}
+	rc = gmap_make_secure(vcpu->arch.gmap, uvcb.gaddr, &uvcb);
+	if (rc == -EINVAL)
+		return 0;
+	return rc;
+}
+
 static int handle_pv_notification(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.sie_block->ipa == 0xb210)
 		return handle_pv_spx(vcpu);
 	if (vcpu->arch.sie_block->ipa == 0xb220)
 		return handle_pv_sclp(vcpu);
+	if (vcpu->arch.sie_block->ipa == 0xb9a4)
+		return handle_pv_uvc(vcpu);
 
 	return handle_instruction(vcpu);
 }
-- 
2.25.0
