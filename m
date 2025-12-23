Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01F2E65D;
	Tue, 23 Dec 2025 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457056; cv=none; b=m2mNCxZJ007BbxJ4f2sTKEFCfQMyeD9IXvvJrQqZrsZrHWy08VGzkC46YU9Kds2z9Zwidh7oAbZRC12/MY3CUk5vWk7Ka+RbNPhSd7+xhR317jhI2ee6gk7+V7DQ6LTyt1OqQwTu/KPxw+Yls1r/Q8uRyG+6tMNNwwR58g1YEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457056; c=relaxed/simple;
	bh=EGu5F46cvREoMWotC8TtqKlUedKHHiCD44Ca991/ZQg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H99WZG2Pg+vBzdjVPNarsYIZYeWJVzkByqZX5EErBRm0xZmVlPyEJs22nb0pldSaVOh060moVxljm5DoHrX6Fwnxu8W+EFnIGQizPFOh/qWTrZQzvBUW1QECQTn+b7o3YLzXB4dqF/Hr7gaUDATd3esyy5wQCvCgGx36Fe2rXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1QL8f41R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1QL8f41R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23ABC4CEF1;
	Tue, 23 Dec 2025 02:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766457056;
	bh=EGu5F46cvREoMWotC8TtqKlUedKHHiCD44Ca991/ZQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1QL8f41Rcexjp5HR46WOg9kxNLNocZNvvEbYU/Auokx8zqa8xA3O5RiDLBnxGF9E4
	 y/C4Lqpm2r02rxa6co5a+BWXUIOB+8WAgimhq2VUTMXekY8F7nwfHvPj/swOESZT8s
	 NHNWrvdZfY2vDa1FW8ZegBx08PWoBohUIHQY3dNI=
Date: Mon, 22 Dec 2025 18:30:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Borislav
 Petkov <bp@alien8.de>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik
 <gor@linux.ibm.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Sasha Levin
 <sashal@kernel.org>
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
Message-Id: <20251222183055.88c3cc1f0705c1dc29c7f011@linux-foundation.org>
In-Reply-To: <20251223013045.4579-1-sj@kernel.org>
References: <20251221104907.032abf56c67f3e50c9c94e31@linux-foundation.org>
	<20251223013045.4579-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 17:30:44 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Sun, 21 Dec 2025 10:49:07 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Sun, 21 Dec 2025 10:22:44 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
> > 
> > > > 
> > > > My main concern was -
> > > > A fixes tag means it might get auto backported to stable kernels too,
> > > 
> > > Not in the MM world -- IIRC. I think there is the agreement, that we 
> > > decide what should go into stable and what not.
> > > 
> > > Andrew can correct me if my memory is wrong.
> > 
> > Yes, -stable maintainers have been asked to only backport patches where
> > the MM developers asked for that, with cc:stable.  There may be
> > slipups, but as far as I know this is working.
> > 
> > I don't actually know how they determine which patches need this
> > special treatment.  Pathname?  Signed-off-by:akpm?
> 
> I guess it is pathname, based on ignore_list file [1] of stable-queue repo.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list#n16
> 

Oh, that's a bit sad.

- other trees sometimes mess with mm/ and they probably aren't aware
  that they need an explicit cc:stable.

- misses drivers/block/zram and probably various other things that
  the MM team maintains.

Oh well, I guess simple mm/* coverage is good enough.  But I do worry a
little that useful fixes coming into mm/ via other trees without
cc:stable will get missed.

