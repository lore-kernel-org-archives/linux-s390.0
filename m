Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887F34F479
	for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808913; cv=none; b=EE44z+W0YQmwV5VKL0yg3c7Wu1m11uj9KufvCkfJOzRfmLVnQMVJB0+vsR9dhmB1tc5xSL58iP2WTIXdjBq8qoRatqEgW4Lkoc3hurPuh54QAkhFnY9rbzivfGbkB6VS5Kq/744+xf9Izk3ziNIUrspZhCYeo9+7N7UiOaKNXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808913; c=relaxed/simple;
	bh=xyYx6EKfSNYgy8umDBVjFDGC9ANxj/5Tbt7GkFR38jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RosXm5aOsNZ5CXkdUN4CUhi9teotXABJxRdIkDtwgk2qwuDJ3vE4zjAEWMqoE6uZPqn1qkCQZEE5UnyHyW0vWSRMXynil08dZoE2DQKhbBasXTJQzbJIGqPItn05E2A0N1DhoLAO9zVZJA8d96J6FGfR58LVpRNgo82PaKgWVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3Ku1jm7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VM8sk+fz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3Ku1jm7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM8sk+fz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVwG8S2po1iduREwk8io7PMDE8wG9YqvUAWHOi+D4qs=;
	b=T3Ku1jm733ofpBp4NFCYlA7i+sj69T7vm948aMKzIgVWKE19VZbZLcPzkpCOq7ZEZTqkCk
	FmGRTwtbid+xyNunPg9WXAhw1JyaPBDcHFzsvFnXCyJd5Jn4WwbieAg3ykVahIYkKz+9gu
	nplNJoI+1mGjOv1V71IS639F8qvMlg4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-3yGJkB-OO6SEKREzgRuH6A-1; Tue, 21 Apr 2026 18:01:48 -0400
X-MC-Unique: 3yGJkB-OO6SEKREzgRuH6A-1
X-Mimecast-MFC-AGG-ID: 3yGJkB-OO6SEKREzgRuH6A_1776808907
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4891f2eecb7so16045675e9.0
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776808907; x=1777413707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVwG8S2po1iduREwk8io7PMDE8wG9YqvUAWHOi+D4qs=;
        b=VM8sk+fzYFB9wZrk6YKEd38F5lC5fNsgZhgtGGi85s8KRi/uWx0lareBfmfdcVrWGe
         j8MjQrL+jyJkLq3CIaj5r/VNoHysPPxSnw+5eo1nUWCjGFl/fkfQA8xBQVbiNYuOaDA5
         WzaVZoyY9ZNo5af5Z2SIrwOQvawrD/37UqhTY2z/UpI9pQGyE+269yGyrgYunGPO4MuW
         crRnYP9u/B3uSTAMyJeLi668q5D6UgEAJSAS4pIFi7An2eyI1ETJ5EKB0KS+PAY4105F
         wR1qdk5SBBRvgMFUqjHoRid+JdalxzXd+peb5SwkwzmNJ3Y0qQydN8V57HhRMonG/xuV
         7Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808907; x=1777413707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVwG8S2po1iduREwk8io7PMDE8wG9YqvUAWHOi+D4qs=;
        b=ZtFwNFkAS9CO7jkmwdEYLcbP/wBoF8DavimpoYpa+aY5dZ3r88YZqXdjwenvYUGHDX
         AdJa+k6IC9VJD4HevELOneGzjN+UahOyX5uZtjLmN9mTEk9880oh0lMiCjJuCkXfM+1x
         DGSCev5sy5HmOY3afeJ76RLGC1xNvA7DKR3I2BLGwiRsagchCsowpReHU7nJqsNTgWRq
         hDI47M3m0Mpo7PVi2T00pq+EUCpEskKA6g1X10dBibWE9TeJngclkbh74FC988Q4er9/
         0N5BAU7XWY2aAUvdf0RoJmyZu6EIJUUTsuypEeEMoyIKk9Qzbf6CYVT7MDq7yPij3gqm
         u9uA==
X-Forwarded-Encrypted: i=1; AFNElJ/DnNqlkk1Xrp7eDIup+ttePCui343V/T97fkDI5GYTFE7okmvUZnhkB6vmJ96e8cBrJxamFvCDKAxJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaik6MzYW8e9GcDF7dSBRlJafuw9+RlfV5G4xDhFLXnUVPaRUg
	3od/1vkYnm3scDW2YXM2Lm13hHVcGvG6v1PJMR5UsIMcD4mDa9nv1zMQ6KgHDRy8Xm5Cvre2SCW
	toPR7HbmXMyYPlbTmyltvAM9yC5+ndVYfNvsJ55f0xOxa52Y6UVfPPI3n0Qdss68=
X-Gm-Gg: AeBDiet3FjFfM0H9UN9GCAWjLZzva0VYUC4xuS0jBLQkHGYN0d7TKIlh5U5rfHn0pAx
	dxkUp4fEBL5ZaItmdKlC/D79TlAYBMChxffrlJFHy56aQ2TF2RZEyTiz2gFNSKiQt8Wqs2sXZLI
	eJUHEK+Uta/EqoIQc1vuGTUy31rgsI1AVKu9PC1rNm1FjH9yyMSDkQSIor7yOP2spkanSVX4c4s
	I3ic/m0fcgcYHHIF0yvzz0VPU8COfnm3nDTy1FQvCakM8v2DmYT35DKMqN4kzGltvbtv7lg2c+B
	cBL1dQS2ceCv7O6u+B59bc6ALInBGWKKAOup3+rdTh5t4I2mJNWhE6wVvpQhVaWjrypBsrehI3M
	fToSou5PIjTUkAKrMUOxyQ8/JN7/m4HfkbV/C51pOvQD/TyN9VJX1/g==
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr57315945e9.7.1776808906897;
        Tue, 21 Apr 2026 15:01:46 -0700 (PDT)
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr57315565e9.7.1776808906442;
        Tue, 21 Apr 2026 15:01:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8193sm361473545e9.1.2026.04.21.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:45 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:42 -0400
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
	virtualization@lists.linux.dev,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: [PATCH RFC v3 10/19] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Now that the generic vma_alloc_zeroed_movable_folio() uses
__GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
x86 that did the same thing are redundant.  Remove them.

arm64 is not affected: it has a real function override that
handles MTE tag zeroing, not just __GFP_ZERO.

Suggested-by: David Hildenbrand <david@kernel.org>
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

