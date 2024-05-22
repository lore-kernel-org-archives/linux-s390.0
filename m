Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EB20DF4
	for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412214; cv=none; b=sU86spRNthtGCN/KLh7o2sCrduE8L8i3rr1TyLUtJBt5vowrTrOmvxpl9xwCzDWuPE/9eim95Ed2AGIhvhk9NGDmqYGtJjuf31kOzvs1tdMzdRfyxFoJ9NKxszIqbE2Z3fq9AoUD4C6zCpdYOl4o7BbfyWmLph1Qr7v8YZlFdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412214; c=relaxed/simple;
	bh=teWvZqr4fuCe+HySoCjNXQIodCFoQbx9bF10G5JBqY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=IokLWDfshCeyGR0bDUTZAHzR4GdjBBUlpeJjAz2SJumsMTbfFu7h8dJkBoA8ZZyVVJ9APLQq/XmOzjOmeyaBNIlzLYnV9nKFtONL+F1PGDqG0B6m0kuy4M8EaaFndAQ13byeBCeIMoP2D9XMkLhL+9zENAP4o4Pc3pKsUwRU1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+2197S0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+2197S0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716412211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BFrd5ebkEcX4DAl9U00OWoi+E1totBiZiszJ1VoHyFU=;
	b=R+2197S0fM/MBY31RLqovLIQu3KyfxAdeq1RHw9bWuj1DksUfgvQV0bIONchCnUF2PpG5L
	iqmIH3JU+IGseW4uJCr4aEoOt1jyKfFRM73A/fK72c42e8gWI+Ss+OW4Wkho7loeKEl2Mc
	YNht0nQk4yDKc2PkkyH4wwdORQqzKy4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-PfhAI1_zPLm1UFU0pFUqFg-1; Wed, 22 May 2024 17:10:01 -0400
X-MC-Unique: PfhAI1_zPLm1UFU0pFUqFg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6aa12fc1fafso45607346d6.3
        for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 14:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716412201; x=1717017001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFrd5ebkEcX4DAl9U00OWoi+E1totBiZiszJ1VoHyFU=;
        b=eKMDoa5dsF+UfYbprw7Y3SF39iTj6Wh1ou783/tgwyHBa29bsUTASjgZDycTiIFnqO
         ZcflA4nyceRpa6gXf9yWd09CRufOCktKHop/Jb5nqKQUNH9jmJ2GJZ8qaniKoz9OU0tI
         dbg+oO2zrG82s+sojsztF5nsFtAmXtyvd2SCze3MEoHDuwhsK0H+0mx5xczgU1xngE7j
         ZWtUBWH+7iq0HSsT0nd+niEdF2J7Lq4oqV5Hf3VZkHGj9rb27GI3unv6CkR5ezlerMud
         eyBiA/52RQou6kRR2fXr3qpjMp6Qody5YVJ6cUhLK3U9vIB/kjrK5LTu4UdNpZP/41br
         s10w==
X-Forwarded-Encrypted: i=1; AJvYcCWx859FxyY5dKf5As17pbnrKV1vRZtJUn0QJpmhTDxAsdo8X/Xd+It2x32NIpGTvdelVZ9mexS0XsaJpwsXyid2HfUF6Z2FI4KwJA==
X-Gm-Message-State: AOJu0YwP+uBw5dbB5wsJnm5QMhTx/DiPreB/4hKLGhPLN6mBB7knI+F7
	bbOJu3LjSoqwnUtpWk3jFS7Nd/yjDDVlKAdOrFWrVzL3NS8RGDUfZeoh6/KfNlqjdaAPFkKelh7
	lXzEFoCmxDf9WOuu/3N7TqefEBxvhJOdEmM10bkBN8lV0wyL82a0Sm7GAw1A=
X-Received: by 2002:a05:6214:5b8a:b0:6a3:48af:8e82 with SMTP id 6a1803df08f44-6ab80900d8dmr35624496d6.46.1716412200519;
        Wed, 22 May 2024 14:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFReHW/gidOrXfSOPUsmAujbeGWtlLPFc/p6bBtQ535MfveRlLhqKqI7KsQ5F/jf8a4uc7Dvw==
X-Received: by 2002:a05:6214:5b8a:b0:6a3:48af:8e82 with SMTP id 6a1803df08f44-6ab80900d8dmr35624146d6.46.1716412199899;
        Wed, 22 May 2024 14:09:59 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a35d0bfeabsm73204686d6.2.2024.05.22.14.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:09:59 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Eric Chanudet <echanude@redhat.com>
Subject: [PATCH v2] mm/mm_init: use node's number of cpus in deferred_page_init_max_threads
Date: Wed, 22 May 2024 16:38:01 -0400
Message-ID: <20240522203758.626932-4-echanude@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

x86_64 is already using the node's cpu as maximum threads. Make that the
default for all archs setting DEFERRED_STRUCT_PAGE_INIT.

This returns to the behavior prior making the function arch-specific
with commit ecd096506922 ("mm: make deferred init's max threads
arch-specific").

Signed-off-by: Eric Chanudet <echanude@redhat.com>

---
Setting DEFERRED_STRUCT_PAGE_INIT and testing on a few arm64 platforms
shows faster deferred_init_memmap completions:

|         | x13s        | SA8775p-ride | Ampere R137-P31 | Ampere HR330 |
|         | Metal, 32GB | VM, 36GB     | VM, 58GB        | Metal, 128GB |
|         | 8cpus       | 8cpus        | 8cpus           | 32cpus       |
|---------|-------------|--------------|-----------------|--------------|
| threads |  ms     (%) | ms       (%) |  ms         (%) |  ms      (%) |
|---------|-------------|--------------|-----------------|--------------|
| 1       | 108    (0%) | 72      (0%) | 224        (0%) | 324     (0%) |
| cpus    |  24  (-77%) | 36    (-50%) |  40      (-82%) |  56   (-82%) |

- v1: https://lore.kernel.org/linux-arm-kernel/20240520231555.395979-5-echanude@redhat.com
- Changes since v1:
 - Make the generic function return the number of cpus of the node as
   max threads limit instead overriding it for arm64.
- Drop Baoquan He's R-b on v1 since the logic changed.
- Add CCs according to patch changes (ppc and s390 set
  DEFERRED_STRUCT_PAGE_INIT by default).

 arch/x86/mm/init_64.c | 12 ------------
 mm/mm_init.c          |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 7e177856ee4f..adec42928ec1 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1354,18 +1354,6 @@ void __init mem_init(void)
 	preallocate_vmalloc_pages();
 }
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
-{
-	/*
-	 * More CPUs always led to greater speedups on tested systems, up to
-	 * all the nodes' CPUs.  Use all since the system is otherwise idle
-	 * now.
-	 */
-	return max_t(int, cpumask_weight(node_cpumask), 1);
-}
-#endif
-
 int kernel_set_to_readonly;
 
 void mark_rodata_ro(void)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f72b852bd5b8..e0023aa68555 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2126,7 +2126,7 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 __weak int __init
 deferred_page_init_max_threads(const struct cpumask *node_cpumask)
 {
-	return 1;
+	return max_t(int, cpumask_weight(node_cpumask), 1);
 }
 
 /* Initialise remaining memory on a node */
-- 
2.44.0

