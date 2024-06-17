Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0118FDD3
	for <linux-s390@vger.kernel.org>; Mon, 17 Jun 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610955; cv=none; b=EVZ09y0V+K8Pxa7fXzpa0YVqeKTmqG70rYpGkgn6wcBfApdjh8490gNttnSuMBOj6fQlPBhRX78WLj+m1YNdRGyslXlS3y4d3yMgMDLJ3OzpmgvBG7XCI1T4mzczx42fvWoGi1LAPsXfOuaKP/Uw26DEShl74y5eRjnYPjh10qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610955; c=relaxed/simple;
	bh=JhFXSTpTbZnynjs4GWaWiZ25aqQJvGOYbY3MGHI2j0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccskw7stQ/SPzznDsXWt4KST8pf2wVO6uWs9edt2HFlReVAjPysjYKZVKF3JAtZHReyWTTp8hAd1CqgNjwT/zgN6YLKge9frMi2qzcrSVMVwWIrs61iOmcf4mgYt6f9YMjineZrnObQUWuNpxHWtCZUrD9VUrsFVG84dVwiNV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=PRV+DM6j; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PRV+DM6j"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4421c014b95so20836151cf.0
        for <linux-s390@vger.kernel.org>; Mon, 17 Jun 2024 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718610952; x=1719215752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6I7HjTVD0FYGpGJyzdWr9lYyHGbtAeqv6wNa85E5Tlk=;
        b=PRV+DM6jEikbSJU+DC5oCjO9958pbLBhKoPEJFulkR6ypvkc5V6majzBGPX6ggfkHc
         JiqGZGqqKzIJrQBdH4mNGx2m9AOdeXg5HpVebQwqGi7bQt2+J4qCU0N99ekRoZdJzQu+
         7nJ/4+iQ7Gvdt/6F6LxjcFTJZ65VNeGv/HMbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718610952; x=1719215752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I7HjTVD0FYGpGJyzdWr9lYyHGbtAeqv6wNa85E5Tlk=;
        b=vRS1jM9tkpol0LoNcijUWdiYJJKhLb6a424SRtWONLTC6AtrUSJHAmcp390RknSNtW
         r3XYnI4yYsSTz8wenBXKmm4F1qkvKvv+yaurl0T4zaw2/nMq69o8vMeMGjMNMPItK9TJ
         ATEqoWMXX5+9uVQX4Jv6UQSWFvQwvnKIL6612AXryZPWgHBfNnPz2X5L3VdLyFvi0g+n
         U4dMPKmOWK6drEE5ViJTGh/tri6nEwh25WVJFRR8VtZjk7RcqcF8aVp4JulEE8wWYyiM
         lh1rKqkCw6xbzx/4lR7UR80kkexppsPgyAmMlNodojAoKnoxEVc7R7fyHGbBfDFVfvPO
         CsQg==
X-Forwarded-Encrypted: i=1; AJvYcCXn5GjYm0rjLnYViJsPt8RDQ9ktssHfu/9s6Rte7aYV8iXfI65Ec5cBoh55ef/qlOAsKhTcu/fR8s8Pr9JQZOr0F3RI5nzwkvlqUQ==
X-Gm-Message-State: AOJu0YyShnxF1QXl+OyLBHlNMwzyjoK/g53F8ISlGOyQJqvZF0dvsSng
	fx83zVIauPuN/fcuOoGOcLgOX30WWek6f8CUDTIqIegebze2A8VtrhzwKrD90tA=
X-Google-Smtp-Source: AGHT+IFxBb+fxu+zFP9/mPYH5nZSCdE6S/NGqQ55TdkfvSsNQ6okiuS1Itv2iysUUW0wZGmJIGDYbg==
X-Received: by 2002:ac8:5e11:0:b0:440:10be:3ecf with SMTP id d75a77b69052e-4417ac402c0mr199666251cf.22.1718610952095;
        Mon, 17 Jun 2024 00:55:52 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4eefaesm44094171cf.21.2024.06.17.00.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 00:55:51 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:55:48 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
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
Subject: Re: [PATCH 01/26] xen-blkfront: don't disable cache flushes when
 they fail
Message-ID: <Zm_sBInagtSkOZtg@macbook>
References: <20240617060532.127975-1-hch@lst.de>
 <20240617060532.127975-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617060532.127975-2-hch@lst.de>

On Mon, Jun 17, 2024 at 08:04:28AM +0200, Christoph Hellwig wrote:
> blkfront always had a robust negotiation protocol for detecting a write
> cache.  Stop simply disabling cache flushes in the block layer as the
> flags handling is moving to the atomic queue limits API that needs
> user context to freeze the queue for that.  Instead handle the case
> of the feature flags cleared inside of blkfront.  This removes old
> debug code to check for such a mismatch which was previously impossible
> to hit, including the check for passthrough requests that blkfront
> never used to start with.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
