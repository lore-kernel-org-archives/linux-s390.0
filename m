Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541948664C;
	Tue,  1 Sep 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282844; cv=none; b=XU5F8OUHLR+mXg0KpicOiKAEMwY5MsNvf92Ag8ZpybLoUuYQOfS3uUtWBnQc2Hy86PW9nzaidBtovqmo6myxOqh5QgAJG3YPco9qzwGhJBJj/ID3TwklP8Ns7wRphvxai2d+AlruQuDlH1g8gfsXapRdzhucR4rsQcGXQAfF5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282844; c=relaxed/simple;
	bh=f4JLnZ5ow1BPC0oxjbrrnwXBcPTZtqNifoYVSxvFuAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utrpnBEVrLcsmVSGwNsNoLuiHrdQ1SqHvQVMUrQ8jtyOODhwFUkNUANFhTBsLLxrPAZG2b2fh0rNRmkSTY7qqtBqqOsKDlVMHjacxzGTEyJJ1hcjI9HJJ0rx98zYS5aG5nfIx8UTaIMDbn+s9DNUvXUw33swk2PH5FRpTKwpv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1LNqSy3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1LNqSy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539EC1F00A3A;
	Tue,  1 Sep 2026 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282843;
	bh=rxSJ6upXAwrCdlBg+zPXUt0hwX65jWSdNQ6WR7zOubA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n1LNqSy3M8jnxeKfpCGdnV8veBYaIyN1AL8Dm8rx7+HDMcchvBtIc6ZI7LrEQZbAw
	 tfsVPRLKwKicSvsuUmjlp4u2SJICFAhanTFAjQOQ+goGjQ+d/AhBTkQjIIT5iqURp+
	 2yMx57OvB+9ccATwA5IUvYYAlRCCpTjihayw//KnjAxr1M+E07JLckAScbm/yndCnJ
	 chZega13S1pPcu/Mlfl41wdysgLc5ErED7QKcJeBZrWBTtwNqmRJomZZ3MeqROxZy4
	 kGggdFXrK9u0msYFu+HQFIVs+8+7jgnklvaTUhv0MypznFsvLtzq+zUCV2kdBEStXD
	 ZL5MBvlC+i+5A==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 67D9E1980083;
	Tue,  1 Sep 2026 13:13:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 13:13:57 -0400
X-ME-Sender: <xms:xQeXaqV8loEGFnZexkyJCxP3rg-N4QYIToRp3rKjkDTxrnVQL1gS6A>
    <xme:xQeXag4Lh3DDrks_RrbzG2k8C8awQN9zc8XObGUj7pHz_2iNwoMm0pTbNT7CTAPNk
    vp0PQjkhXlbHPIb4iLRJEEruCXo0FxnN_E9iJQQljRa1p3y5LRtH20>
X-ME-Received: <xmr:xQeXaqU1oLe_Okvv0a9Qy1njv_x3ymejuVS52bmcLF3DCgzxB4uHGniaR1M>
X-ME-Proxy-Cause: dmFkZTFsVsS9QxzfNE8Zc/xkNjZIEuir/bwAcyK8hIwM2NebUd4sQatdwIPqNsbpB1XVse
    5uZUzDbqWNwZ48AG7ZVwmjvFiAKn4L3IYAvaFn4DQPDJPouw0ut3ChVPjAmMCRYrpQks/f
    1IjUjSdR6rGJ8PH/8ZN/bq9aaNcIwsIHJ+W10sXj73V3Ek8Vpnv1A6OHP+E9dr0YtgEEKV
    ds5NeYj4TkdU/h2OzTs/e9I3HeHw006SE6KQ22XcXsVtQ5Ridmg+p2UCCPMnSsCFJwXq+o
    NfKF1bGQIi/LvtSee1L5bRM3w76AYvrF/BqhfAU9qLCyleEU1XUiaHShW9MyXHSbVgJaOX
    hMwdwR4eftF02GCubB+SFa7Q4QpoVzw7JM1DRHGNHXFwhmRbAVug7W/IdOcLb/nrDMWef0
    KkUiA7nHVPxKD4AT8RxS/44MjP9xZYwD5jxu4rR1zHMmEvxhsrMZa1SDysOwuA7RUs7KJN
    4ytLSGjlddPPqpyqvZaXgCDNd6mWeyIrBhFBlxdH7EUzrGV3F7qSsiNCyyHYUX1Cb4RUj4
    hSni8vyJoXkGiivg9CkTIGCtDY2O1wlpN5xSB3Yzxu8Cf7vy8qmTAqMxZaY3f8YuCqBoRV
    m1CTaBp39x6fO7SaPEpIs4UyFfLgZpIfwcnGb6I9WUGCyXkqsD4X84Y2L0cQ
X-ME-Proxy: <xmx:xQeXau5SDPm8X9ZPVmC3nkfvnblsrbXXAB3UELP8S46KGzzjm75ZIw>
    <xmx:xQeXapmTRhWrJa2dimFLN6HQHdphUKlZ5N9N_s7BRhRL5RYJv6aymA>
    <xmx:xQeXaoZRRZdtTpR_oYP130ILceFgEOa8W9-fNA_pOWU-V2bjGgKeDQ>
    <xmx:xQeXalF_s7CzAQ-VbOU7soyFklnjyuRKWmz2tNRVxZ-CNHXwYzKvAg>
    <xmx:xQeXatt95GT14XoEAnDFWPH6gQb2fRXK3au_NtwTvG7r-BtoMwwQDwVx>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:13:39 -0400 (EDT)
Date: Tue, 1 Sep 2026 18:13:38 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 	Jason Gunthorpe <jgg@ziepe.ca>,
 Andrew Morton <akpm@linux-foundation.org>,
 	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 	Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, 	Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Guo Ren <guoren@kernel.org>, 	Brian Cain <bcain@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 	Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 	Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 	Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 	Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 	Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>,
 	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>,
 	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>,
 	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, 	Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 	Andreas Larsson <andreas@gaisler.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 	Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 	Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 	Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 	Sven Schnelle <svens@linux.ibm.com>,
 Richard Weinberger <richard@nod.at>,
 	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 	Arnd Bergmann <arnd@arndb.de>,
 Vlastimil Babka <vbabka@kernel.org>, 	Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, 	Michal Hocko <mhocko@suse.com>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, 	linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
 	linux-arm-kernel@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, 	linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 Hugh Dickins <hughd@google.com>, 	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <apcHiE7jDQaFYXOM@thinkstation>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
 <20260901142408.GA56830@ziepe.ca>
 <apbiB51hjm-9pRzf@gremlin>
 <apbuO_QveZNAz3ns@thinkstation>
 <kasi4mkjkt56wxsrmphm5o2qfg2lwsdxf3tlmzx5tq6t7uez74@kozleoavd6r2>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kasi4mkjkt56wxsrmphm5o2qfg2lwsdxf3tlmzx5tq6t7uez74@kozleoavd6r2>

On Tue, Sep 01, 2026 at 11:54:47AM -0400, Liam R. Howlett wrote:
> Do you have munmap() performance dependent workload that you are
> concerned about regressing?

exit(2) path is performance critical for many workloads. Like, if you
need to restart VM.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
