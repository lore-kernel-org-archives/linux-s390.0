Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349493;
	b=T5+BqfXzn5njBX24d8jRnJL5PpClZRNWSBBxhjHJFF6+qv2EmauBl+to63ETuTl+WXJ4
	 4aNmPTg3nn5ZsG4hCxHQIQAPQTtKABMHbuGOcEoaCu5hOyTUdmkw72yGrrxd3HhR8yPnc
	 mWksif8i5/h6+tqDn3MqkMX2sFSv3vNwza0/2zvbHQy6Vc+yUrx3jkFVsAFLoNRbQxgen
	 IbdRXSHPaHe0hDzveDHXKejSoT9FMn/tEwMutyk7/l/1ni8CdDMrW0Bajl3YNVykTVUix
	 CZ+3b4DbXZMH5WSlp6UeXSkYSRqzPk9LHORiCwMUucB4LJxPnaPRlYXyua/nP/GqV2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
	b=iLm2T3SuM/UFByj9yjT7ahwMAwWRfjz4yYjuJfzWr5mLSjyoIacjgl/TRBqtaPzy3tOD
	 aveFaTeiSEtzEnGtY+5f28urj5Ucg5HPt0W2W4+A7yvb98q20AkWbmsG1AU3bec57tpP+
	 PnQ7J86Fqty9xLTm3ifUc0LS4vHyEtPfUC7NGlpbhtA+2CffXKHP7czi8CeDOKBME28Ja
	 2ir0DbMer7n3GXKzdRc+eskrmvmu+/az1/0leouXZlfslrny/8U9AVn0ZBYNw+9PwWoVN
	 R6pYlKRvszvVHKSRJgvD5wglL8k8an8COsnGbF/nPMIsIYyk9swikh+AivbNTG4e95A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=B3qLNBas;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EB606A321
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 08:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 692EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=B3qLNBas
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd623dfe420so302367a12.0
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793349492; x=1793954292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=B3qLNBasitzf6QWVfYdSO4M4fb+3mJygu2Kl+gY3YU+aYRkjSfNxVvnwbTc3Y1MYmh
         SrNHFFRP6u2kzxV2WkRKPt9zbzjRMIwFCENvXZJEr5iJb2yyq4eNLacHh1Wob+gtM9uy
         SbRswPI2mty1hHvr+50TA7YXj8o6GoxMu+ZpgFZFbUjoHzq+uqnCw8jAimDCDM3LcXJi
         zTMWX2laLn/Zw3UlsiR7ZX2lydLN59p4udq8E+ZMZmtUOFVcJaSBpcM2upIYp1RJaq4O
         Y46Pn/FkGHCTZtrkCXyufob1K6unSqc3aA8EgpD1o5WUG1FxNrtm8KYgAx+zgnbrluK7
         2mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349492; x=1793954292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=THkqggPUTIgX9bB8b2vsC17gmkDzWpnKYhIi1JesbnPxSTAL7t2T3OF4am+dw6ycqr
         DYi8zjdwzgwuvhMmjcQ0HyuSwnSdJlccTDth2xgkH8kVcitzLPzKwE9piOzShJEUwJIp
         csaFPCuyhEPerPQ/ZKP529SAlcDfJBFhWFP2AKbqAouGRvzCojDNWfc7yQRUGOvrZvmF
         el9iR5uCsjlpL4lumLGmGNsjX4JEzxacHpvfRFKzBp8fhzw9DkBLx5BSxMaD3MGaVgbi
         lZXgbPodOLNM5WViaKChOAVGBUEMaV5tfaYxqubzPjz2U88rdu/8pdJbrm5KJoMxXvbU
         h2Iw==
