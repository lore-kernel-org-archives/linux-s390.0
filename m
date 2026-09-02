Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9D386C3D;
	Wed,  2 Sep 2026 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329743; cv=none; b=pN90J5kFb+XKd2bGrWD5SNpLGPFugPNJlCyJGEzXJG3Sgy6/6V22m2HsyomJmwUgPbV449JEDWwi8BUoZ6tQ5edvQrVbSRLjVX1LlxSXx65OikHJQThplTbnYnsd0PK5LflBK5dWyQfOVzrToG6JGiLr/7dGX/vkEBzGn1sd2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329743; c=relaxed/simple;
	bh=3Kxvl3vX0xOruGJqXO47tS1ILmPa2NLsdEexPXqkiRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4GwghO/Lmq8dmWmxinraCHGyrniZKLmXb2aXiV3sbHSiLv+0UKA0GsKXkCVEuq6RpDRdSMKwBu1da7Jndy50nrXuVXPFKov6uEKf8CPqWIVuL66a/jbQiKsMBJBCQ434vd6o9eU/DYlkL3Rhs6YFPrn9nbo12Y5CwioGjej6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G85a2JdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G85a2JdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17D11F00A3A;
	Wed,  2 Sep 2026 06:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788329741;
	bh=JMHG+THezrVqv+LxM1LlqqUzwwh90wkGAEXs+OQ+QKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G85a2JdOCh9i7kPV4oxSIFO3tRpnuXjL1+Hkbcz/GdOjbU+cATqvnUEkvo+HovQFS
	 mDAzWVrbtoC2INqMSDc5cVraa5h+T8JwuKw8CFCVCv4kC99pg5ZSdTINyqVGt7mO8T
	 vpktFiYmdzQe6eB+Ea7sfDCe1iPmcTKYvXmQ/EvrslTcD3T5Y7o5ZdCJmAXOPR5nTz
	 PAGU1hcL9SqAe6Fkit46TtmSyAZOG6CbPSDHIwih9DekxMjW2G+sf4bHSDG85j1cI8
	 MGqs2jB1aBYz995A+yEML7RoaZgubgy92NM7kGvNO9htDihdnaOyYpoNzZVlqfRlLq
	 h3DYFXRms4igQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 02 Sep 2026 09:15:15 +0300
Subject: [PATCH 3/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for the GIB
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-s390-kvm-v1-3-3bc0986550b1@kernel.org>
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

kvm_s390_gib_init() allocates the guest information block (GIB). The GIB
is passed to the hardware as a physical address and must be page aligned.

kmalloc() guarantees that a power of two sized allocation is aligned to
its size, so a PAGE_SIZE allocation is page aligned as well.

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
 arch/s390/kvm/s390/interrupt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrupt.c
index 0381ae9817035..02065fb8d053e 100644
--- a/arch/s390/kvm/s390/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -3689,7 +3689,7 @@ void kvm_s390_gib_destroy(void)
 	}
 	chsc_sgib(0);
 	unregister_adapter_interrupt(&gib_alert_irq);
-	free_page((unsigned long)gib);
+	kfree(gib);
 	gib = NULL;
 }
 
@@ -3703,7 +3703,7 @@ int __init kvm_s390_gib_init(u8 nisc)
 		goto out;
 	}
 
-	gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL_ACCOUNT | GFP_DMA);
+	gib = kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT | GFP_DMA);
 	if (!gib) {
 		rc = -ENOMEM;
 		goto out;
@@ -3722,7 +3722,7 @@ int __init kvm_s390_gib_init(u8 nisc)
 	gib_origin = virt_to_phys(gib);
 	if (chsc_sgib(gib_origin)) {
 		pr_err("Associating the GIB with the AIV facility failed\n");
-		free_page((unsigned long)gib);
+		kfree(gib);
 		gib = NULL;
 		rc = -EIO;
 		goto out_unreg_gal;
@@ -3742,7 +3742,7 @@ int __init kvm_s390_gib_init(u8 nisc)
 out_unreg_gal:
 	unregister_adapter_interrupt(&gib_alert_irq);
 out_free_gib:
-	free_page((unsigned long)gib);
+	kfree(gib);
 	gib = NULL;
 out:
 	return rc;

-- 
2.53.0

