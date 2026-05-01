Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA6214A9B;
	Fri,  1 May 2026 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664373; cv=none; b=eTIthslF2fRBDNaxu4D4FWihbt7eDM3yD4OMbEd8BQ51RTm8siTawlMC+gfXVQT/e134PToa5IYikRI9M4wtVyctT6M7/LzSssCUQMBncstF2MkmSDWCZT51YTXdJvwhVtJC7hLNz0gPXcOxL2PtTWB8/WEFWS6nJwZo+Iu6Ino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664373; c=relaxed/simple;
	bh=w1+UajOyjTTGaFHm76vcGt07GcQBpJdXIpMH/yU8BUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYAjKUHZd/kVRZ1Q9ItKGLTu3ID1ujTghw9hI+v/pdlXI7tisZdZlDNZk+A+rtQ2pA8OJb187U5wi0am6ux5C++Ylj3reGbXy/KFNcDcDc3IClyLf3h879Ognr9yo/vVbBYu5ovlXcOFQ915hsHQuyWxS6TEUtU9WtHVt7ohtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uHjHrPPD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uHjHrPPD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rp8f/WeQia8QAD+YJmPABxXPXrvHyOM5hZfBchCKMDA=; b=uHjHrPPD2LeDk5mLziBh3YyqEj
	pfhR1tJpiKuUsooCkGqL2JZsb+D6vXBCRLBIbK0Q44xOCZOqwgtOj5wLR1q5KX9Q3NvcP0rciSd+G
	ckgC0Zlz14TMgm+JsN7ZyOCt1Uvx4cReuGP0X3rwHMIqy2VNYPteQIn4/oeQedWAMeFvYDZOK+5J9
	gMu8Q18KidiWTxvlLNVjdpduJUbW8ext7a3iuodZcXYJM4buozO5xWvugDSnEUtY1AeZRzE+j32qI
	9Rxm90eK24xcN0FvxD+xBCl3zDGmbqcxwWSaplpXlbRREhdZ7Fj4povFbiHlxELsrOySKt4514WFP
	5emRWH6A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIthf-00000009F6Q-0jSu;
	Fri, 01 May 2026 19:39:11 +0000
Date: Fri, 1 May 2026 20:39:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz,
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn,
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com,
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afUBXnPVnt7Jt5hh@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>

On Sat, May 02, 2026 at 02:25:37AM +0800, Barry Song wrote:
> On Sat, May 2, 2026 at 1:58 AM Matthew Wilcox <willy@infradead.org> wrote:
> > Yes, but that still fails to answer "does this actually happen".  How much
> > performance is all this complexity in the page fault handler buying us?
> > If you don't answer this question, I'm just going to go in and rip it
> > all out.
> 
> I’m getting quite confused. In patch 4/5, you suggest a more
> restrictive condition using
> if (folio_test_uptodate(folio) && !folio_test_writeback(folio))
> rather than if (folio_test_uptodate(folio)), before we decide to skip
> retrying the page fault [1].
> That seems to suggest we should be more cautious about when we can skip
> retrying the page fault.
> 
> However, in the cover letter, you suggest removing all retry code entirely.
> Does this suggestion apply only to file-backed page faults?

I'm making sure that if Andrew decides to override me he at least sees
that there are other problems with this patchset beyond "I don't like
the additional complexity".

And maybe we decide to do the fallback for anon-mm but not file memory.
Or maybe it's just something somebody happens upon when reading the
mailing list (or more likely it's just grist for an AI).
