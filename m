Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F226159E;
	Mon, 23 Mar 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281115; cv=none; b=c0kZmJghE9fLDBxGytJmtgEa0/ib/u0xVnWWVQM/DfKQ6gbzlltedODadFpdiu3MrEb4004D+ljeozhA8QeXU9vxQevYavSDSAkKDicX0B3MNzMKOegfLSb/zhwu8uQh3FZPj8ONOp5ME3ArW/pUaL+4wvN8O5kLzz+4uIpCc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281115; c=relaxed/simple;
	bh=vZdm4GONA/O1jK4+M6185Q0giqh3AS1i2sFB5Pfd/2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WC/Su5DSfbmKx/hjjLx/LWUbWOrLtkC+iAtlSS3Ov8uRSbFx+FSuKN5K9Y7423IO//a3uq1zVVBsKflkqLnS2RxcBs+9CJeJYk9SLvxeYLMbT8sPvlYBC/w0ZotbH2yLYJvHqZxWSXc+2/FG2D737L1EOieH3Ivfyp0uqVdkFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1THjGW8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1THjGW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA5BC4CEF7;
	Mon, 23 Mar 2026 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774281115;
	bh=vZdm4GONA/O1jK4+M6185Q0giqh3AS1i2sFB5Pfd/2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1THjGW87BBZn2ZRvUB/ZbG6Bpk46OGuXu9+rNxgEX1JPplRd0PmhhIVaepJQX2x+
	 tNfnZZ2oJ/LEW/V1kb+Kd4rSlee9+4uD+RKeGWfnc/xNRMj7aASQw2bbJQ+4aFpnT4
	 D5oU71wAa1icX022onJ8SXq1egN+wMrKLzs0GkJXDMxvnSocAjVWuUsitbcyyxaQfV
	 JJXP9c4lBWKh9RLPX/Xy30cKFsVybbnBnhAp26jeybHA0vntxV0OkXb/w0rzQv6/lE
	 VQ33MGCeDpT2FONGoMZBv7aFNGtJEznzEExGGKYXFQSBLYixZR0A4kZUSTFL4AAduW
	 zfBJEYhpa4mqQ==
Message-ID: <47f796ed-ac66-4a75-98c9-64afc8929f35@kernel.org>
Date: Mon, 23 Mar 2026 16:51:41 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/25] mm: simplify VMA flag tests of excluded flags
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
 <d395c5dd837a9864f5efcec42175910afbe3ce73.1774034900.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <d395c5dd837a9864f5efcec42175910afbe3ce73.1774034900.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 8:38 PM, Lorenzo Stoakes (Oracle) wrote:
> We have implemented flag mask comparisons of the form:
> 
> if ((vm_flags & (VM_FOO|VM_BAR|VM_BAZ) == VM_FOO) { ... }
> 
> Like-for-like in the code using a bitwise-and mask via vma_flags_and() and
> using vma_flags_same() to ensure the final result equals only the required
> flag value.
> 
> This is fine but confusing, make things clearer by instead explicitly
> excluding undesired flags and including the desired one via tests of the
> form:
> 
> 	if (vma_flags_test(&flags, VMA_FOO_BIT) &&
> 	    !vma_flags_test_any(&flags, VMA_BAR_BIT, VMA_BAZ_BIT)) { ... }
> 
> Which makes it easier to understand what is going on.
> 
> No functional change intended.
> 
> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

