Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190953ADB94;
	Wed, 23 Sep 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193678; cv=none; b=Ut5gNZUabxMRB2w8HXhq4DKvybVSm65NM84MLtcgQy3IscnDTIaa1B2HGHx3IbmnA5+VD7/VqHZE+Szj/nYPl5FUrOrC8jwLzu97Xxv9TSzGleiCHophzpxp81hXNN0WB1mNejaa7QbJk2VI8PpxBTas0HD2OkRiQcpC9K/l8Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193678; c=relaxed/simple;
	bh=EoAm9eQnkEX/Su8Tb54A8ZssNa84fNPugYrGvhxvhGs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PIgw6HoSqBahVwt9IRIAGNNfcJSquxWhPqqBcSTvYpvezso3UvwIEKSm8S3nDwXLe1r4bEYP0sEzqdiwrAjj1+s2z9DN/ms6whv7byrJ1nkJm/MPPJlKqnZ/Ouu77rWFmjtKOfg0YfLpj/H+S6kt1CTjjCXUDU1zrdqZ8aZjICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yukRbG0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yukRbG0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976111F000FF;
	Wed, 23 Sep 2026 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790193668;
	bh=pvDDKbJOCHVNMBf6MfRG+XPEG43cFbYIZQUAS2hlVUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=yukRbG0qkn30dWVsqij/SU5fM7nkPcs9gLdvOBDFKy6hSl5ItrFuR2BYdapipYrFp
	 /ULALkETS2Hzxxifit/ssnY1WioE70raLvLXq6WSexLRbbzTwV3qRYdtF+xb4eB5wp
	 1Lu+3tjEqSY8F42OSvK9noPy1qtRRMWcgWlWM4o4=
Date: Wed, 23 Sep 2026 13:01:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren
 <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster
 <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne
 <shorne@gmail.com>, Rich Felker <dalias@libc.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>,
 Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris
 Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge
 Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Shakeel
 Butt <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Randy
 Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, Hugh Dickins
 <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 00/12] mm: make userland page table freeing RCU-safe
Message-Id: <20260923130105.522942080238d133a36afc91@linux-foundation.org>
In-Reply-To: <arN3iaw7VDIA-bWf@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
	<20260922160021.a2fc65d05d9b867a141e5457@linux-foundation.org>
	<arN3iaw7VDIA-bWf@gremlin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 08:04:25 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Err, Kiryl reviewed the entire series, I sent it in -rc1 of this cycle, and
> it's been in -next forever?

I'd failed to notice that v3 of this series was in mm.git, oops. 
Thanks for cluebatting.

