Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71930403EB8
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068205; cv=none; b=rWTno4kcE3o+JbFKEUmMn1gFVW6vYfd7AWuqtAuxcPFbNmtg+aSxct234WX4r3KO2DQuT1Ue5bfMnlWxYJ0ySWI+q9w8aNqNrilp6z+Nxa94zRa/QBFeZWypgHl9kPqwsYugLbGNMXoOaMGQu8jFpfj0Dx/VgYsUHxi43Gx2SzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068205; c=relaxed/simple;
	bh=+lLqKB25GJ8Nk/N/QA5/TP30kbyhPVpqAySiqciCa4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+4rd3Jy5uvsTYwHgIk2OwOOdzvZwzcefdkHaiEO4Gygo59RK6CV98kZayYNMoYV/t/xyslzHtIaFX15YqlwV3rjAduP+g1m5D7Wp8O/qi864WThVy+Vs49LlyGfaS1dogfn5CORmT9OFPSHCs8ufC5J9l199vjIFkl+7gN5Ixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=habA5NCM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlpWIUV4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="habA5NCM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlpWIUV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTMC7Vi3qz2eQrpu1XXxCoOuK0TKvwPfinMf53HH2Ps=;
	b=habA5NCMWvy09QxivtZez0ycD8JqlyD0rct/u85OOIGOnQfV9fmqlbAMlARMuDTx9FV8Kb
	SeBNC79gl7pX/wLwv6CNqz1CSh1bLxpYzsXuSWuqSJsSyhGvoZ+AIsz0E7ww28/lYH+ITS
	lEjweLLAg+Y/d24Y2coiiXLPY2u7QpM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-gzWo-PXNNfSRKDunBYtr9g-1; Fri, 29 May 2026 11:23:22 -0400
X-MC-Unique: gzWo-PXNNfSRKDunBYtr9g-1
X-Mimecast-MFC-AGG-ID: gzWo-PXNNfSRKDunBYtr9g_1780068201
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e79219704so95023125e9.1
        for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780068201; x=1780673001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTMC7Vi3qz2eQrpu1XXxCoOuK0TKvwPfinMf53HH2Ps=;
        b=OlpWIUV4FBBPwNsZ8qu2qqvQdMJThXFnzKBbUjl2YYo2oIEEYHnOsaLdXgAAlPqVR4
         GKS75CfNj+cenXZL+x15szsXRcDIkwX3LercyhdytT+R62VEEqutvamNuhemslzo5Lh2
         h/u0ahzxw2bZD32vXs+uXuHm5bM3aVXHZskesPM4ztyaMTnYa7Llx4EE/9dj5GVfd+w6
         ovL166BG6fZThuKkTxi8SUZ4vF+CitxBveclW779oNWgKt3SU90rwfd1f7ujkVSypGyX
         BfC3XDvcViZlt8IuXtrSIICY6LMTf1wQxDIpp5B3i9FKutEZc4JmF2dp/qEYv5tCq03X
         g5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068201; x=1780673001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTMC7Vi3qz2eQrpu1XXxCoOuK0TKvwPfinMf53HH2Ps=;
        b=Xtynd+BPyyNMDRMY46zRJGkDmK1N6+UbQBbp4/NZSKdiQbc8HIqc2Hywc6BrKaNjPd
         2nu/5H4E3hxDELjxKYRy6gt3iuq9ZvaO8AWtEB+GnABifGKvxyzajDFqkgcf2xYYDfLp
         J710aWDFzLXYzolP43z3zkU8R8jel3ItGToTIK1E7gZnt90BUmane8TXuJmQ3OHJbHNP
         nLRHTwWAZ7Aq1ikbGMX4M/9OUe/aI5hxKIE02o42MuaXLwzaXCKHyvmy59eAlubkFHlA
         RtAIJUKRmwPbvgztHEJO3cIdmMHp1qPf4jkyGjrfZAqUmLHE3fCvr0KKvNaSc5K9xp/t
         VLRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VQdLozrwv1wU1MH8GVmvYb4grOrkDkeHc92cFfdVgAyuyQ+0cora/rnGzYw0vIwA6f9WNIT50Fej6@vger.kernel.org
