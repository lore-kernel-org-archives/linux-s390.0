Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C582517AF;
	Tue, 23 Dec 2025 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453453; cv=none; b=kGAyk+0tVHNQRv7PCX3W+IWLAk8N3pXjOLRAMkX1EOtUhucSivgWlhIaQA46J+UWzm9NHK/mf5KAiM2IlmXWLpvo6h7RLh2ObhzrYuzKW0cEQq7FCmmBnvXBhx2CK6YkfpVz4VvW58svZOPsYYUq8b6n04xYcdAVPeHnQ8l5hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453453; c=relaxed/simple;
	bh=j7q2987NriSlS+UGsGEBmtZisdMET3w6wHahvWlFCXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utN5a/1MTmdrs5NnXPNBYPQAfeqJ2Z357dCoz5IYuF2OjJV+WbA5fAyoP+Hb99VNR0QeW3uVPkkk5lk0IgKBZsajKIHvc217DvgyiqHGsQGy2A5Tl9Mwig5otbH1i81r6jNdHwJPhiRlCLWC05qfSmN8r/86qd39PQ8sQpTiZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO5p1eAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO5p1eAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613A2C4CEF1;
	Tue, 23 Dec 2025 01:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766453452;
	bh=j7q2987NriSlS+UGsGEBmtZisdMET3w6wHahvWlFCXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dO5p1eAeCiTmrLjfR2upqrJjMfmN+fqYqX5pLP/UpyRrXF2AUHgEYFwEMyD3r1obi
	 pEDjXWgKmiqndnrwphcQ1xmocdXiVenBgaQpH8OhamNZ4Iq/5MM1cZj8puJ14LI3RY
	 LIv+2+3bD4SBxu39wqhdoZkP8nz/qNyqFeQe02gX9CRGPAcZc59Hrq2vgSPjMPIkYw
	 UaOU0CNfN/e1qXIcM9EXSCPrhHOvAC89afJ/neG7VaxyRjcLSVrHRanYLjzuXOsJWy
	 l8K/ZNSDlGs6d4U/rrmNlDoBWYqa9kWYB4qLSlkOXTaf4oEIb8M8vGOL0VKP76nvWM
	 AiNxz4lmAEbWw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages are unsupported
Date: Mon, 22 Dec 2025 17:30:44 -0800
Message-ID: <20251223013045.4579-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251221104907.032abf56c67f3e50c9c94e31@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Dec 2025 10:49:07 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 21 Dec 2025 10:22:44 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
> 
> > > 
> > > My main concern was -
> > > A fixes tag means it might get auto backported to stable kernels too,
> > 
> > Not in the MM world -- IIRC. I think there is the agreement, that we 
> > decide what should go into stable and what not.
> > 
> > Andrew can correct me if my memory is wrong.
> 
> Yes, -stable maintainers have been asked to only backport patches where
> the MM developers asked for that, with cc:stable.  There may be
> slipups, but as far as I know this is working.
> 
> I don't actually know how they determine which patches need this
> special treatment.  Pathname?  Signed-off-by:akpm?

I guess it is pathname, based on ignore_list file [1] of stable-queue repo.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list#n16


Thanks,
SJ

[...]
