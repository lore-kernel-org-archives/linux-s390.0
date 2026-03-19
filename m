Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558952BFC7B;
	Thu, 19 Mar 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941494; cv=none; b=HHLtbLRTLRgOX4QlUVvM4Djzi5re/jmwrRMOfxxyPJUSMMcfIBE9sErZhpkGb4f0Tq19pKUTciVkekB6wmBZ9VDmxo9CgGK3mnYGiwYn9AIUaBXRx5sk8JoCA+eUXWWj6RGgTblXodBpabS0sVtspRJ9ki+Hi0PpVekrJrRExsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941494; c=relaxed/simple;
	bh=5DppXj3QcNzrGmdgZID5IYobrhntHlZzGlg5qMCJioE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im+S8zdARqsyKwZdRBHV+QBDZ60PJXbeON0gWC6nc8tAsayY0iJfVVWfypWzdR7nUASSpi0+z/IrvVBmi5pJhJ8OecGqA9fHN8FCRmtm109IH1imXF3a8LavwVdLxm/bcmobdPbJGOLgyYzQTkXbu5qyrerCIMu4WqJns3B+gVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO7vfJuT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO7vfJuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13691C19424;
	Thu, 19 Mar 2026 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941493;
	bh=5DppXj3QcNzrGmdgZID5IYobrhntHlZzGlg5qMCJioE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SO7vfJuT4xUudvKFdjyC/XRHnDWKzUW5zhPZGOW4NkcLJWB/0zaBAPUZDEbzNniLu
	 o6gtnAQILi1Xg5RGSgTnobL7eO04ZT32Gx2h3qfXV8nubgacMQGFufOtrVHdeNmWgM
	 pZkRzoFA3bJPOKRw3mhQGFNORsomWmRnmNuVBbUaFpZmVyH6WM0IdprCTCpaX8+qFC
	 9GF8H3rbnnwghtEQQ9Ex+hdnihLJcH+Gq6I/Fk+KprdszHQSk8Tg0pLI8axTqiBT2S
	 atwtkQeokLlmSyD0VHX0bighzaB+U0P3innYYSr/zVKdE8T5gI4Lh0EcWg4r+v5cRx
	 N/zcFeNPSI1JQ==
Message-ID: <12bb9812-d7c4-44da-aa57-689ad520cb17@kernel.org>
Date: Thu, 19 Mar 2026 18:31:20 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/23] mm/vma: introduce vma_flags_same[_mask/_pair]()
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
 <028d03f1b980b7f65fcc556db2e97224c06af1a6.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <028d03f1b980b7f65fcc556db2e97224c06af1a6.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> Add helpers to determine if two sets of VMA flags are precisely the same,
> that is - that every flag set one is set in another, and neither contain
> any flags not set in the other.
> 
> We also introduce vma_flags_same_pair() for cases where we want to compare
> two sets of VMA flags which are both non-const values.
> 
> Also update the VMA tests to reflect the change, we already implicitly
> test that this functions correctly having used it for testing purposes
> previously.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


