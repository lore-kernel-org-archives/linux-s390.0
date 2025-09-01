Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953526F47D
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759832; cv=none; b=gQStDw8L0agIYo66qIlx4O/cHvgG3D9PqARG8HPbUjVmiIcPWr6IbTaAdHqJyFHwbbW0RJvkA7Ca+MAOHSB2/o1KE6Z7dpF+n/bDzoYnOhN3KxkW9u4Kv3+Z0sG9fZ+6Yg8txbYUkxe/oVN31mGYXftU49WbIv9Ux8lrXnrl9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759832; c=relaxed/simple;
	bh=r3gId/u5LD1LKIELYHoNIdIwUxYyWCHrBFDvgyaA1xM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KbJJZI+9cTfJPJ2SIIbnqUCtFq4cbsp8pbTaG5iAUduE2IZU47iPpnXbw2/9PRzZ4I/kJaIWE9JNNWlJhWv953Y0plSepJbfNCdDvLRPxxQWGcHhsKBQvQgtPUt4Eu+Sj5oQoyR8GrFOyjpMUj4toSGLjdpydTWg/yfaTxn86Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SuoDHvXQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SuoDHvXQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b043da5a55fso127750566b.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 13:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759827; x=1757364627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h+HtzMm8aCoEYebuXFm6wKGd65XfE1qqAFatqE2tqt0=;
        b=SuoDHvXQuuOwIyBl5RNvbKGcaWwA73psQR7EXfOGEPyVGn3IujNkAi9Azcu8IdGDEE
         6sUn6DtNskwmB+3UlUVYmwuv/Et0atj65nTbVVlS1TcUGfOrEGuv37r9EdLNYwDE0cfM
         QKU5O/pL8VCqG0D/KU9T0+aSctYkLtMhYfR8Pqvk3ru8pWzNbjS0VpKHfRjMtc5ss9p6
         mD88P2026OOvHKRX8xNtuPQlzw2X3l3dJkert1jQMpkKAkbZJYYVz+pklvexBuziXHgO
         VggIX36FAFYj+G/nBX6075A0n1JBGmeFiHrIVf/X4K4/MgWlNyqmtB2GafXHsr2jCGBN
         9+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759827; x=1757364627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+HtzMm8aCoEYebuXFm6wKGd65XfE1qqAFatqE2tqt0=;
        b=N05PXu+icumtviL0wm87HLzIJ7vl1KELmvtDsiwHhykSSoNahyuBTY1W4Y8W35cPwh
         xYEWBWyDNzWdYN8Y+NWFLa51PlBo2cmlSwBoU6VxXj+4Pwj6U+T6E/J7jWWHBIBu+QzB
         L6m5Dc7daJaYd+ocR7WsGjq05AdDHztmO8s4y9V+QF/zZE+5Bkg0q1oehKXdZPbjHMH/
         kfH7a5uPMyovNWNRjBqN3vDPbAfsuvMX3zD24ljVUxtSyddcLyqzDA67UfrZuUJIe7AF
         7HCUknA5+XtbH6uABEFh7/NR1MBVmFdmGqvbA4j/95NV1spTg3DQxIHNgZ+AOhrxuQY3
         iNpg==
X-Forwarded-Encrypted: i=1; AJvYcCVUZDZkBDmDEqXQXpHYv1u05O5Xm6YCWzU6likv33oZnGt1VJ5IgTfd/Z90O8KzZssEQlCwx+7QIKvu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3/MYQV8z8ZkRMN60wExhwhxTifWXI7AOwp4//RSKEqlUzuC9
	SNF3KSipk86cB47WrryPtKabL/v7rtS8HHgbnC73NkxV+gcgzg6bqvVohE0f3qmTsdE=