X-Forwarded-Encrypted: i=1; AKwUvBy/lzZuLi/Gqs7GUA5f22zrGZCr0Kf9lEK4iWeLWghIo5by+zFquqr+YyxV70dn7VDnJCS15PmadjS4@vger.kernel.org
X-Gm-Message-State: AFq9FYJiPbRtl9REqcJjbRWPoM6kyuYuFaMNcE1KqD4qZscSbm8Xb4Zl
	lObC4dWaKVw9pTdy9y0ow/vI7vLqi0xPO/7VXc166VQ8Sj7lzMUMGC0GYjrYi5Wms0o=
X-Gm-Gg: AYBFou27q3EknPcotpzIz07o43HehAccBJk1ZlUtuVCWeUDSeVK1jOsYojsZQhewqiw
	4D/RgLSS9pLvyZ7Nr2Et3ebwvCHfjsOKyGQr/U3pEjX3MZZiwoTaaakVycH04EP3j3I7AOgWrTv
	HERlGyM37UaRI7qes31h+nf+AHrynDSMme82urL0ozMs0mgcwpUZdc1fv/5frCHSgYl5Ou5slZF
	Yb1GLjVdzRrxGk/A9/RANZGdnS0AMmHC5unsRquWffY0opNMNVQrLgc+nfHr3GBRo/FDfKaoJV5
	8fFftJmP/Uvibbr0TCuxy94IQ5momzqr2Dap3abYE0l0zCeXVSch3XLP2HHfCdbWcVcrZrdXuys
	xEikT3deQuIAouqMgjcBQyIsyg49KrIzZngqrlgi2GjxA4Uuo5AzqolHQJnSUDiwdo+qWxFmQMF
	IvYVbUrCG4AaewqMgKBVlbH9zNJCvqJ4fAiU2JOROWZC8n3wm5lEHEAo++VpqspECsGnzrZh86B
	zzt8EPZy/lbYWtFAF1lN51Jx4JVCh3/SnSEGVqH2dLFyC4BRHz13PxwIPJjTGKz7HzhwLwTl5On
	2AaBWGSpC0G5Bubk1ZpGNtr0Cj6AJSAKOULi4w57GCTpJbVkmYA=
X-Received: by 2002:a17:90b:5147:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ae897c7c28mr1424866a91.14.1793349491405;
        Fri, 30 Oct 2026 01:38:11 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm7542122a91.15.2026.10.30.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:38:10 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Date: Fri, 30 Oct 2026 16:37:58 +0800
Message-ID: <20261030083800.599152-1-songmuchun@bytedance.com>
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

This is a follow-up cleanup to the page-table teardown fixes [1].

pagetable_free() now invokes pagetable_dtor() for constructed page tables.
This makes pagetable_dtor_free() redundant and leaves explicit destructor
calls immediately before pagetable_free() duplicating lifecycle handling.

Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
then remove the remaining redundant pagetable_dtor() calls. This keeps the
destructor decision in the common free path. No functional change is
intended.

[1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com

Muchun Song (2):
  mm: remove pagetable_dtor_free()
  mm: remove redundant pagetable_dtor() calls

 arch/m68k/include/asm/mcf_pgalloc.h    |  5 ++---
 arch/m68k/mm/motorola.c                |  2 +-
 arch/powerpc/mm/book3s64/mmu_context.c |  1 -
 arch/powerpc/mm/book3s64/pgtable.c     |  1 -
 arch/powerpc/mm/pgtable-frag.c         |  2 --
 arch/s390/include/asm/pgalloc.h        |  4 ----
 arch/s390/mm/pgalloc.c                 |  4 ++--
 arch/sh/mm/pgtable.c                   |  2 +-
 arch/sparc/mm/init_64.c                |  1 -
 arch/x86/mm/pat/set_memory.c           | 10 +---------
 arch/x86/mm/pgtable.c                  |  5 ++---
 include/asm-generic/pgalloc.h          | 12 ++++++------
 include/asm-generic/tlb.h              |  2 +-
 include/linux/mm.h                     |  6 ------
 14 files changed, 16 insertions(+), 41 deletions(-)


base-commit: 9c449f885765cf8d80b2c60b1971e774bba51a3f
-- 
2.54.0

