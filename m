Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80F1F4289
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264640; cv=none; b=qu3iUL8IgUoy3r+TZ0xlwHGjGXDj0Pxl5O5paahKgzkZkYB56AUrvEvp0gZ1sUnqxunynPsq6EmCS+/jKmLrxy4XAv23r3oQyBsVx2g6Jv5uAzzll5xtDYYQft1V9GE7SUaBXL68PRzKR4gtWeb1L2sgPxN7UeaohApTT/3/NGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264640; c=relaxed/simple;
	bh=0QXPE+eXFXyIB0uillW17Lfw0Fpu3Su9RoFjQWDKyq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aqs1ea+WNl7z8GocBAc0FaD71Ac3miWDIP6Rbh1uIPWhBNIuXqplplyAs1Rkld9vsG/nRlvTGRxjZCAazSVfveYS7PIoqsUWXq743aTBEVswZv+T+MfLUHlieeqacPn0lNRy86PzQtvc3fAUBjR02Ave7dr/y+WnSg2CcgXAnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gh2HxaTb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gh2HxaTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736264637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksT98VQdUhSv0luDz3yS7GKqTDZHnvkmGgkAuI3OBoQ=;
	b=gh2HxaTbvX2RmcOD0cGRsm99yTJR+wFWr79bjfkjI0Xitop66qz5zBnLjAXYnbbfQpEk9o
	UMQa94fk0lNIkiLScfQrTyaFSwklIj6PcDidAenQX1ZfZH4jliGKZuyKp2KWY6Kluy6hE+
	qqz6BiOrIMTveJocEnWdb6dnIetXnvk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-3Xu0dVeBM9-Zi1XujdCIAQ-1; Tue, 07 Jan 2025 10:43:56 -0500
X-MC-Unique: 3Xu0dVeBM9-Zi1XujdCIAQ-1
X-Mimecast-MFC-AGG-ID: 3Xu0dVeBM9-Zi1XujdCIAQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361ecebc5bso44024715e9.1
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 07:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264635; x=1736869435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksT98VQdUhSv0luDz3yS7GKqTDZHnvkmGgkAuI3OBoQ=;
        b=ejQ9n71XZz4IBVM8z1aNqxTeq4x19UgZ8pyz4wTZkyCkxyHYTPK0dYutfW1ESpP43f
         gIaZGDdyysMjUjwux7FBqlkd+n2BBJ4aC7tPMYtuxejiv/hasy5n6uPp4mcdI1eU4Nc5
         FeDtkkkSBGaz0xJ0BmOVFb070qtWj1ief2JkJUWjktBFGZsxu6/aYE6rwNHc9BtTcCQQ
         0pSS0NVaX/cLYYNBib+/0bLsdWLmr6nABMPjzSmiP1j2vBG8wKPwl1f/Dbx+7ftTi7VQ
         cke5mdrBLVEv19kLeau3xJ6Oqrzy6kLNYtO9WVHfCNA6spv5xmhVLzEb2dXb9dXgaACo
         cLUg==
X-Forwarded-Encrypted: i=1; AJvYcCVggpFiHv2t1x9MaDq+ZYIVHsaBC4ebOrmK+RCrdhBI0EnDBFY1tn2QPL2WumAdG/jTj2VuOln+Pt6p@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5l43hFdv0IAA2BRY8mEN0mSlfdOPl38OV6i/oCQr+ak5DQXm
	Yzni0tn7GdwsleWNhLn85rxgGsbm00BkLYPxB3wmf6RORszvZ/iwPgPH+Vo+WVM7u/U3FK8hTE7
	/k+DT1BXY1Mji6M3I1hagEFATr3S61NOq1W3qZqSwWvUjZO2PxRb+tG9Xx14=
X-Gm-Gg: ASbGnctAPWI9OmAA8/8W8Z0EyZxwKEOoN3Xm0DAIHoS0P5aUxtjo2fkJIbRXEsKASzT
	Jz2tbiFbh1DuB58WDJFWGw7lTiQ6yHx7WGh6ZPb8RPCFfB9MrPphq/JjMfpm8QjZ0QEgylbsv4a
	zwGtD4PX0XA+3Lc9K71dk/3dbIqq+McGat7J6kVAdxRazHk2mmrsJZRWCefKqWQqkj69Kcea5KN
	s3fDAFqfN95cpsSVFkBYI4pPMhNd04xZY5d46n9pWbxPlpQxALLE7N5rp5mwdjXi6r90oIG985w
	deCWE6SWFpO9EBqN1P/+COpovjOq+FaCOZPX73M3Jw==
X-Received: by 2002:a5d:6486:0:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38a22408e42mr60678378f8f.53.1736264634928;
        Tue, 07 Jan 2025 07:43:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsk0AvacnGYBFNBBsM2kiGWVAG8AyisJBhvtUsieGfaJb05XpWAWuK2N6//5cFbq49Bs8eag==
X-Received: by 2002:a5d:6486:0:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38a22408e42mr60678347f8f.53.1736264634544;
        Tue, 07 Jan 2025 07:43:54 -0800 (PST)
