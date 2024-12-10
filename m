Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3BC1AAA09
	for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839107; cv=none; b=Vnv03XFwvI8URHfOQ5Gi48pL1vXlQZ8NhQhDacltydnPoPFr4PXMFvI82oR/vmoZiG432lPyLC5gsIq52pz8dCV9b5cSzkQSIgNwF6VmYh8c0hzWrmpimBLeKlk4BgVgG27SPiCsxELIvqzD4C4lJ/DUVZHhjkMTOKyMgHoPTS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839107; c=relaxed/simple;
	bh=Wus6PTVVywKwLtxZ0EhZyXK0M1Oufs2XnqpD+8KgydU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2dLhOHfN08KG9y50U0DmPYhk/mWVaWZc0dL8AeF7xsbJDPWgAZuqkvXLLlQwyhHqYVHJlw2fNpG6Gre7S4fDpwtVFqbuoVo6oYqw3+n8W6hVsYarEgIzaafVlOodMCVUFyVtaHo04Tt/3Nwp7N6DncDWzGV4s3GVa/YvpNkDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BCNxEF3M; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BCNxEF3M"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b678da9310so486418985a.2
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 05:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733839104; x=1734443904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPnoeJGC4S/+isJNT4aLkrLE+MbFACDHEAIE5X2EVic=;
        b=BCNxEF3M72Cr1/GhG9QWaEpnCg4GdG25ekoIXvawtohpZ2u+gEreHJWMCjPi4duk5f
         3fa019qhyrkxqRS/SQQXg7ysWA1v5GUU30FjHw5XzjsWRquTt0H7ZVilMruuC1Ump7ou
         tz2ahMTh2tMbyaU3/uWcNbDCfRMGWGwgHIs88s3877gVavLarCs459rS/9gwnFjRt31O
         x+WtWTe7/HPONip90Uy70SZZ6pAzgXu7bT+N3LsqsQGBh573BT8Sts4fQh57N6iMGEC3
         KXShjFpugPgBgtt1dsF/sTi8qnOptYN0KKh0uPZo32GVK44nxZloUvvxPytw2ZYjjc9b
         29OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839104; x=1734443904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPnoeJGC4S/+isJNT4aLkrLE+MbFACDHEAIE5X2EVic=;
        b=u3X2/N10GEre3wxkBulGEwxcaehjn096bmvFFmXN3oEJoaiGF9moixuDPy55QTIuhI
         yP0qr1LoxR1fVMZlplhXw2FG6K85C6Y/B4DYKcgdg2q99qei8ovRTw7zOjRjd8KJe/Gf
         nhRN3FGzqhG0cxjcf5XE8vaREAKDz0KqccCk8kO/BTgsCYcVzmsiA3NmnG4o8B2bLXs7
         VhSjL91oRPyjWl749ww/2bcu2vpwceZTlPYEmuXyUGRjQc/H0VwgMQnolJItpzbQP8hJ
         qjxqCz7L0ysJoxnCfmLMHno2hKsr9e3aqUmTCdyaHTSb61LuVNEqSic495u56Q26Iu06
         RCBg==
X-Forwarded-Encrypted: i=1; AJvYcCXCZMPDWBE36TfnXurBSMjtZag4fStiLglTkmn967+IIjRMTHIn4tZ4TxJOCaku7q3yD83LSMXgcHhP@vger.kernel.org
X-Gm-Message-State: AOJu0YwQzECPBUEtkFQvOO3s8uXzlFStTq7JQ8/XPuIsNTfG9U6f+aIl
	vr93jhOiW4QDrV2JqlhN7DSnzXqIdcZHrPkLvBGMzAiaOGlvMwwFyGfh0malFIY=
X-Gm-Gg: ASbGnctwr1Bu5/YGFbVyC4KVvU/LxkUf2K2CR8/dhimTwDFPvRC5v/Z9mmlz8xyaEVg
	3KqkD0mQDor/nck8eRdlXClfzFpLC1dfgmxwNwPL/W5Gwp7YGg6QkK085620KfOwEICajV5qU5Q
	rCpKcuRwLDq7MVW2ufohkAObD92nG0xa3Zrxn3By8wSf/iOo9k6sGyMHzArxerHdxwkKp5v2GwI
	QGpFFFsDsWkRQzFbE2b5tbGmfEubpfOtUCUPb0xbDaHXgUOHyMSuG4LKfeohkemrNMi4p/lw+5i
	SYtBFW+CxC91o3zeL+wU6xl0Dcc=
X-Google-Smtp-Source: AGHT+IHCnaEPp4CpRU8sWpIALCYJ9lPsx/4FMzmUmHystykqZf/cdX7zqBlHRWE8kGoyRP25rAtzdg==
X-Received: by 2002:a05:620a:1a1f:b0:7b6:cfa3:c685 with SMTP id af79cd13be357-7b6dce5aa7emr703714685a.23.1733839104407;
        Tue, 10 Dec 2024 05:58:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8ef223d18sm45464336d6.99.2024.12.10.05.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:58:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tL0ko-0000000A2D4-440E;
	Tue, 10 Dec 2024 09:58:22 -0400
Date: Tue, 10 Dec 2024 09:58:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ramesh Thomas <ramesh.thomas@intel.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com,
	gbayer@linux.ibm.com, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, ankita@nvidia.com, yishaih@nvidia.com,
	pasic@linux.ibm.com, julianr@linux.ibm.com, bpsegal@us.ibm.com,
	kevin.tian@intel.com, cho@microsoft.com
Subject: Re: [PATCH v3 1/2] vfio/pci: Enable iowrite64 and ioread64 for vfio
 pci
Message-ID: <20241210135822.GE1888283@ziepe.ca>
References: <20241210131938.303500-1-ramesh.thomas@intel.com>
 <20241210131938.303500-2-ramesh.thomas@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210131938.303500-2-ramesh.thomas@intel.com>

On Tue, Dec 10, 2024 at 05:19:37AM -0800, Ramesh Thomas wrote:
> Definitions of ioread64 and iowrite64 macros in asm/io.h called by vfio
> pci implementations are enclosed inside check for CONFIG_GENERIC_IOMAP.
> They don't get defined if CONFIG_GENERIC_IOMAP is defined. Include
> linux/io-64-nonatomic-lo-hi.h to define iowrite64 and ioread64 macros
> when they are not defined. io-64-nonatomic-lo-hi.h maps the macros to
> generic implementation in lib/iomap.c. The generic implementation does
> 64 bit rw if readq/writeq is defined for the architecture, otherwise it
> would do 32 bit back to back rw.
> 
> Note that there are two versions of the generic implementation that
> differs in the order the 32 bit words are written if 64 bit support is
> not present. This is not the little/big endian ordering, which is
> handled separately. This patch uses the lo followed by hi word ordering
> which is consistent with current back to back implementation in the
> vfio/pci code.
> 
> Signed-off-by: Ramesh Thomas <ramesh.thomas@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_rdwr.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
