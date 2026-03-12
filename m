Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE03CEBB5;
	Thu, 12 Mar 2026 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343840; cv=none; b=kOyZILzWYNrtCfa7QP7nVhiCcsT0Be/AjcUwpRrgw1y5qBfL1YnQiyuzk7QVGpEJJnxD6g7leKeZpwOw782kCcHhNSj7mUvNt7PS8I/pjKQ/N7P0bOd07guMpO9jQVPXQ8deQ7VOR1gnGrVM6/UkfGaQrASrg3MsW6AyMTZt8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343840; c=relaxed/simple;
	bh=dppx5bZj4+zeqj0N8m+gDYvEY1V3ochaIFGxa6FTN9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QotUXfUyZ+PGJUkYzES5mbmljYxpU4ySO4GbhDYlEFM/Wl93nCznH0sFUWZ4Pz3ScyuwlqhoShThayHJLEJAiK6t1JJLsfvmZmUysyRUOnCajri3NoCDnoPG2gR/lVK1YVNJy6fO3JrUxVkhpStm6JFDtAVgOhfJz2mBIHmSmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpZymGjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpZymGjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7617AC4CEF7;
	Thu, 12 Mar 2026 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773343839;
	bh=dppx5bZj4+zeqj0N8m+gDYvEY1V3ochaIFGxa6FTN9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpZymGjSfeezPsAxTR8is/y91vPi0xEPN0K7IFHZz77hM83w5Vj26pRQa3IjU+zwy
	 tbXTe0vQVq6U2m+k9m9HlIImXQzU1M/vS/yGyO63HG8DiJ/vWb+uh3H//T9IyA4hRD
	 LHmNXH5dbPF1f5a6PD6COunVyQVhVzAFmLKrarzr4fRbA4mQYsRv3xiTnLsrX7/jL3
	 WHpFX+yadIsp2XaB8uyt+zH82bPt5Vn2z3z5NgdxkOECEMl6n7PpL7zmNASsxMRVme
	 OdW87Byykc4nbucZ93idCIAIBC9mWbsdzDxSrxwiqiZl0Wrvakg+Vhl50YtatzUzD4
	 wIPQgYElJZvAQ==
Date: Thu, 12 Mar 2026 19:30:38 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Kees Cook <kees@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 02/20] tools/testing/vma: add unit tests for
 vma_flags_[empty, diff_pair, and]()
Message-ID: <9198d18c-a1a9-4321-bf34-13e48172eab4@lucifer.local>
References: <cover.1773340636.git.ljs@kernel.org>
 <87517d01b3973aa43f874164d0741d02cb123537.1773340636.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87517d01b3973aa43f874164d0741d02cb123537.1773340636.git.ljs@kernel.org>

(Please ignore this patch, it was sent by mistake, the correct 2/20 is [0])

[0]:https://lore.kernel.org/linux-mm/ae25ef9cd48e20553babaad3868da1cf74f16af1.1773342102.git.ljs@kernel.org/
