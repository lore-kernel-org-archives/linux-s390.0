Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD63D5647
	for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489698; cv=none; b=HH8KVGbqo3U0mFrAMbFYoDT5Ure/ZXxKqsux9Ug+czfVSd7zxrWOYdU2mVWrkbUpK86TW4zhktIFEl2oEDD4EJAB6aF9DUxN5ni6VNNbFhcFhTGxWSPVLWUXibaYeS50adZm6IyWG9gnGGFI07nA4AGf15qmpnWvcaTPArSBD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489698; c=relaxed/simple;
	bh=xVZpENOTPSkcCw9H72WToBvwV1ZsJAWZkigdtcUbLLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfrk5tNROLTM+vpZGv1lQmkxPIKmoIJsSBNsx5Q8mN02DCz48s0yLrJtcQjdSoQMSgFZ6X5gIz45b/Hh8wEQoFxkxND1CJRyZP6gbXRj3EqMN/9RP2Lc6eBzBUAqVx1LHpaLzCj6ktXvGgn3AvyL7lGqJC4VoBHlpkXH6ghJcoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2es8Z0f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kDHRQF/d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2es8Z0f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kDHRQF/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
	b=M2es8Z0fR81f9xl6NPaBs2Q70yl5V0+AF0gQpDBziSXf/vpy62fI5iYDsS+HhoU4WbNLjS
	PSKeMrVsXPIzLdeJ9vsVhbqk9clXKgDeYhOmslwysHM+qm/iDyjEMtq3OEs7GF2mQuhHEf
	OPUD0Jl2QnwSnWEsoh1fAY56L/XYjR4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-BQH3OYY0PSOQ4LlKdnOheA-1; Mon, 11 May 2026 04:54:53 -0400
X-MC-Unique: BQH3OYY0PSOQ4LlKdnOheA-1
X-Mimecast-MFC-AGG-ID: BQH3OYY0PSOQ4LlKdnOheA_1778489692
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48919890a95so25995275e9.2
        for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778489692; x=1779094492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
        b=kDHRQF/dOmNzIAhcGmS9Wn1QckUrx0zY8goOH5wfUlJ08AeXpDeCK8oHPHK+JhioS4
         1v37C+LP8oO8dLDkXo/kU9ofp9tABD6FAbLSHmPxAoNsXx6YMoGRx7luUUJcjN1PPSfS
         KwmWdRQsdB/dAEdI15XXDGhFTJ05Uq3hkKBQofMN8EkbsxZ+xLnRFpZH1oP+8TZnUXTc
         np3v3OIGMD7K7VIu2ipdFHXVa4NpI2w16Z/ug8X1GpDVYSMvg4CZ3MCxufC78F/Kwn1U
         TH11uyKD3paTZ+3cex+w9mjIr6WT54P+aeBJA1GWjTjYIOQl9WxhQ10F5pNJkLkWcKFD
         1/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489692; x=1779094492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
        b=RsremXFC0DJIu8xj0Qe6L5D5z5DoEIfn+d/ipwJWfV8xLYcZ9KlTs/4jm5RR/IhZM6
         z7GUvzG3zIN0lOYLDW5eCNhhwdBzIl9IzjVhl3mi7RwGP5w0gsPaPmUiukjs7P7uLazh
         Evj3kA5WKzHsjJo0+W8yMQ6uXkdfO4Z+BAA/dya6cHKYn8wKpVCYLOeGCX44EIUmpdd2
         xMoskdXaiuXKw1gwj+F/ycynm3LhnGtfhDYsL8lAAOCuhejhzOjU8mEsh7Rc6iMUel9D
         vyOnakcYaK6BP5NnTdGiMdepE4P1S/iHgsrZjx8+3EQsaJMzebG11YlDvx5CvB1HQAQq
         ov+A==
X-Forwarded-Encrypted: i=1; AFNElJ+sF2O+SVAb66RFi68VYEaPGfzjCp2qQ3HN+wnQiobwi5hHgHH+S3bl95eHuW7dnn2jNmezdWymsVQI@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLEClGn31xbDSB7F9BY1gzQ9X6mfpISmCU8/W3hQHuo4D95y6
	BqSuLjQqKcIOAw+429eriVs6dlu0AFDxMp/ORo3hHzTkqpbz6VnQWO+nH/JFFOq3sL+8vRwJcf1
	Ou3o4c1FQmcZ55IOOuZK0n6HVJ5gSOVxniXz/D9YwAWM0y9lX0nm0eip3mwQByGE=
X-Gm-Gg: Acq92OEAc0eMCAEo2heAAOOO7K5Oqs9ahiQe7ihEj9iBFhbEmF9h76UVal67sTiTSI0
	QEousCPx491gs6JzhH9TpA0MN5K1jsIexA9wDBOiE8FeNIwVjAqxg7VDj0y/hstxDnWuGXdl5kG
	W1HxAaYYN9KhClYwSWkbtd7mp4WR9e6o6f2QPRStBU2gqTVgpdE3u+IyQmIEihB+2PuLQdZo6hN
	CP/ZFsYMXanZnIprFjAfle5sGlSgD8Vo1Vk0iY+0FX/Ca0TkodUBTi/YTgEHPXIxB8mpSjGtC1J
	Fc/WnTEZRxzEEZj2/7daU3n1D5rrRkblAmdTn6+/5bGFE/H9SYZoUDl6/dmdT5hX+jcollcA8F+
	lO7mjmePn1Do0pguiyz+SjcyflOXf7sm7EP+rpdgS
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48e635a1ba0mr253243835e9.0.1778489692280;
        Mon, 11 May 2026 01:54:52 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48e635a1ba0mr253242975e9.0.1778489691662;
        Mon, 11 May 2026 01:54:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454919c13c9sm23822939f8f.27.2026.05.11.01.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:51 -0700 (PDT)
Date: Mon, 11 May 2026 04:54:44 -0400
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
Subject: [PATCH v6 15/30] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <64e3432a5982607dc886f5943f556f54c0612e3e.1778487000.git.mst@redhat.com>
References: <cover.1778487000.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778487000.git.mst@redhat.com>
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

