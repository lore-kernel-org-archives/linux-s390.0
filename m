Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794780119;
	b=hggMoQYzL7WllUb0Nvj9CBvqCSyLLylSBEDZS5DdCDzqoqMgQ+uYAEk1NIK/LhxxsIUs
	 LDvQqyaq0AKGiLRKAlmG6LOO3+kzP+FbXtMoBNtbETMLYYzfVDcgAZp+ubfCsVUry+4/3
	 oNIRYaDi4JdlkRNyQ+ZtwSHMrs7s56ctRItmKcZrPCXjkAWTZOyJDhkghO2jt9ySAX2OQ
	 NZ3h1bvgPHS/jPYUA4UB6T5Szt0wc5ASjVyVk7c3+EJjTPAjHp1+8MP/NLrO2h8Dvq9pn
	 nphMfemLCaWf3hN1uSmhNo2uh4Ql3e/9hedxBRiiGD0mFxIIYUI1yIV0Zx/36He/uZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780119;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=1zf9DtiDcfPDq5FyebYj0+43UHmIfZzFWjiLt3zTvI4=;
	b=nQb+0N93J/ibk9QIFIRxcUPR7WexDfnNnOieVWJsB+bcASoWx5zE+VL/gLbkKqD7yl+m
	 BA4CGnNnvge8Z3OEB0VLc/i4TzYLMbVJhW/o42fZ1aFS8rqzEqLTQteXRQiO9mLNHgGPD
	 zHcWI1/b3nozTxcsvn0wK28rSxS9Ej/kw9OC90osjbD8olKslB0Y/MmeSUakyAWgUuFoH
	 VLhPEZ/RsX02wm0jdMsvKK4FhGRhbPF/rCCLAErBboYzVe2LWAf6PaBib9txtdnyoeiu3
	 Y4eR2rzCW9TvBcB0v69eOkgd/+EtXcFK/u2xonYbsYGJE+0nhvK762C4gJZF7ASJ6rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yNGX8YxI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dHWSkrl9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cJgxd3Yd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=w6YCGSqQ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DB606A323;
	Sun, 15 Nov 2026 22:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C81DB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yNGX8YxI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dHWSkrl9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cJgxd3Yd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=w6YCGSqQ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 823DA1F453;
	Sun, 15 Nov 2026 22:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zf9DtiDcfPDq5FyebYj0+43UHmIfZzFWjiLt3zTvI4=;
	b=yNGX8YxIAosQlOja9ZU/DwAPoErOoX9tiCZ8akKF166Lm6qYQSMCeAL3R3/sF4TQjX6FLE
	ycbjHmfI2H5imUKG32J0skIjvnlST3pMqc4fujZJvoc+xd1o3qxri9w24OytkYPztxdXa8
	mVpwdedxzbtfSWpy+SUNIgEqEP4lses=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zf9DtiDcfPDq5FyebYj0+43UHmIfZzFWjiLt3zTvI4=;
	b=dHWSkrl9Ab90oUOi+637KJWjEanMbqrLDo3uZW0Gyq6k0uWKl8iO8v4ZcRmM8vAWx36wiG
	v20AB2TvWuegIPCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cJgxd3Yd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w6YCGSqQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zf9DtiDcfPDq5FyebYj0+43UHmIfZzFWjiLt3zTvI4=;
	b=cJgxd3YdqlBzrT0x3saP226VtNmr8Dbf0IuXsJ9QRky7GmCFPKjT/AUigeik0r1vhnYNH2
	ICgRncrTSMVHljQ9jm5u2khxArdWaJ6CMfrTjAjSrnMudJQ5V84BSRo+6RpWMXavkh/iz9
	tdLK99DGjhU5Q4PGrZawd1ea9gBCSVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zf9DtiDcfPDq5FyebYj0+43UHmIfZzFWjiLt3zTvI4=;
	b=w6YCGSqQW59XynwaOG0YgMU9UeloEIJoSsXdzI1jbZzMZoXjJ4gKyf4TsH0cnQjD68KAzM
	nAStPVwSQnbzEOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C67B134F4;
	Sun, 15 Nov 2026 22:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lhSBO9Ar+mr7cQAAD6G6ig
	(envelope-from <clopez@suse.de>); Sun, 15 Nov 2026 22:01:53 +0000
Message-ID: <079c15fb-8b41-472d-b9f2-d88826e27286@suse.de>
Date: Sun, 15 Nov 2026 23:01:52 +0100
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
Subject: Re: [PATCH v3 5/9] mm/mprotect: add MM_CP_PERM_UPGRADE
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
 seanjc@google.com, pbonzini@redhat.com, akpm@linux-foundation.org,
 david@kernel.org, peterx@redhat.com, imbrenda@linux.ibm.com,
 borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-7-clopez@suse.de> <avdw0O4rWi4WrTvy@gremlin>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <avdw0O4rWi4WrTvy@gremlin>
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[21];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 823DA1F453

On 11/13/26 9:37 PM, Lorenzo Stoakes (ARM) wrote:
> On Thu, Nov 12, 2026 at 03:20:34PM +0100, Carlos López wrote:
>> Add a change_protection() flag for changes that only add permissions,
>> so that MMU notifier users can keep their mappings and fault in the new
>> permissions later. mprotect() sets it when the new VMA flags only add
>> read, write or execute permissions, or VM_ACCOUNT, which does not affect
>> the page tables. Any other change, such as a different protection key,
>> is not an upgrade.
> 
> I'm struggling to comprehend what this means.
> 
> 'Add a flag for changes that only add 'permissions' (not defined) so that 'MMU
> notifier users' can keep mappings and 'fault' in 'the new permissions' later.
> 
> The rest of the message just states what the code does but speaks about it as if
> it was already what happened.
> 
> This needs to be completely rewritten...!

I'll rewrite it. By permissions I mean the access granted by the
protection bits in the page table entries.

> [...]
>> +/* Whether this change only upgrades/adds permissions */
>> +#define  MM_CP_PERM_UPGRADE                (1UL << 6)
> 
> What are 'permissions' exactly?

See above

> [...]
>> +static bool vma_flags_is_perm_upgrade(vma_flags_t old_vma_flags,
>> +				      vma_flags_t new_vma_flags)
> 
> No comment, random abbreviation (but just one word). Not ideal.

I'll rename. As David noted, the name I chose is not really correct.

>> +{
>> +	vm_flags_t old = vma_flags_to_legacy(old_vma_flags);
>> +	vm_flags_t new = vma_flags_to_legacy(new_vma_flags);
> 
> This is beyond appalling and a complete abuse of the VMA flags API.
> 
> You seem to have decided that you won't try to learn how the API works, so
> instead you'll just write deprecated code that I have to find time to come and
> fix up later I guess?

Sorry, I'll rewrite the helper with the vma_flags_t API, using
VMA_ACCESS_FLAGS and VMA_ACCOUNT_BIT, and document it.

> And we're at v3...!
> 
>> +	/* VM_ACCOUNT does not affect page tables */
> 
> What does this mean? And why are you referring to a deprecated constant?

I meant that setting VM_ACCOUNT does not affect the protection bits of
an entry, so it should not prevent the new flag from being set.
mprotect() sets VM_ACCOUNT when a private mapping becomes writable,
which is the case I wanted to cover. I'll explain this better.
