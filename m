Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E532E400
	for <linux-s390@vger.kernel.org>; Tue, 28 May 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922844; cv=none; b=WcEA+EF9jJpgdthy7JpqSTRxBN7ttUTOwn/nyNj+8I5KLNKy4xgdyRSr5a0Wr9oBQjJKOjG2WYwrlhGcNZnhNVDbjkH3TM810OgrXJaSugHgArtqisZQVkgQrBFKooUKy15qi+4atCTuNbFlbAKShpDS5RFlPpGMyG2gkbqmHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922844; c=relaxed/simple;
	bh=f+voVYQgJ6rLsoG7iQDzb3odNjuXcpx3jZ1qlcYa4aY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=bdNKjcLxk/uizrsq9aTS7MGTZ5RQYNLf06o/nt4IQkzVDqr5vci3PZKYm95yDdone4Lz9uIkYSlbJtvGvU0xr0WSTYbynzNzBzpi4wnUTFJEOInt5cajOAjXeJCv+Y+opg0Byi0xqF5otKZMuIUvtleQ7crIlB7nU68bJJ3EWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WE/CSpIS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WE/CSpIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716922841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EroyhAMtYZlwFiF+i06GpFh0h6zXLI4AvXcFdjRTODk=;
	b=WE/CSpISAN2XMbpdDZUEbE6eUfsq/jFIUAMb5ZN8Vm1o8573Nrv5kCC2JYV9ZIptHYQET4
	bFicKq3X/3JnfpUGmzVsHOWBE6cbFK5861fWZZHYiqwKoTXqR02Ap06W5zVb8+Vc1HAZ4m
	jsRhZULhWMcDqno8Yj3kxO95ejh/+lU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-tc1QNwtTNuCDaaEZtT8NUA-1; Tue, 28 May 2024 15:00:39 -0400
X-MC-Unique: tc1QNwtTNuCDaaEZtT8NUA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43fde19a996so5653741cf.3
        for <linux-s390@vger.kernel.org>; Tue, 28 May 2024 12:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716922838; x=1717527638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EroyhAMtYZlwFiF+i06GpFh0h6zXLI4AvXcFdjRTODk=;
        b=jEL4z4hIqTv3IVdohC+QEMnj2j/xQLu0j3p8jSVXKt4Cxt4MezsHdumkC2SRJnzwZF
         fUkehXl+Am+nWZTPsGOa4EHNH1ArrZ0DPaat9yCrljz+ghl9lm8rmNUsOrWML6pzF+Yp
         wMurWJjS0qquUQfSqH7uNviHTdto9uozmvsvtxMVTl1O4N9mFDGJB91XtWOve7ZhKY3+
         T1qyy2HIcS3eijNQacYZ9MZmoXCwwqBrBpxQNzvgsTj0yJbzLUUnlpPE2J4S88DxJ0ZU
         wNr6tUygmaDvNhWEp6YKRxeVnTya6xRghL8yl1crhRvogRJSIcRxd2UzO/o3KfHK4QxA
         w2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCHxI3NVDlBHx9pYg82lOjSk9rvSJmModKIKVpsQxvSSkVS7YrhVSddAAxAsLe+UlE7E/Bz520+io667tuaIvQth6vDjBmO0dOqg==
X-Gm-Message-State: AOJu0YxQ39Fzgybz2pLhznl44a0ZgWrm7SbwL1d4fmbY03Z5OLFfuDxP
	NetaOfJLxf9fC8YoVOLSi9ertSjZ0GkJd5suyKFNHTxXpXFMcoMF7YvUGi+ROkD3qbMvrxn18da
	OQTFEDZXR4fi/FPoP6as1bXlNnc7YzPhtSIlIEKastJPMuhDyMHziH4UIycg=
X-Received: by 2002:a05:622a:10a:b0:43e:34ea:80ee with SMTP id d75a77b69052e-43fb0e8d809mr134384031cf.29.1716922837941;
        Tue, 28 May 2024 12:00:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLHIs0G4ODwLtaTgMc9fP7BM4N2EDamkPS2f5rSvXhQ/RuodqmrywBv65gQp5ZlO5A4PV4Ug==
X-Received: by 2002:a05:622a:10a:b0:43e:34ea:80ee with SMTP id d75a77b69052e-43fb0e8d809mr134383451cf.29.1716922837199;
        Tue, 28 May 2024 12:00:37 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17f69ddsm44981881cf.41.2024.05.28.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:00:36 -0700 (PDT)
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
Subject: [PATCH v3] mm/mm_init: use node's number of cpus in deferred_page_init_max_threads
Date: Tue, 28 May 2024 14:54:58 -0400
Message-ID: <20240528185455.643227-4-echanude@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

When DEFERRED_STRUCT_PAGE_INIT=y, use a node's cpu count as maximum
thread count for the deferred initialization of struct pages via padata.
This should result in shorter boot times for these configurations by
going through page_alloc_init_late() faster as systems tend not to be
under heavy load that early in the bootstrap.

Only x86_64 does that now. Make it archs agnostic when
DEFERRED_STRUCT_PAGE_INIT is set. With the default defconfigs, that
includes powerpc and s390.

It used to be so before offering archs to override the function for
tuning with commit ecd096506922 ("mm: make deferred init's max threads
arch-specific").

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

Michael Ellerman on a powerpc machine (1TB, 40 cores, 4KB pages) reports
faster deferred_init_memmap from 210-240ms to 90-110ms between nodes.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

---
- v1: https://lore.kernel.org/linux-arm-kernel/20240520231555.395979-5-echanude@redhat.com
- Changes since v1:
 - Make the generic function return the number of cpus of the node as
   max threads limit instead overriding it for arm64.
 - Drop Baoquan He's R-b on v1 since the logic changed.
 - Add CCs according to patch changes (ppc and s390 set
   DEFERRED_STRUCT_PAGE_INIT by default).

- v2: https://lore.kernel.org/linux-arm-kernel/20240522203758.626932-4-echanude@redhat.com/
- Changes since v2:
 - deferred_page_init_max_threads returns unsigned and use max instead
   of max_t.
 - Make deferred_page_init_max_threads static since there are no more
   override.
 - Rephrase description.
 - Add T-b and report from Michael Ellerman.

 arch/x86/mm/init_64.c    | 12 ------------
 include/linux/memblock.h |  2 --
 mm/mm_init.c             |  5 ++---
 3 files changed, 2 insertions(+), 17 deletions(-)

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
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e2082240586d..40c62aca36ec 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -335,8 +335,6 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 	for (; i != U64_MAX;					  \
 	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
 
-int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask);
-
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 /**
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f72b852bd5b8..acfeba508796 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2122,11 +2122,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 	}
 }
 
-/* An arch may override for more concurrency. */
-__weak int __init
+static unsigned int __init
 deferred_page_init_max_threads(const struct cpumask *node_cpumask)
 {
-	return 1;
+	return max(cpumask_weight(node_cpumask), 1U);
 }
 
 /* Initialise remaining memory on a node */
-- 
2.44.0

