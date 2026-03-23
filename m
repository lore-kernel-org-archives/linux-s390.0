Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3885525F984;
	Mon, 23 Mar 2026 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280867; cv=none; b=tds1sJtUdDULVDOO9Dk8ssd3iVs2tSDwdfNbLXiI/2p2xW1thyBzAw6NFGs0iPJ1MTYY2WCI2ZriVQhE4LYGErmzome8dHp8OuEDuRSFAOF4xN0KaGCtp3G0GsnpjBb2teMvv1dQ1epuF3J5LQDzOhVIu2q10gpuzrQQfxDNAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280867; c=relaxed/simple;
	bh=ykDj0Ppke/lrsvnXc74bDdUkqngFPXP4WoK/RTIL1I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svgwBne/1MbrD9vwpwKcqtI7tUBhuJjMHTJgNNQ0jLhOml/mgZYgmJnTb5nV5UPhI50YeYKXmQ45TMDLmv3Ff2udaPX5h3IKHYtsACMDgkijjZRpLuCDbMsFNjyfBrMB4RMQrGpxz+aW/xRTkwPxy3vM/ctUmnngebpxlznHIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPjnpfdE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPjnpfdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1465C2BC9E;
	Mon, 23 Mar 2026 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774280866;
	bh=ykDj0Ppke/lrsvnXc74bDdUkqngFPXP4WoK/RTIL1I0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KPjnpfdELqJbpC4ncfqddvGU9IIIkup26qddC2aNixhFBIb9mHkF5A7epXJQ3KmSH
	 MuLQQp032z1JuZmOTzDCg5uhT0pMXLmk69mazn1wBoES5rRXYs+2i01B39tCb0fgwm
	 eMVmp2zxvVNKgA6OUptqx23bwS7Xpo/9N86ZlA8ang/MlqIECTmX5MKUewXXQzMnmh
	 QUNRieF4AKOOU9JlQtW5hTno4YlkFFGvDEgeAtLrbiTNsDF5KI83hQ66Af3sBzXk2x
	 2EQzT+rnWcdOU/touJNZDWaVify96eKObV19ON47GNNYH2ceCv+xCHG57JoxHjqvXU
	 vAON7QUwQBDNQ==
Message-ID: <cd30724b-15e3-4642-b19e-c464d0978282@kernel.org>
Date: Mon, 23 Mar 2026 16:47:32 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/25] mm/vma: convert vma_modify_flags[_uffd]() to use
 vma_flags_t
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
References: <cover.1774034900.git.ljs@kernel.org>
 <51afbb2b8c3681003cc7926647e37335d793836e.1774034900.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <51afbb2b8c3681003cc7926647e37335d793836e.1774034900.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 8:38 PM, Lorenzo Stoakes (Oracle) wrote:
> Update the vma_modify_flags() and vma_modify_flags_uffd() functions to
> accept a vma_flags_t parameter rather than a vm_flags_t one, and propagate
> the changes as needed to implement this change.
> 
> Also add vma_flags_reset_once() in replacement of vm_flags_reset_once(). We
> still need to be careful here because we need to avoid tearing, so maintain
> the assumption that the first system word set of flags are the only ones
> that require protection from tearing, and retain this functionality.
> 
> We can copy the remainder of VMA flags above 64 bits normally. But
> hopefully by the time that happens, we will have replaced the logic that
> requires these WRITE_ONCE()'s with something else.
> 
> We also replace instances of vm_flags_reset() with a simple write of VMA
> flags. We are no longer perform a number of checks, most notable of all the
> VMA flags asserts becase:
> 
> 1. We might be operating on a VMA that is not yet added to the tree.
> 
> 2. We might be operating on a VMA that is now detached.
> 
> 3. Really in all but core code, you should be using vma_desc_xxx().
> 
> 4. Other VMA fields are manipulated with no such checks.
> 
> 5. It'd be egregious to have to add variants of flag functions just to
>    account for cases such as the above, especially when we don't do so for
>    other VMA fields. Drivers are the problematic cases and why it was
>    especially important (and also for debug as VMA locks were introduced),
>    the mmap_prepare work is solving this generally.
> 
> Additionally, we can fairly safely assume by this point the soft dirty
> flags are being set correctly, so it's reasonable to drop this also.
> 
> Finally, update the VMA tests to reflect this.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

