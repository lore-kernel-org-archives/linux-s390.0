Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8E137C59
	for <linux-s390@vger.kernel.org>; Thu, 25 Jan 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211193; cv=none; b=TZjlULiKHFNJvwrTsBr/9sYuFNtGqSZ4ZmuoE6QqpxC6e9yQ4+RG4zZhXYlBeXnjtOVuO+IN8e1pkbsx4+93fUDYqnQkP43LklCH9k6xF8pxFla3Wv0o9YmQzRwVduyBUlqXsN+e/vZFhKh0BGOXvzGCjQ8kIWV8SBcULdmwpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211193; c=relaxed/simple;
	bh=z0pv7nQf3+BHeMquvzePcn+FXugfWYxDh8sD9Yk/afY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvquHY9P9H20k1aZLO69QpAQS2owAX5AmjbqUXmufdj7qQ5vJMq5oDSihwZFpgyvMrQv7bb+hxUOJUwxdiKueHZ1/e/bAFBO6phjIoxhb0iUPLhondsNsl+wToe4dUsEbdHl1UdVQ14RYOn8k+/AfRIhyjynGho9zkgTRAsVazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NojYa8rs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NojYa8rs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706211191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLkdB3aR8b5AzZf8mrQLfb2UlnHWewFM+noupjKQsYY=;
	b=NojYa8rsnlGQpAElfyYOesIjD5LETWGFcNKsiEpQUCyBzlkNEhTJsHVooaEw9ssbekUV5C
	nKj5qPmaEhenzPm5vXRLouSXwt5k8CEiJ+vzKkkc90iI3DdcwGxlKPgfuGCldfdrIgPtTw
	B+8iqA+xu/b220WkynRoazHYLoQxLcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-gRvtxHOMNz2NEaPqxmRHPw-1; Thu, 25 Jan 2024 14:33:06 -0500
X-MC-Unique: gRvtxHOMNz2NEaPqxmRHPw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 045F81013673;
	Thu, 25 Jan 2024 19:33:04 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.154])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 59F4E492BC6;
	Thu, 25 Jan 2024 19:32:58 +0000 (UTC)
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
	sparclinux@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 05/15] riscv/pgtable: define PFN_PTE_SHIFT
Date: Thu, 25 Jan 2024 20:32:17 +0100
Message-ID: <20240125193227.444072-6-david@redhat.com>
In-Reply-To: <20240125193227.444072-1-david@redhat.com>
References: <20240125193227.444072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

We want to make use of pte_next_pfn() outside of set_ptes(). Let's
simply define PFN_PTE_SHIFT, required by pte_next_pfn().

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/riscv/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0c94260b5d0c1..add5cd30ab34d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -523,6 +523,8 @@ static inline void __set_pte_at(pte_t *ptep, pte_t pteval)
 	set_pte(ptep, pteval);
 }
 
+#define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
+
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pteval, unsigned int nr)
 {
-- 
2.43.0

