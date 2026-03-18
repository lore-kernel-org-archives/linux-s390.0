Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6E3DC4C7;
	Wed, 18 Mar 2026 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844958; cv=none; b=IMmnywadryJzNBoRBy72YEpuKNh9cPCjGIZCv73hYUelbsKAscUKNAeHLB6zDiHIEVPokpYn65OjhLUJ0W5WC+SV94vwqYskjwZpbIKWdm6hE2/dqelmR8SyQWMpfj+0u5ymS0U7uhUa1RkPsDo4Dd7s3ng3uaLAy4PpIuulvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844958; c=relaxed/simple;
	bh=o3Vqfegoze9voxgxHT8hNS1xVKI7tWzSZbrQEQde8dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WV3SWjLh8hj3fqw6Rog5l3UqmN/Dar+cHyQ32yPajsZl0m9zJ3wNm/bE0SPFqQwIEAH2WZ5R+BpQ9hOLsboLOCm0Mj40nn8q20vXrLsDYO3BW1Of7b1kmZ0/JfMDIPH1h9jgN65QigKQXoiRefFwYDoSRJ7J6Z2UPnaWHRzSDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Brfo6kwq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Brfo6kwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C9AC19421;
	Wed, 18 Mar 2026 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844958;
	bh=o3Vqfegoze9voxgxHT8hNS1xVKI7tWzSZbrQEQde8dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Brfo6kwquW7beM2eQzf+4i3bKNLjG6pitESp5wXj5j3/u4EMe+7TKVtW2kDQi189b
	 ksXjz2HFO5CzN39JGKjLjl5Cz6xte8b16X4vUnfN0qyNtCbUwrFXww9J7LQMWeH4tV
	 XxLcTaXa36dEp3pR9f5ACT1A0MF31tlrAm2w9z71HsxNJA+lhDEy4wTslHSjno+Jr+
	 oUiTxttBYh7Xfz9WqNET76CHoWG5D2z7or5j/VSvQHP6oD/BMerKadPNSlJmAi/h8i
	 4hOfDPVsWi8QZQJI/KS7nt3ccmQBTwTGOCza7YTyeCo9Fsju2QNwapLG0bKt1L3tAC
	 KTJlXh0jWxX4A==
Message-ID: <b706a64f-c142-419d-a151-931847cf8444@kernel.org>
Date: Wed, 18 Mar 2026 15:42:24 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/23] mm/vma: add further vma_flags_t unions
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
References: <cover.1773665966.git.ljs@kernel.org>
 <a37030f2eefc90147e84f9273e325cc289cb9e1d.1773665966.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <a37030f2eefc90147e84f9273e325cc289cb9e1d.1773665966.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 14:07, Lorenzo Stoakes (Oracle) wrote:
> In order to utilise the new vma_flags_t type, we currently place it in
> union with legacy vm_flags fields of type vm_flags_t to make the transition
> smoother.
> 
> Add vma_flags_t union entries for mm->def_flags and vmg->vm_flags -
> mm->def_vma_flags and vmg->vma_flags respectively.
> 
> Once the conversion is complete, these will be replaced with vma_flags_t
> entries alone.
> 
> Also update the VMA tests to reflect the change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

