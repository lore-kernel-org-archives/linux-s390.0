Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC381643B;
	Sun, 21 Jun 2026 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782074998; cv=none; b=r+LFd2t7km5cueYI9qf+RrhohR2RydnJwQeb8EjnpHeA37e+278yHRcKR9uuouua58zMkT4eUIeabpdFLyu69+hNL1z9T59Z2i0WPkb0bWn0nYDsrLe/0/M/j5Wa6SrOL9a7qdSKOKbSjTKd9BPXBLpNxbHROWF/N1u1et2zvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782074998; c=relaxed/simple;
	bh=7lkfirBnw1Xta7UexC6RyUUzuxWU5/cPK+BGvQuqhIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daCKqZhHSd75U6xAS0BUXEI+XVGZDROaCVkf7MBVGidleTL12URZCY/O4ecrPSOTkhgolZwKNZJyvwhVselwbKQgonQFmW/r0DOtrK6is0VS7abSJMYWSli0Q5K6X9gTH5sGhRGsIFtovh+2RZs8w8uCSNILZ4Evd6VWU7bCikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g6iAM/3x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g6iAM/3x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M8eA5erpVUaElEed48rJS2wGTR5+Yv1nLd38ESSS2Rw=; b=g6iAM/3xDdWgV5X+yh4FkmLv62
	OiHp0rJWKrS0azBEgV4lUi6tf73QIx3b1EfxkJWLE9+0vYHZwchHgBudDH0pHDxxXgTjwrWdu/mct
	Pv33b+2kvV7VjO9v7r9ZJhg42qZrzl0nH7+5lsv84CGZePPxYtNzgtc+jHFw/OqqVr5gfB6dJeyht
	Ta+Y3SqdvDLqXkzUCijftXQvtQR1xKMpDX3P8Pi4bp33DePJ+q2Ae6ol72ij7EXyHBJ2UsHVBJ0x9
	+qUBkAxK1+zVPdKdmOAH0oG08P8SIzHjxBxu4r6NIyihQBFDoDV5qvDZCRzyYtm8IkqtseF10HUAj
	vqUbW0Ug==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbP6X-00000002ysn-1JeK;
	Sun, 21 Jun 2026 20:49:21 +0000
Date: Sun, 21 Jun 2026 21:49:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Barry Song <baohua@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org,
	mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com,
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ajhOUdbWsswgQyl2@casper.infradead.org>
References: <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org>
 <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org>
 <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
 <ahB6QyHgYq8ksj65@lucifer>
 <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
 <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>

On Sat, Jun 20, 2026 at 04:48:57PM -0700, Suren Baghdasaryan wrote:
> Just checking in on the followup plans. IIUC the RFC mentioned will
> try to implement the solution we discussed at LSFMM: splitting
> VM_FAULT_RETRY into two flags - one for retrying under per-VMA locks
> and another one to fallback to mmap_lock.

I continue to hate this idea.  I don't believe that those who were
pushing for it have ever tried to understand the whole fault path.
It's utterly byzantine.

I defy anyone to make sense of this:

        /*
         * NOTE! This will make us return with VM_FAULT_RETRY, but with
         * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
         * is supposed to work. We have way too many special cases..
         */
        if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
                return 0;

        *fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
        if (vmf->flags & FAULT_FLAG_KILLABLE) {
                if (__folio_lock_killable(folio)) {
                        /*
                         * We didn't have the right flags to drop the
                         * fault lock, but all fault_handlers only check
                         * for fatal signals if we return VM_FAULT_RETRY,
                         * so we need to drop the fault lock here and
                         * return 0 if we don't have a fpin.
                         */
                        if (*fpin == NULL)
                                release_fault_lock(vmf);
                        return 0;
                }

Wed need to simplify the fault path, not add additional complexity.
Josef has said he wouldn't've done the lock dropping had we had per-VMA
locks.  We should rip it out.
