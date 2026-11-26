Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706703;
	b=t9WQsAupclit2xAgDvvAjwfdWKKaGiKsqlwt7xdEyp6l7l2Wl+QBpXsPS0n0GjwAlLxc
	 ovx6B/7Kz/EYSPt9i2t1MLoZMUl8gdX3H4F3iKccYeZa1g91Jd/5yL1V2oDMidmu6jNRI
	 Jv4kNoFBhLDdyJLXG/oKn7hOV2Gjoh3UKkAnL7F7txwBGyZ9LlCtOGUNIYuGMWeg1pJsa
	 9IhCpBZuFomKmVWxWze5awunoAB4OxjMKs9evktiXR0IAPj6dcN9jCI1TwKWio51b7ZC4
	 tmme3rXkGtQmxQgTMTiXW2rwai5to14WaVT176XGGp8VSgiip9Stu728E2ycWmf4dzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706703;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WaGhGP18N1e5WQjSL7Kf13XBuOe/Lyl+VKElqyiI+RE=;
	b=On55IKP6ljkCjV5uLf3DvFa20vOfnVK8D3ZcsFhjb+l3Yyua88bZPZGPZo9FI2+R3/TU
	 S2oTN9bXLA8kpu+1jbjFTFUrikxu7uZMAoc80EpspIUr23pGdGj1s5iuHvGWRl0B9CvPH
	 pTVVdn43pyeny/Q0J9vkbsqDRuGiuz/argLNBF/TJT7ygor1m1JCdFP8fkoLLO1IfwAgi
	 RoA5639wVq51ewUtYcRPeu+3Q8t7hzUy0ZrFN9oDT+JEnJ1axQ8H1GmosIk+5GG2yu4b4
	 3T+hZLI4HV6OF0rRo1QWJOuiDhHUzoGkYHt055N/Mh1/oYSgLzo4pO556ytWcW9vwWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dVVGBgUe;
	arc=none smtp.remote-ip=95.215.58.222
Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9C606A32C
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 15:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B9C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dVVGBgUe
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e8n4p5I4AJEqksbOANyj0Uvx8iI2baqGaT4jyvFlF3s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795706700; v=1; x=1796311500;
 b=dVVGBgUe9owodYdGtln7dPUN0WIk3zQGtK7GCZTw6lfdipbYqFHMw0LFhVZI8JKiHj+WsVSd
 rbidA0agbBLiw9bFTKrdjACzbkA/wZ3FPqDUSunPEUSfUSar+tGgjt4oTqTDIZE0KadgDSWuLpd
 BbL4GL+aNZDp2IMQHMncHFDg=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e28c61dcd929e842;
	Thu, 26 Nov 2026 15:24:58 +0000
X-Mizu-Trace-ID: e28c61dcd929e842
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 07:24:42 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Harry Yoo (Meta)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, "Liam R. Howlett" <liam@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Amir Goldstein <amir73il@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Eric Dumazet <edumazet@kernel.org>, maple-tree@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, iommu@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-um@lists.infradead.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH slab/for-next v2 00/14] mm/slab: mandate SLAB_MAY_ACCOUNT
 for __GFP_ACCOUNT allocations to avoid wasting memory for slab metadata
Message-ID: <20261126152250.GB738059@shakeel.butt@linux.dev>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>

On Wed, Nov 25, 2026 at 09:37:01PM +0000, Harry Yoo (Meta) wrote:
> TL;DR
> -----
> 
> The purpose of this series is to convert existing slab users that
> specify __GFP_ACCOUNT on allocations to specify SLAB_MAY_ACCOUNT on
> cache creation, to reduce memory waste for slab metadata with
> CONFIG_MEMCG=y && CONFIG_MEM_ALLOC_PROFILING=y.
> 
[...]
> 
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

For the series:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

