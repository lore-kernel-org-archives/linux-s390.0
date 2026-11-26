Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702350;
	b=CqRTc5+67UUQpc2WRLGuReKw3ZDLJxl+b1g8zDOhUyKHdWmJoBbeLieGMUje6ZS/W+my
	 7N86oGZGR8HmV909ZBAtf5ITpAmHdkiDRiwtfhSxrN8z/Jw6ULE06Oeh+6Nw4ePqv1lEr
	 FOCL44dswHkc4uJ8MBHm7hJYXMrB4UIpfqWYHM9qBLQOQDdKBSKhzoFh5DosKfEfDzyaB
	 OdJbmcw1uV7SabcvLifK6wO6ePFSfzA6Rz9W1nAaOALKRMLznlpT9qYdHS0olSKBEwkCU
	 eoarOQgSGhccdJtE596u9cQojnhnkT3xes5zcpxUV178Adqcjas3dajphFY72LMiYLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702350;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=i2cNc8HSARC2wOejD22JDbD0mwhfJQiUlrWNB6pO/o4=;
	b=ulEbBod4OZ2k92KJnXNYiCegLD3hhPorpfRP7XNrPkIPR8nUbmJmB9FjFjYohObhV7WG
	 iKpO5hYmaW/8p5/XNIUCCMtx5Sey2DT7ouGbNR4RMM38iGHSVm5EF/X1uz7B3FYinO5Kq
	 Yny3X2Ls+J7Q43zrOX1QFRwxnX0tu/8EKD70UcmJskZmtpqMYerfTfr3Zjg+lVL4Y+K0M
	 i/wqUXNGRMmYU63hFfrPakTaqV16w0YmthgOvANCcDXSCcYgYK7Atena5uWK2KYTueBNx
	 3i8/sO65jEX3OthvhJzTyXJpfPnCRe1Tq4sJwgRWNOko1aW3PX37JlMB0u0k2leIlJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XM/v0L+X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DF606A335;
	Thu, 26 Nov 2026 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XM/v0L+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F20F1F000C4;
	Thu, 26 Nov 2026 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702350;
	bh=i2cNc8HSARC2wOejD22JDbD0mwhfJQiUlrWNB6pO/o4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XM/v0L+X45woIBgANOwNtHPPIUmqXvHJxQ6mG9ukfV9OpVWj+xy+U5/lLU6twpiv8
	 I9moaYBWThXPieB8iVDdrgZRck2TaptOWDWaINkRf87Eq23OBBP4BTZHZiTLQF+6Dl
	 3VoSl6+svsMEeJ2t/4eq+g6pv6fIyAc88iW1KHSuMke+N+vXD7PgYDbZOpIKcCeCBD
	 LeBKC5ixNrN57C6ukG4KDBtar3YC/74xgGg7ZUoS6201lCrDlW5P4oZaRkM5OvGFkt
	 8tKz+wqmdZnUid+GmJ08v/IpaXMQLzrmptGj3dz97OX8yyKN8C9vQpgSwH1Cha7eo+
	 bzApLFZU5wIZA==
Message-ID: <4b60cf7b-bf8f-42dc-979e-71fe6d00c5d1@kernel.org>
Date: Thu, 26 Nov 2026 15:12:21 +0100
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
To: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, kvm@vger.kernel.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-riscv@lists.infradead.org, seanjc@google.com, pbonzini@redhat.com,
 akpm@linux-foundation.org, peterx@redhat.com, ljs@kernel.org,
 imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-7-clopez@suse.de>
 <3314e44d-dbfe-45da-a1b0-8337784a5e86@kernel.org>
 <5412ba3a-ff32-48e8-b5a1-d46b97cf5f8f@suse.de>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <5412ba3a-ff32-48e8-b5a1-d46b97cf5f8f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/15/26 23:03, Carlos López wrote:
> On 11/13/26 7:51 PM, David Hildenbrand (Arm) wrote:
>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>> index 84bcfe0281d3..8c0fcd10f5a3 100644
>>> --- a/mm/mprotect.c
>>> +++ b/mm/mprotect.c
>>> @@ -767,6 +767,17 @@ static const struct mm_walk_ops prot_none_walk_ops = {
>>>  	.walk_lock		= PGWALK_WRLOCK,
>>>  };
>>>  
>>> +static bool vma_flags_is_perm_upgrade(vma_flags_t old_vma_flags,
>>> +				      vma_flags_t new_vma_flags)
>>
>> Two tab indent.
> 
> Will fix
> 
>>> +{
>>> +	vm_flags_t old = vma_flags_to_legacy(old_vma_flags);
>>> +	vm_flags_t new = vma_flags_to_legacy(new_vma_flags);
>>> +	/* VM_ACCOUNT does not affect page tables */
>>> +	vm_flags_t mask = VM_READ | VM_WRITE | VM_EXEC | VM_ACCOUNT;
>>
>> Why is VM_ACCOUNT a permission upgrade? At best it's "no change".
>>
>> What am I missing?
> 
> It isn't, this just means to cover the case where mprotect(PROT_READ |
> PROT_WRITE) on a private read-only VMA sets VM_ACCOUNT as well. Without
> this, the change is not detected as an upgrade.

Why is setting VM_ACCOUNT and upgrade for permissions?!

I'm sorry but this is all way to shaky and confusing.

Take a step back and think how to do all of this cleanly without making this
code here unmaintainable :)

-- 
Cheers,

David
