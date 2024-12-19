Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFE227BA3
	for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625383; cv=none; b=LNYgIP9YuvkGwbOMbdNtiWwa6OXPwUQlbwi7VgPjODaSlYJvgXtF4S4pKffWDUZBVvAmuUyqpta17zTqBOLMEpf5deLwIcmHLvObPEqoSmAKh9/r0dcIwv97DXH8Y4q8lgPRz465QLTYZN2bLuqAreeqOW5tpgz4uPq2aA+lmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625383; c=relaxed/simple;
	bh=RscznQ+6VC0sXZEoyTSpnyDgC41djSdPpp5qp9e/MXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4jU1GbBzjzdD/DAnr+K6Rf7BscE8DtU1mXfLD9yHLSub4Cn6wIqZznY6ezPcoLGtdY8SW2ggfMOWznZG7YmH90D3R1z9N2iYnNhbDYASc01oRIyT2Sy+PgXCei0zZi4f9m9YC2+KJpl+hV0VYGZLOGksdONHuN+0zSlucyF24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PPsTMJ/B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PPsTMJ/B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=O7XYqGGLGp/IKnTrXx+UwDKU51QHYdhcYEERHhuMXew=; b=PPsTMJ/BWB4POeS+3ZcO9ryAJ/
	0jyOiaNXcZnahPQUZt/GrYjHnZqfKk50A+fVG/tdfDSvkpJBcnBpUIG84JV5Xx2YbP8s7gA7fWoUs
	JRyB+lKM+G09FprA2eWcTGuoER1xcxVmvVBjBRc0AsyhBguxy8QV6ohdA99mXu4FdJgEpSaB05iRM
	vISrI2RPQ92txLMMZIrhhC9Jkl3b1IT5g37ABCZkA1g6wWVwjDeT0hAXbBVLjk9HfIW4gYcDXmXsN
	LCNIFf6iwDsxk7Dusmzj707mENsE6VC2mMTvdW9JV0vQgOYb/+KU5V8YZVXmp7Th91nqPllXSVUFX
	y7j5Aqmw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJIc-00000004Ijy-1ged;
	Thu, 19 Dec 2024 16:22:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: [PATCH 2/2] s390: Convert vsie code to use page->private
Date: Thu, 19 Dec 2024 16:22:50 +0000
Message-ID: <20241219162252.1025317-3-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219162252.1025317-1-willy@infradead.org>
References: <20241219162252.1025317-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vsie pages are not standard page tables, so do not convert them to
use ptdesc.  Howver, page->index is going away so use page->private to
store the address rather than page->index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/kvm/vsie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 150b9387860a..26cbd69eb06d 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1393,9 +1393,9 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 			kvm->arch.vsie.next++;
 			kvm->arch.vsie.next %= nr_vcpus;
 		}
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->private >> 9);
 	}
-	page->index = addr;
+	page->private = addr;
 	/* double use of the same address */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
 		page_ref_dec(page);
@@ -1496,7 +1496,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 		vsie_page = page_to_virt(page);
 		release_gmap_shadow(vsie_page);
 		/* free the radix tree entry */
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->private >> 9);
 		__free_page(page);
 	}
 	kvm->arch.vsie.page_count = 0;
-- 
2.45.2

