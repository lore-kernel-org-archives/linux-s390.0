Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977409;
	b=fMEWjezyFt4e/KQMTMzgm84qywVHWxN8aKyc+d07zLfQyvok2GS2uTDIBg4EScwDG2mY
	 XwcgCsjkK0UvOqA2EDUvBaHQ5M7W0I1/YWeDaGOZdUn0Y9MheFgZp6ODmVOXRWB+1HvlV
	 RnmEz9SPw3DxklRS0VptVcDcUHO4UIQXDkOuBKdPzaZiFvofQ7LfLPdaefGgaRQHiJNAu
	 ws+Uw/6eIcJlcPeBbBUeCTKTyfXz9NQt1QybctKY40bH6xuCRaGqL5LMZ6HwKAZfN3pBU
	 d0izc1g/aeAWAmWVXBluedsjQ8O4T3I1Dv0AaKzWRlX3UZxzI8OSJH5m5f5R0fA8nSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977409;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=6FoXJI83hjTO3ej0IaD9RjGbYyhgQtVCqkHhpUVyi4c=;
	b=jcfvwMUD9nx27WsaiGBSpsngaXthCbm+PWF/bIJPXbWA8vJlWQHkrFr8BjWFOyp9RYYF
	 fXshXnxGhbiXrT9oJeVHyJrwY3WfiCxLQAGV8bjUyy0xOyl6keD0giq1V+EzVLdPU3v9x
	 UM2T/wqSeEYmtG02tu8EQkrhrpoMrxRiyagZGOp1wPaPoygEeUK/DdVObV+ZhtA0RXTTx
	 BPva+/o4BR1pCG2/SN21f52yxjAhPRXX0ZawvCv2Wmsxpe8Z0lz0BBjpleEBYZLBArsFo
	 QsxWduXGH/8tJIGyiD6p18EBqEQmgR3yMehWvr28mQTJ8xQ1espcvDA2PASPzp+YC7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T99h4t2e;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=A2iRrZUk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TrP7zV8B;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pwChqOUr;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD9606A33F;
	Fri,  6 Nov 2026 15:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6DD9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T99h4t2e;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=A2iRrZUk;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TrP7zV8B;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pwChqOUr
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C528B1F452;
	Fri,  6 Nov 2026 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793977407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FoXJI83hjTO3ej0IaD9RjGbYyhgQtVCqkHhpUVyi4c=;
	b=T99h4t2eVaDmcmrjVcu27YVtUhLbvUNfnyHjcqGwmJAK8EY3JM5NW5F64yAYp/wwy8z4CL
	OQ3ZR7qiT0H/FjFFL5nmUgbhfEZgFD9A5EtEfwwQfjsDhOuOnsVFcTehzefBuemiKXfZT6
	E8gfqHNX/vfuRnQ1iXGfrwne/66b0go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793977407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FoXJI83hjTO3ej0IaD9RjGbYyhgQtVCqkHhpUVyi4c=;
	b=A2iRrZUkUprSGaX3DSBXtYraW62Mf+y73dvDiOil3BLXplUYqTBbKk5eyLZK8lPx4MkHqO
	AdHMM067QoKSB0DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TrP7zV8B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pwChqOUr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793977405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FoXJI83hjTO3ej0IaD9RjGbYyhgQtVCqkHhpUVyi4c=;
	b=TrP7zV8B8N1md/3I8OjCcYITIt4ESSWHs0Yz8xJhnNoMmua2OoyrnWj4n7PNXBtu2z1R9G
	90BoSMUNQDUeYsD97x9WMj89IbtxNHO6Bl24ZQQIgRG5rYGqdWpolgLjdvqds6BCDhpws1
	YspriT66b/zBgFq/O7crDSGBMle7v+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793977405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FoXJI83hjTO3ej0IaD9RjGbYyhgQtVCqkHhpUVyi4c=;
	b=pwChqOUrbMtB61kYeSJynpZeIOHohxyjdHnde7E83dlZHSYA2ThLpp3JiZ/YStXID2sheR
	ThpKDcjnpwj+lDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33B42132C9;
	Fri,  6 Nov 2026 15:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mWThNTvs7Wo+GAAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 06 Nov 2026 15:03:24 +0000
