Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369308;
	b=P4lEfZu+QaTAoYkg+4e+D7yoTrZ94KAe9WQQKH2OOUMEEPeDZXkXtg5Lqg8SljaiLGiC
	 K2JDAYd2956RuGHkqiHYfiaZjh/+eGG5+ObHArmkwnOnTET4dK0Jq3TRxk5Nka9l0/lhj
	 wJzmuyJFnyRBmy1oMVHH01jMkas3TCYxvWf29EPUt8z+w8iM0rW25dUigdUb5P811qsXV
	 7PcjK6tO5EOoavVDorQ0bSlUUA1D1ct92M+8AuWVCIvanhr4o4sxrePyZ2tByGrqU9Vmv
	 qEAwkehYlWf1tuWF19cyEk3LIgOuEUvq2StCJvMnje3XWXjn+pRl06BVurnRtxkvjKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OGrdsvz70oET1GgEqFqkefkFXtM+kYm4wLwbKsNMt9o=;
	b=l1yE8E/mqTzouE5jXxn0aPZMWYckPGX4O4QCY+aedjef71yT5c9JrMivyR1UqbNtmaIU
	 +BLKzQOIalJ+UeIsQszHznZOanvYQybbxz8ZYa3q7A95BPsNDJsq3om+ecVHCmvyBlLyq
	 bw4tBn2bDZJ0Pnq2AIick4FX8Z//Li748bp3od4jKHlVWxBwlLp54B7yPI1/FQIrudZ1Q
	 zzzQL5SZUpqcMLBuaRkSeGPZOBVXnEHqSgyUv/3SRP9zTAmwwCvb3y/ddCChTJDtutlWL
	 t8FttiyNQ/2UeEb+k19cquqE6gf1gxoZOB/9BS2VteIBAvBmm9VGxpdU+jggT6m8qsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UW4zkaST;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCD606A31D
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 14:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45CCD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UW4zkaST
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e942864693so4273225ad.1
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793369307; x=1793974107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGrdsvz70oET1GgEqFqkefkFXtM+kYm4wLwbKsNMt9o=;
        b=UW4zkaST1IP+A/TyfNLtbXQlme+Lx+YCEzsAPxn07XgKzE/t+9ZiMONOyiRrwdVuPh
         FKi7DyjJsfqo0qVY+dsyGHGqePInWXVoMBjAJ/YKJ7Q4n4czbFu7us+DiSdyrpH7eLzv
         Yg/cqAEsRpgZte33an+BcDadPQKLgGokDGA2AmI0p0kfQfZMo6wT0UkxJ/zdpvnTmRUs
         NtdRaQ5zA3uTIJopWWG9/lsy5qh94Se6o6jKQkt8lxh4jTyWAMvHo02AhBRXfyDex46P
         UwQ7uZPVQe4LSTzEe7rfhRM6mJwx9+eHQkqo7P7svwJSx/ygkv6ww5nEfx5T4loSEHd5
         G9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369307; x=1793974107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OGrdsvz70oET1GgEqFqkefkFXtM+kYm4wLwbKsNMt9o=;
        b=F+tAHMcNW3OqiY0HlZENEV5Ak9FFGVZ0mtmikxsocr1Q0agL2evRqQGP05u1g1p2QK
         zYPmRv5AUXnHTEh1w2QUlE0lqPYTv4hDlwyAp3TxKjVyTzOOGQ3VZSHtgqtP5azaXqWr
         VqfMOjfoq53A+Ywm9U/d2Ed6D09wChLXgwZH7XWYRYnU4FLuCCDC58z5o7OuKthSMBSt
         nSZOrfUviBGNP4ZzVi7isM91Zixbw0uiUThEZsFtMsLEiP4KHYS4Ion5GxwpAuzIzms/
         PB2wHadV9fXPCboXkBHjPx9MNGgsgPvGJXRrrb/H+JGVcscq9jl8xKscJ66uqqvyumR+
         dL2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxCvuzNDHyfOGZmnLQOyzXxTROxG+H+2hbF2J0i+62pbTKaWiTfjaXsUGxuCSar2FFDQvmE25TKOwMx@vger.kernel.org
X-Gm-Message-State: AFq9FYIbWanxUrFmAd7onl1IW8hx5ttNCBXo0N0RTf5ZZabgTRfajzDX
	+kIeHJhOEZIL8uK20WC0rSjY4wcCb7PgAIb32zQXqsbQI0Gv6pptg8SshoXGtb47Cfo=
