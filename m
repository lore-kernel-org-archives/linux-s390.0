Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F023F99F5
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059163; cv=none; b=P04xVW29CkD+VckFNqwwp2LCTSCCHizt0j8PT4Rjnwee0ZKtJXSl/t7Vv7gB6VmyFLBu9qm6/D8Vvl035C+yT3uutxFkO0V36yaVexv945VkEjRW2qE1SacqBjmCowLLcEYM6bBTPBJDtt4Qbs4dvxPvOMYgDf+0KWgBAciQUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059163; c=relaxed/simple;
	bh=1EEc9DXazDAkqWyOTVLtE2IybOrjkcWooeu2y5oJv+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iq6te2NNjwMVlv7mQFc5zvBlpwGWvDCbCH0DBSAd0T8t8cGbuP7bedNiT0JXanbcV95IpnK1ixI1DKEI3wykRWkdfFIz/je8guJqGYojZujcPbb7jRtvvFvVPiH3FujQXQMYZnQ1ARgUJ24h7qrhQhgep1LbSUfKaOp+/4Wh6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWDrO9e7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYXHfURV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWDrO9e7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYXHfURV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786059160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1PY9KJIb1qTfXyzcPT+pdmLvTO8tSJ3NAtvLbML8yo=;
	b=ZWDrO9e7JjOZbjJtct0oh3/mGYsYezAsXRz2CPyFAnJnvcoHeLfbHfpnL0HGPqfFBXVQo1
	geHWjQ1nC8chHH1an4p3Uc4llTRmm1o17Fj7AD7npscH8gAwDKyFHEt7fHT1/HXST+P/UG
	jzr0Mx29/PA5oIGcRdk8typqJY5Ggw8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-4axSIJs6OWeSgTY2cmSu9w-1; Thu, 06 Aug 2026 19:32:37 -0400
X-MC-Unique: 4axSIJs6OWeSgTY2cmSu9w-1
X-Mimecast-MFC-AGG-ID: 4axSIJs6OWeSgTY2cmSu9w_1786059157
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0408254aso17356921cf.0
        for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786059157; x=1786663957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1PY9KJIb1qTfXyzcPT+pdmLvTO8tSJ3NAtvLbML8yo=;
        b=WYXHfURVAoykH1tH+TgahTEScVCiVPTZ1eFiubpXWxWiQPHVGFvAv1gU8YBlXRHiPZ
         r+l5u6DDdb8axzseYxH0B00FpIaYqcj7v2hOwkg/je3w75+mlbYNmhcJoYUHYRfXdwOK
         HtXOZoe0HDhLqIHGjqTS1q0ycOpcP8jmtIisp1LG6BkGh6GN7LYsyV7PkM7j+jNYdIlW
         TTrmn82Fg5A89o2IO4JjGQ1GFRbwOL01I+dD/lZCldonX4pFZOlIFdPsvC46vtqSne6w
         CFLsxq6/wFI7bLcyJrL42pAXtOrlhc1tLA3yKrIakz/R7AtwrkT8xSxHFZgpYGVlw/18
         z9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059157; x=1786663957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1PY9KJIb1qTfXyzcPT+pdmLvTO8tSJ3NAtvLbML8yo=;
        b=NBksdBiXoUB2GeIucIM45x+QMwhON74szDpQv77o7I38ixyrSZFMaUMn/TxAqKWBHF
         Ft6skD2n8zKc/DONIWVTQr8VwRQhXwclGsnkVIk7rKiyFPImway2GvM1B5Z/gUMBUiZF
         6iXBQPXbbrulbyNi67RIfkNlDeOObpalYKpw4teJelsOyEKdC0vuW9K14HH/dAXXTiVi
         jZCykcycrUh3UdvHFyOGdLEVUJ3xddNFPxK3Rq3mJouyD6IkpWSQK4kyoyvjA+upeOPS
         c+f9MphR80Voqe7WdRBk0uKiXUlNdudc1BnD571cPnSegUwzPfJtwiiebYqfrgCxpnWd
         3SMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3dnPjroL+NMhGIUdLIJ3PV9nXbbPVgPbkEYpQjhtpAqQkiTADBdm5Lv61/vc1wPzOgFoiKiFunpg7@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkJyS7rA71Pk5vKLzgrs6HiK0K9FwExFZDSdk1T0HaT5fAmgc
	uF28pK2p2fu7Bleacjhxwclfixh9k8yhQopExi85z+9yS/RGnfAajOoW2EJD7i471BQG7Ytay8y
	ivaYeCMZNp7kf1saadZARkYF4in5k6p3Vse3v1U/y2k/an3WdHW+cU1tI65YkhWE=
X-Gm-Gg: AR+sD10unfoXIBw0Pv7XV7B5c14gvZyRt1zV4qkIdS6yjeekzu+ffuweADP8Nwul0ob
	CkLenZpRpCX22S91fJqNRO2Mf8KBcZCQajl+LeD3bcz5SlmLEV+x9CFIVgYPBHOl21wab4MjXNB
	oGOo8n6pVlbpslvk9q4/Y+TiHwQy3Pf1XgK0JLMokHhBz3lYTLU+Tix65/NIMzkiSSTqOr9tHnS
	f1FoS6f2rlpjA+Wg95Ja3hWN6CyxUFI8kt3KJEIxNzvxbEiETjk71C7nZrgAFAcm96WjvCd/LMm
	1mqTrjy7LkWsMAzQncgRw/E4LE/6hopQtjkdof0h1cMLh25omJQusXpBaUoW0rNLdKNr
