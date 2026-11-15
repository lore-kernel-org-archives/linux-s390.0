Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794780059;
	b=efAS+/pCpfGo54XxO7IDYNwNcVb+tnrqQtQQJg9ID8HWXY/jK08F7inR1aXzpK+SeY9T
	 Yhk6N/hSryHioIPQJKOjqmDeRljYx5vCpdQmMYD1iXSOM/+Q8+u9E+bUVNMP11+L4zhJ9
	 am3ZCWu2xexvKwYM+YNWXPjV2QI+5yA4x2wwTZFx9AEZg3HGZtniY1NjgT7XAxN4uANj+
	 3/qfjmq4KSJhwPnL9IiTjV+MjG2UfWHyf86r0WkLnHkrvmdY5xIHt9Xw2RYo3OBlu4oi6
	 eKQo1W6Q60DhBPePolvotJFgcLdHJSQXofFJJzxHajBARwcEwpVTGhZjU+RHP3liKOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780059;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=7FlApLM+6NHXeyNHrZs7qFAb7ZQYfBd5O8QQnbg+ljM=;
	b=ICf6QYQtooWCO4xmHaeU5kZhkMb/gluCjdqyZgcB/5f/JSYEKseo+I+5Lm2i/qYia/m4
	 59bP6lqrssI4ptG2ChBhoawJ5EFIjpT44xzk5fhb4fPvxRdsSMxcdtnnIvEfYUlg0QyqU
	 Mm+jBnw9L+rleHKM1N3MaAMLIwjIfAEHMLGLx3kwi9F8N/YnyT/pL9kh+gXfM3FN/XRDd
	 UOi08L4ktG/auIHM5sUCwV62QiJTQ2GcPT3xoIUaLnldQw7tcRllotVCqCPNEp4qZQR/6
	 LDKlAWMtPpvpwMyuTKegkbAodec2tCNxVIlVU+kJZu3LMwEvo6WsXw1GKTbyz4rXxrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qwaE8OCh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4+zODNCs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UL2AJR1B;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8xD41Gpx;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82300606A329;
	Sun, 15 Nov 2026 22:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82300606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qwaE8OCh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4+zODNCs;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UL2AJR1B;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8xD41Gpx
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 220F51F453;
	Sun, 15 Nov 2026 22:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FlApLM+6NHXeyNHrZs7qFAb7ZQYfBd5O8QQnbg+ljM=;
	b=qwaE8OCh9q7DPjRCRWrDN3gSH+C/rRxOO4tjyMLG9u1935rUbhmfAqEsM8HKtkWWRu9Zwg
	Edk21Rf9o6W4cR/K8rlzm3w3VQgzTPqYi4XjKDo5va8dWtQTK9ZcUoAoaK0qag7ugYH9WW
	lJyY1EnCiHEFQrN5YOkYwKlBRizhvdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FlApLM+6NHXeyNHrZs7qFAb7ZQYfBd5O8QQnbg+ljM=;
	b=4+zODNCsDGJ5IVOEpCHjeUo1EVO9r5zTadv/CLmLmfPhVg+HsnElN6wR+yHo9EWPWXC3cw
	l/ef6th5jEOjNdCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UL2AJR1B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8xD41Gpx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FlApLM+6NHXeyNHrZs7qFAb7ZQYfBd5O8QQnbg+ljM=;
	b=UL2AJR1BrjXZmm+GGh4UMq32pWsgoSMmhN+u1mUj191Yfs5b2UovWRoPPLgbaxf4LoQxHe
	wCkxg0dVMwml21R9t1wsR4ic7Og+VfwWcbt6UfUHcYLsnTPWJqR53SFSh/uwgiQIBxfef2
	wFXlaHNqK/MHeQ+sqT4+M+Bw5A8iVJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FlApLM+6NHXeyNHrZs7qFAb7ZQYfBd5O8QQnbg+ljM=;
	b=8xD41GpxBN+xCOa43OZxnWJbsv0+D7lCV3ihsL9anYIBLNyrixPBhfRBT9DyCinpAMuTWb
	81hngw5kGsBimuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D712134F4;
	Sun, 15 Nov 2026 22:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9PgqNJUr+moqcQAAD6G6ig
	(envelope-from <clopez@suse.de>); Sun, 15 Nov 2026 22:00:54 +0000
Message-ID: <f0a6bfcf-b131-419a-8b7d-ce10e0c507d8@suse.de>
Date: Sun, 15 Nov 2026 23:00:53 +0100
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
Subject: Re: [PATCH v3 1/9] mm: fix eager write-bit restore for write-notified
 shared mappings
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
 seanjc@google.com, pbonzini@redhat.com, akpm@linux-foundation.org,
 david@kernel.org, peterx@redhat.com, imbrenda@linux.ibm.com,
 borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Peter Feiner <pfeiner@google.com>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-3-clopez@suse.de> <avd12eMWaTl87uL0@gremlin>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <avd12eMWaTl87uL0@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 220F51F453
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
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Score: -13.50

On 11/13/26 9:47 PM, Lorenzo Stoakes (ARM) wrote:
>>  static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
>>  {
>>  	/*
>> @@ -596,19 +604,16 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
>>  	 * if we can't do that automatically for all PTEs in a mapping. For
>>  	 * private mappings, that's always the case when we have write
>>  	 * permissions as we properly have to handle COW.
>> +	 *
>> +	 * vma->vm_page_prot lacks the write bit if writenotify is already
>> +	 * enabled, so pass it with the bits restored, as vma_set_page_prot()
>> +	 * does.
> 
> We don't write code in comments.

I'll drop it.

>>  	 */
>>  	if (vma->vm_flags & VM_SHARED)
>> -		return vma_wants_writenotify(vma, vma->vm_page_prot);
>> +		return vma_wants_writenotify(vma,
>> +		       vma_pgprot_modify(vma->vm_page_prot, vma->flags));
> 
> You mention vma_set_page_prot() but then implement it differently from there and
> make no effort to abstract it?
> 
> And so both callers now do the same thing, and both open code it... you should
> abstract that.

Okay, I'll add a helper for both.
