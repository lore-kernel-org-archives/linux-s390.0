Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493535;
	b=o8ixdHFPjsZFHCqfb1lM5HGcqo5V7BPfWBIlGsmxLAnJnSUWmUrv3BLyoCBmYNWuc29e
	 og0T4gQDfCRbauU14DmQ0VQ0BLNlluX9/Z8pU9l6qwt3cAAvbcZZdrIZrvOG1V8JOsSqB
	 jVn14Lf2At42R/eMM7rDNd7ik5qGos+zhrz5K3rXjFwhvfht9dsRPGckdSAxzBmqn2GQD
	 uHna95udwJAPF2THQLAQkMBvyRSrj3wY3J2XlFQ6d2wHlP8VOoSqNqSo7lK9kRmCylkXn
	 OjmJoWalc9NpTpEbbLuWStyhO2WUansj4hqTtmbGMRdTWJKyCccQHYRLMr10sq0XfOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493535;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=LXnLw2dXuPgpiMbQNtTJhA3OydD17Gjgr9VksJJ+Wms=;
	b=JKjS2zBUazHW77aBnAKXy/I6L7+OZVfMstmSo60rhg5sqINOdnCNYSOOSmEkchtqQsye
	 wfonWejD2ynCI/vdCXc2ap3Tc7vUcPaCcLesUvUFoyLK7kK2t0917K12dZ6Pe61n9m3Fy
	 CY+JfC9g8RN5nLgp1DxXPTIQj4fk0fNel6LXmSRqzT++nHYSL2+hWoJVWGvVvRC+oe+HY
	 OuwXbskvYd7QfDbr2Pv775ufpNlStPM1X/hjvkjW6+yWMdI9kYw88UI+EOEF/4hfg9NC/
	 mk5Hrumzow3jPflHgG6Frhu2qBBBQJ7G0vc3O/jr+B+pg+VLca983qSDw0BWu1F5N9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XOPq9hkB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VRwNGR11;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NWCP7kfa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=emN3tH4j;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273706072A02;
	Thu, 12 Nov 2026 14:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 273706072A02
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XOPq9hkB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VRwNGR11;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NWCP7kfa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=emN3tH4j
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80C781F7A3;
	Thu, 12 Nov 2026 14:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LXnLw2dXuPgpiMbQNtTJhA3OydD17Gjgr9VksJJ+Wms=;
	b=XOPq9hkBTmQ12iX179lstxBX0lJifWx5Qm8tfaSvLPJ/xa6bL60x3pVd0MMANIzfIfoUb5
	xsInpqLoStIjcqlkfVfwsJdrR0m1jMZRAdsAMGFYj1UG6ZFToJwZBCnbV3OEjKTNzO40PV
	Z8PG7GaQzfRtKADBnjJ5j/XdMLCgVbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LXnLw2dXuPgpiMbQNtTJhA3OydD17Gjgr9VksJJ+Wms=;
	b=VRwNGR11Y+aNPLjA4hhU+3I4OV3XzYVJZ5z4iWfh87WEEx9uDh2prUNx4qs1O1kFzayFhu
	taiZ4I/6RhCbgnCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LXnLw2dXuPgpiMbQNtTJhA3OydD17Gjgr9VksJJ+Wms=;
	b=NWCP7kfaAS6UvLRCwbVy1JZAGPa4tbILC1ena2duuOVPDBL5kDNRJZTuWevPSSZNxgPalD
	VMPHtfL5DHhHJYVZF3zuJfljmNh9o+gTj8y1jOE+4uHTjvvbJQdxas0w3MnUPBMou/o/RQ
	E2bJ8WbEb93bbIjypp5KSDy6iD4/ZMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LXnLw2dXuPgpiMbQNtTJhA3OydD17Gjgr9VksJJ+Wms=;
	b=emN3tH4jzFF8oNkMNtJjgsZAgTEiPGpWFjct/O7xIU+MiOl95wPfxLfQCl+2tyqTQ4fnwa
	D3mdcN1E7GSkkzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5912713432;
	Thu, 12 Nov 2026 14:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9GzDFnM9WoAPwAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 12 Nov 2026 14:25:29 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	peterx@redhat.com,
	ljs@kernel.org,
	imbrenda@linux.ibm.com,
	borntraeger@linux.ibm.com,
	frankja@linux.ibm.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3 0/9] KVM: don't zap secondary MMU on permission upgrade
