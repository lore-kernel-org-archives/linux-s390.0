Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794779987;
	b=Faerjoj41Dx/KX1lqW20EzSpXKtnN+U1u4Q3sb7gYMxF6an8xYQOKFq2TyYonOd68JzK
	 IINh8xroGeLm4G96Uv7Vp3oWzuO+DL8jSSwNUXz57+YfT0AXl8oFntDimd3cT3I6lb8/a
	 A+PFTPjbygyMMbUEwwR/sI32yPQkqy9UMGfLfiTxol9o3wyc/SkzymerV/bTtmnAuxPBQ
	 eNQZlXrPrUnSqWthRp1SbNDiZnflPoHeJ60M1+NkfvR+uhrX2lRWLjpSpopDMtCvbyJyF
	 IABt7dptiWVv1mwgsXex/z3l1tFX/tmzMjVIrKegOHvsz+ftepOgq4ykeEsxKulTAZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779987;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=CVZtep4ZvvYVafoyhBpdOjFTJN1dKVl9nzH4Gq67ry0=;
	b=otWFu5WLPa3ucoxUCrmOMT2Q0CXns9MPmwc+SnV7EB+SN0Da/q+/NThdQaFhsECTG/9W
	 Qxpf0/r45KQht59jSDmHOrEs5T+P11FVj263Q+P7oQ8bBlVJJXbHS3Se9nDZDnqTUa2Qy
	 fwEnezX4wVNADA6+pAGDmncBe62+EWy8HN5LPdPrI+sWMHKdLkJjr3D2TbeqXibOlSqLF
	 p1igEo0O7ljZQPcA2aenUQ+nQH+aKtzDw6GNldYoDGox6+DMwumBXo4TO/9fsH3qpCHpQ
	 YDbfuI5PuDsDZQl237axqqMDGS6WouiTvDeHaIkH5Bak/YslyfpcfnXwC5sxhAwSLdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gY3mMjYg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DmLbD5KU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qIV84Pyr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mZIJVbXM;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4038606A323;
	Sun, 15 Nov 2026 21:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4038606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gY3mMjYg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DmLbD5KU;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qIV84Pyr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mZIJVbXM
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1ED7B1F449;
	Sun, 15 Nov 2026 21:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794779983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVZtep4ZvvYVafoyhBpdOjFTJN1dKVl9nzH4Gq67ry0=;
	b=gY3mMjYgF5vu+pI9mP2Rd7Drc/pLMD4+v0EO8drluBELU1wBHzwhO1G0DsDiVTzXFHGgH+
	O1TnR4e+K/hgSgv0EpizCjhk7Znh2BGwNm/UvaVImw1Nl0VmTZZ0sY8HpSDVbFQn5Cmuwe
	x/iUHMnlIVIoZGAEAtOoUhKk69k9i7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794779983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVZtep4ZvvYVafoyhBpdOjFTJN1dKVl9nzH4Gq67ry0=;
	b=DmLbD5KUDJLP/w2kKJHYFJocZG1hzbxdIfNN2YISnQFOeYfkFh3/beBXJ6IR+yltYHkFXR
	2sIQl02LYF9HBpDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qIV84Pyr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mZIJVbXM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794779982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVZtep4ZvvYVafoyhBpdOjFTJN1dKVl9nzH4Gq67ry0=;
	b=qIV84PyrNE0dD3kBoWUBjZeNZWF3AuDrlfCmqolb2FyOl3t/p9nLINmfhRiuwbEhnf7cHn
	uvbVod1sY0b1k4VFPEjCI4wF9A6sHGkBMWXKQMyIMavO1PCvH88n5U2cE3xwkVVWvd5TV9
	ynZMTjAbR5YSxOQOGxknOfLcTpH5dRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794779982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVZtep4ZvvYVafoyhBpdOjFTJN1dKVl9nzH4Gq67ry0=;
	b=mZIJVbXM4XB1a0Tz1IPi2hV9yfHM9XZLuK3X4kSgmZKoLw9I0IrLNWZDHe+a9xJq9w2YW+
	TR77jarbUdO9STAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ABED134F4;
	Sun, 15 Nov 2026 21:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 408tCkwr+mr9bgAAD6G6ig
	(envelope-from <clopez@suse.de>); Sun, 15 Nov 2026 21:59:40 +0000
Message-ID: <743f60f7-d611-4d73-a2d1-d5873bcdda36@suse.de>
Date: Sun, 15 Nov 2026 22:59:39 +0100
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
Subject: Re: [PATCH v3 4/9] mm: keep writable entries writable on protection
 changes
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
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-6-clopez@suse.de>
 <603cd8e0-c2c5-4c1e-85c4-d0a5ceda8d4c@kernel.org>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <603cd8e0-c2c5-4c1e-85c4-d0a5ceda8d4c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1ED7B1F449
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RL3zg8z7sygsujbub1yh4z3pr1)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Score: -13.50

On 11/13/26 7:56 PM, David Hildenbrand (Arm) wrote:
> On 11/12/26 15:20, Carlos López wrote:
>> change_protection() applies vma->vm_page_prot, which lacks the write bit
>> for CoW and write-notified mappings. MM_CP_TRY_CHANGE_WRITABLE makes
>> entries writable again if a write fault would only set the write bit.
>> In shared mappings, it relies on the dirty bit for this, as a clean
>> entry might still need a write fault to notify the FS.
>>
>> However, this misses clean entries that were already writable. For
>> example, a uffd-wp unprotect makes shmem PTEs read-only if they were
>> mapped by a read fault before uffd-wp was registered, so the next write
>> to each of them faults.
> 
> See my other reply, adding such optimizations without any motivation why we
> should even care is not really what we want.
> 
> Drop it from your series and keep the MM changes to a bare minimum please.
> 
> Or is there a real dependency for your work?
> 

Yes there is, but I clearly did not explain it properly.

The whole point of the series is to avoid zaps when no permission bits
are removed by a protection change, e.g. mprotect(PROT_READ |
PROT_WRITE) on a read-only VMA. My proposal is for change_protection()
to signal this is the case to MMU notifiers with a new flag. However,
change_protection() sometimes write-protects entries that were writable,
which makes the flag wrong, so this patch fixes that.

I'll be sure to explain this properly.
