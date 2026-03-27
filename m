Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77AC3D75C7;
	Fri, 27 Mar 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603531; cv=none; b=YPuw3/Tk9uWoX2l1bLgzDh1QDNLV6cHo13sC2apHSYSnbv3YzpbMbuBFjN9OeKc2cH344sMcpBjgEzj0evLiX59UMlEUI+H1Z1PtXgdkDCRILQGw2uM99ODiThRBaz9k+Pfq2mB/EzBdkkQmNkHTofUvbml3sZH/bnsRUM/5l1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603531; c=relaxed/simple;
	bh=q1ism79nJfn/cEtGypwqofF2VKU2iXSfP9bNn9U8VUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lO7hZtAkR4BaOOGOiasZUx9qjOCy/+Xx6us8ZYRR15WuMWuQiThoCgD19aKreBXLBytAzD0BreU/3WhB2W17cepTRyNSFF709yW7hHnkkoX0lH2mPuOiIaenp2sAA9l0al2gkb7Ad48z7ZdU9gvHJTTYM1PnTSKWArnjgi4Le5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmaF744H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmaF744H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7BEC19423;
	Fri, 27 Mar 2026 09:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774603530;
	bh=q1ism79nJfn/cEtGypwqofF2VKU2iXSfP9bNn9U8VUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmaF744HVRFoUZuE9WelikX7CssORJvCcgjqvHAlHItCZonH1f5u3pjVqPu2pmNwp
	 0sOJELio9ATZHzGY1mVGObw+Tj+ohu4ZlzfgUHHShjnGHOR4dUZH1xacEXI3dnxcCp
	 EPLuQMpDGTQFJ6BT1KDFfyUJZB6B2Qsux4f40zQaPLLMtx14hJ4SV9M9QHDzNZ1Hmg
	 qS/wTO148ZrNsrmGjIVpE0dqOE0Hznelj+tzTWUKV8e/iMqwYv814Ef3aQMBHHZ8F+
	 WqEr18L/sAwg5B4z4KKGy9OErz7dmEjltoJtuBoYAp8fZcOBM+JhLzwbWduY4hEBwv
	 PVr5K0M6Wu7Wg==
Date: Fri, 27 Mar 2026 09:25:21 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, linux-mm@kvack.org, fvdl@google.com, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, kas@kernel.org, 
	baohua@kernel.org, dev.jain@arm.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	Vlastimil Babka <vbabka@kernel.org>, lance.yang@linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
Message-ID: <cf36f821-8285-4b9f-b1fd-e080292f4204@lucifer.local>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <48d7c810-d219-4346-9e8b-d70243445a91@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d7c810-d219-4346-9e8b-d70243445a91@kernel.org>

On Fri, Mar 27, 2026 at 09:51:31AM +0100, David Hildenbrand (Arm) wrote:
> >
> > RFC v2 -> v3: https://lore.kernel.org/all/de0dc7ec-7a8d-4b1a-a419-1d97d2e4d510@linux.dev/
>
> Note that we usually go from RFC to v1.
>
> I'll put this series on my review backlog, but it will take some time
> until I get to it (it won't make the next release either way :) ).

Yeah, please update to v1 from RFC because I'm looking at this and wondering
where v1, v2 was and why I didn't see them...

Generally I'd also advise un-RFC'ing a biiiig series IDEALLY be done early in a
merge window :)

We've pretty much shut the door to new series this cycle, but being so late in
the window at -rc5 would mean no way for this one anyway.

But in general it's going to be a rebase pain this, and I'd rather not see it
land in mm-unstable at this point, because that's supposed to be 'what's in the
next release' and it's stuff like this that leads to 'I am not sure what
mm-unstable represents any more' being a thing.

I think in an ideal world we'd ONLY see this in mm-new.

I wonder if we need some process for un-RFC'ing really, where somebody kinda
asks rather than it being a vibes thing as it is now (or a 'people don't reply
to my RFC' which yes I'm guilty of :)

Anyway this is more general points and not about you Usama, because - hey - all
this stuff is pretty unclear generally.

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
