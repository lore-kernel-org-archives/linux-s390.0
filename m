Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794780045;
	b=FutokV8eo3sWK0tmS4pPnYQRyXhztgJMVs7aUFi5BdoFq0PgmQb0KhzwnHQtbfZrBoev
	 lOjVrv0xyuN76fwnUYUSezlbHbCW+CEfMIDvcTSz1A478YLq5+CUQOOyRaoooklYjAx7g
	 uobhaxk0XC7VMQhlY1d0RuvcgjRf70yglOp0mkvxf1V/UpCRVtiURBlMHswwPJbPschUJ
	 cqfBZiJYWW4F+W4FzitQp2FaKiI9f4y22oa4t0tcMfCn+3pIdC5f4HCs+ey3XZBWY5a1C
	 UFJZ9Y6B+1qQPAYmwyF4puJk0dgAKgsctyS6w4KRqpW1gtlMhicZWm/C7PsTJshFqWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780045;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=u1q2m7iCmRu8/0QbFElHLPq1Wp6Csg/qGVcaQCf3LJU=;
	b=tpt6lb4ATuLeLom3bQW8qInvw2Gvm2qrG7X+I6ib9z+F6PK/ayjECMH8tfewWoSxW156
	 LFMD9ilmWhy1a6gH/a+ZXLwuXPGbgVGztXuGyqCiu4kFuz/D7zUUzkq336To7NSzDJuo4
	 5Wbmrk9pXlHckSkRR2PBrh4jcp2bb4/wTlWU4vrmJdHEsIMpe6aXvgwBMNyjT0YtkUm79
	 7qsnQjrI6VAE3DG0/WjqfF7b/Gus0bvJDbHIv1qqoEXoZRn4FvjXbpbs1jTO/cMss1/Ix
	 pNeOYmq8IbdEoBiKTJyV6nQbiM2iAZXbhMiDhNPm4fa3NJN4WgC3yZXJnANsGATT8bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VtC39wDA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FSD3EA54;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VtC39wDA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FSD3EA54;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B139606A31F;
	Sun, 15 Nov 2026 22:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B139606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VtC39wDA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FSD3EA54;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VtC39wDA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FSD3EA54
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8882F1F449;
	Sun, 15 Nov 2026 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1q2m7iCmRu8/0QbFElHLPq1Wp6Csg/qGVcaQCf3LJU=;
	b=VtC39wDA1GWTGm0xox6CVDf2jVHsVvaOgt8LdKsluJlNGWsTnvwnbRNo+nszbXNH/ZPn6y
	mdlew/Jpo8f7BwJUW4HaSquuZ8yOPAoLg69ziQTIda6nEc5Eni7s2jrotzE7DBLQUWLjFQ
	AmQHK4DwrDTT5G6BDD9HFxk+aM4yeTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1q2m7iCmRu8/0QbFElHLPq1Wp6Csg/qGVcaQCf3LJU=;
	b=FSD3EA54NpSYVbs7Zde8pdPXSOSxZXRemtfdLIRL9+aSukEH1zgttElCb9EI88/JkNI5gh
	sHc8q8hKGbej2QAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1q2m7iCmRu8/0QbFElHLPq1Wp6Csg/qGVcaQCf3LJU=;
	b=VtC39wDA1GWTGm0xox6CVDf2jVHsVvaOgt8LdKsluJlNGWsTnvwnbRNo+nszbXNH/ZPn6y
	mdlew/Jpo8f7BwJUW4HaSquuZ8yOPAoLg69ziQTIda6nEc5Eni7s2jrotzE7DBLQUWLjFQ
	AmQHK4DwrDTT5G6BDD9HFxk+aM4yeTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1q2m7iCmRu8/0QbFElHLPq1Wp6Csg/qGVcaQCf3LJU=;
	b=FSD3EA54NpSYVbs7Zde8pdPXSOSxZXRemtfdLIRL9+aSukEH1zgttElCb9EI88/JkNI5gh
	sHc8q8hKGbej2QAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9EFE134F4;
	Sun, 15 Nov 2026 22:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KoiGLokr+mqVcAAAD6G6ig
	(envelope-from <clopez@suse.de>); Sun, 15 Nov 2026 22:00:41 +0000
Message-ID: <1cc05b4d-e713-49e8-9bac-444259bf12f3@suse.de>
Date: Sun, 15 Nov 2026 23:00:41 +0100
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
Subject: Re: [PATCH v3 3/9] mm/huge_memory: honor MM_CP_TRY_CHANGE_WRITABLE in
 change_huge_pud()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
 seanjc@google.com, pbonzini@redhat.com, akpm@linux-foundation.org,
 david@kernel.org, peterx@redhat.com, imbrenda@linux.ibm.com,
 borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-5-clopez@suse.de> <avd0Cexmmu7kCN45@gremlin>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <avd0Cexmmu7kCN45@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL8fugicft4tip39ru97wanzoz)];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 11/13/26 9:48 PM, Lorenzo Stoakes (ARM) wrote:
> On Thu, Nov 12, 2026 at 03:20:32PM +0100, Carlos López wrote:
>> change_protection() applies vma->vm_page_prot, which lacks the write bit
>> for CoW and write-notified mappings. MM_CP_TRY_CHANGE_WRITABLE makes
>> entries writable again if a write fault would only set the write bit.
>>
>> However, change_huge_pud() ignores the flag. For example, device DAX
>> mappings are write-notified once soft-dirty tracking is armed through
>> /proc/pid/clear_refs, and a protection change then leaves dirty PUDs
>> read-only, so the next write to each of them faults.
>>
>> Fix this by adding can_change_pud_writable(), based on
>> can_change_pmd_writable(). It omits the NUMA and uffd-wp checks, as
>> change_huge_pud() bails out on those changes.
>>
>> Signed-off-by: Carlos López <clopez@suse.de>
> 
> Is this a real problem that actual people have had?
> 
> The why of all this is still eluding me, especially for THP PUD...

Nobody reported it, but the new flag depends on it, see my reply to
David for this same patch.

>> [...]
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> +static inline bool can_change_pud_writable(struct vm_area_struct *vma,
>> +					   unsigned long addr, pud_t pud)
>> +{
>> +	struct page *page;
>> +
>> +	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
>> +		return false;
>> +
>> +	/* Do we need write faults for softdirty tracking? */
>> +	if (vma_soft_dirty_enabled(vma) && !pud_soft_dirty(pud))
>> +		return false;
>> +
>> +	if (!(vma->vm_flags & VM_SHARED)) {
> 
> This is getting annoying now, you're seemingly _knowingly_ writing deprecated
> VMA flag API code on purpose.

Sorry, I based it on can_change_pmd_writable(), I'll use vma_test() instead.
