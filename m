Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794780021;
	b=eRZ3cDveG2EXn8GVKVrWor2kZP9K3vdosR2U2MusbraEesvNs4ILpnzwwPvcec5uDm+4
	 RZ6MvfTeoYs6WMB8q1QTUCSfN5PSE/Vs3H5eV60PJsUKdvQLGlW0dALdi5gOIFI5CJTNc
	 HBEzoYnw8WPfkyQvbQWau1ktMhWsGcRYDi60Lw1cmbCu9oqF0llcwe5Q+zJ7WU9bbd4lL
	 c9TIGHeGahTOnWzf7uBeB3XFAK7w+PPDrl6GZe9CM+OM2ErqU7qq54WYNomiKTNUCtHE6
	 ii82ofaXIsehdOnYf4NGJxqcpUMRhi/EPWa2ZlauFAGbSD9BC5gWpgfuwEvmuekgHvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780021;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=1RSqXe5NSBqTmAqgI8yQZO9YY1N+JiA5u+pgxFt2XGs=;
	b=gdd1qIoB9SfnThwy5cjCYsyAkpvXvjEw1ZXPXW4lVN3+U+KUWm2oQ7IoOOYaISyxZ72g
	 2etqo11RCXIh+Kce8Kas6SUmDofnKpvSd2r3PfcYED89yBKFnNKT5Bgq6XO4rA/Ksy3BN
	 oO2/g1pbzv99PGRoaMB+zdK5EWQOaOk21fGohARH0LogENsd4ckdApDcEqnmRW14NeS6c
	 Dm9qboj/2jsN4gir0pyt3yyccXwWELyc1Xm+GZofMFfDXSqFGjGo6a/Bnwb/SMwIoKoC3
	 D2jD+uMFc/RjXGhnBQv2Oum93K1j3IxMqqTvGbyEFG+49llZqUU89qPo2J+fecz4GNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lWT6b5dW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ryh0U1mL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lWT6b5dW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ryh0U1mL;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F3606A333;
	Sun, 15 Nov 2026 22:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C68F3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lWT6b5dW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ryh0U1mL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lWT6b5dW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ryh0U1mL
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C5861F45A;
	Sun, 15 Nov 2026 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RSqXe5NSBqTmAqgI8yQZO9YY1N+JiA5u+pgxFt2XGs=;
	b=lWT6b5dWKL4zHWCtNzWw4QbP9c2lP277H/TJ4gs21j9HdqDLwKhCuTdOPoTvq/W0hKti9N
	qiRESjvlUKws885BTsvURzshHmxXehtvXR2uyjE4ltBfq3YZqLH8r65sMV7sIeXAW7lFpW
	Ax5ukyMJonFfG3Nki741rMlwANhsgC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RSqXe5NSBqTmAqgI8yQZO9YY1N+JiA5u+pgxFt2XGs=;
	b=Ryh0U1mLig3r/y4YnBhEFlh8FmJ9siMCFCE6mh+qhd9Jfxu5Tzs6a+eMWexV2xzYpJf/b4
	RCEFROmkX4WWK0CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lWT6b5dW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ryh0U1mL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RSqXe5NSBqTmAqgI8yQZO9YY1N+JiA5u+pgxFt2XGs=;
	b=lWT6b5dWKL4zHWCtNzWw4QbP9c2lP277H/TJ4gs21j9HdqDLwKhCuTdOPoTvq/W0hKti9N
	qiRESjvlUKws885BTsvURzshHmxXehtvXR2uyjE4ltBfq3YZqLH8r65sMV7sIeXAW7lFpW
	Ax5ukyMJonFfG3Nki741rMlwANhsgC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RSqXe5NSBqTmAqgI8yQZO9YY1N+JiA5u+pgxFt2XGs=;
	b=Ryh0U1mLig3r/y4YnBhEFlh8FmJ9siMCFCE6mh+qhd9Jfxu5Tzs6a+eMWexV2xzYpJf/b4
	RCEFROmkX4WWK0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51406134F4;
	Sun, 15 Nov 2026 22:00:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 65LNBHEr+mrobwAAD6G6ig
	(envelope-from <clopez@suse.de>); Sun, 15 Nov 2026 22:00:17 +0000
Message-ID: <343d0637-d88a-4505-b7d3-37b41c89a9f9@suse.de>
Date: Sun, 15 Nov 2026 23:00:15 +0100
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
To: "David Hildenbrand (Arm)" <david@kernel.org>, kvm@vger.kernel.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-riscv@lists.infradead.org, seanjc@google.com, pbonzini@redhat.com,
 akpm@linux-foundation.org, peterx@redhat.com, ljs@kernel.org,
 imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-5-clopez@suse.de>
 <136002e1-646d-4607-be3f-b6a6a869bbec@kernel.org>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <136002e1-646d-4607-be3f-b6a6a869bbec@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C5861F45A
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
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[28];
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

On 11/13/26 7:58 PM, David Hildenbrand (Arm) wrote:
> On 11/12/26 15:20, Carlos López wrote:
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
> 
> Again, please keep MM changes to a bare minimum for your work.
> 
> If this is not required for your work, please drop it.

It is required. The new flag is not correct without it, as a protection
change that removes no permission bits still write-protects writable
PUDs. I'll explain this better.
