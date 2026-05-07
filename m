Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97739A07E
	for <linux-s390@vger.kernel.org>; Thu,  7 May 2026 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192592; cv=none; b=Cdrxcy/Jw5mbF0cJAWU6vrTu4CiYRNUnSTClNRZZ+fzN01fevbNvwycgwmZ1Ekii6k04adOW1NyvtbcpQphSHpa62wU6fT3L4AGzxtxnV5V18XwaR3fUQGHVGTK64OYISGAZ0cz3P+o/jAizSCv4U78HXfEfc0yygEeUT7MMv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192592; c=relaxed/simple;
	bh=o+vhOTjLhvS47fv9tom+Yt3TM9vgXV0mo+tAnh6qa+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwwOe18090XlMG0/laa11N/mexY+HafouvgBBZgGptEKq0ZK/IDAOHji+FkettjVgDLctED3E6wGqOfl3kJLi3+qg6a74YjK5iZD5BzNt/f1iSi543RXgeh++27Q3OYUnfgrcqgSUVGjMAeigjw5EsinxEfUgkyNoEmK8FyhMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kxn/7SRT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+cB4XwQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kxn/7SRT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+cB4XwQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778192589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxxPeFo8b5YQQgq6okT6k4ODeRwXIuGSW0SUh4EUnR0=;
	b=Kxn/7SRTVg+1y11F3weI900bT53eSmNN/IZfbKom9F+w5LBFqwnxAZPo/9elyIOm0uLSHt
	l5UsvJQOFSWe3Lvc2eP45z6M5dMvMVHukBk449fL93SJlH+IfI3MQXZ87/qtW8ve4lRj6X
	Vs8j6xQ9hCtOdYbzFjbcDUAuH3WKYcM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-H_mgzcTcMZeXRR-JxOVX8w-1; Thu, 07 May 2026 18:23:08 -0400
X-MC-Unique: H_mgzcTcMZeXRR-JxOVX8w-1
X-Mimecast-MFC-AGG-ID: H_mgzcTcMZeXRR-JxOVX8w_1778192587
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d144d3428so7818455e9.3
        for <linux-s390@vger.kernel.org>; Thu, 07 May 2026 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778192587; x=1778797387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxxPeFo8b5YQQgq6okT6k4ODeRwXIuGSW0SUh4EUnR0=;
        b=K+cB4XwQKShvaqBdKcldswwmuDkaf431z7P2oI5KuH9wWoQw7UVnkM4nmfcRQNE69P
         xAIVztalsE7+yaC2+YoHpT7wM7dInlVJWIx6VN3SUz7tly8plrFGTfz78Bn6UuUKEckT
         05tWgrgdoNqrwkO8nTgkkbGPpKSwLkQHpZbPCYb5RIxim5FjXilDYT5G7fKHFdE6g9fW
         etuixKtwd6ZUJAu6MmUYJrIpHm10FtQAyqXqK+Px0/Pc25wzmxZ/6AYP8QzgHn4EN783
         HKUg+ocLt318X5k88aEAFhm9CxXj1oCpT/AvgmcyoC6ayHxl1vRHodMOibhGrehcN157
         p5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192587; x=1778797387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxxPeFo8b5YQQgq6okT6k4ODeRwXIuGSW0SUh4EUnR0=;
        b=QP9UslWb5QMx7TCOU+r3h2tV56d6PbTZQsGa4FYfJR7fCcAjJa1ERMxUUG4fW9WIVQ
         jXZLSXOflI7+GsYGhvSm53XiSjtXoLUPZUfJ+ie2fJmSiHZAmAcjcOuLS/DrHZ2TOo/4
         4o9UyceENuqc/WaUjbMgES/oT6QKMGaAB9j6ED3tTuES922URwC5Cp9xDw1h50YSn1G0
         N0SrlBDnn423UGoD/E2vb8VFaKpG8QuGacf3LUceZ1u3vfgjT5ysxLrFh0UPCl46Onnc
         yHSRGygwP3GUxmGuo3W9ynRassYcYm2skDDO+cThp0WeVuQLUamMlBiDr6SpBfYFLmfF
         /ngA==
X-Forwarded-Encrypted: i=1; AFNElJ8pQdnhDq+S1MrDkPUR3TltQeooYwgBSdE0cd5vwma/JV/Os6A26T3/2vpiePL/7UdjTZt0jbmMUX+Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyC/VtoxA54u1yiwl/tvw2Mhrfnh+7BUzRvqUEtsi9wQZfd0txP
	DID4sVsyF4I3cVnBhiDQMsekGj1R5eyPzNEPEt92Rhknxphdm8DyXS1yP+jB6TYiaIwvbe735pj
	s4tqcnKE54aCV/51InFEpqOtMHB3P8B57QMi0HQ+2Ws2GmBu4FfffO3+96uf60+U=
X-Gm-Gg: AeBDiesDF2NJaQUkAEsCewNOn5s6Z4MZ04nFpinJovSats1x2TnA+wE0ZV85lOO0ZgM
	VKAMlvN8CwmRPp5pIxzWHhw8wv8PFw/wsUkQtowtvYMJZD2WXMlxAV9ThQ1Ahu9UIMfhLDCIdpy
	cpycz9dfSFkdjaqILqBZqTlMzOoe4KuvmfmprLp6Q/EgDXcDcEU2C139zC0YDaWIXXb11zArqfn
	1kP1uqmM3cALNia1/ohqTMQgdGF8GHpdMiPb7QWGMpoFVRQIAcCRQqm1S09RQNLyPSpKrG+n4uj
	fVhBuL1Y1ZztS4exQgALUUzPYe5oJK25LNzwC7tyUmvCz23J/xLbc4XRXjFmc8D3rQrptZ7GE1h
	BHhboHu2LCA8CSM370BoUBL0x4seEWKfB3SCfZCBX
X-Received: by 2002:a05:600c:1c0f:b0:48a:5342:36b5 with SMTP id 5b1f17b1804b1-48e51f3deddmr177389015e9.21.1778192586764;
        Thu, 07 May 2026 15:23:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0f:b0:48a:5342:36b5 with SMTP id 5b1f17b1804b1-48e51f3deddmr177388435e9.21.1778192586184;
        Thu, 07 May 2026 15:23:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820303sm2289369f8f.4.2026.05.07.15.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:23:05 -0700 (PDT)
Date: Thu, 7 May 2026 18:23:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>,
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
Subject: [PATCH v5 13/28] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <44d46ba982b39e53a2b5f978dd7239836e535196.1778192416.git.mst@redhat.com>
References: <cover.1778192416.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778192416.git.mst@redhat.com>
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
index f339258135f7..04020a19a5cf 100644
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