X-Gm-Message-State: AOJu0YxDT26mmUjlYd4qkSgnzLqjoLciguMoC3MLF1YJ4XuTbnxxC03Z
	rBbskGqKroZdbhqyylikSYbS8b3bxEy2dHabwnn56PGyTy/mSZSw0CU3UqZUQE/edQ73xnUX/HR
	M2mZ6TttAZz+FfbRQRLlg1f82hbgK8n1Xzh+ZjSOiTxRL2jrhsVGsJI23KEWrd54=
X-Gm-Gg: Acq92OEFVieDiXad5vUPdU6SAzh38LGBdd13GYxBWzLg9nptqc5UlGxV03A7sXlv7be
	xKiZcXD18k0euERNbziirsJ0JzAxfLq5QsHnSoxFinyjV4/4ptgvuTXIYvv7ETAc2eQ5kc6lVq6
	W5CFinNYT+FsY6j7G/COnHhCo2x2B7a7HFIiOyAlVdpiesIWHKZGDUsvLuncGkHohLQ5rOr8nVD
	VrZcyg5o93kPRIbyYeoq3Y7cVqlBpKbprSzGE/b4Ihepn8Ndghk+0YVKHG1Xi44gzX5xzpumnnK
	Kr4BJxq2CZURcz2uPn6pP6wguw8eZywF2K5QPuXWYXWfKVS7T4SVkGPwwQjW9h+ljbVWxkwZjwQ
	V90RpiWYFLmkZMcp/zABViKLtiQgh3sJijblc5DMSv+1mNW/EQjSbIg==
X-Received: by 2002:a05:600c:4fc4:b0:490:6889:202 with SMTP id 5b1f17b1804b1-490a29639e6mr547855e9.29.1780068200778;
        Fri, 29 May 2026 08:23:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc4:b0:490:6889:202 with SMTP id 5b1f17b1804b1-490a29639e6mr546645e9.29.1780068200009;
        Fri, 29 May 2026 08:23:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f35f8sm40956085e9.13.2026.05.29.08.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:23:19 -0700 (PDT)
Date: Fri, 29 May 2026 11:23:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Subject: [PATCH v9 14/37] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <17905f527ee63479bd406efc228acf481a54b2d0.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Now that the generic vma_alloc_zeroed_movable_folio() uses
__GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
x86 that did the same thing are redundant.  Remove them.

arm64 is not affected: it has a real function override that
handles MTE tag zeroing, not just __GFP_ZERO.

Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 arch/alpha/include/asm/page.h   | 3 ---
 arch/m68k/include/asm/page_no.h | 3 ---
 arch/s390/include/asm/page.h    | 3 ---
 arch/x86/include/asm/page.h     | 3 ---
 include/linux/highmem.h         | 8 +++++---
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index 59d01f9b77f6..4327029cd660 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -12,9 +12,6 @@
 
 extern void clear_page(void *page);
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 extern void copy_page(void * _to, void * _from);
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index d2532bc407ef..f511b763a235 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -12,9 +12,6 @@ extern unsigned long memory_end;
 
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 #define __pa(vaddr)		((unsigned long)(vaddr))
 #define __va(paddr)		((void *)((unsigned long)(paddr)))
 
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 56da819a79e6..e995d2a413f9 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -67,9 +67,6 @@ static inline void copy_page(void *to, void *from)
 
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 #ifdef CONFIG_STRICT_MM_TYPECHECKS
 #define STRICT_MM_TYPECHECKS
 #endif
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 416dc88e35c1..92fa975b46f3 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -28,9 +28,6 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 	copy_page(to, from);
 }
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 #ifndef __pa
 #define __pa(x)		__phys_addr((unsigned long)(x))
 #endif
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ffa683f64f1d..7b5955bf9336 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -303,7 +303,6 @@ static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
 #endif
 }
 
-#ifndef vma_alloc_zeroed_movable_folio
 /**
  * vma_alloc_zeroed_movable_folio - Allocate a zeroed page for a VMA.
  * @vma: The VMA the page is to be allocated for.
@@ -317,12 +316,15 @@ static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
  * we are out of memory.
  */
 static inline
-struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
+struct folio *vma_alloc_zeroed_movable_folio_noprof(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
-	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
+	return vma_alloc_folio_noprof(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
 			      0, vma, vaddr);
 }
+#ifndef vma_alloc_zeroed_movable_folio
+#define vma_alloc_zeroed_movable_folio(...) \
+	alloc_hooks(vma_alloc_zeroed_movable_folio_noprof(__VA_ARGS__))
 #endif
 
 static inline void clear_highpage(struct page *page)
-- 
MST