X-Gm-Gg: ASbGncukyqIj+Z2I7mMC2m9sleq3um6+5Ok/wTmsnfxfSwrXBFtbWJQKko6vPN/I+YS
	+FsVAnS/4yNBvAOJt5GJWh4MM0PKgtgPk9hQ5/sRBw+yRJ+Mg2VE/X3ahmhZipPgphtO9wLiIuM
	orkVH2AzmEJbGG7+lJQWLJOJ3qC8riTUtt62a/QuZMUgdxjPFpw4lINAkkryBqJyQ0R/CvIFiCU
	sryCADaK0ItfUQOeiBUkt0qfsVgkbfTebxOzDchuTstD5Pg28VTJjzexJzekDqRqfCU/WE//V1D
	ctM0ouz13B38vgQiOrazAs5X/qobNfj8hpGHgL9EXEAb41C/aootj8dB6+5H+ZT/Wh33OTzLwVQ
	5uwcBOVMz2iUgQtxVbULXJm9vMsBXdVnrsqcgdMmaojS833GElinyhs9nsfn0JU2usyYnKV/unZ
	o9JuEEVCctdA3Pk21knG8Rrg==
X-Google-Smtp-Source: AGHT+IFm8ymM2lVjoF6wSC8TwGE2I+pinvEWrAbXATzLNjz68TsRuYVhbwX52a8lzV2r8vSv8pkRWA==
X-Received: by 2002:a17:907:cd07:b0:b04:37b2:c1a5 with SMTP id a640c23a62f3a-b0437b2eb32mr399274666b.34.1756759827409;
        Mon, 01 Sep 2025 13:50:27 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:27 -0700 (PDT)
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
Subject: [PATCH v6 00/12] mm: establish const-correctness for pointer parameters
Date: Mon,  1 Sep 2025 22:50:09 +0200
Message-ID: <20250901205021.3573313-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness in the low-level memory-management
subsystem, which provides a basis for further const-ification further
up the call stack (e.g. filesystems).

This patch series splitted into smaller patches was initially posted
as a single large patch:

 https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/

I started this work when I tried to constify the Ceph filesystem code,
but found that to be impossible because many "mm" functions accept
non-const pointer, even though they modify nothing.

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

v4 -> v5:
- back to shorter commit messages after an agreement between David
  Hildenbrand and Lorenzo Stoakes was found

v5 -> v6:
- fix inconsistent constness of assert_fault_locked()
- revert the const parameter value change from v2 (requested by
  Lorenzo Stoakes)
- revert the long cover letter, removing long explanations again
  (requested by Lorenzo Stoakes)

Max Kellermann (12):
  mm: constify shmem related test functions for improved
    const-correctness
  mm: constify pagemap related test/getter functions
  mm: constify zone related test/getter functions
  fs: constify mapping related test functions for improved
    const-correctness
  mm: constify process_shares_mm() for improved const-correctness
  mm, s390: constify mapping related test/getter functions
  parisc: constify mmap_upper_limit() parameter
  mm: constify arch_pick_mmap_layout() for improved const-correctness
  mm: constify ptdesc_pmd_pts_count() and folio_get_private()
  mm: constify various inline functions for improved const-correctness
  mm: constify assert/test functions in mm.h
  mm: constify highmem related functions for improved const-correctness

 arch/arm/include/asm/highmem.h      |  6 +--
 arch/parisc/include/asm/processor.h |  2 +-
 arch/parisc/kernel/sys_parisc.c     |  2 +-
 arch/s390/mm/mmap.c                 |  6 +--
 arch/sparc/kernel/sys_sparc_64.c    |  2 +-
 arch/x86/mm/mmap.c                  |  6 +--
 arch/xtensa/include/asm/highmem.h   |  2 +-
 include/linux/fs.h                  |  6 +--
 include/linux/highmem-internal.h    | 36 +++++++++---------
 include/linux/highmem.h             |  8 ++--
 include/linux/mm.h                  | 56 +++++++++++++--------------
 include/linux/mm_inline.h           | 25 ++++++------
 include/linux/mm_types.h            |  4 +-
 include/linux/mmzone.h              | 42 ++++++++++----------
 include/linux/pagemap.h             | 59 +++++++++++++++--------------
 include/linux/sched/mm.h            |  4 +-
 include/linux/shmem_fs.h            |  4 +-
 mm/highmem.c                        | 10 ++---
 mm/oom_kill.c                       |  6 +--
 mm/shmem.c                          |  6 +--
 mm/util.c                           | 16 ++++----
 21 files changed, 155 insertions(+), 153 deletions(-)

-- 
2.47.2

