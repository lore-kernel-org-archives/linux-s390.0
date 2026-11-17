Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920971;
	b=ueu4mZa1EjTenkKqTyBV5IpRdLAjriffCY0JIYkXSbYLwcDtrNwLjaymXsrEPsgpOeTP
	 OeU9v6fqXJNmT6BNSg1Tsbf4k/Y71YdGzc8eLfQDWQcWiJvPidcOuwArNVukRYU8ZYUCs
	 A8yhPxz7EWb6nG3XerTq3zwPIkiS9JHxaCO2LdCCfHw0jKV9zFobJ/sxhfB458rhQrTQC
	 N0PBitRPuxORBhT6GMhjtChvHY4I520NzePL5txP8zudqUlqZbS9kMPHZ8acn02/EBBPe
	 9AFu/qy8+3C5UGIWTKdlon/JKDoBpr4jKw+M3vUZrJVVoTDKC984um/fnnTh8eDfUkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920971;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MYlCavCmKBR+LcfhJHx6WNDCyIS5wdpBm9jT9WBogFw=;
	b=i5qFnMZDSYx5G40ls+WVdLVfWvxcQwcPwDGFB/ueSbknDDAypCFZ0j6PuuD3c9YIAYMn
	 ohkJNvT0RtgPHz0fwYK7TMMfktGNsUJaamLnMTPfa27jaMRYO6NFQhLPodZEYmUdEiOTm
	 0bGU1vM8RIr0RBiTAb6gbh24ocZ8lCzMgtII0lkecMYQrKLuQlrFMra9LJcMp84xiovxe
	 JSLbm6yMCAtqEBPDT/e3quc3lPlbr8QX8BFTTOxvDc3vcHDgZLr1M5qvKyv0vdvBF6SzA
	 MrEEqqlJNU7Zh5qmcazBMISA6b510pR3VufF1hUyeQolKarnSHGS46+KH0hTv2oA5GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CN8rDF/C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348C606A32C;
	Tue, 17 Nov 2026 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN8rDF/C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3771F000C4;
	Tue, 17 Nov 2026 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920970;
	bh=MYlCavCmKBR+LcfhJHx6WNDCyIS5wdpBm9jT9WBogFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CN8rDF/CUbNhGdiyHjCAuz5IQlDn3iZmVveFZowSyDnlwjfBoBajAEkldEHCfnP+8
	 LvzB7xSnpehC2DMCTIZcbLlcqe41Z8LGjH6LsxAK+jkmJJEn17s1ZYyGQ12QtKZB/i
	 ZnXx4nafqJUtuwBCQZ73qMSie9EUQ39m2XRb2xZ96/OI20FTnAy8Pc7jlJHyxHf/Sy
	 zvDjDn1lrSSjKiIJlNUjCCizTzczGQq3xngE8ajRTGZhtPh5ne3NSZmqkGoJ+VDB19
	 yv1DVazWv0zH1+atZx6Z6FsHFZFeuKPkNvzpP828G5PswbrrAwGS0ed4yLCo81UXpN
	 mJJJJUXu9y9Gw==
Date: Tue, 17 Nov 2026 15:09:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 12/14] s390/sclp_ftp: Replace get_zeroed_page() with
 kzalloc()
Message-ID: <avxSBMGhTU0_QseV@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-12-3e7c90eb6676@kernel.org>
 <20261116152608.165348B07-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116152608.165348B07-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 04:26:08PM +0100, Heiko Carstens wrote:
> On Sun, Nov 08, 2026 at 10:58:43AM +0200, Mike Rapoport (Microsoft) wrote:
> > sclp_ftp_et7() allocates the SCCB used for an HMC file transfer request
> > and sclp_ftp_startup() allocates the SCCB used to read the SCLP info in
> > the debug code.
> > 
> > These buffers can be allocated with kmalloc() as there's nothing special
> > about them to go directly to the page allocator.
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
> >  drivers/s390/char/sclp_ftp.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> ...
> 
> > @@ -250,7 +250,7 @@ int sclp_ftp_startup(void)
> >  		return rc;
> >  
> >  #ifdef DEBUG
> > -	info = get_zeroed_page(GFP_KERNEL);
> > +	info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
> >  
> >  	if (info != 0) {
> >  		struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
> > @@ -262,7 +262,7 @@ int sclp_ftp_startup(void)
> >  				 info222->lpar_number, info222->name);
> >  		}
> >  
> > -		free_page(info);
> > +		kfree((void *)info);
> 
> Sashiko is right here, the ugly cast can go away with a trivial code change.

Argh, missed that in pre-send review :(

-- 
Sincerely yours,
Mike.
