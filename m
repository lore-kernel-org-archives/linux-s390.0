Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592552DF13A
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981396; cv=none; b=DfnMPSlSuE45kkKoWFs9bt1sWOy0vDa/vpHPU3+IPpX+H635QtaW/tvORCbbtavQjAx9uYpOjbtaBlh8tPN/YOUm5Uhvf+OwrxqerhNC1YVvR75j0dOps9UY+UpfoA3cQAJ6o22dMCyadt0GmRw8PHI8EXB33k609+pp24eXCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981396; c=relaxed/simple;
	bh=PDFT+txlDs2nKZDsUx39mzdUciP7xguuP/qa+Zt5Oa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/JHhAMPR6EIt5t+TrfaN35oQbm/sF1IPdSlZLURaFvuD4IJTXXzD6bpCEtr+esfAA1pkppsEBY376f6Lw6zX0LCGKSafxq5KIdF3viFkDoQJVzOYlAbV0/90NL0CHk0hU2ATMPLcATTIH9i7PUskrKqoXdxuLrEdt6BaHkfTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfQFt/Rt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfQFt/Rt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C1B1F000E9;
	Thu, 28 May 2026 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981395;
	bh=Pg6v2cHv333kaMyV6l/oOPdxvdmDPIMAAMr4S3kInJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RfQFt/Rtv99mAIbHAuPbcQTpG+wlXUBPJIqc99qjOUo31TL1Qkt+i7XwHBPVAu92P
	 OUrtcioSKrHaDlVIV53UGhnfhGXZCWWiMhmCBDWxuWNJSjOMPUN1Ux+H+d7tSEp2rt
	 +3A96WtXidRte4WAus7yezOlR7jZUkkFOuba3c8rEM1aDd7Zw6qf6EScoeuZyXn3rf
	 YJYWJXM/gugrh4zJhxnRu7QEBtcTQdfw4T1dm/jrGBP56D52PJloPx7Sd4jS3x+DuF
	 JAcpbLWeFKMO9ZnB1EEoFLkX7AE+OLdDpTXTvlG9CuK7lHwTt83GcWqT7DN2KeMlGn
	 Nug/pZNCGPH/A==
Date: Thu, 28 May 2026 18:16:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/6] s390/drivers: replace __get_free_pages() call with
 kmalloc()
Message-ID: <ahhcTBxuT154MmNI@kernel.org>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <894c759b-fe6c-4dfe-8b60-3b74916498c6-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894c759b-fe6c-4dfe-8b60-3b74916498c6-agordeev@linux.ibm.com>

On Thu, May 28, 2026 at 04:48:41PM +0200, Alexander Gordeev wrote:
> On Thu, May 28, 2026 at 10:09:48AM +0300, Mike Rapoport (Microsoft) wrote:
> 
> Hi Mike,
> 
> > This is a (tiny) part of larger work of replacing page allocator calls
> > with kmalloc.
> > 
> > Nowadays the right way to say "I need a buffer" is kmalloc() rather than
> > ancient and ugly __get_free_pages().
> > 
> > Also in git:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-drivers
> > 
> > ---
> > Mike Rapoport (Microsoft) (6):
> >       s390/con3270: replace __get_free_page() with kmalloc()
> >       s390/dasd: replace get_zeroed_page() with kzalloc()
> >       s390/hvc_iucv: replace get_zeroed_page() with kzalloc()
> >       s390/qeth: replace get_zeroed_page() with kzalloc()
> >       s390/trng: replace __get_free_page() with kmalloc()
> >       s390/zcrypt: replace get_zeroed_page() with kzalloc()
> > 
> >  drivers/char/hw_random/s390-trng.c |  5 +++--
> >  drivers/s390/block/dasd_eckd.c     | 12 ++++++------
> >  drivers/s390/block/dasd_eer.c      |  4 ++--
> >  drivers/s390/char/con3270.c        |  8 ++++----
> >  drivers/s390/crypto/zcrypt_api.c   |  6 +++---
> >  drivers/s390/net/qeth_core_main.c  |  4 ++--
> >  drivers/tty/hvc/hvc_iucv.c         |  6 +++---
> >  7 files changed, 23 insertions(+), 22 deletions(-)
> 
> Did you use a particular tool/script to identify these locations?
> The immediat question would by why these sources only and not the
> others that also use the old functions?

I used an LLM to identify "the most safe callers to convert" to being with. 

Since every call site requires a manual review of the surrounding code and
the actual usage, for the first round I limited the changes to allocations
that are temporary or staging buffers.

With a less restrictive prompt I've got 57 patches to s390 (both arch/ and
drivers/), bu that's too much for me to chew in a single setting :)

If you are curious, overall changes (before the human review) are here:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=gfp-to-kmalloc/v0.2
 
> Thanks!

-- 
Sincerely yours,
Mike.
