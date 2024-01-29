Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2E64CCE
	for <linux-s390@vger.kernel.org>; Mon, 29 Jan 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532471; cv=none; b=tficpNKyPuoXHFAV+fHxP2nfyPM3nn8XNs3aSxuTvGUrdigHzdxDsCIw6zIyVK2fchTsZq0ZQrrXHpms5FKRw4Po2O9KapqKvwOMLOJyCSjFEM4+6DtxWkIVqWw+GOEbdQBY7kQ82E1UjaVjBB4tGgRBqipVlyBlXmumHU0yy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532471; c=relaxed/simple;
	bh=NAbv74JbKmrqdh93Ibq9r1hHLRt7cxZLtU35wjHXMGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqXX0Kfqta6EQGuoinPUwCm//cy1oy1Z3Aq9ENf/3h7j+eghSzSBwZhLBYPGnr+EItZvD3MHHnoYUsgxa4WOvTsaIk/xYQOKFHfVM4hfzi3wTBxdI1HFL5ILVJlFEN8NrWF1y7dPMsIVp1dkVnSBEqxKa8c7FwU9dEd76YeXtoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wfr0+qJp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wfr0+qJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706532469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXK02yTQR3iX9+2hOAsyvxeT8orGle3067Vuz1QJ0iE=;
	b=Wfr0+qJpqRUdmSELBjWCJKOwk4YE3A7vrIhjFoSZjFWhFN1AaFXDGfoFFS0ZAqGyUpfiXj
	bd754oEVg9YCgGmjORs26Vjh8Zljv5CA3THlXoSn4yvTpOWnW0AgyPqTxVUOsfKj7OGKBr
	Tkffi8EtKir3aKebCoQlcaw6fBeFynE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-Yd-jPcF4M0WLV77ep4J5DA-1; Mon,
 29 Jan 2024 07:47:46 -0500
X-MC-Unique: Yd-jPcF4M0WLV77ep4J5DA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C956E3CBD507;
	Mon, 29 Jan 2024 12:47:44 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58D62111E8;
	Mon, 29 Jan 2024 12:47:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v3 08/15] mm/pgtable: make pte_next_pfn() independent of set_ptes()
Date: Mon, 29 Jan 2024 13:46:42 +0100
Message-ID: <20240129124649.189745-9-david@redhat.com>
In-Reply-To: <20240129124649.189745-1-david@redhat.com>
References: <20240129124649.189745-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Let's provide pte_next_pfn(), independently of set_ptes(). This allows for
using the generic pte_next_pfn() version in some arch-specific set_ptes()
implementations, and prepares for reusing pte_next_pfn() in other context.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f6d0e3513948..351cd9dc7194 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -212,7 +212,6 @@ static inline int pmd_dirty(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
-#ifndef set_ptes
 
 #ifndef pte_next_pfn
 static inline pte_t pte_next_pfn(pte_t pte)
@@ -221,6 +220,7 @@ static inline pte_t pte_next_pfn(pte_t pte)
 }
 #endif
 
+#ifndef set_ptes
 /**
  * set_ptes - Map consecutive pages to a contiguous range of addresses.
  * @mm: Address space to map the pages into.
-- 
2.43.0

