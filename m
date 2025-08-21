Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD421E0AD;
	Thu, 21 Aug 2025 04:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751893; cv=none; b=Oa5w5wyApBJMP2HlA879GrQ7ZKrCXvfbhHIF00XMi/zwDcRc9VhazT5RoAV9J17kEqYOMfqLCYMNiHRz00Es2Ekvp/f909Gk4IyNne2NrsMhgXyWObmPPQdi9n5SlSxHq3sp+BRwHXpXJqoRBUKYBtnt7mUE6Affu72w/PGfoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751893; c=relaxed/simple;
	bh=vm7QKEaDiXO+rNlJ45FmZQoPoaxlWAsBMFsHstnZQ+Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OQoTF5b9LlfIGaDo++lPCfVRG4dNskuZ6Nr2nSYDJM3xjPAcmKicXRP+ZrAaKqAgUA4Z8E6el4dcvYvGPcX7CHeEZvwFhza781D5Cu/Rh3hQAmBmVlqfsh0+wMggPl0asBI/AAutKr9Q5AKZwKmRPy04BjR9B+mxD7aXxVq54Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oewEGILT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oewEGILT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C37FC4CEED;
	Thu, 21 Aug 2025 04:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755751892;
	bh=vm7QKEaDiXO+rNlJ45FmZQoPoaxlWAsBMFsHstnZQ+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oewEGILT+80jklKi2EOEkEMU2Eo9leBjB3vGXsGZDBSJ3aPnWyhS5JMS4PquNaEq7
	 1c9z2p15r2zyKsGcBAKA5ArNmr1nr2DFaL7v5fSWQzkoNQmCnDBba2l0Ya6sXYaiV8
	 SWgHJcH55rHxyNde2GstGcoQv8+ccKcHXWt/AfOU=
Date: Wed, 20 Aug 2025 21:51:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-mm
 <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
 richard.weiyang@gmail.com, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390
 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v4] mm: fix accounting of memmap pages
Message-Id: <20250820215131.6925be694bf1d904c3f463b7@linux-foundation.org>
In-Reply-To: <687b556e-0196-4a38-986a-2e7b0308e03d@redhat.com>
References: <20250807183545.1424509-1-sumanthk@linux.ibm.com>
	<687b556e-0196-4a38-986a-2e7b0308e03d@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Aug 2025 16:23:52 +0200 David Hildenbrand <david@redhat.com> wrote:

> > @@ -567,6 +564,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> >   				sparse_buffer_fini();
> >   				goto failed;
> >   			}
> > +			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
> > +							   PAGE_SIZE));
> 
> IIRC, we can have partially populated boot sections, where only some 
> subsections actually have a memmap ... so this calculation is possibly 
> wrong in some cases.

The patch (which has cc:stable!) has been in state "stuck" for 12 days
due to "possibly wrong".  Could someone please find a way to get it
unstuck?
