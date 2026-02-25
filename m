Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF8E3016E0
	for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007287; cv=none; b=H5uXxGzUbMtaS3kn4OT1nSHLnX1L5OwQYAUfrUnaYWUOhza3yuoZCbfbHZyskZdy0q6WYp03gq8A/9VgppqmgNkU8IxIPMZ7ukmjcnODXBn6fmIEWpusXn5xqc9lQ/6U+3aA09GZIedivtdCLFt5Rb9Ak3cWnFFSD/aQ+MfvlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007287; c=relaxed/simple;
	bh=h+tpPqw8AsgODJEQncsIs35uIKU3vmAZCPspYgg/of4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=KuhmLeLH7E6PvcfZH8mSAmCoJSuxLY57LkpceaBnGFQwhSVKyNqLbFsX6ni0olL/+tJx0ODxZ4VpYbmE49RVuvXmbWJeDJdNpa9NKPjUHHBCLQQGQUuTsSRtDbFhBYfrv6YC4z2ERBlq4026o3OKDNXVGd75NXzxeyawe+yUDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5QC44Tg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5QC44Tg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=re7E4sxplbVcSJsRUE0dixF3rx550iAmXm+wmG0q1R4=;
	b=A5QC44TgvZ84nuJ8Balk6+xYd5gq7uh5bNZYYn3fc3tm3MnAM8hOuZF2yFqcmY4nQCGYwr
	XfOJ1YVqnAEM4SnRbw7HkrixstUVghEx5jQVqArn88HC4AVg6E5pjskIBjJrVMdFZ4orb6
	VaGCzVrCcb9Plv7hLfyyF46l+5V1W00=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-8STCbgGpNdSEQd8WeY9I3A-1; Wed,
 25 Feb 2026 03:14:40 -0500
X-MC-Unique: 8STCbgGpNdSEQd8WeY9I3A-1
X-Mimecast-MFC-AGG-ID: 8STCbgGpNdSEQd8WeY9I3A_1772007278
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A1281956067;
	Wed, 25 Feb 2026 08:14:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C6291800465;
	Wed, 25 Feb 2026 08:14:26 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	linux-s390@vger.kernel.org,
	hca@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 00/15] mm/kasan: make kasan=on|off work for all three modes
Date: Wed, 25 Feb 2026 16:13:57 +0800
Message-ID: <20260225081412.76502-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently only hw_tags mode of kasan can be enabled or disabled with
kernel parameter kasan=on|off for built kernel. For kasan generic and
sw_tags mode, there's no way to disable them once kernel is built.

This is not convenient sometime, e.g in system kdump is configured.
When the 1st kernel has KASAN enabled and crash triggered to switch to
kdump kernel, the generic or sw_tags mode will cost much extra memory
while in fact it's meaningless to have kasan in kdump kernel

There are two parts of big amount of memory requiring for kasan enabed
kernel. One is the direct memory mapping shadow of kasan, which is 1/8
of system RAM in generic mode and 1/16 of system RAM in sw_tags mode;
the other is the shadow meomry for vmalloc which causes big meomry
usage in kdump kernel because of lazy vmap freeing. By introducing
"kasan=off|on", if we specify 'kasan=off', the former is avoided by
skipping the kasan_init(), and the latter is avoided by not building the
vmalloc shadow for vmalloc.

So this patchset moves the kasan=on|off out of hw_tags scope and into
common code to make it visible in generic and sw_tags mode too. Then we
can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
kasan.

Note that this hasn't been supported on s390 since I am not familiar
with s390 code. Hope s390 developer will make it work.

Testing:
========
Testing is done on upstream kernel 6.19.0+:

- For generic mode, testing is taken on below systems and passed.
  - x86_64 baremetal system
  - aarch64 baremetal system
  - ppc64le baremetal system (Model 9183-22X)
  - risc-v kvm guest

- For sw_tags mode, testing is taken on below system and passed.
  - aarch64 baremetal system 

- For hw_tags mode, testing is taken on below system and passed.
  - aarch64 kvm guest with "-machine virt,mte=on -cpu max" qemu command.

Changelog:
====
v4->v5:
- Add helper __kasan_cache_shrink() in mm/kasan/generic.c so that the
  kasan_enabled() checking done in kasan_cache_shrink() which is in
  include/linux/kasan.h. This change is made in patch 1.
- Carve out the change of renaming 'kasan_arg' to 'kasan_arg_disabled'
  into a separate patch from the old patch 2.
- put the old patch 12 to earlier place as patch 4 in this sereis so
  that the ifdeffery scope embracing kasan_flag_enabled definition is
  meaningful and understandable.
- Remove the stale and incorrect comment above kasan_enabled() in the
  old patch 12.
