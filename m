Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358676;
	b=pvBe8as4fgXtdwXp7uWYoNC6tQS3jdyEhPZgvdn5It3S9uzlqfzrIhDd+qC/TE6E9FZP
	 t/Izxe8dWLq1CovvV2DrJ/JCfPfgDIQCFEN3OWZXKIswv9q1ps070ca4EZeJO9SM2z45p
	 xXrzjE/hg5tx2yCLIVJMUII5p1PQo6e11jY2eVfJXhcHmj4Ka16g1AczKEBOyeSQhH1B+
	 h29ezWZv7r96V8QXGSdmYR8a78wuTxtC+fpVstjpP0vgaBPsUWT/xMy5yt5VV8Eb6AUN9
	 28KGm57K58p4Dt9SBddJMAzWEK2iC1YvdoFWYEtMz04w0xlwLnrgZaM4f/TH47PLPPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358676;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=nszrMrMC8JlryWKVnrpBXd9LzP9yZlaTn4MSY8r3MBU=;
	b=XcqqtiS4Ay09Oxx96k4TQqFbj3OCMQsk3v0CsEQvuacYzfKmoVh3Ef+wLpx4xO/EJWRE
	 IjNM0OO/cyc/GVJFQRhEDJ9qgNj+XBZHvMSDeNppYlsHyXYP4K2KgQ5fHAqZThmzjwMEY
	 oCxhlwZiBZL6dtk/EFdgTlzGNNTAUnKfhWwJCcmMQMh0AIWEY5UtswWPd481Wcn4fy3hd
	 ZuqxdnsHaIrGqsCQwf6/6UVDgy/BRywZ4YrrRVTPsQFalSdOjkxczPa3atBj+kbFSkO8G
	 qUl5cEVoIZmHnnRbXbuaFfLdjZCOrUYz4yFalnBAyIYYcGVY546UrmD2GILsyVJyUkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ekkmc0iv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=meBZKaxc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=euVkA99P;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pJldxYkT;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEA606A334;
	Fri, 30 Oct 2026 11:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56CEA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ekkmc0iv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=meBZKaxc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=euVkA99P;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pJldxYkT
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35D83221DB;
	Fri, 30 Oct 2026 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793358673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nszrMrMC8JlryWKVnrpBXd9LzP9yZlaTn4MSY8r3MBU=;
	b=ekkmc0ivszyK/vAY6lBPUE6qzElfnru/iUuzfCgKurIOdUPfpTcZe4CQ5WdHK6uL3HpPe+
	ivAE/pEXQy7dDGEFw+qX3s0Z84oKfI3yKDuaJBvFZLVbH9Dkd8KiHbWtIywrqaQlvaQFUc
	JKeBzBRaWoSBGTLsp7OUQf30CTmgbgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793358673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nszrMrMC8JlryWKVnrpBXd9LzP9yZlaTn4MSY8r3MBU=;
	b=meBZKaxcQdo5M64Civ0W8Qi/p8wiRzpNc0CNoDYaq1bku7e9AvD+TUTvwGMpyXcIQ/SeL8
	wvr3F55IIX8v5dDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=euVkA99P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pJldxYkT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793358672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nszrMrMC8JlryWKVnrpBXd9LzP9yZlaTn4MSY8r3MBU=;
	b=euVkA99P02W0HOtNgkwVGJU0eZPovuI7Z5vIQKYRCLeaKtnfmcUQBmK3vxdh6dKKmhhli2
	7VmJSetuGoiMj9Tt+ITO9lvykXuyB5MampsGDXUfJZJXuFRdpQsw/WiPiRkNlPyyF9QkVr
	T3K6swpXqDdQnzSF0lLDFSeJgKqgcXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793358672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nszrMrMC8JlryWKVnrpBXd9LzP9yZlaTn4MSY8r3MBU=;
	b=pJldxYkTA1CYZE9/K7+AqoHKGny9M0DH5G+YPoB8VymsOdj36c0gEmwgZx6L4ggLfJsNAW
	vXLPyJhRAoJlUZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7654132C9;
	Fri, 30 Oct 2026 11:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nEf3HE975GrwSAAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 30 Oct 2026 11:11:11 +0000
