Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2930AAD3
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718367; cv=none; b=hRCWkCRJiO07CW724u4zs6detv5tjie57e57M+wekwqedAHTj35rxG3Y9f46+SDnvar5vZhoDRCPMQyGNE5gUYXgbVPem7u0K4k2A/WjDUofdxiwfrySeYb/TQpL6PivLEs0NeSIZs8oRBGNOJo5wjb+3EQVoZPdrn/w7qaVN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718367; c=relaxed/simple;
	bh=mKqCh67Y8GjWCP9TMAeIQOxT8NZFxglB07weMmMn2YY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VNBgjyqOJFtIO3kJOeD55IBv1VSMj+yW4bNnqlZ7OK8KGRDraCHjtDNrtO7XSlRYbq83p52TuoiDb1rfpETLH1al551U0jnCnYF8yJHoKjDAY0pv0y9OIp6kX5cpaHVlvgfJi2gpwFosUIGBckY6kmvl55HmRcVAVz5E2GVYDL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=f2+0jrbv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="f2+0jrbv"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afedbb49c26so627576166b.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718364; x=1757323164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IjlvOc7eDmq89ai1ZTLunEbTu4eGMpRVy5UBgVL+2qk=;
        b=f2+0jrbvllazQq6qkTQULI32d4ElFex75hfRYAJRO/ydb/LPYGnbhM/80J/Qvf4M2N
         MxPcbTuhccEM/Gv08YKcl75bUamgDiviFf6gAJiyrferkSLP/2cW7OIfX3LPxgaLoc1I
         MJ220OqhlZCjvzrfLwisawF3CyTFYTYV7vrvlYHxcGRviYdDQ1l6hX79Ytiz5Fj5HJZv
         ao+/Xo+mwRAV6LurzqzF3jdn4WxtbhTV2MNBnpKL4NYATqRI/XTTeXwHhhHrkcsb0UY2
         dEPz7P8ehtUc0CdTqjZ8xoZjNc8tuCBQPabp9qAbr7jCRt1zRakJJc5zZeSFzYDWlePU
         GSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718364; x=1757323164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjlvOc7eDmq89ai1ZTLunEbTu4eGMpRVy5UBgVL+2qk=;
        b=ZsDaGzAi2i7Iv3LS57JCe0fSSpZPPpvegxdnaDw3WJ7PmGmAL0DMbMOlA/h941ud07
         4i+dU3jolZ/NWluWBGOL5XIveWSDd8rksXS+5v2I+BOUJ2aqN1Wd9/2NPXlybe9zlWuW
         6fHj1bDTu+fR+z6VZcSPlPbycqTGwq05eJmtyKjdYmsYEYKj9qzxY4AX++PlbIUUmwXK
         qmenjTgQmsTKrDT71Yz44Hz8bkgOEjk8epXUm1BJBYIM2Tpku6eRwSomruIDU1Rau7c2
         yYDvPaHTS5fjDnsO4265SIkGuNs76B2TAS4OWMfeAa3o/q3qZoQCRLad+uROf/cCYc9P
         PJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWebsLJZpVOhLKwID4ql4vTh9H6cOdyLYQh1SxRz7FbgPU6IAJV9AKmjOWOyQIzo0Qn90TwSEsRDRBq@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlsrmT91QcswjqFJx5DOAdF+HWTzrJvwTeYNdcqMAWrBjJZPj
	FWpMJwoJi7+jdwbukjp+hfSq+COfJbaikf9CNs8Nc1QxCc0Cy9pmUT0pwwj/MQ4cFJ4=
X-Gm-Gg: ASbGncupOa2x87s08K6PdSaLFELwjQ7CJe7GuxCDTk+wlSbZWRMrnCbgJhmWcTMFyFl
	Xq07Eap4sWBNlussqCErcK9leRPZOgrDrxnuUzy0aM/N9wUNMPZfsy8AoA5+/YFNSjFBuiPZLGW
	HaGZPryVutH3tlTy3ummcaI2mHWFwYkPGFq9Ls2z2nvliQOYl0GIGvgkJbo7s98JFLWSiHEHKR9
	C6K1iDQfc1FdaCZTKAKn8y/zwvDcjXlKV6HTXzMppgbvNgvpJKAyxxedoKMaac9dDZEeNbOcYAv
	CIBRTnkbh7dgo++cGcs2qUvGiOUsNrjReHWZWfzDGViCR2i39WDWZvsbVmhfHvKECQXKuT/f3Vx
	Ah5G53vhh2k9mLylFV4JaHEFw6bLa8LovdLe90hUxA/dRmkzq2byKbNYcpUC53fInFppTfedb4y
	K3JYTosGeYSSNcWd0EYdX3TORovinpNncq
X-Google-Smtp-Source: AGHT+IFTes99iR4h1SIirBohNckEBvGOnxGmn6ipBhPiK9MotguUOISNLv8vVelWffxZXwdx4Lg8FA==
X-Received: by 2002:a17:907:94cd:b0:b04:2cc2:e49c with SMTP id a640c23a62f3a-b042cc31acemr254882266b.19.1756718364079;
        Mon, 01 Sep 2025 02:19:24 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:23 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 00/12] mm: establish const-correctness for pointer parameters
Date: Mon,  1 Sep 2025 11:19:03 +0200
Message-ID: <20250901091916.3002082-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

