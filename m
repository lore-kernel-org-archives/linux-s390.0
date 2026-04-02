Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD42DF3FD;
	Thu,  2 Apr 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135970; cv=none; b=omSRw5Xd3Ir++eApjzC3ui5gWsq7cZiEoDB13lAOVEiqcb4VS2l5hBIYsaoUe59f0Vc+iq2S/7rQRL9Utrr5koiUxegdd8JZFMWF8P9ELVR8mwUqm7bNUj6Nz3sDfRBvNPwFQTWdYqRxY70QyLGQNs4K/pkuktzXQYZSJHAgcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135970; c=relaxed/simple;
	bh=CP9YsJiyp8+E0fCnXGymsdmnpD+1bZ07yNUfO87lEas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCXaSlf1bjJuWRb5fZr4+QQUg86jQPpglmCxWGqUfnpO3AIy8GHEvANYwg9M1Sn0wVp+iUOWYerosdJ20NQYMMQyNd9pNhfURCabl08l2AuCqfsF3t3B6CaKHn3I8ERldzJbQExv5QV2vvccObDnCjYrnK+Pki/KbOKNiNRgTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzJ7fOKs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzJ7fOKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31ED0C19424;
	Thu,  2 Apr 2026 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775135969;
	bh=CP9YsJiyp8+E0fCnXGymsdmnpD+1bZ07yNUfO87lEas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzJ7fOKsWMjrIYw4RJoa1MJ8JdkSBETKO0e3SOHFOipeBkQaHxlJaKax1lNPJAeQM
	 AyQHmkOhxZVOkl6d2nMduakMhWSuDlo9qEM9+GrE4ZxxIEUxLicD6UisMn9EKqxiP9
	 WB8vE2SXYzvePC/wKF6aqhfFUmK0Obdf/6vaD8rj8DGtV6r1S5Z8KNB+wXA9V6Ey3k
	 hoT4E+QVrLAPlVw39NhFwHRy2vT/WfASIQgOWFBVDasGHTeogMRrCF7a7HzWLX036o
	 A+9JEDdDNYvUUqHINUb/XMGlk1O4ax+VM1V28f+QpJ9iKqzfmWmQ+8TDG62A4a7/Vn
	 53EDKad3CxxLQ==
Date: Thu, 2 Apr 2026 14:19:18 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, 
	rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
Message-ID: <495a4331-6575-4eb5-91a5-245ab0ad3637@lucifer.local>
References: <20260327205457.604224-1-surenb@google.com>
 <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local>
 <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
 <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
 <CAJuCfpH2eomYbZ0DzKpkae5DKVF69aRsfXx3HzMfPc6cTT5fTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH2eomYbZ0DzKpkae5DKVF69aRsfXx3HzMfPc6cTT5fTg@mail.gmail.com>

On Tue, Mar 31, 2026 at 01:14:51PM -0700, Suren Baghdasaryan wrote:
> On Tue, Mar 31, 2026 at 11:47 AM Lorenzo Stoakes (Oracle)
> <ljs@kernel.org> wrote:
> >
> > On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> > > On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > > Instead? That is, assuming we really need to care about this at all.
> > > > >
> > > > > But I think I don't like this change at all?
> > > >
> > > > Yeah, this was the part I wasn't sure if it's worth adding. With your
> > > > vote confirming my scepticism I'll go ahead and remove the parts I
> > > > added to avoid extra vma_start_write_killable() call (3 instances in
> > > > all) and will post v7.
> > >
> > > Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advice on
> > > v7.
> > >
> >
> > Ack, if we just drop the problematic bits we might still be fine for 7.1 :)
>
> Let's get your cleanup first and then see where we are. I also hate
> the way I have to report a fake error code, so with that cleanup the
> patchset should be much nicer.

Ack, yeah it's horrid, + _my fault_ :)

I can put something together now perhaps that can potentially be queued up for
7.2 at 7.1-rc1.

Cheers, Lorenzo
