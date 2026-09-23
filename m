Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAA3E5EF8;
	Wed, 23 Sep 2026 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155493; cv=none; b=RmEfH7qjn+baPqMqTFiLEFElQLqE2tkAAePDHpnIl/c2+sInpRR72IQZtkuMZH/DX8kH+vo7mUji6xPDRg9O3po8WdFfyFcTGpbFF4aS8W5RJF3O+ut6nprAS4yobJffBJPerkNNRX7BjmdSuCbjc3eUgr5XIVl879qXwMZaM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155493; c=relaxed/simple;
	bh=de5fgle82bLILPDmswSi2vb3mLGL++T0W8W0EDiaSr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq/wqz4kWrgaJJaWIJ07toKo+e/D3E5jgkZCzaXNuFkGwDhtj/HmY4OagzoxiA84yO9KzH9PpjLmQUJ9vZc++HdZk1VW9t/o2JSco31WsJk1+LdLeGOU1bmnLVV9FZf2CiW5NiOnujeT/5ktB+vZzKGoalGTK5jatCARmyrEFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf/HJYmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf/HJYmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F05E1F000FF;
	Wed, 23 Sep 2026 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790155491;
	bh=rLKRb8Y4+nISCnQaxnX4ctxBf/lcPEd8M1PAoqnsICk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lf/HJYmS7UTiPzh9amAhYD2S1aZFVo3LNH5rJLGdyYuILAzd5aGZtD7Z+A88a9tmL
	 hHM6MECEikQkwhUsVWW9OiN+brnRisqJ9m4BU9synUw13IBOU89ZTDelvYTT+MbfCr
	 YHCOAWS4p2NquBk89ID0zbIa8fuQleDE9KqU4RAhKfHJPAKRRbVI/pQHilGVcicP07
	 EW/UgyDgmSBMmHsdSA0fJ+c0tZ/MA4+6VdDCVG/bt0KetNYvzUPxCl4XaT+mMKf/Jf
	 B1arbqfvaLL4O7tkudrCw1fmUe8fqQeMQ5Yhy/QP0Sg91jXC39kkSIBIAWf4RbKs6W
	 EnUBG7zakOYgg==
Date: Wed, 23 Sep 2026 12:24:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
Message-ID: <arOa28u0tRZ-jGYi@kernel.org>
References: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>

(cc s390 folks)

On Tue, Sep 15, 2026 at 07:42:15PM -0400, Tal Zussman wrote:
> Use a folio for the page cache page the s390 fault handler reads the

I tiny bit of context why is this only relevant for s390 would have been
nice :)

> old kernel's memory into. This removes four compound_head() calls and
> one of the last callers of find_or_create_page().
> 
> The vmcore mapping only has order-0 folios, so the logic is unchanged.
> 
> Compile tested for s390.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
> This is based on the kexec-next branch of the liveupdate tree.
> ---
>  fs/proc/vmcore.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 44d15436439f..2dc3803aa11d 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -474,29 +474,30 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
>  	pgoff_t index = vmf->pgoff;
>  	struct iov_iter iter;
>  	struct kvec kvec;
> -	struct page *page;
> +	struct folio *folio;
>  	loff_t offset;
>  	int rc;
>  
> -	page = find_or_create_page(mapping, index, GFP_KERNEL);
> -	if (!page)
> +	folio = __filemap_get_folio(mapping, index,
> +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
> +	if (IS_ERR(folio))
>  		return VM_FAULT_OOM;
> -	if (!PageUptodate(page)) {
> -		offset = (loff_t) index << PAGE_SHIFT;
> -		kvec.iov_base = page_address(page);
> -		kvec.iov_len = PAGE_SIZE;
> -		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, PAGE_SIZE);
> +	if (!folio_test_uptodate(folio)) {
> +		offset = folio_pos(folio);
> +		kvec.iov_base = folio_address(folio);
> +		kvec.iov_len = folio_size(folio);
> +		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, folio_size(folio));
>  
>  		rc = __read_vmcore(&iter, &offset);
>  		if (rc < 0) {
> -			unlock_page(page);
> -			put_page(page);
> +			folio_unlock(folio);
> +			folio_put(folio);
>  			return vmf_error(rc);
>  		}
> -		SetPageUptodate(page);
> +		folio_mark_uptodate(folio);
>  	}
> -	unlock_page(page);
> -	vmf->page = page;
> +	folio_unlock(folio);
> +	vmf->page = folio_file_page(folio, index);
>  	return 0;
>  #else
>  	return VM_FAULT_SIGBUS;
> 
> ---
> base-commit: 4d17a004cfd5489f88ad0a7a151dea11a533338b
> change-id: 20260907-vmcore-fault-folio-4b382eeff262
> 
> Best regards,
> --  
> Tal Zussman <tz2294@columbia.edu>
> 

-- 
Sincerely yours,
Mike.
