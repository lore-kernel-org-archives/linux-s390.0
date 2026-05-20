Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33353B637A
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315712; cv=none; b=nYHMk5tPXqCTYP5fC4P+UT4owFA1ZA7duHurd4gtUwOVAnHmEhqEBAGS7dIuXuBYHqUXrkH4gcg70izPg5Aeev+/IayItvuBRPmqCMAw6rvKGICyZpyzmfOMtTDo+jqTNFkOgRaoaeJzJcCEOe/Ba/+V5NPg/qPc9Ez9VrBAfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315712; c=relaxed/simple;
	bh=+lLqKB25GJ8Nk/N/QA5/TP30kbyhPVpqAySiqciCa4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVibeYLe0krHGgW6RWsJbrhBNPaMDZhnHpJe3PnSsGd+DZbihvsdaSk+8/ETskh8MX59onGQ59vBodyNKu2OkiqJPoF1lu1R+NmBwEZmjemoGXX8oVBPR5m+4kzsyy05/N7sBbXlU+3pvn7dkpG6FrBmYgA3MLJOxwnp765Biho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bap42vw2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIiPUiFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bap42vw2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIiPUiFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTMC7Vi3qz2eQrpu1XXxCoOuK0TKvwPfinMf53HH2Ps=;
	b=Bap42vw2MtpEJ4+5RwJUJZTWCTx3n9+bIhYdNYh/9G+wNwQNAiGwG216inxcBXm1U5ZTUZ
	+m08fc+j9KiOeJDhY5NMZksg+gYp75gma8ljBP181i09CYNVBbbbkkW3GnA4ab47KK7M03
	WT1eOnA5UUAbrYOhIBAy7peZkgYDHeQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-NuhUpVaaMI6cDdHHED6Irg-1; Wed, 20 May 2026 18:21:47 -0400
X-MC-Unique: NuhUpVaaMI6cDdHHED6Irg-1
X-Mimecast-MFC-AGG-ID: NuhUpVaaMI6cDdHHED6Irg_1779315706
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48ff0eb77b5so51027455e9.0
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779315706; x=1779920506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTMC7Vi3qz2eQrpu1XXxCoOuK0TKvwPfinMf53HH2Ps=;
        b=GIiPUiFeyXoYfQcSzCQ8UDLKNF8eIxCGoGWYZUAP2105svD2H6KOUyYeVB/Xr6sMva
         3BowiY+z5O5SrdheNyzuqgpyYM/zshTqAAXW7g04eN0C8eL1Au+kUrpa9Xiuobj1UpoT
         2awR7+9l/TNjwnv5QdShBeZjYM794QlHyumKE21++S52oDAQ9cjQy7617xplq8PJxteE
         7s2fgPlDrVBD7v/BxhdCdTcuExdsWcu6iOogWguLL1dwSU3xPudt+5MlOGxt9Y/qUdO3
         32BAWJ+t7w/zg5DBl7xa11mSmhIG7hfAXnJGG1z8Z2kxetk015oSEB71v4lLLG/SnqC/
         mPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315706; x=1779920506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTMC7Vi3qz2eQrpu1XXxCoOuK0TKvwPfinMf53HH2Ps=;
        b=j721J+MzZe8tI4QSjo7PcNvQWH/VD87Xfpl8v9nDq7yW2SFTFepo/VBilpeKxQOM2M
         GKaW/TFXGXdJSPuIt6LgkVJ/fzGM/odijmgajmbk2JaakyHyF54bv6kg29X7amYBm14o
         KKe6fFjyA0pv4Zhu6IXda/DnNY5qhFDbOaDMPmoGPX6QelqikrdiIAwqEvZh0iO8/L8C
         Q1L5inno/MtTr6ux/M6toPQRNUDDQtG9VqUrTB7sTuYY3INm6TjAY+OFQuV3t5WTjtqB
         jzXgZXjowigLQNidy0Abjw4JdBnKggIt6MahevyAy6WmycUgiJzmdKi+WN7jwRt/jmjr
         x5Ug==
X-Forwarded-Encrypted: i=1; AFNElJ+gIxEWX2XtDsRu6fospSdocugKdgvZgzSW6k/IlYz8cs5xHwLUaSKCuCeZLxocPOdQCqb0IUUw+08s@vger.kernel.org
X-Gm-Message-State: AOJu0YypCG8tSIBGimXBvDCl73kg59TRGUOr5onhVcUZOzGvVxPyna2R
	XceVyn6FcwhBalsuo5vMrlepX8ReY9AiWTovIamvljQGsAkXmnjEn/KgsJa3tb083h3R5Z9UfjD
	hqIKUCoODFMZtUpIXGvFni3DebvjeKG98kbqZE6mqfcJkyARGYNgy88chXAXo8r0=
X-Gm-Gg: Acq92OFpcdnqUKfKBivC6q/PYQ+dxbOE3eA8f0w83axnYMqj/xVzJ68uQwuiZ+h5HGg
	+t0rkiB5/4SXF1AQtcuGLxpYmN4GZywNrnTZieQPkCvSNEECpO+KyLBPAReudF5+0Wj1yI9zPxB
	FDlxKyDNpx+Q3BjP9IjD4vlT+WZ+KiRpN/G76kGCUj8nmHTaNzRTzCk+YOfWf3xjqvtH5/+ViUx
	G5STc26Jj6vG8yFMcbWyeyM86eUXUntXQWU4S+Fnmi5QceheaFUe0cpSVssRq9ZSJkKPPOPyxqs
	9ZkhGQ2fBquTw+5fW/RdY7i9XDGIWe+TxegSJoocQLob+rBpcm0VzqpnTnNka9SNj48EAfK2L1b
	bmXX1TzhfDORhoSvAivhMLGcYw8i/ZnURkPRLWLnagJOACW326F8amw==
X-Received: by 2002:a05:600c:492f:b0:48f:dfe3:dae3 with SMTP id 5b1f17b1804b1-490360af200mr1567055e9.17.1779315706118;
        Wed, 20 May 2026 15:21:46 -0700 (PDT)
X-Received: by 2002:a05:600c:492f:b0:48f:dfe3:dae3 with SMTP id 5b1f17b1804b1-490360af200mr1566725e9.17.1779315705516;
        Wed, 20 May 2026 15:21:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d8e24bsm20846035e9.10.2026.05.20.15.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:21:44 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:38 -0400
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
Subject: [PATCH v8 14/37] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <9c2ac9d2fc159822b9fd6cb1304bf222324d70a3.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
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

