Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898056;
	b=Vw25FQMO0Rl+qhxKfzRTfAM2YH//0hY4GhccqBKXkDghC6XuNpEbfEwSHSnoSU43Mwfh
	 LRpmKACxVNfgBLp/OriuTjPWBVEB+fJkvbZCR/k0khNX5RSZ3mtzIXXpPPyVWVF4B7VoS
	 PZ+pCFMxDcbOlZ65P/YD4eA9lPe0lu+ApWM1uHDVsm36Wy1x7z6a5eNM4UflBdPk4X7kf
	 XaJp0svV56VtHcEIyYT4kp4lDbnYWVlhSy0utiIRuc/NDZzm8Xjfze6E5TDA8CTJDVJd3
	 BMh27/K0zc24px1HBkjPgSUzpZA4dGlD9l7bhFCzjRWUub0Wcae0A7ouYgrECgXA3Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898056;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=kR3hA/qC7N/4wdgBMp2prE725QVAL7ltGxoTH+1x9yI=;
	b=elUmiGeIyvkKMRo1RZRtHKpkdssDrd3iHE1wb5rAbGGclM30HyB+s3VOVXvurd0hMFJz
	 Qs+6jAiDu+hxruIBG/10AYd/AgGEWIb0M7KMNdkmBx71B4ojLu70k8jtHz9daB0/ImIYu
	 Z6266USYhsxX5yv2AH2WTa/cqYN7kr//DnK/8SEQj6xFtrpr3zk9kizCthvs64HvBAPe9
	 o9MF3HUPpeaSv7aJRupoepHlrk90zYcZfBWMZZl15O2XK3YbErALj/zDOkWTmHu0vdCj6
	 4tAg4Xsn0s5QZ81S09MjGWBEOrx6fTXKWUycHa6d4haKhs2wR1Q7+B8MRyPFqvgP6+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hLxlU5Cc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8n6XwFS4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lnYTHl2E;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KR8JqhS8;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFADB606A32D;
	Thu,  5 Nov 2026 17:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFADB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hLxlU5Cc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8n6XwFS4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lnYTHl2E;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KR8JqhS8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEED81FB4B;
	Thu,  5 Nov 2026 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kR3hA/qC7N/4wdgBMp2prE725QVAL7ltGxoTH+1x9yI=;
	b=hLxlU5CcmAtXUBoy8jPKfwAtjRHvR8jGUwmIC8ygTkSOj1nbmSscFvdK3BKF3MyXjJkIAH
	rWF2nfacG3p+6ixd993VTuXeiwzHl8HmgN4FJH1WYAnGKJ/oY+RQ5PjN+Q8yLB+yl5LuCw
	fFw/r8s7tKtee5ZSSlN5LiacdT4+UUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kR3hA/qC7N/4wdgBMp2prE725QVAL7ltGxoTH+1x9yI=;
	b=8n6XwFS4EbwHx9p4FlhtsSje2lzwd1vGEjjtZ2wYf7214kwe/43O/yCmfHjjSElxO2uwlk
	y+r6PnOI9gWExqAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lnYTHl2E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KR8JqhS8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kR3hA/qC7N/4wdgBMp2prE725QVAL7ltGxoTH+1x9yI=;
	b=lnYTHl2EqOTto4qZ1S50GiKjWi34+6LyphlZwyEsNpclHCwO8+HsrMA0mYguWw48Fpj/2u
	RRO7UDhpULb2AQsLT+nz1mKQahxa/ZtaJkDqhUH82kfB38VRt6yqq+RZ2NwnxlmHhg7ETp
	9rCX2n0PxD1kiyOEJLWhNIiAtnsNw7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kR3hA/qC7N/4wdgBMp2prE725QVAL7ltGxoTH+1x9yI=;
	b=KR8JqhS83a5KFZtq6k09ZkUBNok/kKwUV/UeNPr6uKVmUFEPmly6ft0Lr2HnKlrtKXmdrt
	zeG0FiYs8yZYCSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E64A133F6;
	Thu,  5 Nov 2026 17:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:00:50 +0000
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
Subject: [PATCH v2 0/9] KVM: don't zap secondary MMU on permission upgrade
Date: Thu,  5 Nov 2026 17:49:57 +0100
Message-ID: <20261105165004.2663799-4-clopez@suse.de>
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
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: BEED81FB4B

