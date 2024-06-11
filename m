Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C758ADD
	for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124660; cv=none; b=GfiiYF9BzQGd7Q5noLh9IeJ9UP9ARE3lDqDxTYLaKDoA7Wrra8kADHnzU4S9ww00iGLEV0XYhJcLxxUmlxavnx3Q1qUr72GRJA+1TFMixVD8zMlnWh9VzvX7KnIZNg7vuEYHmDWI94wqazWCL2G1vsZ4mejf1sGN3ErtpYXvVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124660; c=relaxed/simple;
	bh=2FT/emrK48iE3dx07WXN0ST/iq8T21acuyaCQMRLCLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8Zv5CwySfiWAbVp1jyL56B2PcXchJyu0qW3eBDtz5BjpwBsFJMJFDt6OI1HU8+NpS2b59B/x2fXbpRw+B5PLP8RDflJp4qPgsIiZkqFxW8c+bSM8bpAFpD+nkzG7JX5EizLYyru1T1P4nqMoy0KnA/1E0dcuLh55dRG3jHyuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Zt6ibg/s; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Zt6ibg/s"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfa727cde2dso6227390276.0
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2024 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718124657; x=1718729457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7qH/Egkqtc5OmSCKcG8suDn1pwScsKWRQ+gioBgKgY=;
        b=Zt6ibg/sXDFPcB1PdqLbi9y9Lq84fI4dtsabAaKnS71DR4ge4yMuB1Z9lS7wA4wHrn
         shpAYklqhBt+02fv/lI70+9yLugOwkE6jd95eVKnaVgZYxsTh2WCsmHTgQ1UVgNRVLal
         wmO5N6RWxwgoiytstIBOrWyQFGmt3N38VbBAgwcFn/bnZiw+iwyuahz+8bpIWwoYMk5k
         XMp/oVXEeglCEkIcBUpukavQm3svwzpoI5LogCeDIIPsZ/TBEY3fH93kounsMrkvv0iU
         qwThWU60dMvFW8JzcIe4TZiEEXk0LdCstA848HdLhK4LdxhwQLIYyB46hHTq4v902MUD
         ZUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124657; x=1718729457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7qH/Egkqtc5OmSCKcG8suDn1pwScsKWRQ+gioBgKgY=;
        b=R9CFYwsGpisc4xIACWH/4BOOoeGbL9DdL/KtdalEe3P+s8WEb3kBq8tYVtRSSFyBv7
         jJ8ggmKNuaVzS2bG3bQiR9DvWoUYiOJB6Yc5K3nA9MLtMz3NdD59pnh0Wa/kQv531SVW
         C1IcCZnig5X8tdxLx0qwlcKW/4mPAyOQykVWG+jRgTsnjVNaHn2DcAtC0+bVxMdZgugh
         gW7hFkjiwWTW1Q6jjjcpT7IGMkPiq0zLfAhiG+yvdLpfbrrAk58yRLCPneGwqHDXz63W
         g/stKfxisiA2pu7u6sNKRHbvSUqdDxZlLwR7wpplHm/nNZMMU6XYdpW5z9gGnSLf9i1D
         kWDw==
X-Forwarded-Encrypted: i=1; AJvYcCWECIKc+SNdLcsyr+uq0j/B7ZB/jvEJqv3nwfodWIrf7apex5u6OFck7zR4DRr5OkoJSm6yLZTVHxOAsBhtSqKBfxGUXrLGBM5vdw==
X-Gm-Message-State: AOJu0YzCEz93YO/1h7PffjSS0Xwvg+O8y4WYwxTFl8AQWReLew5fdcuF
	7n14iwiszE+tYbljDEnb1y7AXA7r2yMl+NnKMjmhkEAHPqcCpQFLIkve1nkdQh0=
X-Google-Smtp-Source: AGHT+IFLbNcRGoXteJvsvQz9ePKtTqtffGprFSIVvQoC+S7q0aJ0DFFhhqHjAFy+KyUVXYjD8ktBew==
X-Received: by 2002:a0d:d851:0:b0:618:95a3:70b9 with SMTP id 00721157ae682-62cd565129cmr130634777b3.36.1718124656832;
        Tue, 11 Jun 2024 09:50:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccaef2825sm20935207b3.139.2024.06.11.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:50:56 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:50:55 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/26] nbd: move setting the cache control flags to
 __nbd_set_size
Message-ID: <20240611165055.GD247672@perftesting>
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611051929.513387-10-hch@lst.de>

On Tue, Jun 11, 2024 at 07:19:09AM +0200, Christoph Hellwig wrote:
> Move setting the cache control flags in nbd in preparation for moving
> these flags into the queue_limits structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
