Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59415153819
	for <linux-s390@vger.kernel.org>; Mon, 22 Apr 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807789; cv=none; b=bWYBPvMN4NOigVR/k6hvtbQ0YiynI8VCvb0vvT/lwzSZi1adKHTz8fEe3wel1ikm3IZH8Yoj3S03CmAhfAql6unlqo3IvzgDQlSvfXRTRs0+eMGoOkq6XHcKqnva866xwv3rJJ//C2jjnuvEmpMGp1KWTWb7SjQYp/apbuKOWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807789; c=relaxed/simple;
	bh=FPRYflSYPTzX630Jd0+hB1WOM3PbajZTXlGiVPiZLwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7FvJCJllsVmFEeTcHkMG6hfBkZnYqUE80zlHcbyDRoP1TldQuyoGkkDPc4nBkIST20Ushfpk+NQbNFNfJU0CNhHTxdXaHp8ue7cWmjx7zY+H/ZpJJKGsq5cz2b0Iy3QvqptJgfrXZzlXijRK2yGGIFANOw8v1UGW/JQFh7Kzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DUQwm9ry; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DUQwm9ry"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78f0593f45dso334556885a.2
        for <linux-s390@vger.kernel.org>; Mon, 22 Apr 2024 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713807786; x=1714412586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/KOCqovdO5PsKSs9PxME/OsGBVBN8Xn1TisHFdx68w=;
        b=DUQwm9ryLZY0bh3kXfAbzC7p/jLS0DsNSzp0F6Xrso2bUIDG0KSP//+N1wUGLLwnfx
         x5Qe4eJV2BgMp/R7vpPijfIwOPPtfj1HTPk/jdKeAWj//gzi+dCOUviK/CqxPfQ3C5Lg
         RYB6ViVzk8WuAba5UjVxgYzdG6YCEWDyD/tGp775u5jVOxuKOx/Dy7yVxqKmfa+2IDfq
         OEtQ9VW0TXKEsb3ehsczY/VJ043vTpmetD2J8YrbdX/IHQKBteoueg3F80KCzkxvJr6J
         03d2weegRHQPRaX0ZuP5D+hZrLXplxdixVqqUU7YtRvsyvZa+1PAYNJR/Tsej6o+vMUh
         zOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713807786; x=1714412586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/KOCqovdO5PsKSs9PxME/OsGBVBN8Xn1TisHFdx68w=;
        b=tI51lAyn2Cm88pXy2UOwyjCNL25XbdgXXgy5JME1Z3rjjTq2Fh+KtyY/tkzblA4QaW
         wo85dymZn+KEdRUxTQRq+CasvPKj0znkKkePKXjRVZKyv9V+rjojJ9m772JmSlRT8xXI
         h6PlBlHQIF5B5Dxj73XuQq00nJz/pwnPS+QFHLcNAjNwxQLOpc9wqLOkYC6QPhcoucVc
         JkdlAXlPS2iaOH15EyUKkeIJifVBIzY/uV46OfP+7sCBR0WMOyQ7cHIZjpuAoWtMpSNq
         gAt8v7drmRpaqiANVn7AZfaK7IdoLkvelzWSpFvKocZLtYja6IR7l+BzK4RkOGDfpbaH
         3oPg==
X-Forwarded-Encrypted: i=1; AJvYcCWLml4YYdyZ+Xv0fpvEyDojRXT1U8TnxUZNa5Z4/IxffsJ/ZsDgwd5JlF+sCta8cF66QvL/HYnHo8bWqDL3qlT5qz6vHvVz96Uh+Q==
X-Gm-Message-State: AOJu0Yxf0awT3EWcRu/i2Y+3HkIHep78RHxMJgtr4VdKN1wT0E7QlU8S
	yHr208nyN24vM5DQZqwgyM6wchgbKRv8lQOHHHmG7BhgeQTWUFd5FvY0CAzeHRw=
X-Google-Smtp-Source: AGHT+IGHiFa58Cxg/cz+5GibMHdsBS0/TvPvketvKNLRvd4ffYu0hhtDDfBaJpWtYAmFnVmikIfyBA==
X-Received: by 2002:a0c:f8c9:0:b0:6a0:5e9a:a9a4 with SMTP id h9-20020a0cf8c9000000b006a05e9aa9a4mr12406744qvo.7.1713807786099;
        Mon, 22 Apr 2024 10:43:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id x1-20020a0c8e81000000b0069b40c06b11sm4430054qvb.105.2024.04.22.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 10:43:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ryxh3-000ykz-20;
	Mon, 22 Apr 2024 14:43:05 -0300
Date: Mon, 22 Apr 2024 14:43:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Ben Segal <bpsegal@us.ibm.com>
Subject: Re: [PATCH v2] vfio/pci: Support 8-byte PCI loads and stores
Message-ID: <20240422174305.GB231144@ziepe.ca>
References: <20240422153508.2355844-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422153508.2355844-1-gbayer@linux.ibm.com>

On Mon, Apr 22, 2024 at 05:35:08PM +0200, Gerd Bayer wrote:
> From: Ben Segal <bpsegal@us.ibm.com>
> 
> Many PCI adapters can benefit or even require full 64bit read
> and write access to their registers. In order to enable work on
> user-space drivers for these devices add two new variations
> vfio_pci_core_io{read|write}64 of the existing access methods
> when the architecture supports 64-bit ioreads and iowrites.
> 
> Since these access methods are instantiated on 64bit architectures,
> only, their use in vfio_pci_core_do_io_rw() is restricted by conditional
> compiles to these architectures.
> 
> Signed-off-by: Ben Segal <bpsegal@us.ibm.com>
> Co-developed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> Hi all,
> 
> we've successfully used this patch with a user-mode driver for a PCI
> device that requires 64bit register read/writes on s390. A quick grep
> showed that there are several other drivers for PCI devices in the kernel
> that use readq/writeq and eventually could use this, too.
> So we decided to propose this for general inclusion.
> 
> Thank you,
> Gerd Bayer
> 
> Changes v1 -> v2:
> - On non 64bit architecture use at most 32bit accesses in
>   vfio_pci_core_do_io_rw and describe that in the commit message.
> - Drop the run-time error on 32bit architectures.
> - The #endif splitting the "else if" is not really fortunate, but I'm
>   open to suggestions.

Provide a iowrite64() that does back to back writes for 32 bit?

Jason
