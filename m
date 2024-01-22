Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38D3B790
	for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952707; cv=none; b=roB4P8NiKbOq/xnpJ8tmR3RvY2G35SMg6V9FQFqbmmDDBbWy0ktJAgsx5sWF9DAP5JYY/jMbvNlTcQ4DvAf0D6MqpSMPesS5U5tBeeIerwjXrIiiLpDPtaOaz/9jzfzXFSQDToCaY/Hwm3KjEsxjTMLWmVaX+Pq8+YUkuV5Zge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952707; c=relaxed/simple;
	bh=qbqvbUcKFs/2kfDFqVxmsqTfTtbxX17+7IsFr77teDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofZDDV86OrNxt1DzR5VSGU7gqm1BMqQzRDIAwMJHSw0T7D5rOOPfDeDgRkWoBTX+fnIX5aTfKE90++gPFur8K0ijryDh5dZA1tWJeJ1NsXarJGlxvrir+4hN456RECNyDwpkgo+V7niLr1aPilfl2aOEGAamrTnK/AFGWDdfc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQtmTBuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQtmTBuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705952705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7CvT91MHkJr0ioIf++HrmdTETO7/LeECE+2pAFvObkA=;
	b=ZQtmTBuD6kU6kqruXwhPM8HA5nqPZX7hx13EoPaLdGQx0kk/7UUbST/g84m5GYsyYr+DNL
	RBQS77kTqBmzUcjeufdZTc9vb6fdhqtPddufaeFJdFLyy65xSzOjQGFYv/+9NfXmLwqjq8
	Ll+Pd7vrI6VF1ctGYLoFnijk4l/4Qvs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-mRFmOKJDPVaGmmWPnrJHKA-1; Mon,
 22 Jan 2024 14:42:28 -0500
X-MC-Unique: mRFmOKJDPVaGmmWPnrJHKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 634743C00084;
	Mon, 22 Jan 2024 19:42:26 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ADD273C2E;
	Mon, 22 Jan 2024 19:42:20 +0000 (UTC)
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
Subject: [PATCH v1 03/11] powerpc/pgtable: define PFN_PTE_SHIFT
Date: Mon, 22 Jan 2024 20:41:52 +0100
Message-ID: <20240122194200.381241-4-david@redhat.com>
In-Reply-To: <20240122194200.381241-1-david@redhat.com>
References: <20240122194200.381241-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

We want to make use of pte_next_pfn() outside of set_ptes(). Let's
simpliy define PFN_PTE_SHIFT, required by pte_next_pfn().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 9224f23065fff..7a1ba8889aeae 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -41,6 +41,8 @@ struct mm_struct;
 
 #ifndef __ASSEMBLY__
 
+#define PFN_PTE_SHIFT		PTE_RPN_SHIFT
+
 void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		pte_t pte, unsigned int nr);
 #define set_ptes set_ptes
-- 
2.43.0