This patch series systematically adds const qualifiers to pointer
parameters throughout the memory management (mm) subsystem,
establishing a foundation for improved const-correctness across the
entire Linux kernel.

Const-correctness provides multiple benefits:

1. Type Safety: The compiler enforces that functions marked as taking
   const parameters cannot accidentally modify the data, catching
   potential bugs at compile time rather than runtime.

2. Compiler Optimizations: When the compiler knows data won't be
   modified, it can generate more efficient code through better
   register allocation, code motion, and aliasing analysis.

3. API Documentation: Const qualifiers serve as self-documenting code,
   making it immediately clear to developers which functions are
   read-only operations versus those that modify state.

4. Maintenance Safety: Future modifications to const-correct code are
   less likely to introduce subtle bugs, as the compiler will reject
   attempts to modify data that should remain unchanged.

The memory management subsystem is a fundamental building block of the kernel.
Most higher-level kernel subsystems (filesystems, drivers, networking) depend
on mm interfaces. By establishing const-correctness at this foundational level:

1. Enables Propagation: Higher-level subsystems can adopt const-correctness
   in their own interfaces. Without const-correct mm functions, filesystems
   cannot mark their own parameters const when they need to call mm functions.

2. Maximum Impact: Changes to core mm APIs benefit the entire kernel, as
   these functions are called from virtually every subsystem.

3. Prevents Impedance Mismatch: Without const-correctness in mm, other
   subsystems must either cast away const (dangerous) or avoid using const
   altogether (missing optimization opportunities).

This series adds const qualifiers to pointer parameters in functions that
perform read-only operations on:
- struct page, folio, and ptdesc
- struct vm_area_struct and vm_fault
- struct mm_struct and address_space
- struct zone, lruvec, and mem_section
- Various architecture-specific mm structures

Each patch focuses on a specific header or subsystem component to ease review
and bisection.

This work was initially posted as a single large patch:
 https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/

Following feedback from Lorenzo Stoakes and David Hildenbrand, it has been
split into focused, reviewable chunks. The approach was validated with a
smaller patch that received agreement:
 https://lore.kernel.org/lkml/20250828130311.772993-1-max.kellermann@ionos.com/

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1 -> v2:
- made several parameter values const (i.e. the pointer address, not
  just the pointed-to memory), as suggested by Andrew Morton and
  Yuanchu Xie
- drop existing+obsolete "extern" keywords on lines modified by these
  patches (suggested by Vishal Moola)
- add missing parameter names on lines modified by these patches
  (suggested by Vishal Moola)
- more "const" pointers (e.g. the task_struct passed to
  process_shares_mm())
- add missing "const" to s390, fixing s390 build failure
- moved the mmap_is_legacy() change in arch/s390/mm/mmap.c from 08/12
  to 06/12 (suggested by Vishal Moola)

v2 -> v3:
- remove garbage from 06/12
- changed tags on subject line (suggested by Matthew Wilcox)

v3 -> v4:
- more verbose commit messages including a listing of function names
  (suggested by David Hildenbrand and Lorenzo Stoakes)

Max Kellermann (12):
  mm/shmem: add `const` to pointer parameters for improved
    const-correctness
  mm/pagemap: add `const` to pointer parameters for improved
    const-correctness
  mm/mmzone: add const to pointer parameters for improved
    const-correctness
  fs: add const to pointer parameters for improved const-correctness
  mm/oom_kill: add const to pointer parameter for improved
    const-correctness
  mm/util, s390: add const to pointer parameters for improved
    const-correctness
  parisc: add `const` to mmap_upper_limit() parameter
  mm/util, s390, sparc, x86: add const to arch_pick_mmap_layout()
    parameter
  mm/mm_types: add const to pointer parameters for improved
    const-correctness
  mm/mm_inline: add const to pointer parameters for improved
    const-correctness
  mm: add const to pointer parameters for improved const-correctness
  mm/highmem: add const to pointer parameters for improved
    const-correctness

 arch/arm/include/asm/highmem.h      |  6 +--
 arch/parisc/include/asm/processor.h |  2 +-
 arch/parisc/kernel/sys_parisc.c     |  2 +-
 arch/s390/mm/mmap.c                 |  7 ++--
 arch/sparc/kernel/sys_sparc_64.c    |  3 +-
 arch/x86/mm/mmap.c                  |  7 ++--
 arch/xtensa/include/asm/highmem.h   |  2 +-
 include/linux/fs.h                  |  7 ++--
 include/linux/highmem-internal.h    | 38 ++++++++++---------
 include/linux/highmem.h             |  8 ++--
 include/linux/mm.h                  | 48 +++++++++++------------
 include/linux/mm_inline.h           | 26 +++++++------
 include/linux/mm_types.h            |  4 +-
 include/linux/mmzone.h              | 42 ++++++++++----------
 include/linux/pagemap.h             | 59 +++++++++++++++--------------
 include/linux/sched/mm.h            |  4 +-
 include/linux/shmem_fs.h            |  4 +-
 mm/highmem.c                        | 10 ++---
 mm/oom_kill.c                       |  3 +-
 mm/shmem.c                          |  6 +--
 mm/util.c                           | 20 ++++++----
 21 files changed, 162 insertions(+), 146 deletions(-)

-- 
2.47.2