Message-ID: <df9dc526-4275-4784-8a0c-2e4fa8e96402@suse.de>
Date: Fri, 30 Oct 2026 12:11:07 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, seanjc@google.com,
 pbonzini@redhat.com, linux-s390@vger.kernel.org
References: <20261029143336.390231-3-clopez@suse.de>
 <20261029175203.5bdd51d7@p-imbrenda>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <20261029175203.5bdd51d7@p-imbrenda>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 35D83221DB

On 10/29/26 5:52 PM, Claudio Imbrenda wrote:
> On Thu, 29 Oct 2026 15:33:33 +0100
> Carlos López <clopez@suse.de> wrote:
> 
>> Prevent x86 KVM from over-zapping its secondary MMU on PTE permission
>> upgrades, which leave the PFNs unchanged and do not revoke access.
>> Permissions for SPTEs that KVM holds are updated on the next fault, so
>> dropping them early gains nothing.
>>
>> Do this by adding a new MMU notifier flag to signal that a
>> MMU_NOTIFY_PROTECTION_VMA strictly upgrades (loosens) permissions on a
>> particular range.
>>
>> See below for benchmark results.
>>
>> Background
>> ==========
>>
>> change_protection() pairs every protection change with an
>> MMU_NOTIFY_PROTECTION_VMA invalidation, and KVM zaps its SPTEs in
>> response, as it cannot tell whether permissions widened or narrowed.
>> This is costly e.g. during a QEMU background snapshot, which relies on
>> uffd-wp to write-protect guest RAM and then restore permissions as each
>> page is saved. Without this series, the permission restore causes the
>> guest to re-fault read-only memory needlessly.
>>
>> Note, the reverse situation is already handled for secondary MMUs
>> that reuse the CPU page tables (e.g. ARM SMMU, IOMMU/ATS). They cannot
>> refault, so they are notified of a permission upgrade on the CPU
>> TLB-flush path [1].
>>
>> KVM, however, owns separate page tables and faults permissions on demand,
>> so it needs no such notification (as Sean noted when that signalling
>> was first proposed on the fault path [2]). This series applies the same
>> principle to the change_protection() path, signalling the permission
>> upgrade so KVM can avoid the unnecessary zap.
>>
>> RFC Considerations
>> ==================
>>
>> 1. Having the zap skip in KVM's arch-independent code does not seem
>>    obviously correct, as s390 caches additional translation state
>>    that may not be rebuilt by refaults. Maybe an expert can correct
>>    me. The skip could be extended to arm64 and RISC-V, but I have not
>>    benchmarked the benefits and I'd like to get feedback first. Hence,
>>    x86-only for now.
>>
>> 2. change_protection() could simply not emit the invalidation at all
>>    for a pure permission upgrade (shared-page-table MMUs invalidate
>>    on the CPU TLB-flush path, as noted above, so they do not need it).
>>    But again, the s390 case could be broken, and even then, that would
>>    seem too much intrusion for KVM's benefit.
>>
>> 3. The flag reaches KVM as a bool on struct kvm_gfn_range.
>>    Alternatively, KVM could forward the notifier event, as Claudio
>>    Imbrenda suggested at LPC [3] and others have proposed in the past
>>    for different purposes [4] [5]. That, along with the event flags,
>>    could serve the same purpose. I'd be happy to take that approach if
>>    there is agreement that other consumers would want it.
>>
>>    (The LPC talk recording has some audio issues so I am not too sure
>>    on what the final agreement was)
> 
> AFAIR the consensus was:
> - adding the reason to the kvm kvm_gfn_range is fine.
> - having a return value from the notifier to pass information back is
>   _not_ fine; I should add a new callback instead.
> 
> regarding this series:
> 
> on x86 you don't care what the new permissions are, because you're
> updating when re-faulting (if I understood correctly).

Correct.

> for s390 it might be beneficial to know what the new permissions are;
> of course we could look up the vma and find out, but since you are
> already checking the permissions, maybe you can find a way to also
> convey the new permission bits?
> 
> that would make our life on s390 easier :)

