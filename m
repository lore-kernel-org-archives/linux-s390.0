Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213D34FF45
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222636; cv=none; b=Lmc3JXvllQl4OrYZVtoF9c6GgULnfl2jEp6/zwUxSq7cNsw288uO3wGKYfhX+VplZXU0pRFcCF/mJE3EE/eBgQH9m5LB+vPwgCvDOTM9cTsDn/YtFxe7cpvsfKPtxTVtBH74/B0Bgz477BHuiqfuAsYJhas14NxhIS9Le4nr0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222636; c=relaxed/simple;
	bh=rICRiTfJgrxNYivqrx3QRWj2Z2ZWCmZ73P4l1f7hwi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSRdo7b4tOEWQlYyh86D8jPH+BFcclJGAPBbftn8p0PjPO8g4E4qLF0x/e0LxTa4gPUprzRIk95H4OsoFLWQN5pyQ0daUNdmlmAsbh19h9WMuPPTvN0vbSzqK1waf0p/s9ZCUczKbl0rS/3/GCPZ24HYW9+TctDRi8EmEz5VWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ1zVRUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ1zVRUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE981F00893;
	Sun, 31 May 2026 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780222634;
	bh=W7IA/4CjL0iLf6bZ6LzNEvE6whR/XHRl/myZhG5caaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hQ1zVRUUznBCiMVES/N9PCfKASCvGHJNqCNkXWvKW2U3dge/NPMqXJojGqeS8jXlK
	 Tbp5lTNd2lVv8UMxYx6CZIzhi7OtfsX5OK8R7H1Fem8KM7UuQ9ZCwCWKMIX2mcYmmH
	 XwWkUralwIeM2pJgAoFHEHNB73qfG9BkuXbx4S97yHcVjTgG8NDvTzwDeRePi7XeJo
	 JojnL+FieOg8E/cO+TnW5gv0xxRGj7n4kPSmg+AhFqfq6lDUO4IdwC1CDVSVROj7dM
	 cNd9idQGgt34JJZEy9fP5/PrYCZt5BCzabGFLbt5URKE94iBvNhetSLZx2nU12De5g
	 5wi+o9skMHb4A==
Date: Sun, 31 May 2026 13:17:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/6] s390/qeth: replace get_zeroed_page() with kzalloc()
Message-ID: <ahwKos-rF4F_zwA4@kernel.org>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-4-b7108f54d722@kernel.org>
 <20260529102345.26496C83-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529102345.26496C83-hca@linux.ibm.com>

On Fri, May 29, 2026 at 12:23:45PM +0200, Heiko Carstens wrote:
> On Thu, May 28, 2026 at 10:09:52AM +0300, Mike Rapoport (Microsoft) wrote:
> > qeth_get_trap_id() allocates a temporary buffer for STSI system
> > information queries used to build trap identification strings.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> > 
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> > 
> > Performance difference between kmalloc() and __get_free_pages() is not
> > measurable as both allocators take an object/page from a per-CPU list for
> > fast path allocations.
> > 
> > For the slow path the performance is anyway determined by the amount of
> > reclaim involved rather than by what allocator is used.
> > 
> > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > kfree().
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  drivers/s390/net/qeth_core_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> > index cf5f760d0e02..9274087557ec 100644
> > --- a/drivers/s390/net/qeth_core_main.c
> > +++ b/drivers/s390/net/qeth_core_main.c
> > @@ -3362,7 +3362,7 @@ static int qeth_query_setdiagass(struct qeth_card *card)
> >  
> >  static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
> >  {
> > -	unsigned long info = get_zeroed_page(GFP_KERNEL);
> > +	unsigned long info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
> >  	struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
> >  	struct sysinfo_3_2_2 *info322 = (struct sysinfo_3_2_2 *)info;
> >  	struct ccw_dev_id ccwid;
> > @@ -3381,7 +3381,7 @@ static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
> >  		EBCASC(info322->vm[0].name, sizeof(info322->vm[0].name));
> >  		memcpy(tid->vmname, info322->vm[0].name, sizeof(tid->vmname));
> >  	}
> > -	free_page(info);
> > +	kfree((void *)info);
> 
> Speaking of ugly casts, which seems to be one of the main motivations
> of this approach: the above adds casts instead of removing them :)

Hmm, I'm sure I made this change. Seems like a rebase fallout :(
 
> So I guess the below should be merged into your patch to get some
> improvement:
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index 9274087557ec..20fb0d2e02a9 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -3362,9 +3362,9 @@ static int qeth_query_setdiagass(struct qeth_card *card)
>  
>  static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
>  {
> -	unsigned long info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
> -	struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
> -	struct sysinfo_3_2_2 *info322 = (struct sysinfo_3_2_2 *)info;
> +	void *info = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	struct sysinfo_2_2_2 *info222 = info;
> +	struct sysinfo_3_2_2 *info322 = info;
>  	struct ccw_dev_id ccwid;
>  	int level;
>  
> @@ -3381,7 +3381,7 @@ static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
>  		EBCASC(info322->vm[0].name, sizeof(info322->vm[0].name));
>  		memcpy(tid->vmname, info322->vm[0].name, sizeof(tid->vmname));
>  	}
> -	kfree((void *)info);
> +	kfree(info);
>  }
>  
>  static int qeth_hw_trap_cb(struct qeth_card *card,

-- 
Sincerely yours,
Mike.
