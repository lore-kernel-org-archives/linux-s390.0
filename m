Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285084;
	b=fP5/ViXISwdz2fvgXoXwFuuxkHLhwgi+W6RzP7Xa+fqWvMzuVa8lY+xBrPJvCAokMdtw
	 irvlBycMeqzI6LkZGgP+s25gn3I7Ri9ikz7/4FXM8r4Qx9jcUayA1syXzTsG+oQyzvAoF
	 3SUc2dDQErzySrgB1BMmzdo5fbB5FbgfjqDUsRonkm0NQOfiL9tUqA0PlR7fNpbNxed45
	 U4xmjPjxAahjJjyHbEed7vIuIbNnIFs+EqhQLgvopmSrf6Y3GV6aO1eM08u8dhiW9Fwnd
	 6b79KCcxeBhfOP2h8vQgzSnxGVrvVK7CibRtqKIAd4AIsegqH6yV2gjudamwGMViugQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285084;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=Ma02zVhR/wiqxtMf4JB5WMp1YLmgiNfWHzj9kC5VbP4=;
	b=vcHfMbbwaMBBgY23XHp1EdO7FcQ9gIxTnwrj81ihsw380r6Xcn4q31gms+tBzExRWzdn
	 PcdgpF8SElx85LeOaPUHI/GPvk2UUorV2/5Gr6Lp81ob2jNLVQM/K0eBW4gY0bd0o8nF1
	 bNNOZM5x9AunqYVt7GB/Av0NvGlaWxkGNd0QlLien1hD72hd9grxoNT32CWMPLWOKoqzY
	 mNyCi1eVano5RD+D55VFBiCDsawFgZ0ak//sNyax4HQdWcdAgH72ZWxynkB9pyz/h7nTB
	 Spg1+JzpDOCZNMdfnec3P98QyKdExM8MopDRxWWI88NnR0P3ZKtCVLlUSKMIUtS4DUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GnyP3M+w;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ROvK8zHR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ANlbcIDE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TE5h7LM7;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8F606A31C;
	Thu, 29 Oct 2026 14:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA8F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GnyP3M+w;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ROvK8zHR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ANlbcIDE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TE5h7LM7
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12955220FF;
	Thu, 29 Oct 2026 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793285082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ma02zVhR/wiqxtMf4JB5WMp1YLmgiNfWHzj9kC5VbP4=;
	b=GnyP3M+wrwXhfJ/mt8bOmompb4hK95hgUZ/AVXEh5csJs5Ib/dgmCnuaPudHkUqdrXPhsI
	vyBNhxct2C3EFj/hIQGCB/q+ReLyCIqZGSAnaiWkj2iUNvPi61Ecgf9lZZBR8VCiVcUMDY
	eZk/LWvfT3jQirSJG7nSL/jcyqToZlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793285082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ma02zVhR/wiqxtMf4JB5WMp1YLmgiNfWHzj9kC5VbP4=;
	b=ROvK8zHR1ViPfnRb/wmNmOKvd8+ruKEHb/fsjoBtaEmA1ibnYHuMv2PjV6tP/Z2h8rqaH7
	NiuqW16IlbbtAtDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793285081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ma02zVhR/wiqxtMf4JB5WMp1YLmgiNfWHzj9kC5VbP4=;
	b=ANlbcIDEbB6Ur4cFIftmZkdDNofc1vc/RFGI8xElieroJEETE6m5QsP9p/Njs8SPd1BhAU
	OrOzudm0cx7TCWwaJGzU5BMwp25N95N5zklBKKyU8PQ/1CgPztIoIuIBbr1oSYDbP869cd
	GTTIOkA1T4ZhbivjJzjGM3IDUqC+r+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793285081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ma02zVhR/wiqxtMf4JB5WMp1YLmgiNfWHzj9kC5VbP4=;
	b=TE5h7LM72RerrFOljyHghrWN+OB5oGMt47TWKid72KLd5VvVanU/6NKTm6YLGwiBfS3VqK
	kZ0jQYdje30fHEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 742A81339F;
	Thu, 29 Oct 2026 14:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iNqFENhb42qRUwAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 29 Oct 2026 14:44:40 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	linux-mm@kvack.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: linux-s390@vger.kernel.org,
	imbrenda@linux.ibm.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Subject: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on permission upgrade
Date: Thu, 29 Oct 2026 15:33:33 +0100
Message-ID: <20261029143336.390231-3-clopez@suse.de>
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
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

Prevent x86 KVM from over-zapping its secondary MMU on PTE permission
upgrades, which leave the PFNs unchanged and do not revoke access.
Permissions for SPTEs that KVM holds are updated on the next fault, so
dropping them early gains nothing.

Do this by adding a new MMU notifier flag to signal that a
MMU_NOTIFY_PROTECTION_VMA strictly upgrades (loosens) permissions on a
particular range.

See below for benchmark results.

Background
==========