- Add comment 'If KASAN is disabled via command line, don't initialize
  it.' to all places where kasan is initialized and kasan_arg_disabled
  is checked.
- Add document in kernel-parameters.txt to note kasan=on|off.
- Remove unneeded ARCH_DEFER_KASAN and kasan_arch_is_ready().
- All these changes are made according to reviewers' suggestion in v4,
  thanks to Andrey Konovalov, Andrey Ryabinin and Alexander Potapenko.
  

v3->v4:
- Rebase code to the latest linux-next/master to make the whole patchset
  set on top of
  [PATCH 0/2] kasan: cleanups for kasan_enabled() checks
  [PATCH v6 0/2] kasan: unify kasan_enabled() and remove arch-specific implementations

v2->v3:
- Fix a building error on UML ARCH when CONFIG_KASAN is not set. The
  change of fixing is appended into patch patch 11. This is reported
  by LKP, thanks to them.

v1->v2:
- Add __ro_after_init for kasan_arg_disabled, and remove redundant blank
  lines in mm/kasan/common.c. Thanks to Marco.
- Fix a code bug in <linux/kasan-enabled.h> when CONFIG_KASAN is unset,
  this is found out by SeongJae and Lorenzo, and also reported by LKP
  report, thanks to them.
- Add a missing kasan_enabled() checking in kasan_report(). This will
  cause a KASAN report info even though kasan=off is set:
- Add jump_label_init() calling before kasan_init() in setup_arch() in these
  architectures: xtensa, arm. Because they currenly rely on
  jump_label_init() in main() which is a little late. Then the early static
  key kasan_flag_enabled in kasan_init() won't work.
- In UML architecture, change to enable kasan_flag_enabled in arch_mm_preinit()
  because kasan_init() is enabled before main(), there's no chance to operate
  on static key in kasan_init().

Baoquan He (15):
  mm/kasan: add conditional checks in functions to return directly if
    kasan is disabled
  mm/kasan: rename 'kasan_arg' to 'kasan_arg_disabled'
  mm/kasan: mm/kasan: move kasan= code to common place
  mm/kasan: make kasan=on|off take effect for all three modes
  mm/kasan/sw_tags: don't initialize kasan if it's disabled
  arch/arm: don't initialize kasan if it's disabled
  arch/arm64: don't initialize kasan if it's disabled
  arch/loongarch: don't initialize kasan if it's disabled
  arch/powerpc: don't initialize kasan if it's disabled
  arch/riscv: don't initialize kasan if it's disabled
  arch/x86: don't initialize kasan if it's disabled
  arch/xtensa: don't initialize kasan if it's disabled
  arch/um: don't initialize kasan if it's disabled
  mm/kasan: add document into kernel-parameters.txt
  mm/kasan: clean up unneeded ARCH_DEFER_KASAN and kasan_arch_is_ready

 .../admin-guide/kernel-parameters.txt         |  4 +++
 Documentation/dev-tools/kasan.rst             |  2 --
 arch/arm/kernel/setup.c                       |  6 ++++
 arch/arm/mm/kasan_init.c                      |  3 ++
 arch/arm64/mm/kasan_init.c                    |  7 +++++
 arch/loongarch/Kconfig                        |  1 -
 arch/loongarch/mm/kasan_init.c                |  3 ++
 arch/powerpc/Kconfig                          |  1 -
 arch/powerpc/mm/kasan/init_32.c               |  6 +++-
 arch/powerpc/mm/kasan/init_book3e_64.c        |  4 +++
 arch/powerpc/mm/kasan/init_book3s_64.c        |  4 +++
 arch/riscv/mm/kasan_init.c                    |  4 +++
 arch/um/Kconfig                               |  1 -
 arch/um/kernel/mem.c                          |  5 +++-
 arch/x86/mm/kasan_init_64.c                   |  4 +++
 arch/xtensa/kernel/setup.c                    |  1 +
 arch/xtensa/mm/kasan_init.c                   |  4 +++
 include/linux/kasan-enabled.h                 | 10 +++----
 include/linux/kasan.h                         |  7 ++++-
 lib/Kconfig.kasan                             | 12 --------
 mm/kasan/common.c                             | 21 ++++++++++++--
 mm/kasan/generic.c                            | 16 +++++++++--
 mm/kasan/hw_tags.c                            | 28 ++-----------------
 mm/kasan/init.c                               |  6 ++++
 mm/kasan/kasan.h                              |  6 ----
 mm/kasan/quarantine.c                         |  3 ++
 mm/kasan/report.c                             |  4 ++-
 mm/kasan/shadow.c                             | 11 +++++++-
 mm/kasan/sw_tags.c                            |  7 +++++
 29 files changed, 128 insertions(+), 63 deletions(-)

-- 
2.52.0