Stop KVM from zapping its mappings on permission upgrades on x86 and
s390, as these keep the PFNs unchanged and revoke no access. KVM faults
in the new permissions on demand, so dropping mappings early gains
nothing.

To do so, add an MMU notifier flag that marks an
MMU_NOTIFY_PROTECTION_VMA invalidation as a strict permission upgrade.
For the flag to be accurate, change_protection() keeps writable entries
writable on such changes. A few cases where it needlessly leaves entries
read-only are fixed along the way.

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

Note: the notification cannot simply be skipped in MM code (see [3]).
Secondary MMUs that keep their own page tables but cannot fault rely on
it to pick up the new permissions. A flag lets each user opt in instead.

Series overview
===============

Patches 1-3 fix cases where change_protection() leaves entries
read-only even though the write fault handler would make them writable
without further checks. They are performance fixes on their own and
can be picked up independently.

Patches 4-6 add MM_CP_PERM_UPGRADE for mprotect() calls that only add
permissions, keep writable entries writable on these and on userfaultfd
unprotects, and add MMU_NOTIFIER_RANGE_PERM_UPGRADE.

Patches 7-9 pass the MMU notifier event and flags to KVM and skip the
zap on x86 and s390.

Considerations
==============

1. This series covers only x86 and s390. Claudio confirmed that
   skipping the zap should be safe on s390 and offered to test it [4],
   so patch 9 is only compile-tested. Other architectures should be
   able to skip it as well, but I have not tested or benchmarked
   them. Moving the code to arch-independent KVM would also avoid the
   SEV cache flush in kvm_arch_guest_memory_reclaimed().

2. struct kvm_gfn_range carries the MMU notifier event and flags, as
   agreed at LPC [5] and proposed in the past for other purposes
   [6] [7]. The fields are only set for MMU notifier invalidations.

3. Writable migration and device-private entries are still made
   read-only on a permission upgrade. This does not affect secondary
   MMUs (see patch 6), but the downgrade could be skipped as well if
   preferred.

4. hugetlb does not benefit, as hugetlb_change_protection() does
   not restore the write bit and may unshare page tables (see patch 6).

5. The notification cannot simply be skipped in MM code (see [3]).
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

References
==========

[1] https://lore.kernel.org/linux-mm/cover.1eca029b8603ef4eebe5b41eae51facfc5920c41.1690292440.git-series.apopple@nvidia.com/
[2] https://lore.kernel.org/linux-mm/ZGu1vsbscdO48V6h@google.com/
[3] https://lore.kernel.org/all/7ba2ca65-1eab-40fd-ae4c-f7cd9e156d8c@suse.de/
[4] https://lore.kernel.org/all/20261030133939.630e29af@p-imbrenda/
[5] https://lpc.events/event/20/contributions/2552/
[6] https://lore.kernel.org/all/20240801183453.57199-1-seanjc@google.com
[7] https://lore.kernel.org/all/20231110003734.1014084-1-jackyli@google.com

Carlos López (9):
  mm: fix eager write-bit restore for write-notified shared mappings
  riscv: mm: add pud_soft_dirty()
  mm/huge_memory: honor MM_CP_TRY_CHANGE_WRITABLE in change_huge_pud()
  mm/mprotect: add MM_CP_PERM_UPGRADE
  mm/mprotect: keep writable entries writable on permission upgrades
  mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE
  KVM: pass the mmu_notifier event and flags to kvm_gfn_range
  KVM: x86/mmu: don't zap secondary MMU on permission upgrade
  KVM: s390: don't unmap the gmap on permission upgrade

 arch/riscv/include/asm/pgtable.h |  5 +++++
 arch/s390/kvm/arm64/arm.c        |  7 +++++++
 arch/s390/kvm/s390/s390.c        |  7 +++++++
 arch/x86/kvm/mmu/mmu.c           |  7 +++++++
 include/linux/kvm_host.h         |  3 +++
 include/linux/mm.h               |  2 ++
 include/linux/mmu_notifier.h     |  5 +++++
 include/linux/pgtable.h          |  5 +++++
 mm/huge_memory.c                 | 35 +++++++++++++++++++++++++++++++-
 mm/hugetlb.c                     |  4 ++++
 mm/internal.h                    |  7 +++++++
 mm/mprotect.c                    | 22 ++++++++++++++++++--
 mm/vma.h                         | 23 +++++++++++++--------
 virt/kvm/kvm_main.c              |  8 ++++++++
 14 files changed, 128 insertions(+), 12 deletions(-)

-- 
2.51.0