change_protection() pairs every protection change with an
MMU_NOTIFY_PROTECTION_VMA invalidation, and KVM zaps its SPTEs in
response, as it cannot tell whether permissions widened or narrowed.
This is costly e.g. during a QEMU background snapshot, which relies on
uffd-wp to write-protect guest RAM and then restore permissions as each
page is saved. Without this series, the permission restore causes the
guest to re-fault read-only memory needlessly.

Note, the reverse situation is already handled for secondary MMUs
that reuse the CPU page tables (e.g. ARM SMMU, IOMMU/ATS). They cannot
refault, so they are notified of a permission upgrade on the CPU
TLB-flush path [1].

KVM, however, owns separate page tables and faults permissions on demand,
so it needs no such notification (as Sean noted when that signalling
was first proposed on the fault path [2]). This series applies the same
principle to the change_protection() path, signalling the permission
upgrade so KVM can avoid the unnecessary zap.

RFC Considerations
==================

1. Having the zap skip in KVM's arch-independent code does not seem
   obviously correct, as s390 caches additional translation state
   that may not be rebuilt by refaults. Maybe an expert can correct
   me. The skip could be extended to arm64 and RISC-V, but I have not
   benchmarked the benefits and I'd like to get feedback first. Hence,
   x86-only for now.

2. change_protection() could simply not emit the invalidation at all
   for a pure permission upgrade (shared-page-table MMUs invalidate
   on the CPU TLB-flush path, as noted above, so they do not need it).
   But again, the s390 case could be broken, and even then, that would
   seem too much intrusion for KVM's benefit.

3. The flag reaches KVM as a bool on struct kvm_gfn_range.
   Alternatively, KVM could forward the notifier event, as Claudio
   Imbrenda suggested at LPC [3] and others have proposed in the past
   for different purposes [4] [5]. That, along with the event flags,
   could serve the same purpose. I'd be happy to take that approach if
   there is agreement that other consumers would want it.

   (The LPC talk recording has some audio issues so I am not too sure
   on what the final agreement was)

Benchmarks
==========

AMD EPYC 9654 96-Core Processor host running a recent Linux kernel
(6b4b543fa187), with a 64GB, 64-vCPU guest running stress-ng --vm while
the host takes a QEMU background snapshot. All results are aggregated
over 5 runs, and compared between the stock kernel and one with this
patch series. Guest is rebooted across each individual run, and NUMA
balancing is disabled.

pf/s and tlb/s (per-second deltas of KVM's pf_taken and remote_tlb_flush
debugfs stats) clearly improve:

  guest pattern          baseline                    patched
  -----------------------------------------------------------------------
  read64   (read)        pf/s=950,015   tlb/s=1,440  pf/s=2,503 tlb/s=0.1
  rand-set (read+write)  pf/s=1,004,353 tlb/s=862    pf/s=4,073 tlb/s=0.3
  write64  (write)       pf/s=968,018   tlb/s=94     pf/s=2,292 tlb/s=0.3

Guest read latency was sampled with a paced probe thread in the
guest, reading one byte per page with an idle gap between reads, while
stress-ng ran with read64. Each figure is the median across 5 runs, with
the run-to-run min and max, in ns:

  metric           baseline             patched
  ------------------------------------------------------
  p50 (min max)      340     (270 380)   260   (250 260)
  p99 (min max)    19789 (16885 20200)  5207 (4076 5638)
  p99.9 (min max)  23445 (22845 24036)  6850 (6259 7110)

The median improves modestly and the refault cost shows in the tail,
where p99 drops ~3.8x.

A separate stress-ng run with write64 and --verify showed no data
corruption and no livelocks.

References
==========

[1] https://lore.kernel.org/linux-mm/cover.1eca029b8603ef4eebe5b41eae51facfc5920c41.1690292440.git-series.apopple@nvidia.com/
[2] https://lore.kernel.org/linux-mm/ZGu1vsbscdO48V6h@google.com/
[3] https://lpc.events/event/20/contributions/2552/
[4] https://lore.kernel.org/all/20240801183453.57199-1-seanjc@google.com
[5] https://lore.kernel.org/all/20231110003734.1014084-1-jackyli@google.com

Carlos López (4):
  mm/mprotect: add MM_CP_PERM_UPGRADE
  mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE
  KVM: plumb MMU_NOTIFIER_RANGE_PERM_UPGRADE into kvm_gfn_range
  KVM: x86/mmu: don't zap the secondary MMU on permission upgrade

 arch/x86/kvm/mmu/mmu.c       |  7 +++++++
 include/linux/kvm_host.h     |  1 +
 include/linux/mm.h           |  8 ++++++++
 include/linux/mmu_notifier.h |  5 +++++
 mm/hugetlb.c                 |  6 +++++-
 mm/mprotect.c                | 20 +++++++++++++++++++-
 virt/kvm/kvm_main.c          |  4 ++++
 7 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.51.0

