Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F903E4C67
	for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909606; cv=none; b=jHCqan57BZ/vK+yvqILWQQPHlBf82042qUKypmjwMpi7mcl7OsNS8fjQOK0mFXZTcdDyORhM6ZdJfrdbv9Wwa5T6tczKh+bGgfjbqPRtctqSFN5HnWZZYyNGqPbgZZ2uriQc9cUIaSPukyLtChpEovhkK6PVp26iO49vw2wKvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909606; c=relaxed/simple;
	bh=njYxOmFhF0kKZxmCluaJeRNQJOvHXtTT/LYX+fA/Jes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB6XSyYYfI5/joCEDv22UnDo23jc72kvM7VLqGJ3lDnewr6Kye0OjVVazH9YDDe+8O4TzwpJF4sQblPamtfBK9l2foHRJPB4g0ooRC7mzC9/rLxobeN9HeP9pPNwlTki2NuiG1rhwz5r6nlz5Hf7CmbciASrhn6hp8DTeDRztog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SRVjkBgu; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SRVjkBgu"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d006a80ccbso642066585a.2
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774909593; x=1775514393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMpjIoYB4wkYY1B4Qvo8YM+LGvG/wS7KH0HgKJnMSKw=;
        b=SRVjkBguFjfCZK6KyO2Br10O0nqWk6wAn3BLxlEleze8weF4NGKj5VBS1no0JjO5YI
         g/8icibDzjoJ0tJ3mTX8v++aieNJw05tHkPlWTQpChPxIIwkR+mVcZapcZOaZwamMkGU
         BxFsK6CI60m3/NSHR9n7W/1RRGEA/BwYPMseTh37M/BCi6MEgkRPdeEMsVaqjQzrH1M2
         hfIKXlVf8INWVlRRJtrqNQBeTHeyhxBgPBBJti+7t1bjluyepJUzik8KVlxhpl/B3k5a
         5bv6rOSUlHPqk37gDhEw2D5iGe/tdQtZx2u/ofN+hR7axrwuYFIQPz5ctd56nxod8Ysk
         WMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909593; x=1775514393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMpjIoYB4wkYY1B4Qvo8YM+LGvG/wS7KH0HgKJnMSKw=;
        b=SOxsbWfp0Jrq6JVOwO8mN4X7fm6q0HFudWzNcNf6N9umXgBu0fZlOZvMr5HHPyqxZ7
         raOjG+0hSEXxTKbsnJ43HS2iaoNsAljAtL/t/yRNCDoTBF6jftOxYzak91ro00o35eNZ
         c/8x6ZXORaAx6K9h064IVkqLhHO0aIRf25yW4p1QwUgMjjTvSlx68cJ2YhOCySkmKmWi
         eK1EbVHAW+e3aQNZo4W18pdpp5dkdX6B8vEwi/GWFkCUMYzUhoqbeUl3qGEmsVe0aTfX
         oc1wR7ym0/SCcmzscldul4u66MLDnMbzjEpVTqlreKtmjQ6eHAeKOGZQm15P63Tmqv7s
         JADg==
X-Forwarded-Encrypted: i=1; AJvYcCWREbDaVdvrfp+tLL7TNDAvQjbDy2cmbXzrmT29nARC013avhVJQKjcs5Rp+qnDEWmfN7WYGgN7Xpm4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/NTwRiPwFw0RaMZyy7GiAEa5wzoMCIUfItToU7/hX+7PWNAm0
	7hRvDuAe17f+uXWrCIIzS6jcGmIHA3o5g/zH1kL693aqEkzuSfRw+Rh9p2zjiPJbDEE=
X-Gm-Gg: ATEYQzwGbkf9lnU4+eWKU5K5xJpjlk8Gbbj3PZZ/0RWVObviOyDu+dtXMEOR3Ua6WWL
	iY09xHj+em3rIOiCoZi2OdicIjwnp2gfSlXPJgJl1zJ3aa10Ff6hZU7rMFWBr0p+//zPfu7i0uw
	il67Hu19x0F7O1w1K6slguvbt1NDGL3ftri+wVbWwdcWzYCp0YSRRxLZDGd7MJEYXE/vvmvQziD
	Xvy5nICsXu+TUKRWuttm5DjbFTmdaL1rMDJPsczBpK1IkPQHxwOta6wlsATn+FfH+wSDeSWc+Ge
	x64YWzlCQe5McTpfFDkSfV/Hbn+y82NplYd203H8d/ALYPwxM5pcExGjZqM7oBzCjUp/d6brABp
	TnpPQGwf4dXM5NtUmmCif+o3oaOxJpuRSze/MnNMbe3Tyh78Sd86MENA75bXhoCc5jgs06uue51
	OeA5reZYlbZ6exPpGO9iBn0SxjWM4ap7U9TpztZRZxCXYcr2JKoTcUSS+QDH26BqUguy3W0A==
X-Received: by 2002:a05:620a:2991:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8d01c689577mr1767721685a.32.1774909592771;
        Mon, 30 Mar 2026 15:26:32 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028090f43sm711572985a.45.2026.03.30.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:26:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7L43-00000005H5o-0vBI;
	Mon, 30 Mar 2026 19:26:31 -0300
Date: Mon, 30 Mar 2026 19:26:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michal Kalderon <mkalderon@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 1/3] PCI: AtomicOps: Do not enable requests by RCiEPs
Message-ID: <20260330222631.GF246076@ziepe.ca>
References: <20260330-fix_pciatops-v7-1-f601818417e8@linux.ibm.com>
 <20260330214253.GA92498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330214253.GA92498@bhelgaas>

On Mon, Mar 30, 2026 at 04:42:53PM -0500, Bjorn Helgaas wrote:
> [+to amdgpu, bnxe_re, mlx5 IB, qedr, mlx5 maintainers]
> 
> On Mon, Mar 30, 2026 at 03:09:44PM +0200, Gerd Bayer wrote:
> > Since root complex integrated end points (RCiEPs) attach to a bus that
> > has no bridge device describing the root port, the capability to
> > complete AtomicOps requests cannot be determined with PCIe methods.
> > 
> > Change default of pci_enable_atomic_ops_to_root() to not enable
> > AtomicOps requests on RCiEPs.
> 
> I know I suggested this because there's nothing explicit that tells us
> whether the RC supports atomic ops from RCiEPs [1].  But I'm concerned
> that GPUs, infiniband HCAs, and NICs that use atomic ops may be
> implemented as RCiEPs and would be broken by this.

AFAIK none of the NICs are integrated into root complexes in their
topology model..

Jason
