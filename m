Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C6B2F2B
	for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430017; cv=none; b=YIqIg2iFBq5fsFzw24UlIWe6FGwZY7VSv6GqrAQdOGZOo7eAQRR/rblFkpuKN2BzokC0hvsFnky3rMThPGkLKVRdrORTHKGE98a5o69c3BNn5DBb2hxJ8qCgF7LsLnaafEwS26+S+0rHwOJrwQ2s6L1WAYY0wu5sAmJ9fKa58zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430017; c=relaxed/simple;
	bh=rGUePLwxZnq/3D/u14H3DiEQUVLiciMj2KP0W0iiVNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvpArevBfx7kQW75NwTLHYWBB2kdFYUPJGMUMsdmVzsjaZWnffLfFda3Ijaz/NQqh3JrTziMk+XBLjE6Xm9DTK7lGL2he7IHMs41kF7uctZZSeziEbbKw2myvxGbL49agIxAUtfKs/8yoqVfQ32oQT96SpLruybcVAgrWR39UXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NuRRLRB8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NuRRLRB8"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43b0b09d012so4730381cf.3
        for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 15:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714430015; x=1715034815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i63enZKvq49yBuuGfO7A4K/q4kvBEE7D4Fuwwr20hHY=;
        b=NuRRLRB8R48KIMvE7yzPvKgK4ju19NrK3HMyaKx4FpJpThM6rIL/RSJ85WzfiBUnEC
         JZjczGNvIwJ5PFA+cHRJHLhM/bf6Ofa3IsRzWcYy8ZWjJAA/fTxSHaVFOCpJUKnzkhxm
         QHnRJ2HYVFwuIaFu11fy9XCisrMFa5V47TgIoHOyX7tcDzbSAhKlmrrbouc0rN/CEAIp
         joV3oyFZ0doMBR2EwFytK+g6hLm53bZit2NwAwg758ZcZL5m4tOkODVn1MOdbvHEkc4t
         7jOrDtZR8zVEHrSTK0JAqqKPY2FzrhlsP/Gy9AjwOglmx4Ku7AoxyJP8/4CqXC6X8V1C
         YMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714430015; x=1715034815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i63enZKvq49yBuuGfO7A4K/q4kvBEE7D4Fuwwr20hHY=;
        b=CsvZPQGdkNHrTLRjgd59O8F9gTvBt+bHrqGL9IpJpF4S5+z3AHSY2ntOz81mmM7Oro
         s3Qgas32iw0p7ctaFuIZZ9hpM2vKB30IcG5Bzq1bihSqrYj7wwMStTbWTSmhOHkFEwof
         ooOtF9Uw1hHr85M3kxV8yp30nshRKMvxghtx8xmKtNKM8OvmCQsabIJx53j3SQUtAYsM
         u+J9wSd9uCHHroit2k4RrewpO2onp1xjN52UVhZYw7plNMc5s11dZSQnLFJOO3Vn0e9J
         ZCW2ILTd7s15oQaonIH7nsX2MmZfAF7AK5pfrvmjQYtqIMO3yt4RkMdoLdumPK/7oQLR
         Txyg==
X-Forwarded-Encrypted: i=1; AJvYcCWw2mYYutWVYP5rOun5bYy4hy5BIxe+MFs9USlC6gB3I8M7XUzao38F6ZEqJQuHiC19iJXvgpLck3b6Q7tyZ1TMXdNoNBj1HF/T+A==
X-Gm-Message-State: AOJu0Yzc1Sk4TmvHGQkNccVdh8qTjhUMt5pPjX8xVwGCpzjgQNK0dzLR
	hM8iC6I5Xkn4L+Nd/e3i030IAehfRxDNuByKair5/wj+BZ/LKrA81kxF56qksSI=
X-Google-Smtp-Source: AGHT+IFbWPXi6Dp2uoYHr59JYATCzulrcKkzpQ5PDWB5JKsjtvjWnuYd390Ec3xwyOHs1mCH+idmbg==
X-Received: by 2002:a05:622a:311:b0:43a:abcd:c9bd with SMTP id q17-20020a05622a031100b0043aabcdc9bdmr9388548qtw.45.1714430014608;
        Mon, 29 Apr 2024 15:33:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id t25-20020ac87619000000b00437a6e5b3fdsm10521530qtq.66.2024.04.29.15.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:33:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1ZYz-003OoB-AX;
	Mon, 29 Apr 2024 19:33:33 -0300
Date: Mon, 29 Apr 2024 19:33:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] vfio/pci: Extract duplicated code into macro
Message-ID: <20240429223333.GS231144@ziepe.ca>
References: <20240425165604.899447-1-gbayer@linux.ibm.com>
 <20240425165604.899447-2-gbayer@linux.ibm.com>
 <20240429200910.GQ231144@ziepe.ca>
 <20240429161103.655b4010.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429161103.655b4010.alex.williamson@redhat.com>

On Mon, Apr 29, 2024 at 04:11:03PM -0600, Alex Williamson wrote:
> > This isn't very performance optimal already, we take a lock on every
> > iteration, so there isn't much point in inlining multiple copies of
> > everything to save an branch.
> 
> These macros are to reduce duplicate code blocks and the errors that
> typically come from such duplication, 

But there is still quite a bit of repetition here..

> as well as to provide type safe functions in the spirit of the
> ioread# and iowrite# helpers.

But it never really takes any advantage of type safety? It is making a
memcpy..

Jason
