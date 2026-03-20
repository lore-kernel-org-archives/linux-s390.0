Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41461372B4D;
	Fri, 20 Mar 2026 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997169; cv=none; b=XUUzUjyHQCBhICuDhertsp5JK4EluiZ4Np2uTUHcsfNUxlhUtMCO2a+I6eSWe5HmunLDK2Nc97BqFrD49CwbSm8FleL2c4x5xgKyOldAKvVVFB17P1yuMW3kC9w5WfK3zf+OG+EU0M6UUzmpa/1kJqVvBMFSJ49QXqPq88hRaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997169; c=relaxed/simple;
	bh=gZ7mo8VD+NAhXZQb0GYWny9AT9mHJxVOkGXSXRSlXkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6ZIkh7nwpqF8VVKkDI6lFDA1xEDn4yv3VtuIK5FFhRh5xL2C4TdSTHKRs/169d0y/FAXOy2shvNaBIhi5lBvqgcGKY1Eb6lacA0J8cT5tCyUsGcgSU9IWJzaXLGlkseix+GHxkELxS9XFhbqb3RQJhuLHwCPctHZBfuiDemWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vnv5g+fa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vnv5g+fa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99035C4CEF7;
	Fri, 20 Mar 2026 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773997168;
	bh=gZ7mo8VD+NAhXZQb0GYWny9AT9mHJxVOkGXSXRSlXkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vnv5g+fajJemAepqRKZRz47c22+umNsA8K+bcibnuhBXHBu1d5YmKqWsG7qOfUFHJ
	 CztV2PyO5tXV2ndgWUvx38ZhYgi/lqkSfU/R+xvcHnxYaqLoT/e6BRXTA0NdY6badP
	 onDLOW/x64CNFEUrBONrSFSXSn2B8FQntJuy/TT5vt3gBjuLsep153gxDZT/dirYhC
	 CVXFpifY9igf7fwFZwHhAhTf6uDN0JdiB+PEafeRbGrcMqNb+21IkikxadesfcAOxw
	 W1QaWfzU+BhIh3qR/LFIA31TyjFUkVqrJLl/fZ5m//RUqAkbCbCMSFvmboEAlRrHUw
	 pulfK6egziujA==
Message-ID: <c45932ed-844c-48ab-9481-9973bd0193c3@kernel.org>
Date: Fri, 20 Mar 2026 09:59:15 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/23] mm: introduce vma_flags_count() and
 vma[_flags]_test_single_mask()
Content-Language: en-US
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
References: <cover.1773846935.git.ljs@kernel.org>
 <02a6b26542ab70d60175e0125cff5fd00073c7ae.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <02a6b26542ab70d60175e0125cff5fd00073c7ae.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> vma_flags_count() determines how many bits are set in VMA flags, using
> bitmap_weight().
> 
> vma_flags_test_single_mask() determines if a vma_flags_t set of flags
> contains a single flag specified as another vma_flags_t value, or if the
> sought flag mask is empty, it is defined to return false.
> 
> This is useful when we want to declare a VMA flag as optionally a single
> flag in a mask or empty depending on kernel configuration.
> 
> This allows us to have VM_NONE-like semantics when checking whether the
> flag is set.
> 
> In a subsequent patch, we introduce the use of VMA_DROPPABLE of type
> vma_flags_t using precisely these semantics.
> 
> It would be actively confusing to use vma_flags_test_any_single_mask() for
> this (and vma_flags_test_all_mask() is not correct to use here, as it
> trivially returns true when tested against an empty vma flags mask).
> 
> We introduce vma_flags_count() to be able to assert that the compared flag
> mask is singular or empty, checked when CONFIG_DEBUG_VM is enabled.
> 
> Also update the VMA tests as part of this change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

