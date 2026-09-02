Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560B390609;
	Wed,  2 Sep 2026 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329735; cv=none; b=tAujlfnNYWhqLali2/sfXvgeVZPnjNcJldg6oZ26pX9h9jrhszdWYZ2nrRFPlxGYTQgk9fpnXIF2AJ6WtFLmwwWu4sqaCP+Z5vaVnWdlZCPeyhoFBDxyyss9CjN1FfF4ZPmwPUYrF+IjxOuPWQddWo63wCXOMV9MvlvraAMoJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329735; c=relaxed/simple;
	bh=8U95+oHeCA/rmJkgUT/fvmjP+gRFb78XsoMfKDHsIVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OoDPb2UtwDnjI+cC93yHObrpewl47ysmr71lvgV4w+KPFFn4+byjd669L2ir1lbqIA3CN3bjyq07T3M9jsKCIZTct/qE/g3jg5I/kWD7NkV+0vYV+p+4z7te2WBoHV2vAQcN69wnyBj//dbZdX2stIZpnyGj9Pg3IPGkDePjg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyCC6K3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyCC6K3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38201F00A3A;
	Wed,  2 Sep 2026 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788329733;
	bh=rZDmOJa3lKJg3q4J0vxXiCwo1usJZY0dSBwZL2xaIK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RyCC6K3+yoBVj6HOL+jhCmJspI1rOOtMlmlJ09dU7HJTzqEQmvW2aI/S1sfTHPfj6
	 ZHYdLXxvZEV213yRt6hcyicUWOkk/fmtKZ2RbcigWIVDgqKvgU4dQNyaPa3tdhRynn
	 UmyYgIsw6J0sWUvzPkXwjZYh+twK/i+vDC+6T4STp0EIiC0Lknuutak3P8VrbsKjOT
	 9jh7aG7AnlP2sL5unVXGeaY3Dzug0feoyhj1sILuc+230lbhU7aXqxUVJGiXrHlVt2
	 nsi5FDvTfJt+DSOgof/YYHzGjA6EsF0FFHUoTrVFeq7ELA2DJhEqGbMzj/f0c2ZSy4
	 nk9//iAEyiEjQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 02 Sep 2026 09:15:13 +0300
Subject: [PATCH 1/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for the STHYI buffer
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-s390-kvm-v1-1-3bc0986550b1@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
In-Reply-To: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
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

handle_sthyi() allocates the buffer that receives the STHYI response
block before it is copied to the guest.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/kvm/s390/intercept.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/s390/intercept.c b/arch/s390/kvm/s390/intercept.c
index ca1205dfac8b0..aaf9828d1f44d 100644
--- a/arch/s390/kvm/s390/intercept.c
+++ b/arch/s390/kvm/s390/intercept.c
@@ -11,6 +11,7 @@
 #include <linux/kvm_host.h>
 #include <linux/errno.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/irq.h>
@@ -438,13 +439,13 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 	if (!kvm_s390_pv_cpu_is_protected(vcpu) && (addr & ~PAGE_MASK))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	sctns = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	sctns = kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
 	if (!sctns)
 		return -ENOMEM;
 
 	cc = sthyi_fill(sctns, &rc);
 	if (cc < 0) {
-		free_page((unsigned long)sctns);
+		kfree(sctns);
 		return cc;
 	}
 out:
@@ -454,13 +455,13 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 		} else {
 			r = write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
 			if (r) {
-				free_page((unsigned long)sctns);
+				kfree(sctns);
 				return kvm_s390_inject_prog_cond(vcpu, r);
 			}
 		}
 	}
 
-	free_page((unsigned long)sctns);
+	kfree(sctns);
 	vcpu->run->s.regs.gprs[reg2 + 1] = rc;
 	kvm_s390_set_psw_cc(vcpu, cc);
 	return r;

-- 
2.53.0

