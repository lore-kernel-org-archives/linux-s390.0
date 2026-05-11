Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE83C9438
	for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490159; cv=none; b=oDKev+lby2Yfguyimu9N2lfeJA7XkY68WSO8vzEwCIV2UuZm95dh/76BFWLS66jQX3xi1UhgMTu/+CUWbwEWC6fK9NASJwNO26i/h+kxXsXBMTRFk/Vgw/Gsbd+spFRhzeDlGGMb7K+o7rohYvdvzgKl3umXyDpIGJRG+hBZ1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490159; c=relaxed/simple;
	bh=xVZpENOTPSkcCw9H72WToBvwV1ZsJAWZkigdtcUbLLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di2uKZ1D2ahuLS79uC8lwHdp1i5bKj9DqZZU8Ri75u8ZjXWrEpIjtA7D//5nVecMR6wOzpjGquBRTyEZSSjY8Jy+we/X2SYXO9L4bJE1sHY17dOnDcNMMHGz+ao/k8Fz8Krf0imVV95jBNQ2O9GlF6PxSWt/DmunjYBC9oB9+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhUUdbXU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pxS20Td/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhUUdbXU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pxS20Td/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
	b=LhUUdbXU5rLV8LcGjKMJ7r6KcdK7v0VpU8kl2gujOLfEBw1QcpFZdU6JKHVXp4MytvGz30
	+y5eg9IbWLKL9LXyBi6mjJwCJ6W1WtJLqPjv/iGnJ12xGqKZgn2ppJxahTHKMc6w/iweU7
	iGCkJvSUZhFRT6AySbmuZVbnoaDdzwE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ZHNkR_aWN2-ZtNnSAm0pKQ-1; Mon, 11 May 2026 05:02:35 -0400
X-MC-Unique: ZHNkR_aWN2-ZtNnSAm0pKQ-1
X-Mimecast-MFC-AGG-ID: ZHNkR_aWN2-ZtNnSAm0pKQ_1778490154
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e79219704so7725195e9.1
        for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778490154; x=1779094954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
        b=pxS20Td/tXuBCp+2WwfKjxOzm/PvmO82GEQX/QjIjoVxg+zwFN/WR4VJz8P9zmQqaG
         4+Lh6Vz9hgego5Qz8YxqD1lECpXeFnTh7av3NccEbkMiVg4+NuqWYFjHFQSqDyLUg05z
         pqNLJFmnDWkYEpDgh9E6/g2UcKynHnuVYXjk6aNXzk/rS+/61pJRkL8ZN9kBsG/EBnFf
         eqI1Y9Fp8bBiu5y8bS0CXW6S2axX1FB5qotl8PMjc1wLhbok+ewdJDqRPYWmV0rFnJit
         jicXPVzO2Az32Al/rLp7unQ4V3P/kkzt7xaEqyV9adgaFj5JuihEdKSF7ylgR9o5s/c3
         6LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490154; x=1779094954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
        b=sDuroV0sdoqafaJya7kgs7HxcYgRnswGSOSlu2ZgPSRR6QQ3xOMq7WQkLCWv0awIPd
         akFq9RxExHUDpxGTsd5BK4i2d2NIRAVA7a/JBL/X7MQXM/W5vtFM/zWSoNvBc02so/WA
         z1YAkqsC0L5/8DU/cggrR3ZJFQV+pZuXzHALRQudt2UOdEqkybjjyYUMUkatN9BZblFl
         G20picJX/1YLLNINNrGQhqcNf4yOERHFNJQOKPboXXo8kwdeeIMw8cH+p4uhXpkj/ALX
         SiH07Rj7vC/KM6Y2U7u7axf4TS9AGTqdaECuBFMaA3HUqmLy9yHMisTCDMybV0kPS4G0
         DgJA==
X-Forwarded-Encrypted: i=1; AFNElJ8HgYRuHGTubOKoPoSQ07BtIUY1z/jzSHCe9R5N4NRneo3hRlFLm/Fip1atm52aZQgv6M/6hb/Y9bs1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hh9GaIjgOUL7ll/o2Pu18PeHSyurwx+/qcWPOEXqtZShMPsW
	Ah8Cd2vfzsZDYsW/pm+9w7zoplrPsdPDSwPWC8cwlJizi+RpgNSft32XNQlCK2RcHKKsOme3+PO
	3PNtNU62f+XN0VAATfG5FzUYG/TjlJ8jD8e+2XakWSZVb+75+5lxhjeQItHOMsTk=
X-Gm-Gg: Acq92OH34wGPQYPFs3HhrPToZtPMogVMiJzwOBhlqO+4q5iEtzS3gF9SYak8p2sYIug
	fBbAsu006dsmn8kpTBK41nNwVh3QUK4oJ11vfpoD/AAFx1wgx2S9VnDXbbCh/1ZL5pSW2LlQEeK
	+VdsGQsWCQIIXZlzPEwvZhCGjAbPGkY1HPAKblpVGSJxguO/1MUt3MCfExHdaJNQ3Zy4bZjyg0U
	nvw92hxS+oGEltxYGoVAhoWTXiVJV0abWssd4Inm2H5FvjPXuQ21XC9L4HB23pODQ3T20c2EklC
	Z9aMRwXsY4FZwgWRNe4aueHbXUzsEYQ3d4ykEFxEIxR4RD72es4hMYpSBtAqu3F39whd21r9hm3
	tTCx8mR42h5vVDvb/wpqDeDBRczgcp33xH+izGZBU
X-Received: by 2002:a05:600c:1d18:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-48e51f46e46mr365112575e9.20.1778490153235;
        Mon, 11 May 2026 02:02:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1d18:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-48e51f46e46mr365111235e9.20.1778490152468;
        Mon, 11 May 2026 02:02:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7040a9a9sm297049045e9.9.2026.05.11.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:32 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:25 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH resend v6 08/30] mm: remove arch
 vma_alloc_zeroed_movable_folio overrides
Message-ID: <24a1b25f4f1cf31fc5bc053e475958ed5e1bf8bd.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
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
---
 arch/alpha/include/asm/page.h   | 3 ---
 arch/m68k/include/asm/page_no.h | 3 ---
 arch/s390/include/asm/page.h    | 3 ---
 arch/x86/include/asm/page.h     | 3 ---
 4 files changed, 12 deletions(-)

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
-- 
MST