Message-ID: <8e5f0caa-6292-4a65-ba8b-7ae647dd3b1f@suse.de>
Date: Fri, 6 Nov 2026 16:03:19 +0100
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
Subject: Re: [PATCH v2 5/9] mm/mprotect: keep writable entries writable on
 permission upgrades
To: "David Hildenbrand (Arm)" <david@kernel.org>, kvm@vger.kernel.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-riscv@lists.infradead.org, seanjc@google.com, pbonzini@redhat.com,
 akpm@linux-foundation.org, peterx@redhat.com, ljs@kernel.org,
 imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <20261105165004.2663799-4-clopez@suse.de>
 <20261105165004.2663799-9-clopez@suse.de>
 <60c4f0a0-e3c9-42dc-b2e0-0860ab6e30f0@kernel.org>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <60c4f0a0-e3c9-42dc-b2e0-0860ab6e30f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-14.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -14.50
X-Spam-Level: 
X-Rspamd-Queue-Id: C528B1F452

On 11/5/26 6:06 PM, David Hildenbrand (Arm) wrote:
> On 11/5/26 17:50, Carlos López wrote:
>> change_protection() applies vma->vm_page_prot, which lacks the write bit
>> for CoW and write-notified mappings, so it write-protects every entry
>> in them. When an entry would simply be made writable on fault without
>> further checks (e.g. dirty PTEs in shared mappings, exclusive anonymous
>> pages), MM_CP_TRY_CHANGE_WRITABLE makes the entry writable again to
>> avoid the future fault.
>>
>> However, writable entries in shared mappings that are not dirty still
>> become read-only. For example, a uffd-wp unprotect makes clean shmem
>> PTEs read-only even if they were never write-protected, e.g. when they
>> were mapped by a read fault before uffd-wp was registered. The next
>> write to each of them causes a fault that only restores the write bit.
>>
>> Now that MM_CP_PERM_UPGRADE indicates whether mprotect() only adds
>> permissions, change_protection() can tell, together with the
>> userfaultfd unprotect flags, when a change revokes no access. Keep
>> writable entries writable in these cases, at the PTE, PMD and PUD
>> levels. This is consistent with the write fault handler, as an entry
>> that is already writable needs no write fault.
>>
>> Signed-off-by: Carlos López <clopez@suse.de>
>> ---
>>  mm/huge_memory.c | 7 +++++++
>>  mm/internal.h    | 7 +++++++
>>  mm/mprotect.c    | 4 ++++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 506e1e61c0fd..6e23d0e4ae66 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2809,6 +2809,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  	if (userfaultfd_rwp(vma) && pmd_uffd(entry))
>>  		entry = pmd_modify(entry, PAGE_NONE);
>>  
>> +	/* See change_present_ptes(). */
>> +	if (mm_cp_is_perm_upgrade(cp_flags) && pmd_write(oldpmd))
>> +		entry = pmd_mkwrite(entry, vma);
>> +
>>  	/* See change_pte_range(). */
>>  	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
>>  	    can_change_pmd_writable(vma, addr, entry))
>> @@ -2885,6 +2889,9 @@ int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  	 */
>>  	oldpud = pudp_invalidate(vma, addr, pudp);
>>  	entry = pud_modify(oldpud, newprot);
>> +	/* See change_present_ptes(). */
>> +	if (mm_cp_is_perm_upgrade(cp_flags) && pud_write(oldpud))
>> +		entry = pud_mkwrite(entry);
> 
> That looks completely hacked on. We do have can_change_pud_writable() below to
> make such decisions.

Okay, for v3 I can pass the old entry to can_change_{pmd,pud}_writable()
and return true if it was writable, after the existing write-tracking
checks (uffd-wp/soft-dirty). For PTEs, can_change_pte_writable() is not
used on the change_protection() path, so the same check would go in
set_write_prot_commit_flush_ptes().

Does that sound more reasonable?

> Whaatever you propose here is either wrong or way too shaky, sorry.

The idea is that MM_CP_TRY_CHANGE_WRITABLE relies on the dirty bit to
make entries in shared mappings writable, which misses clean entries
that were already writable (e.g. shmem read-faulted before uffd-wp
registration). Such entries can stay writable, as anything that relies
on write faults write-protects the entry first.