Received: from localhost (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38a2432e587sm46830028f8f.95.2025.01.07.07.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:43:54 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v1 4/4] KVM: s390: vsie: stop using "struct page" for vsie page
Date: Tue,  7 Jan 2025 16:43:44 +0100
Message-ID: <20250107154344.1003072-5-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107154344.1003072-1-david@redhat.com>
References: <20250107154344.1003072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we no longer use page->index and the page refcount explicitly,
let's avoid messing with "struct page" completely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/kvm_host.h |  4 +++-
 arch/s390/kvm/vsie.c             | 31 ++++++++++++-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 97c7c81275434..4581388411b71 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -931,12 +931,14 @@ struct sie_page2 {
 	u8 reserved928[0x1000 - 0x928];			/* 0x0928 */
 };
 
+struct vsie_page;
+
 struct kvm_s390_vsie {
 	struct mutex mutex;
 	struct radix_tree_root addr_to_page;
 	int page_count;
 	int next;
-	struct page *pages[KVM_MAX_VCPUS];
+	struct vsie_page *pages[KVM_MAX_VCPUS];
 };
 
 struct kvm_s390_gisa_iam {
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 29fdffeab635d..22643f4ae4455 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -599,7 +599,6 @@ void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, unsigned long start,
 	struct kvm *kvm = gmap->private;
 	struct vsie_page *cur;
 	unsigned long prefix;
-	struct page *page;
 	int i;
 
 	if (!gmap_is_shadow(gmap))
@@ -609,10 +608,9 @@ void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, unsigned long start,
 	 * therefore we can safely reference them all the time.
 	 */
 	for (i = 0; i < kvm->arch.vsie.page_count; i++) {
-		page = READ_ONCE(kvm->arch.vsie.pages[i]);
-		if (!page)
+		cur = READ_ONCE(kvm->arch.vsie.pages[i]);
+		if (!cur)
 			continue;
-		cur = page_to_virt(page);
 		if (READ_ONCE(cur->gmap) != gmap)
 			continue;
 		prefix = cur->scb_s.prefix << GUEST_PREFIX_SHIFT;
@@ -1384,14 +1382,12 @@ static void put_vsie_page(struct vsie_page *vsie_page)
 static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 {
 	struct vsie_page *vsie_page;
-	struct page *page;
 	int nr_vcpus;
 
 	rcu_read_lock();
-	page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> 9);
+	vsie_page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> 9);
 	rcu_read_unlock();
-	if (page) {
-		vsie_page = page_to_virt(page);
+	if (vsie_page) {
 		if (try_get_vsie_page(vsie_page)) {
 			if (vsie_page->scb_gpa == addr)
 				return vsie_page;
@@ -1411,20 +1407,18 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 
 	mutex_lock(&kvm->arch.vsie.mutex);
 	if (kvm->arch.vsie.page_count < nr_vcpus) {
-		page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
-		if (!page) {
+		vsie_page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
+		if (!vsie_page) {
 			mutex_unlock(&kvm->arch.vsie.mutex);
 			return ERR_PTR(-ENOMEM);
 		}
-		vsie_page = page_to_virt(page);
 		__set_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
-		kvm->arch.vsie.pages[kvm->arch.vsie.page_count] = page;
+		kvm->arch.vsie.pages[kvm->arch.vsie.page_count] = vsie_page;
 		kvm->arch.vsie.page_count++;
 	} else {
 		/* reuse an existing entry that belongs to nobody */
 		while (true) {
-			page = kvm->arch.vsie.pages[kvm->arch.vsie.next];
-			vsie_page = page_to_virt(page);
+			vsie_page = kvm->arch.vsie.pages[kvm->arch.vsie.next];
 			if (try_get_vsie_page(vsie_page))
 				break;
 			kvm->arch.vsie.next++;
@@ -1438,7 +1432,8 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	vsie_page->scb_gpa = ULONG_MAX;
 
 	/* Double use of the same address or allocation failure. */
-	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
+	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9,
+			      vsie_page)) {
 		put_vsie_page(vsie_page);
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
@@ -1519,20 +1514,18 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 void kvm_s390_vsie_destroy(struct kvm *kvm)
 {
 	struct vsie_page *vsie_page;
-	struct page *page;
 	int i;
 
 	mutex_lock(&kvm->arch.vsie.mutex);
 	for (i = 0; i < kvm->arch.vsie.page_count; i++) {
-		page = kvm->arch.vsie.pages[i];
+		vsie_page = kvm->arch.vsie.pages[i];
 		kvm->arch.vsie.pages[i] = NULL;
-		vsie_page = page_to_virt(page);
 		release_gmap_shadow(vsie_page);
 		/* free the radix tree entry */
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
 					  vsie_page->scb_gpa >> 9);
-		__free_page(page);
+		free_page((unsigned long)vsie_page);
 	}
 	kvm->arch.vsie.page_count = 0;
 	mutex_unlock(&kvm->arch.vsie.mutex);
-- 
2.47.1