Right, getting the new bits from vma->flags should be trivially done
from the MMU_NOTIFY_PROTECTION_VMA callsites. There'd be no users in
this series though. The rest of architectures still need the notifier to
tell them if the change is an upgrade, since they don't have an easy way
to grab the old RWX bits. Passing the old RWX bits from the MMU notifier
does not seem trivial to me either.

So what I can do is to plumb down the event and flags into KVM, and
leave it open for you to come back and forward the permission bits you
need via the range flags, if the MM maintainers are okay with it.

However, I tried to understand the s390 code better with AI, and it
seems to think that skipping the zap is also safe there (and an
improvement). It could be further optimized by passing down the new W
bit to eagerly fix the gmap when restoring write permissions.

>>
>> Benchmarks
>> ==========
>>
>> AMD EPYC 9654 96-Core Processor host running a recent Linux kernel
>> (6b4b543fa187), with a 64GB, 64-vCPU guest running stress-ng --vm while
>> the host takes a QEMU background snapshot. All results are aggregated
>> over 5 runs, and compared between the stock kernel and one with this
>> patch series. Guest is rebooted across each individual run, and NUMA
>> balancing is disabled.
>>
>> pf/s and tlb/s (per-second deltas of KVM's pf_taken and remote_tlb_flush
>> debugfs stats) clearly improve:
>>
>>   guest pattern          baseline                    patched
>>   -----------------------------------------------------------------------
>>   read64   (read)        pf/s=950,015   tlb/s=1,440  pf/s=2,503 tlb/s=0.1
>>   rand-set (read+write)  pf/s=1,004,353 tlb/s=862    pf/s=4,073 tlb/s=0.3
>>   write64  (write)       pf/s=968,018   tlb/s=94     pf/s=2,292 tlb/s=0.3
>>
>> Guest read latency was sampled with a paced probe thread in the
>> guest, reading one byte per page with an idle gap between reads, while
>> stress-ng ran with read64. Each figure is the median across 5 runs, with
>> the run-to-run min and max, in ns:
>>
>>   metric           baseline             patched
>>   ------------------------------------------------------
>>   p50 (min max)      340     (270 380)   260   (250 260)
>>   p99 (min max)    19789 (16885 20200)  5207 (4076 5638)
>>   p99.9 (min max)  23445 (22845 24036)  6850 (6259 7110)
>>
>> The median improves modestly and the refault cost shows in the tail,
>> where p99 drops ~3.8x.
>>
>> A separate stress-ng run with write64 and --verify showed no data
>> corruption and no livelocks.
>>
>> References
>> ==========
>>
>> [1] https://lore.kernel.org/linux-mm/cover.1eca029b8603ef4eebe5b41eae51facfc5920c41.1690292440.git-series.apopple@nvidia.com/
>> [2] https://lore.kernel.org/linux-mm/ZGu1vsbscdO48V6h@google.com/
>> [3] https://lpc.events/event/20/contributions/2552/
>> [4] https://lore.kernel.org/all/20240801183453.57199-1-seanjc@google.com
>> [5] https://lore.kernel.org/all/20231110003734.1014084-1-jackyli@google.com
>>
>> Carlos López (4):
>>   mm/mprotect: add MM_CP_PERM_UPGRADE
>>   mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE
>>   KVM: plumb MMU_NOTIFIER_RANGE_PERM_UPGRADE into kvm_gfn_range
>>   KVM: x86/mmu: don't zap the secondary MMU on permission upgrade
>>
>>  arch/x86/kvm/mmu/mmu.c       |  7 +++++++
>>  include/linux/kvm_host.h     |  1 +
>>  include/linux/mm.h           |  8 ++++++++
>>  include/linux/mmu_notifier.h |  5 +++++
>>  mm/hugetlb.c                 |  6 +++++-
>>  mm/mprotect.c                | 20 +++++++++++++++++++-
>>  virt/kvm/kvm_main.c          |  4 ++++
>>  7 files changed, 49 insertions(+), 2 deletions(-)
>>
> 