X-Received: by 2002:ac8:6f19:0:b0:50e:635b:5562 with SMTP id d75a77b69052e-52d00498b36mr95353251cf.22.1786059156650;
        Thu, 06 Aug 2026 16:32:36 -0700 (PDT)
X-Received: by 2002:ac8:6f19:0:b0:50e:635b:5562 with SMTP id d75a77b69052e-52d00498b36mr95352631cf.22.1786059156155;
        Thu, 06 Aug 2026 16:32:36 -0700 (PDT)
Received: from x1.local ([174.91.117.74])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d16335bb4sm273151cf.2.2026.08.06.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:32:35 -0700 (PDT)
Date: Thu, 6 Aug 2026 19:32:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christian Koenig <christian.koenig@amd.com>,
	David Hildenbrand <david@kernel.org>,
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>,
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Sergio Lopez <slp@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable
 PTEs when mkwrite is in use
Message-ID: <anUZhiwas8pN_No8@x1.local>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-4-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804120529.1730187-4-pbonzini@redhat.com>

On Tue, Aug 04, 2026 at 02:05:25PM +0200, Paolo Bonzini wrote:
> This ensures that fixup_user_fault() users see a writable PTE when
> they request one.  The flip side is that vmw_bo_vm_fault() now has
> to record by hand the write fault, because .pfn_mkwrite() is
> not invoked.
> 
> Prefaulting works as before because only the first entry comes
> out writable, while the following ones still end up executing
> the .pfn_mkwrite() callback.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Only some quick thoughts while reading through this, as below.. even if
some of it may make sense, I think that may be more suitable as follow up.

This looks like a good fix for a regression already to me.

> ---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c            |  7 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 42 ++++++++++++----------
>  2 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index a80510489c45..3ebde936ce60 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -191,6 +191,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  	unsigned long pfn;
>  	struct ttm_tt *ttm = NULL;
>  	struct page *page;
> +	bool mkwrite;
>  	int err;
>  	pgoff_t i;
>  	vm_fault_t ret = VM_FAULT_NOPAGE;
> @@ -242,6 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  	 * Speculatively prefault a number of pages. Only error on
>  	 * first page.
>  	 */
> +	mkwrite = !!(vmf->flags & FAULT_FLAG_WRITE);
>  	for (i = 0; i < num_prefault; ++i) {
>  		if (bo->resource->bus.is_iomem) {
>  			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
> @@ -263,9 +265,10 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		 * at arbitrary times while the data is mmap'ed.
>  		 * See vmf_insert_pfn_prot() for a discussion.
>  		 */
> -		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		ret = vmf_insert_pfn_prot_mkwrite(vma, address, pfn, prot, mkwrite);
>  
> -		/* Never error on prefaulted PTEs */
> +		/* Never error on prefaulted PTEs and never map them writable */

I got confused when reading 1st time, but I got it then noticing the mark
dirty was done by the caller.

Two small things I thought about here:

- Comparing to the time before introducing pfn_mkwrite(), this will cause
  previously one fault (with prefaults marking all follow up ptes writable)
  to be 1 writable plus N-1 read-only. May not be the most ideal if we
  consider the 2nd WP faults on the rest N-1 later as slight overheads,

- Split the "mark WRITABLE" and "mark DIRTY" in code might be slightly
  error prone, especially if this is a common function used by multiple
  drivers, while there's only one driver that does the "mark DIRTY".

IIUC the other idea can be, do not reset @mkwrite here but instead move the
set dirty here, invoking whatever the vma's .pfn_mkwrite() is. So that we
stick two things together; maybe slightly less error prone and less dup
code when other drivers opt-in for pfn_mkwrite().

Not sure if it's a good idea, but just to raise it in case useful.  Again,
I still think this is a solid fix to the problem already.

Other than that, FWIW the whole approach looks reasonable at least to me.
I agree in the fault processing we should best resolve the fault in one
shot if possible.  In this context, FAULT_FLAG_WRITE is the flag showing
that a 2nd fault is required, then IMHO it's indeed better to resolve the
fault in one go, as proposed in this series.

Another thing I came to mind that may not really be relevant to this
regression alone, but maybe matters for the future to at least keep in
mnind: I wonder if there can be races happen while fixup_user_fault() is
resolving faults, causing the 2nd pfnmap follow code to fail once more,
say, some other thread modified the pgtable again (e.g. wr-protect with
write bit removed right after set).

So maybe pfnmap lookup and fixup_user_fault() should be done in a loop
until any of them hit real errors.. if any of such race may become a real
problem some day.

Looks like low possibility that threads will mess up with PFN maps.. but
just to raise this idea.

I believe currently our mm fault handler should be working like that with
handle_mm_fault(), hence neutral with such races (it'll loop a few more
rounds until race disappear).  I recall there used to have thoughts adding
some n_retry_max counts to the fault handler, but we didn't really do that,
and it runs all fine over the years.

Thanks,

-- 
Peter Xu