X-Gm-Gg: AYBFou21mFDFk4ibFQiMnBnVO0Df6DbTBmoCqXdUmjoR0qqEFde4RhoqYIvfr+/y+b+
	DEF0ywxkpnebZ2SHGInGnrHMFRT5eLlVfoDJZltt160FYZQz14u5UaN7Giqx457vMRvF5Ki1UAd
	x2flbjpMZJf4DJpSCVRL19TfHBr9dXiIqPvygqbTvAcdpPMGB/QmShyitf1DA0ZuahrSAQq2VAI
	rX06L3AALvWnmzdHm35xhx3rKRF39EtqgN9N3TD5cd/rvrUblOM9fzXfx/8kFUevG42Qp/0bS9p
	4N5hy7mV/RgoBSiAPgB4ZbTDH80V8pNGuWzysf5GMG+iz3Ly7n0sE9kb5OaaJziuGsu/0jDEoNw
	Z8kS49o69FmAOAlbi1Dd8fL9J1eioIOq9bGs5aC70APg1i9p2K254JO8FjJxpIPvntowL8m2YW/
	J5DFjvzZ1/aMyehpHK5rpzLIWjnuqsQb6yNApJIOQNfUCc0MlmNPwtLwRob4yvOFUMsX/amDhi+
	SIHZYBv5de3MPTqLwcs7SjYoB9zUN/5IgTp3nJjbaT1tOsKyRpxaNvSiXdreDjoA/mnysCsPhlO
	8yT+W3O7a/g+4VjokVkX8Oe3hOgiJweH67VkKXonyAiSAyVf7W8=
X-Received: by 2002:a17:903:24b:b0:2e3:1bb4:610d with SMTP id d9443c01a7336-2eb364f6800mr27744295ad.50.1793369307550;
        Fri, 30 Oct 2026 07:08:27 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3929b27bsm7601795ad.62.2026.10.30.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:08:26 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/4] mm: Simplify device DAX vmemmap optimization plumbing
Date: Fri, 30 Oct 2026 22:07:16 +0800
Message-ID: <20261030140720.1256062-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is split out from the earlier, larger series "mm: Generalize
HVO for HugeTLB and device DAX" [1]. While the parent series generalizes
vmemmap optimization across HugeTLB and device DAX, this subset addresses
a single, self-contained step: simplifying the device DAX vmemmap
optimization plumbing.

After device DAX was converted to section-based vmemmap optimization,
whether a mapping can be optimized is carried in mem_section, and the
architecture-specific population path can handle any remaining fallback.
The code still retains the DAX-specific vmemmap_can_optimize() helper, a
PowerPC override, and @pgmap arguments threaded through lower-level
vmemmap population and memory-removal interfaces. These duplicate the
section-order policy and keep otherwise generic paths coupled to
dev_pagemap.

This series removes that obsolete plumbing by consolidating the
optimization policy around memory-section metadata and simplifying the
generic and architecture-specific population paths. This also eliminates
dependencies that are no longer needed once the optimization state is
carried by the memory section.

This leaves the section compound order as the single source of truth for
vmemmap optimization and decouples the generic sparse-vmemmap and
memory-hotplug paths from device DAX.

This is another smaller step toward the broader HVO generalization.

[1] https://lore.kernel.org/20260513130542.35604-1-songmuchun@bytedance.com/

Muchun Song (4):
  powerpc/mm: make vmemmap_populate_compound_pages() static
  powerpc/mm: drop powerpc vmemmap_can_optimize()
  mm/sparse-vmemmap: drop vmemmap_can_optimize()
  mm/sparse-vmemmap: drop @pgmap from vmemmap population APIs

 arch/arm64/mm/mmu.c                        |  5 ++-
 arch/loongarch/mm/init.c                   |  5 ++-
 arch/powerpc/include/asm/book3s/64/radix.h | 12 -------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 23 ++++---------
 arch/powerpc/mm/init_64.c                  |  1 +
 arch/powerpc/mm/mem.c                      |  5 ++-
 arch/riscv/mm/init.c                       |  5 ++-
 arch/s390/mm/init.c                        |  5 ++-
 arch/x86/mm/init_64.c                      |  5 ++-
 include/linux/memory_hotplug.h             |  8 ++---
 include/linux/mm.h                         | 40 +---------------------
 mm/memory_hotplug.c                        | 16 ++++-----
 mm/memremap.c                              |  4 +--
 mm/sparse-vmemmap.c                        | 34 ++++++++++--------
 mm/sparse.c                                |  6 ++--
 15 files changed, 54 insertions(+), 120 deletions(-)


base-commit: 5e6c45aaaf93343c7f8a1cde9797080238af5c1b
-- 
2.54.0

