Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53362F0661
	for <linux-s390@vger.kernel.org>; Sun, 26 Apr 2026 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240098; cv=none; b=WekJ+6gQL43lbMq77z4zLFleigF+AKAfMuqFxaHwIG6Wg30/2N5Or7OBWaxfBn3Lc7AUwZwtlF3mEptU/Kxo76vg+VCT8EIWiSciVxFUIAZMwkXHw3HgVYKRNpR1NgGXc0psArHOfQMspBRGvBqAOOJd4+xvQ3HKpIE1CYBMOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240098; c=relaxed/simple;
	bh=o+vhOTjLhvS47fv9tom+Yt3TM9vgXV0mo+tAnh6qa+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrR+4+ZNBx2Krm+qc+l+fSVOc0ghCJ9fRDZDgwR+Zcb8bfvrjQovcQQ5GQ10owVBEcX24ePoyC45Y4G8YOt9zHFXeEtYnbShmy/wf7VgKg+AXr/A48qbWDrbM3DSTx8kd+oWmgB/wHv4+8yIlp3R4F51K00Sq2I0DfbggzXZpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgPxFQY1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rezq0HIx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgPxFQY1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rezq0HIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxxPeFo8b5YQQgq6okT6k4ODeRwXIuGSW0SUh4EUnR0=;
	b=TgPxFQY1VvQDzV5yyrlydLtRzB0pW9KQSYCoi3c5I3q9+mjOTnqUGV7Sbo290w9wNb7En0
	wOvmRbdDw3eyQISgm7xbK020jiC8xXzTWp8XLzJQHSviJU0d9pPwYaHrmI7BIw4MBer5Ot
	kMWo/hjB8cpOBkH+uh0qztTA1ro2xWc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121--lV6r7XbPpSkqG8xOg4i9A-1; Sun, 26 Apr 2026 17:48:14 -0400
X-MC-Unique: -lV6r7XbPpSkqG8xOg4i9A-1
X-Mimecast-MFC-AGG-ID: -lV6r7XbPpSkqG8xOg4i9A_1777240093
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso66776055e9.2
        for <linux-s390@vger.kernel.org>; Sun, 26 Apr 2026 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777240093; x=1777844893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxxPeFo8b5YQQgq6okT6k4ODeRwXIuGSW0SUh4EUnR0=;
        b=rezq0HIx5sTnzlA6s6dxqTv+0IQOo9Z2pEqzW6tGfRCFJYVKubIuFa441hLh0WV3vw
         diZUcsi5VcsDVjsDnWCSM7C0+/zl8ocXL4WXK/Qm4W8WDjwebbKg5iqKfq4kg0NxW649
         iJEjknvzFUx5M/Hc8XX5ZMKcInkNQxm9KSKS5rUUxwxwIAHEy3fEMORIib8HsETFvwAF
         Dag+vaTxlitpVxNNh9WcgI1ihClnwDbuZwpoGg8V4UuSd8lBcNK1dxGx82WGnue9q1t5
         wFcuIBq3cuOjBUPNkG7tOy/PEGHLbWsRUcijkzFYiHltASuSmpYPtPeRZzyNItpGctQt
         RvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240093; x=1777844893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxxPeFo8b5YQQgq6okT6k4ODeRwXIuGSW0SUh4EUnR0=;
        b=bpDCGo9244IL8bmH0fqjd75bhvU3qxp8aL3NsC17BqdltW8JT4QVeG+Zw8BCTIGn1J
         87tdxMS/tVWcmMZT6FzzOkXQGIFI/wciYf48Jv4z+7INvyjZLd9keJTUJ17wZc3KGqHQ
         7UxOoC+vQbefN0kqZx340ndae3ZyFGN6reKlDfWGmQDwrjeKlpNsnf1uTZmQ8gfYETPS
         HQTKIClCmS9Fwb5uHRl9BxjnH8aCPao5YkcmeMuo6ftPXLlck80cAvkhR3/r1WUOp64a
         YmP9p52UHSS+usae8gh5nimU4EfwIeTrYb782sjxUQOS5lw4HuRqLx4focj+qdifllvW
         ycUA==
X-Forwarded-Encrypted: i=1; AFNElJ/mvhiwkhOD9j6sm/rM0zcg+WbnLlvbajRYlWHoD6tAkfLF56QgtbDssTTHVjARWiVNzW0YyK/P76R1@vger.kernel.org
X-Gm-Message-State: AOJu0YyYU5oXq4z4/5gcGvB2O6fiOBsn2CsrAAhm36BKV7zfxDwBbrjb
	68ffu+AGjFmUIoQtLxKlsO4oqTGZfSNQ6OoseJ9V9saO3MXuQkMjOuGIi48KunsVrgok4KvtbiI
	ipcAc7mfui9Mjcb+thEM5Y1QaJCLl/12emJIbRJBuxc3BRqisLcejIi8C4O4q/2s=
X-Gm-Gg: AeBDievkCSvn1V5CJo+YPHx61kLa6KzQN33jaRQV/gdu3G9SsxFi56YfrSYDNS4JIdo
	QcIl+3WH+Xnberoc7+0pbLWJimo751PBgIpGzc2EicXl4bsmoM6oIC8vO9JN//3SijZA/CJqq3U
	UKMJL0KdTsVDQBf1MRw0gHWgTiKWBpasRYnt1QfdvcMU50w13G5uvLyrelVKV5jF3GbvsnVHKZK
	WYxNwOeq7TVD+AlymL6Ax/xfeF8vIhACsX30wnRNdoI5KSJlOt4Zv/3wFcdA84ReKmLuv4/Wyrf
	8tf0Eb8z48dimbVCiOvKLQqQHKl4iBHzuLvfNyP8aNU04O8VpxcKmFK5MUa7WkunRxwLcfFZwWX
	DEnxmo7wQ/wz36nsu6q5k4Xg96+yZ0W0mUJJ5PcF1a7OTcsyPqznOLOOz
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488fb73d764mr551942815e9.1.1777240093412;
        Sun, 26 Apr 2026 14:48:13 -0700 (PDT)
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488fb73d764mr551942475e9.1.1777240092952;
        Sun, 26 Apr 2026 14:48:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm454414365e9.11.2026.04.26.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:12 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Magnus Lindholm <linmag7@gmail.com>,
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
Subject: [PATCH RFC v4 12/22] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <424f14373b3339c93cab7a080614b7e0dbe7596f.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
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

