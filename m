Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0042123E;
	Thu,  3 Sep 2026 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422694; cv=none; b=R7Kkwqjv+VEFt/EhDhPSkQsD77ZH4KblNwhOQ0p60wa8P5KNjvnw2lWhGELitZt3BKyXUPjcTtZq1TYCtVWET9lLg57l1JFPSJPlHrMFR9ZSKjv7gujp7jgPk3BMHxHsZ+tUY3NAHUHn8c/ZIHqqGD7ZzRuGnPUye8xBJVlGT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422694; c=relaxed/simple;
	bh=Z5gJYyJmuSii3lB5CDz06hrw+0Qhyjq4c09Wuu/Q2Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qajQEBma8c+aTmrbDCWFyH9iYmHevmIQtt1pbRASn3jKAzTUadPiNZNQmrmCmQhfi+Lro8dQsMqKXpDWtOhcwH9lmuf9BbOOh17VTPIxDTMevq7rthujtFhEUylakYch2/UcnF3G2mJkMt4SBr14HCxkN0iLboe4ZI5Tj51yD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUyyKAvQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUyyKAvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9A31F000E9;
	Thu,  3 Sep 2026 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422692;
	bh=nik0wTm+JAvs8cZN7JlAAdq521Lm/c+88mnUUFC//R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jUyyKAvQFpKXEHo2Atpade5J0wfy1AFB0fqkGgJOa8yKzmq5BJ9QpKhNF73PxQp6q
	 djMgOWi1bpqw+KDh5J11hhTA1ywSgPUl/klMK/hMnhJKQNbOgO8+Y2TWMMc4qXYrFx
	 GYMNaw8ICT6/wJnZmkQaAEmo9gO7++djTtBirdbCBsHLCbC2PgW7ao+0dwlxT5TmBT
	 +1TweJIMqStnfbfGl3utjj+BdNFOjYp9SPYZ0rKvy6rTppWVygt9zzStrbH4DPOelP
	 0NQRh3ijzu+TmVTyb2wxZauSsE1G1FEOl29Qs+TSy4pz645AEK5a2hXQrJ+v6wDUV4
	 bTLfVY7bV3ugQ==
Date: Thu, 3 Sep 2026 11:04:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: s390: replace page allocator calls with
 kzalloc()
Message-ID: <apkqHLgg7nqBiYW7@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
 <20260902130612.41500808@p-imbrenda>
 <apghz4XAgv0ro15t@kernel.org>
 <20260902165315.06996af6@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902165315.06996af6@p-imbrenda>

Hi Claudio,

On Wed, Sep 02, 2026 at 04:53:15PM +0200, Claudio Imbrenda wrote:
> On Wed, 2 Sep 2026 16:17:03 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > On Wed, Sep 02, 2026 at 01:06:12PM +0200, Claudio Imbrenda wrote:
> > > On Wed, 02 Sep 2026 09:15:12 +0300
> > > "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:
> > >   
> > > > This is a (small) part of larger work of replacing page allocator calls
> > > > with kmalloc.
> > > 
> > > I have some objections to this series, but not because of what you are
> > > trying to do (which is actually nice).
> > > 
> > > I understand that you probably wanted to touch as little code as
> > > possible,  
> > 
> > Yep :)
> > 
> > > but now since you're rewriting the allocations to use
> > > kmalloc.... I'd like them to be converted to use the __free(kvmalloc)  
> > 
> > You mean __free(kfree)? Sure, I can look into it.
> 
> yep :)

Well, I looked :) 

The only place where __free(kfree) is completely safe is handle_sthyi().

In all the other functions using __free(kfree) creates a mix of of goto
and cleanup helpers and cleanup docs advise against mixing them:

https://docs.kernel.org/core-api/cleanup.html

The cleanup paths are quite involved in these functions so using
__free(kfree) there is really not trivial.

-- 
Sincerely yours,
Mike.
