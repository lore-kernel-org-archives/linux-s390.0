Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4A1DFD96
	for <linux-s390@vger.kernel.org>; Thu, 27 Nov 2025 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206151; cv=none; b=OqKSVFqzwtFtquGY9iaC6Oqf6Vh5JPMHPoSZq9HCI3AS6an47Dmmed7OjKeuzVPPIrXwW2e2o2p+t2BcwSzNIUKhFNXmTa4rVFpX/9BpOIpo2lnxKn2J0vU6XHMhbxjuv6GIKvTyRfw96gbyXNRY8oxJazr5lukWCT1uG5+CkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206151; c=relaxed/simple;
	bh=j3aN58VJ49CNxC1tU6w+qQp3Kagn9SOUYyn6llCeIRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dz7kDBwaC6Pgjk9LHxCQ/RaKMe7EA/VuMz0qwcelhOtP13Kad5IE3yiKs9qtS3taHEpbXfjdNwdcEZ590LVas0lk3JTN3S6h6QEEs3XT694sPYycCYhwl+Ej65oqnMTAW4prZx9l/1sqWq0JNmrapIJwbWBXDsDy7exQhLtcTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inDW6ydf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inDW6ydf"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7baf61be569so350890b3a.3
        for <linux-s390@vger.kernel.org>; Wed, 26 Nov 2025 17:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764206148; x=1764810948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4p1bn22G2i0XoJzrL7o1dUUJ8ghtmPDbFaXYxRwFkI=;
        b=inDW6ydfRS1eT9wsaJ6zpvEae53AArZX5zsf9AMiIjpBhuZtexzRWSCxsmF8DzYHiL
         oWD2e148UGBAg3QlKNiZIS8getDWQ+9MnfRC0wwbAi5Ht8nFq2cc1fecKBpeL/Uua6bZ
         C1bB+Arwb6vHCZicborKNPvxBi48w6IIXDxG9Tz6+T/YmrpMm8dumxtT+RRkJP1DF+NA
         92znTl+1bcivU2tIJ5yEDb8SZ7wR0YzABHFMpo4ZmAX3RqbiZMF/HRY6aVr8rokWinTu
         +lA8+fN8t4jXCiXnUYbWkHwBXVk3b7Q8HlJjVMaw9H5zP22E2/+CA3prVyO2VeSHJAyy
         v3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206148; x=1764810948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W4p1bn22G2i0XoJzrL7o1dUUJ8ghtmPDbFaXYxRwFkI=;
        b=isA9fP1o/aUMEciS1QDPMdsNz0j5uOTO5G4xWDJDEUVQBLLutsN+zQijPO+JFBkbck
         IKF9zAV3YNBaN2WdxXfTUdZLNEycCU38NkdKp9+9weBdx6DXGpiuH8iGpPmPe3lpmiio
         1Cc1WcZhGIHskRVNj3nUHFIq5dhWq9YIx9SwVtDrMKvgEJ2BL/jRVrsCJ6YQV+pYvmlE
         PnLLlFWFV+lxvVCQ7y0D3w7+oa1c4FaCnf5B7pL0yG3D2z25j1/3/uT1wuVxvRH1Gayk
         +AH0Fc/Zbu+dq2/hx6HuDKCLtasyrlREiNfOU/Uy1MwPIupiVsUmn58aXerxy1R+xt3o
         QukQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeD4vokS5h23Gm2p/356WNKt5XibDU4CXA6BllwXBHIkupwFz0hl1030F0D2jkNlp/iuEbOzOwDkvB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/BB4wbtBP3VR9oEhA5vwnZ2q9ErHboforCFjavBkl5i0vjEjg
	DQgz+AI1LYe9b+1h+eGpQdanMqBk3+XdR3ulYoHWQjTvmzARUxgfrFe0
X-Gm-Gg: ASbGnctAvQsPp/fzKe+oSVnIjDGuHQ89fGeEfgJSO/DiQ3CGVvN8qSjY94ppKjMsuZo
	LKPbDHDUHmZu8kSJLzzTFEUlI1KFfhAOappSLlSk8WEStCkdRUeUhoVYsuuawlS6xKjJ3k4VILw
	p06HRqnOpDOrf/RhbmFruG9xwpIQbncAfYeXIQslyJUB6eHqZfnGWdqti9VP3qoeSB2thfEIBed
	6HMcIskqXf2D4DytQpde7NE4aFbvL0dq41N9S0fdJRIJ2GueuSmCPAue2hVw+OhEyY60w7wLd50
	48U++vmFO4KyNds7P7mwzp3tiJEENcZwGrAd7RJ6TTc5T86iavvI/MiTGXgZCK0tvEpvtxB+o/U
	K7m8jieHwpA3r6FfvNjIJlnoFwNDNTk0gTG8/KX1+18xEgp5RPsTXOire1M6k4xmMUEMIZCoabW
	GMbG6ElXvurHXZU1AkVW9mTUqwUFuEwC77Jbk=
X-Google-Smtp-Source: AGHT+IHM/YJW2qPboNwUb7KDGSWGsZmmt6gqbwAlILL0AqNuX4PEwg/PSJbXIFKwaU4zyLqhhDzUUA==
X-Received: by 2002:a05:6a00:4616:b0:77f:2dc4:4c16 with SMTP id d2e1a72fcca58-7c58e016d67mr22034173b3a.21.1764206147616;
        Wed, 26 Nov 2025 17:15:47 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c414c226f9sm22447356b3a.53.2025.11.26.17.15.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Nov 2025 17:15:46 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Matthew Wilcox <willy@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Oven Liyang <liyangouwen1@oppo.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Nam Cao <namcao@linutronix.de>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 2/2] mm/swapin: Retry swapin by VMA lock if the lock was released for I/O
Date: Thu, 27 Nov 2025 09:14:38 +0800
Message-Id: <20251127011438.6918-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251127011438.6918-1-21cnbao@gmail.com>
References: <20251127011438.6918-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

If the current do_swap_page() took the per-VMA lock and we dropped it only
to wait for I/O completion (e.g., use folio_wait_locked()), then when
do_swap_page() is retried after the I/O completes, it should still qualify
for the per-VMA-lock path.

Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Oven Liyang <liyangouwen1@oppo.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Kristina Martšenko <kristina.martsenko@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Wentao Guan <guanwentao@uniontech.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4f933fedd33e..7f70f0324dcf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4654,6 +4654,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	unsigned long page_idx;
 	unsigned long address;
 	pte_t *ptep;
+	bool retry_by_vma_lock = false;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4758,8 +4759,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	swapcache = folio;
 	ret |= folio_lock_or_retry(folio, vmf);
-	if (ret & VM_FAULT_RETRY)
+	if (ret & VM_FAULT_RETRY) {
+		if (fault_flag_allow_retry_first(vmf->flags) &&
+		    !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT) &&
+		    (vmf->flags & FAULT_FLAG_VMA_LOCK))
+			retry_by_vma_lock = true;
 		goto out_release;
+	}
 
 	page = folio_file_page(folio, swp_offset(entry));
 	/*
@@ -5044,7 +5050,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 	if (si)
 		put_swap_device(si);
-	return ret;
+	return ret | (retry_by_vma_lock ? VM_FAULT_RETRY_VMA : 0);
 }
 
 static bool pte_range_none(pte_t *pte, int nr_pages)
-- 
2.39.3 (Apple Git-146)

