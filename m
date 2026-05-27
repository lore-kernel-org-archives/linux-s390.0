Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D23E3DA4
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898039; cv=none; b=akJl3l04xdKRV/mgkSHW7bJvwAeUZiUbj84lCJSCjNgohFYccp6sBLPqIH5PgdOwKpfwzUB1I7ReGBaxrKPQpwPxS4Ol90z5YrJuVTNn1N1QQNA4xYhxmIr+/iv4Dxxrc9lg53E4pH2+5s/KaWDIUbS6mXoMMvFgEqm7tJag0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898039; c=relaxed/simple;
	bh=aval9P+49I+gSSuUWbQmWVLEEDNUMRnbLgYtSiXlBo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk0QBJmDHqi+yx6/5CqxavXsR3Hww+uyABwRd39CP6THQJ6fTG7uWpwxNzY8JfnGGVfhjHLTl+MvJXNMmrOylyGfQSufpCwNNqPtsiO2K3FUv4Hk4uCjbIEACItOq5qBZFAZsS9K3RaBY8FxxNstCkPrwcsUSCa7crcV5Hw6+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h2tiAGEq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h2tiAGEq"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-914bf8abeaeso421532385a.0
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779898037; x=1780502837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STKe203GtXAmunHIdMeMAq0fDblU9FAY1byc40VlLXM=;
        b=h2tiAGEqPW7XLlmf+UIP2CsdaNxwpGao2hDvmsau6y9jbmQGLkss8lg2/iShGVrQ0V
         CCbHsJ+Gl02H3YaEYuVAeMKKu4CYFPPZ4WHgdP3MyRvjtlSVBrfeSYVVISAcs64wjQrv
         0ZMDQZvfcpI40i13Vy35drnRp/cTvGqTc/7OoW+57I8hUQRrwJN2o9B8pmH/LigyJqXh
         RLGgLtW+SZnU3XQRRPkJ7lRyCP66TkhUgIN412F/PJ44fCRBQnYj+6tEOZu30ZLzelhX
         C+uPQaT4h0xdOvcKo7fc3vfNGIMWPbFdEdBWNNv/Nrz86VHr4jNn4HagaZWRhH5pvN/b
         xF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779898037; x=1780502837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STKe203GtXAmunHIdMeMAq0fDblU9FAY1byc40VlLXM=;
        b=DPd7W5LTnCj6Jbr/wUZBS5UHohB1w9+V/QWUuS0oFxLWQZcgixMAkqyGwn0cY81shN
         t68IGSKN95WWz+UUruJnwpRCC0dKlfzjCWuxcWpcm/wEhHOpQtrwjQ3W4pjmnPkT2tt8
         JSAXX6VbioDGIhwHi2vUDSlW827q/ElafY8gk5YRNw/rI5LlPB8hVFj4E+/4RslclHM8
         An09PhMInIM6hhy5VR6Jrquzy9LQjdaU0lEd8qLeiYHK590lS8W8ptkEFSHWbihZyMZM
         LxnDfA7xjfZXSaMQfJCUqg6P/NRvVaJFYcmnCCDTRWb/lk2jWBZSjHbBidg+s42RBELh
         Jw2A==
X-Forwarded-Encrypted: i=1; AFNElJ/Fo873d6BnvU2VtrCbS8UMHvFUCEUyumNoFAqZ5UQ5fRQVfSDhbL1xGAMr18xwj0YFPptdSDcphwz4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2a0AuVYkXsTp1eNR8CWZd0qYdqEUqQn+L+AUvH8O1OSB4isk
	il1o4N9ycLitbSYiA2SFuXEU9/stfPtkM8PAdM2O45qGBEuV368Qms59+SjQKlwW+lY=
X-Gm-Gg: Acq92OGPZD+VKliPetDb2CpUFF2SY7+ddvPh5dPPvMG0/TrrRLCM148Wj+Pv3wQxwkJ
	nL6E+rmCXGveObwfUfvJ6M/ulxqbWh/69ZFp5FT12F+h2roFhvBar/S/q64zMlwct/y74FgUZfu
	ZQy4gNvlFXh5VCSMnl7Y6wnCo4cCeThHSJZtEugbrMxPUOFfuvOdi4kUt4aGj8RY5RUNWWp22HT
	80Fegttip2rbQ9S4u0rkSTYSFh50lqwv1FIivwsVR7GpkFBst12JNXOA/3UdJo+UWzDwn4y7WZd
	SNI3QbbG34JhpSYrye9I0sxEmNb2Kkd5v7Q21SUwc+Zjt/aUQmSCEA5Myv47Cjw5HMCJ4bysBZo
	S7wK8NXnz+ifxjdDo40aZSpgpieD6k8MXbk+eyxQYOCEwL+wwX6GdqMYj1wHChuDnlUMuEWnAym
	yWKoG6EpypGralnaBi1d7GAvI2ylEr/z0FlPD2UaM1ufaTTO5tULoNGIRz9yk75eiMB16qAM8xA
	5GixQ==
X-Received: by 2002:a05:620a:1b89:b0:914:c246:aca0 with SMTP id af79cd13be357-914c246b146mr2808635885a.36.1779898037030;
        Wed, 27 May 2026 09:07:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86e8e13sm505133685a.2.2026.05.27.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:07:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSGmq-0000000FI8B-0NaX;
	Wed, 27 May 2026 13:07:16 -0300
Date: Wed, 27 May 2026 13:07:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, mripard@kernel.org,
	sumit.semwal@linaro.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260527160716.GN2487554@ziepe.ca>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahPqbfH54R3JJyaV@infradead.org>

On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> > module") the system dma-buf heaps can be built as a module. The
> > system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> > but those functions are not exported on powerpc. This can result in a
> > build error like:
> 
> I'd much rather revert the above commit.  Yes, x86 has exported these
> since 2017, but that's a really bad idea, and we should fix it instead
> of spreading the export.
> 
> Setting memory decrypted is a dangerous operations and should only
> be available to core code.  We should have various allocators for
> decrypted code, but not export the functionality to random code.

At the very least an EXPORT_SYMBOL_NS.

Looks like there are about 3 modules using it already..

Jason