Date: Thu, 12 Nov 2026 15:20:29 +0100
Message-ID: <20261112142039.907090-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

Stop KVM from zapping its mappings on permission upgrades on x86 and
s390, as these keep the PFNs unchanged and revoke no access. KVM faults
in the new permissions on demand, so dropping mappings early gains
nothing.

To do so, add an MMU notifier flag that marks an
MMU_NOTIFY_PROTECTION_VMA invalidation as a strict permission upgrade.
For the flag to be accurate, change_protection() keeps writable entries
writable on such changes. A few cases where it needlessly makes or
leaves entries read-only are fixed along the way.

Background
==========

change_protection() pairs every protection change with an
MMU_NOTIFY_PROTECTION_VMA invalidation, and KVM zaps its SPTEs in
response, as it cannot tell whether permissions widened or narrowed.
This is costly, e.g. during a QEMU background snapshot, which uses
uffd-wp to write-protect guest RAM and unprotects each page once it is
saved. Every unprotect then makes the guest refault memory it could
already access.

Secondary MMUs that share the CPU page tables (e.g. ARM SMMU,
IOMMU/ATS) can keep read-only entries in their TLBs that a fault does
not flush, so they are already notified of permission upgrades on the
CPU TLB flush path [1]. KVM keeps its own page tables and faults in
permissions on demand, so it needs no notification, as Sean noted when
that signalling was first proposed [2].

Series overview
===============

Patches 1-4 fix cases where change_protection() needlessly makes or
leaves entries read-only, so that the next write to them faults. They
only affect performance and can be picked up independently.

Patches 5-6 add MM_CP_PERM_UPGRADE for mprotect() calls that only add
permissions, and MMU_NOTIFIER_RANGE_PERM_UPGRADE, which is set for these
and for userfaultfd unprotects.

Patches 7-9 pass the MMU notifier event and flags to KVM and skip the
zap on x86 and s390.

Considerations
==============

1. This series covers only x86 and s390. Claudio confirmed that
   skipping the zap should be safe on s390 and offered to test it [3],
   so patch 9 is only compile-tested. Other architectures should be
   able to skip it as well, but I have not tested or benchmarked
   them. Moving the code to arch-independent KVM would also avoid the
   SEV cache flush in kvm_arch_guest_memory_reclaimed().

2. struct kvm_gfn_range carries the MMU notifier event and flags, as
   agreed at LPC [4] and proposed in the past for other purposes
   [5] [6]. The fields are only set for MMU notifier invalidations.

3. Writable migration and device-private entries are still made
   read-only on a permission upgrade. This does not affect secondary
   MMUs (see patch 6), but the downgrade could be skipped as well if
   preferred.

4. hugetlb does not benefit, as hugetlb_change_protection() does
   not restore the write bit and may unshare page tables (see patch 6).

5. The notification cannot simply be skipped in MM code (see [7]).
   Secondary MMUs that keep their own page tables but cannot fault
   rely on it to pick up new permissions. A flag lets each user opt
   in instead.

Benchmarks
==========

These were measured on v1.

AMD EPYC 9654 96-Core Processor host running a recent Linux kernel
(6b4b543fa187), with a 64GB, 64-vCPU guest running stress-ng --vm while
the host takes a QEMU background snapshot. Results are aggregated over
5 runs on a stock kernel and on one with this series, rebooting the
guest between runs, with NUMA balancing disabled.

pf/s and tlb/s (per-second deltas of KVM's pf_taken and remote_tlb_flush
debugfs stats):

  guest pattern          baseline                    patched
  -----------------------------------------------------------------------
  read64   (read)        pf/s=950,015   tlb/s=1,440  pf/s=2,503 tlb/s=0.1
  rand-set (read+write)  pf/s=1,004,353 tlb/s=862    pf/s=4,073 tlb/s=0.3
  write64  (write)       pf/s=968,018   tlb/s=94     pf/s=2,292 tlb/s=0.3

