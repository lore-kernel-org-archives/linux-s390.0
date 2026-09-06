Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE93C73C1;
	Sun,  6 Sep 2026 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683251; cv=none; b=K6cArgpYLan3NJyoeq4PgS+E9H0MJg7W/zzWBfG1UqC+7TJrKrH2Tkd2gYal1DHlYJfme6t+7NyzhsXSVL8wVKuz1KsH8zla5onoSquWtDVUpwcguVMWkRjCHO99JUEDfqawsXrvNGiQA04Q8dUOKivYYd/7tmmL06T8TUR1tjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683251; c=relaxed/simple;
	bh=KjSvS6cVarz2EGcjO+qgUC/Z3Ug9TAUlDU9fkjFomJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okUgZDcatrCMLR6+qB+4aztj4roGFIcNhS6asVRHauW1Qse1/sPXCBzI/0gAxdoHfetq9EDkD47sQ1UOApksPtGsu5xERD3YyM/SCQQK0u6bKVczWCTiEAUYKD+bikdt+IJ7Xeq15W+PXCyJ6L47sKoq/gGbENfTFZpuXSLllKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcR5c2yr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcR5c2yr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361E51F00A3A;
	Sun,  6 Sep 2026 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788683250;
	bh=YsA6hNpdDuoXhmxFeC3uv8uIXxR1ksQ/iBUtdB1feUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AcR5c2yr8yOxaqMU6PZEBu6m02H8NVpIdqeHBB2EFX2dbaMH3nSarLvRXgeWGBiM7
	 MIeq9DCB9ddMgZ9WeZwLv9n9Y20tR0MzTXQj27Hwib1mXac85h8xBvnuyCvHWezux2
	 JIfpisVjB0kWI3S0X3DZ9SuUMtd+02l8kekxpIcWiS19ONEN8aUAy+NihFDQo50gZq
	 53+02iM0MXsyxPvBUALso3DG9nZBiUHyTVdEGOXM0u10Vm8Kaf7ONJfjE+tVA10+dk
	 78/QrcPBTu8wyNMeh/0ockC9hYKzU2A2vYBSNZhg9kITxws6XQw3NY2P6WmueaV82Z
	 hfqq6KEYyZXHA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 06 Sep 2026 11:27:10 +0300
Subject: [PATCH v2 2/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for the STSI buffer
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-s390-kvm-v2-2-2cf6434e6646@kernel.org>
References: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
In-Reply-To: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.17-dev

handle_stsi() allocates the buffer that receives the STSI response block
before it is copied to the guest.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

While on it, make the buffer a void pointer to get rid of the casts.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/kvm/s390/priv.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index b3cb2c2c3aa71..856939acf012f 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -14,6 +14,7 @@
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 #include <asm/asm-offsets.h>
 #include <asm/facility.h>
 #include <asm/current.h>
@@ -869,7 +870,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	int fc = (vcpu->run->s.regs.gprs[0] & 0xf0000000) >> 28;
 	int sel1 = vcpu->run->s.regs.gprs[0] & 0xff;
 	int sel2 = vcpu->run->s.regs.gprs[1] & 0xffff;
-	unsigned long mem = 0;
+	void *mem = NULL;
 	u64 operand2;
 	int rc = 0;
 	u8 ar;
@@ -911,19 +912,19 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	switch (fc) {
 	case 1: /* same handling for 1 and 2 */
 	case 2:
-		mem = get_zeroed_page(GFP_KERNEL_ACCOUNT);
+		mem = kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
 		if (!mem)
 			goto out_no_data;
-		if (stsi((void *) mem, fc, sel1, sel2))
+		if (stsi(mem, fc, sel1, sel2))
 			goto out_no_data;
 		break;
 	case 3:
 		if (sel1 != 2 || sel2 != 2)
 			goto out_no_data;
-		mem = get_zeroed_page(GFP_KERNEL_ACCOUNT);
+		mem = kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
 		if (!mem)
 			goto out_no_data;
-		handle_stsi_3_2_2(vcpu, (void *) mem);
+		handle_stsi_3_2_2(vcpu, mem);
 		break;
 	case 15: /* fc 15 is fully handled in userspace */
 		insert_stsi_usr_data(vcpu, operand2, ar, fc, sel1, sel2);
@@ -931,10 +932,10 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		return -EREMOTE;
 	}
 	if (kvm_s390_pv_cpu_is_protected(vcpu)) {
-		memcpy(sida_addr(vcpu->arch.sie_block), (void *)mem, PAGE_SIZE);
+		memcpy(sida_addr(vcpu->arch.sie_block), mem, PAGE_SIZE);
 		rc = 0;
 	} else {
-		rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
+		rc = write_guest(vcpu, operand2, ar, mem, PAGE_SIZE);
 	}
 	if (rc) {
 		rc = kvm_s390_inject_prog_cond(vcpu, rc);
@@ -945,14 +946,14 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		rc = -EREMOTE;
 	}
 	trace_kvm_s390_handle_stsi(vcpu, fc, sel1, sel2, operand2);
-	free_page(mem);
+	kfree(mem);
 	kvm_s390_set_psw_cc(vcpu, 0);
 	vcpu->run->s.regs.gprs[0] = 0;
 	return rc;
 out_no_data:
 	kvm_s390_set_psw_cc(vcpu, 3);
 out:
-	free_page(mem);
+	kfree(mem);
 	return rc;
 }
 

-- 
2.53.0

