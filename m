Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840810;
	b=u3uIEGfvjCDm0188rq/WThG0cpr3mutEdUE+XTC4pVqaKfQ/1t5waeUvUa092b6jmj4P
	 vW/1xD+O5x9Hd3aMlV39fPHCt4QYSMQyNzxWRSYt851CtFUgif/d2exk0Wx0gCIlk6Nw+
	 7iYw5RfzRUv8V2bH1alOQ6nezTJnLjU0N/bJ/xxff/lGldprigcWLvjQDM5Z73oINV75+
	 XdcwWBpgCDDKw3U2H0FLqpdOC1HNMcmuuDkE5ZImeeewligxQb7IKOJIjRP7O8Urxw4b6
	 nHcDmUuIYKJGI3cdk+UiDtIBSih5FECL9RsBxLZ2M23IyG0NjBC3XO5xBcXshsJBWNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840810;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=OSKH6DGTrkopNq4tA3GSj5EKxZJjQuu22esfVd2A0Tw=;
	b=TQFv3dJacP1k/bvRrKpNxObz1Bkv2wEJEQVSbjAD5W81yPnDgVdVYoRd1EATjQmotS9k
	 v9jbnjHzqOtZLpKklYQbuOH4gOYjKK3VvUolE5I1QffwurS62EKDYevc1eDX69xQPWXEN
	 600ggdphwfWWTf72mXdpGj+pn0BvuOBlJcPBea00zc0C9JgOu4zJs8/8TcWSs12Uhz0w+
	 4KU19f1vWDEJiwv110iLj7BfRQNXdskscRC2HMD47hslxz0Q82T2RxzZP+pWNgUBtAPE1
	 k8SBbLmJhiBvRfdGJCDWwyHGBiaRc/BYnGA+dO+TpFIC7VEE3uVLQRfUrWa6THWZcOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/eyQH3z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D002606A31C;
	Mon, 16 Nov 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/eyQH3z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0281F000C4;
	Mon, 16 Nov 2026 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794840809;
	bh=OSKH6DGTrkopNq4tA3GSj5EKxZJjQuu22esfVd2A0Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B/eyQH3zoFS8eSMcrtMgxdf11YLokLJ0YHyV5wYnj24qRK5FEAFgjIf8GQ3SAtS3m
	 TeOtZMqmunJFTeq81KdGSP7pzcUYmJhggZHXxpT4w/Eo6Yi17USoOfrsMGatoI7t8X
	 nikwVLMgeiQyItJ4QQR6t6Dvxzeeg3sW8vpq7U1eXgwb7ZWNCTqQpAUXd3bsfBDqbk
	 EOoEXitHtOfu8t76WpxEEAF7dy8RSTuisIMNNBXZkopQTvRRfseu+QhDPg7ipNB43h
	 mc+VDH4nZvyAtNzrVB8ZomBs/1h7a+McMNOuO+O3DQ3T4nhtjoI/GlGieCtgYfAo/I
	 B295pKewLrqvw==
Date: Mon, 16 Nov 2026 14:53:22 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, seanjc@google.com, 
	pbonzini@redhat.com, akpm@linux-foundation.org, david@kernel.org, peterx@redhat.com, 
	imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v3 5/9] mm/mprotect: add MM_CP_PERM_UPGRADE
Message-ID: <avsY22UYKI_Z3OUk@gremlin>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-7-clopez@suse.de>
 <avdw0O4rWi4WrTvy@gremlin>
 <079c15fb-8b41-472d-b9f2-d88826e27286@suse.de>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <079c15fb-8b41-472d-b9f2-d88826e27286@suse.de>

On Sun, Nov 15, 2026 at 11:01:52PM +0100, Carlos López wrote:
> On 11/13/26 9:37 PM, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Nov 12, 2026 at 03:20:34PM +0100, Carlos López wrote:
> >> Add a change_protection() flag for changes that only add permissions,
> >> so that MMU notifier users can keep their mappings and fault in the new
> >> permissions later. mprotect() sets it when the new VMA flags only add
> >> read, write or execute permissions, or VM_ACCOUNT, which does not affect
> >> the page tables. Any other change, such as a different protection key,
> >> is not an upgrade.
> >
> > I'm struggling to comprehend what this means.
> >
> > 'Add a flag for changes that only add 'permissions' (not defined) so that 'MMU
> > notifier users' can keep mappings and 'fault' in 'the new permissions' later.
> >
> > The rest of the message just states what the code does but speaks about it as if
> > it was already what happened.
> >
> > This needs to be completely rewritten...!
>
> I'll rewrite it. By permissions I mean the access granted by the
> protection bits in the page table entries.
>
> > [...]
> >> +/* Whether this change only upgrades/adds permissions */
> >> +#define  MM_CP_PERM_UPGRADE                (1UL << 6)
> >
> > What are 'permissions' exactly?
>
> See above
>
> > [...]
> >> +static bool vma_flags_is_perm_upgrade(vma_flags_t old_vma_flags,
> >> +				      vma_flags_t new_vma_flags)
> >
> > No comment, random abbreviation (but just one word). Not ideal.
>
> I'll rename. As David noted, the name I chose is not really correct.
>
> >> +{
> >> +	vm_flags_t old = vma_flags_to_legacy(old_vma_flags);
> >> +	vm_flags_t new = vma_flags_to_legacy(new_vma_flags);
> >
> > This is beyond appalling and a complete abuse of the VMA flags API.
> >
> > You seem to have decided that you won't try to learn how the API works, so
> > instead you'll just write deprecated code that I have to find time to come and
> > fix up later I guess?
>
> Sorry, I'll rewrite the helper with the vma_flags_t API, using
> VMA_ACCESS_FLAGS and VMA_ACCOUNT_BIT, and document it.
>
> > And we're at v3...!
> >
> >> +	/* VM_ACCOUNT does not affect page tables */
> >
> > What does this mean? And why are you referring to a deprecated constant?
>
> I meant that setting VM_ACCOUNT does not affect the protection bits of
> an entry, so it should not prevent the new flag from being set.
> mprotect() sets VM_ACCOUNT when a private mapping becomes writable,
> which is the case I wanted to cover. I'll explain this better.

Thanks for all! :)

--
Cheers, Lorenzo
