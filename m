Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D9C42123A;
	Sun,  6 Sep 2026 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683248; cv=none; b=gacqKEQox47PR4AZLjEkQaY83NeamVvknW5dCGrWcfI7hCcSeerTjMrK9njYmLUeXGGQuvp+SulBmFv9qNi1yy0BPuylz/f4HpQRGoKkOFeObwK+Sv3jVtdlfrBNTQZ7tC0mCkNQUQ99B8X5KBO0MRXycXxXsFPdFNk8x28JjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683248; c=relaxed/simple;
	bh=sU/e0fY+v3yOZepe/bQAZAzN6JHKQnyoIpSt9leu59g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddrE/hRKodSm2vekhpyCcMM3Nf3OX1D9bQGEX8fNCDXTuLuL4LsfRTIsRMEhMWMYbka/BK+99zK2pxXaSt5hKl0o5dDI+n1lYYXikVodvIfJHvOQ9NbWJ3NctOEFeuRAIEIjDav41zb+cFPgYpA5EJplWNNo16Rg/eWrpuaU8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9xOmBhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9xOmBhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B3C1F00A3E;
	Sun,  6 Sep 2026 08:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788683246;
	bh=+/DLks/ODhSSfW/GITBux87qvqpTH/gxUu8xFDYHwLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B9xOmBhf5s1dNs5ihOaIRxoyVrbv3vnNPdqW1m1NfKoTMp2VCm129J6VEykH+qPZy
	 TYo/4xEBX69W2vMkcM/8fu+tw+R4A9OS3OLvpBmVySnAEgusWdb85ZFx7idRl6qYmv
	 8iElq7IoQW46OE+TTLDuiloZmzhPMfm8DuRYIOkdyCVw0R9QiAaKQUVYyOOe2fdaKv
	 lcJpzhvsJdNb52UKsz6NgKjJsBFqv5aA3FMT+9lqSulnkIrpwNf9N7FzssS3icUuFR
	 vh5/spbemJxViWOplTH8NDh4Mc/rX3ETRLyXT1/ulYvl/lKJ4LgwU9W42ROUFOxjn3
	 Sdp2QgxR9wNnA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 06 Sep 2026 11:27:09 +0300
Subject: [PATCH v2 1/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for the STHYI buffer
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-s390-kvm-v2-1-2cf6434e6646@kernel.org>
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

The only goto in that function does not unwind anything, it merely skips
to the exit when the function code is invalid. Turn it into an early
return so that the buffer can be freed with __free(kfree).

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/kvm/s390/intercept.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/s390/intercept.c b/arch/s390/kvm/s390/intercept.c
index ca1205dfac8b0..f7ad111f259c9 100644
--- a/arch/s390/kvm/s390/intercept.c
+++ b/arch/s390/kvm/s390/intercept.c
@@ -11,6 +11,8 @@
 #include <linux/kvm_host.h>
 #include <linux/errno.h>
 #include <linux/pagemap.h>
+#include <linux/cleanup.h>
+#include <linux/slab.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/irq.h>
@@ -411,9 +413,9 @@ static int handle_partial_execution(struct kvm_vcpu *vcpu)
  */
 int handle_sthyi(struct kvm_vcpu *vcpu)
 {
+	struct sthyi_sctns *sctns __free(kfree) = NULL;
 	int reg1, reg2, cc = 0, r = 0;
 	u64 code, addr, rc = 0;
-	struct sthyi_sctns *sctns = NULL;
 
 	if (!test_kvm_facility(vcpu->kvm, 74))
 		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
@@ -430,37 +432,32 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	if (code & 0xffff) {
-		cc = 3;
-		rc = 4;
-		goto out;
+		vcpu->run->s.regs.gprs[reg2 + 1] = 4;
+		kvm_s390_set_psw_cc(vcpu, 3);
+		return 0;
 	}
 
 	if (!kvm_s390_pv_cpu_is_protected(vcpu) && (addr & ~PAGE_MASK))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	sctns = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	sctns = kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
 	if (!sctns)
 		return -ENOMEM;
 
 	cc = sthyi_fill(sctns, &rc);
-	if (cc < 0) {
-		free_page((unsigned long)sctns);
+	if (cc < 0)
 		return cc;
-	}
-out:
+
 	if (!cc) {
 		if (kvm_s390_pv_cpu_is_protected(vcpu)) {
 			memcpy(sida_addr(vcpu->arch.sie_block), sctns, PAGE_SIZE);
 		} else {
 			r = write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
-			if (r) {
-				free_page((unsigned long)sctns);
+			if (r)
 				return kvm_s390_inject_prog_cond(vcpu, r);
-			}
 		}
 	}
 
-	free_page((unsigned long)sctns);
 	vcpu->run->s.regs.gprs[reg2 + 1] = rc;
 	kvm_s390_set_psw_cc(vcpu, cc);
 	return r;

-- 
2.53.0

