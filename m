Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702256;
	b=VaZmFevHw13jpqQhFwNQSpFyIbV6XgIsTG/biicEUtDngMbdearsx5MGMTn8ZE59KfFm
	 1hcr/BIN3vRIoVXRfwOqxdArDRIxM/7xc6+32adN+LYeGj0Bimoem/b1VLoOmwPaFL/aM
	 9MrmrJVp6a8ElrV0ac610qA2QwNGEeIKv72ABaBcVUkZpHpzZyZ2YtuJNywlt06CZh1Mj
	 irCR60HrdoFex+Hy2Evut3Ttmh+ShE54RQDARgfWrE9TC+Y3sQ4xxhDCMUEzm/7ZjWlhj
	 +as5O4uKxxwllpx2Ffo6FYUvAxfoaoeTEwLmqAya75lM4xW9qwfEE8SaJnCielppMng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702256;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6O9fFPnsC2fRnN/QRfMcf6hwkntt/ekyLWGe+pOVc4U=;
	b=d7x6xZAYri8Cv+7qPfQm5muiR4ZyAtaiJvJuFGgaSdshu+jeH6nS2M77hNrh9QdFtexx
	 cFv+8V1tHJR7Xf5kKw3GTOSYrxR8uAS/JktpYZ1ke/Wjz6bWSUPow1bP+ULfllsog92t/
	 8cASLwY+qkd+XJUaHHtx1lv019kwQ/8acsi7Plc9JJ86leNR6vlit0fHRiiS3c18bCoSg
	 npm4ZzzXNEynDo0L63wOawjFAj9154+nJRy3hP4QB+fSIgL+Y6Q08LdiuRMkdL8rHfNYT
	 qzkpWhy23dazALz36B3Hrq2FFAfH+9i3mXEjAaY7gvu1fyNGAxOKf3ajTF6OrQLd41g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2pz3ZCU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BBD606A31C;
	Thu, 26 Nov 2026 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2pz3ZCU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D773A1F01564;
	Thu, 26 Nov 2026 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702255;
	bh=6O9fFPnsC2fRnN/QRfMcf6hwkntt/ekyLWGe+pOVc4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N2pz3ZCU176TcfVQhG2iuo5458/3FyeO0kX903oXUUqvpGySu15X6A3HfU+AA6eEX
	 Iyuu5ZeD+XYBv18n6tsOIpEp93zp+oW+TZJ5dWBH0buqUinIxKYdy8l3CUWtUi4XFX
	 pvBTZZKDkZzVDnGB5RiefR2c+6IyGyAI2gTVRmQRvax7uxgNKTLf+anD7RIAVJAlG+
	 b/al4pBnu6+4vPkZ33ZiV45scsPGvwc5+zgRH+84qQrDGn0aoD0Epzt46iXl1Lr3cf
	 wZHHg+PhqTYEg39ZnAp9rK/bbQl58DGdd+2EzysXttKD5OgpysLYjSVuEoM8A1bMFv
	 69QeNtO35FVEA==
Message-ID: <59ac6564-519e-43f0-9a4a-11600e1d794e@kernel.org>
Date: Thu, 26 Nov 2026 15:10:44 +0100
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
To: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, kvm@vger.kernel.org,
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
 <743f60f7-d611-4d73-a2d1-d5873bcdda36@suse.de>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <743f60f7-d611-4d73-a2d1-d5873bcdda36@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/15/26 22:59, Carlos López wrote:
> On 11/13/26 7:56 PM, David Hildenbrand (Arm) wrote:
>> On 11/12/26 15:20, Carlos López wrote:
>>> change_protection() applies vma->vm_page_prot, which lacks the write bit
>>> for CoW and write-notified mappings. MM_CP_TRY_CHANGE_WRITABLE makes
>>> entries writable again if a write fault would only set the write bit.
>>> In shared mappings, it relies on the dirty bit for this, as a clean
>>> entry might still need a write fault to notify the FS.
>>>
>>> However, this misses clean entries that were already writable. For
>>> example, a uffd-wp unprotect makes shmem PTEs read-only if they were
>>> mapped by a read fault before uffd-wp was registered, so the next write
>>> to each of them faults.
>>
>> See my other reply, adding such optimizations without any motivation why we
>> should even care is not really what we want.
>>
>> Drop it from your series and keep the MM changes to a bare minimum please.
>>
>> Or is there a real dependency for your work?
>>
> 
> Yes there is, but I clearly did not explain it properly.
> 
> The whole point of the series is to avoid zaps when no permission bits
> are removed by a protection change, e.g. mprotect(PROT_READ |
> PROT_WRITE) on a read-only VMA. My proposal is for change_protection()
> to signal this is the case to MMU notifiers with a new flag. However,
> change_protection() sometimes write-protects entries that were writable,
> which makes the flag wrong, so this patch fixes that.
> 
> I'll be sure to explain this properly.

I think there are some weird interactions between things.

I'm swamped with other stuff right now, but once you resend and explain it
better, maybe I can figure out how to do this cleanly.

-- 
Cheers,

David