Guest read latency was sampled with a paced probe thread in the guest,
reading one byte per page with an idle gap between reads, while
stress-ng ran with read64. Each figure is the median across 5 runs, with
the run-to-run min and max, in ns:

  metric           baseline             patched
  ------------------------------------------------------
  p50 (min max)      340     (270 380)   260   (250 260)
  p99 (min max)    19789 (16885 20200)  5207 (4076 5638)
  p99.9 (min max)  23445 (22845 24036)  6850 (6259 7110)

The median improves modestly, while p99 drops ~3.8x.

A separate stress-ng run with write64 and --verify showed no data
corruption and no livelocks.

Changes in v3
=============

- Patch 4 (was 5): check the old entry in the existing write-bit
  helpers, for any MM_CP_TRY_CHANGE_WRITABLE change (David).
- Patch 6: add mm_cp_is_perm_upgrade() here instead of in the old
  patch 5.
- Trim some commit messages.

Changes in v2
=============

- New patch 1: fix setting MM_CP_TRY_CHANGE_WRITABLE for shmem with
  uffd-wp or soft-dirty (Sashiko).
- New patches 2-3: honor MM_CP_TRY_CHANGE_WRITABLE in change_huge_pud(),
  adding pud_soft_dirty() on riscv (Sashiko).
- Patch 4 (was 1): only treat changes to the read, write and execute
  flags as an upgrade, plus VM_ACCOUNT (Sashiko).
- New patch 5: keep writable entries writable on permission upgrades
  (Sashiko).
- Patch 6 (was 2): don't set the flag for hugetlb (Sashiko).
- Patch 7 (was 3): pass the MMU notifier event and flags instead of a
  bool (Claudio).
- Patch 8 (was 4): check the flag in range->flags. The APIC-access page
  reload issue that Sashiko pointed out is pre-existing.
- New patch 9: skip the unmap on s390 as well (Claudio).

v1: https://lore.kernel.org/all/20261029143336.390231-3-clopez@suse.de/
v2: https://lore.kernel.org/all/20261105165004.2663799-4-clopez@suse.de/

References
==========

[1] https://lore.kernel.org/linux-mm/cover.1eca029b8603ef4eebe5b41eae51facfc5920c41.1690292440.git-series.apopple@nvidia.com/
[2] https://lore.kernel.org/linux-mm/ZGu1vsbscdO48V6h@google.com/
[3] https://lore.kernel.org/all/20261030133939.630e29af@p-imbrenda/
[4] https://lpc.events/event/20/contributions/2552/
[5] https://lore.kernel.org/all/20240801183453.57199-1-seanjc@google.com
[6] https://lore.kernel.org/all/20231110003734.1014084-1-jackyli@google.com
[7] https://lore.kernel.org/all/7ba2ca65-1eab-40fd-ae4c-f7cd9e156d8c@suse.de/

Carlos López (9):
  mm: fix eager write-bit restore for write-notified shared mappings
  riscv: mm: add pud_soft_dirty()
  mm/huge_memory: honor MM_CP_TRY_CHANGE_WRITABLE in change_huge_pud()
  mm: keep writable entries writable on protection changes
  mm/mprotect: add MM_CP_PERM_UPGRADE
  mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE
  KVM: pass the mmu_notifier event and flags to kvm_gfn_range
  KVM: x86/mmu: don't zap secondary MMU on permission upgrade
  KVM: s390: don't unmap the gmap on permission upgrade

 arch/riscv/include/asm/pgtable.h |  5 ++++
 arch/s390/kvm/arm64/arm.c        |  7 +++++
 arch/s390/kvm/s390/s390.c        |  7 +++++
 arch/x86/kvm/mmu/mmu.c           |  7 +++++
 include/linux/kvm_host.h         |  3 +++
 include/linux/mm.h               |  2 ++
 include/linux/mmu_notifier.h     |  5 ++++
 include/linux/pgtable.h          |  5 ++++
 mm/huge_memory.c                 | 46 ++++++++++++++++++++++++++++----
 mm/hugetlb.c                     |  4 +++
 mm/internal.h                    |  7 +++++
 mm/mprotect.c                    | 29 ++++++++++++++++++--
 mm/vma.h                         | 23 +++++++++-------
 virt/kvm/kvm_main.c              |  8 ++++++
 14 files changed, 142 insertions(+), 16 deletions(-)

-- 
2.51.0

