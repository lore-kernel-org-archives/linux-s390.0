Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AB33554F;
	Mon, 16 Mar 2026 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678106; cv=none; b=CvyIGqEVHLcQA+YMtY2X9uRGSvDp00it+B1l+Y7xa24Q2NA+F+T95r6m9cpkkAWknHJBluy4IqePkQRPjOb2HVwy3mvpldkLySEIVu80JWfbUN0rfLLeSZfGI3xQSwF8DLdcLh5fxFHZ/K6hTx//zSNDGWD7y8ljCkLpqZshyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678106; c=relaxed/simple;
	bh=T+QCEG7rS4slK+eGQWKuSmiAa6E+o4G10P1NpOZ/x3k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W2sMXQhUAy5zBMUlcsV8Bgdg15N6BEL8suVxAM+ToHC3/Mp+yb6oEuNZ2sfyOdNTHz+KNK1M/75ySCOa6AHcEIL0hS9ePhtFYUjKFZqSGaj7Bu48Upe/7wZo1mxlhZbWLi629afXvPCiM7bRFkdhTmXQJRwsoqAGiVJR6rsTqTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C78b3RIn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C78b3RIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D22C19421;
	Mon, 16 Mar 2026 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773678106;
	bh=T+QCEG7rS4slK+eGQWKuSmiAa6E+o4G10P1NpOZ/x3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C78b3RInQ6E9r2o5eQWhKAKKyMjBu8BuYuFLtQb2c4U384vA029N6GED42iVwexvs
	 Qy02HSzj4wC9NG5ChI3KVHgChg8X9Mmh5uG9/p43xcgZK3sY2KpRjz4FNz2ddxVAic
	 WH+xVUhU8+zr+WxlOE3+Sik0WbkV22WKcpegZwQQ=
Date: Mon, 16 Mar 2026 09:21:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Kees Cook
 <kees@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Vineet
 Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian
 Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh
 Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Michal
 Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 selinux@vger.kernel.org
Subject: Re: [PATCH v2 00/23] mm/vma: convert vm_flags_t to vma_flags_t in
 vma code
Message-Id: <20260316092143.8b21650c803eb99511395b83@linux-foundation.org>
In-Reply-To: <cover.1773665966.git.ljs@kernel.org>
References: <cover.1773665966.git.ljs@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 13:07:49 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:

> This series converts a lot of the existing use of the legacy vm_flags_t
> data type to the new vma_flags_t type which replaces it.

Thanks, added to mm-new.  I suppressed the usual email storm.
