Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EA2E7F0D
	for <linux-s390@vger.kernel.org>; Tue,  7 Oct 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854079; cv=none; b=G6gOAP2u50eC8XUl9kxGCOwq9m6BJCBRxhCG9pahv/S56M2/oLvCQ7HKRsMOWCuXV71kBtm8Ps9asrsy4g6ByXhJnZD+J2Yiz1oJxajeYy2lUXVGIdymWom1nzUN8i3rW7FBOCN6vM3uMRIaXjQvGebjxB+vvBiVAuILS5Vt26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854079; c=relaxed/simple;
	bh=rUj4e7mW96AJXx7tHHanond6R8M9cTYxkixXGkn/ZsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF1+vNIOBniWZVn2RqxUtUfoinrF8udxQ0j2o21mobyVfKdF28joW0g5rIhrs+estmgRKW3Dg1q1h6O8j2VTlfKmKT9BuCoem2spd8mK43JQq0VRRWflqWXZMtuuJKCX+t7GTR93eamFJ4KGjQYt0LjZ/BvUD4OJZR/sWB1pbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gYtJcW2m; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gYtJcW2m"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-854585036e8so668617485a.1
        for <linux-s390@vger.kernel.org>; Tue, 07 Oct 2025 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759854073; x=1760458873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nG7dBmqQ7oC7V9KJ7eaX85jqj65+GaLqPAyJt86l2UE=;
        b=gYtJcW2mx3N37KZa7zBTQNLno+q9ti46KzWNXwNLcmj90jHk6WIDmBEELERQGJ/Dk8
         e1Xtf6UFxXjkO92uGPc6l/1u/NJlK7sQbWwxhnhBFSGXz1hhR9mQEovkfGufJq8FyBn2
         BCuRF+gLqLEruO8xKMBJuwe9jEblze6wr8szxPK7lX33G3OOL6+KIeozdfUGULYJnGtI
         fI+F6Au4dpfa0KfKUaVhjFegApmp+V4k8L4j85J3UVtmyokprrsjl0mh1vh1vgE0VKQC
         fYFt6MIicyOm3vqpT28dl6xP69UiHpHADpOrdmIP85f9jwl0Fj6FGnvEGLxqB4U4kOUO
         GcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759854073; x=1760458873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG7dBmqQ7oC7V9KJ7eaX85jqj65+GaLqPAyJt86l2UE=;
        b=E7lgFbhCiW5TBIRlJZyDt9MAEuTQj+5H6Yfh1mlk70SP73aSuXPjSHOjJZuYygbMXu
         QA8FTM/rJ1Frh4/SII/bhI1ObTL/r4CFZAlFYi49sq2Jjs/xfpqq2dD4oScypKLSnPOd
         PimScU5qEZjS3uh6dfrPtQBmCuHPVMregdMflMG+eh3WhJKYxhzm69xHiGbJLbq15C14
         uf+1wRoyZeOKoW9II+mxJHWcZ6yVZSkWjgi+uqM2lQ88QMSZSKekNS+DZx6k5AAR4Nhq
         OTweT1iyQuP/31OsnZnhFeiW+4lC2i3EBnvuYJOekxU1pPS3ukR9ZlxlWdJJ+y3aIgEO
         iFtA==
X-Forwarded-Encrypted: i=1; AJvYcCUmPAqHfmNHFSfQKj+YCEFins+wOlwYmWOGKuoncNUPbz+Ks7NY8tqSCAgfEQTkz6az4XESSyXMZysS@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+pE5XTqcBt7wK8OWr2NJ7OFNJ29hJHn0BVKkxYknY/sMDnFA
	TYx34s0IKeUOiz1VGAbj6kevbFtu1C5QcRgHCp6v4I1zOAnNdRSnfWM/eUdl2ZAY2kA=
X-Gm-Gg: ASbGncv6NP6cn8xO9Xp23GhZ3RPtZ26+llD7lGEIMSegiKQBNtp6/Ikp0B5tcjSf5QF
	Nkd0xq3+SLG4qMYuxMG7Y2KRi8Em/8IFN6PufNHFO74T1T+2p2+o/ghKN+u+RUOlWM94oKYMUjH
	xQGLqzVfL/ij8d1jJrSsLG/HKSQ3HBOfRaCKQbYEkl8C8PgNzZbno4oCNif6IZborGoQ0XZR3my
	w3C5IixW4vh7cH7gQBFqQwWFHRQhw/KqRD1m3quBENlkwNaJ3OGbCFlbo5T9U2ZG/AVkkYOqX9X
	pMQg4kvqASG8tRcEi6b//r0igFWkPQWZQGftDQG32uhDDWp8VlgzxD3ySH9PkPdwHnR97X7sIde
	dtOIE0lEvQV93h9bjqVeIgrS1BY+miRekvTsk6SEbIQQ0bKSsYvfD9wq2llAp1e1q3mooDdHXiM
	dA/gubixn6/rjbRmoF
X-Google-Smtp-Source: AGHT+IGIL2y2zEPuHipwkl4TUjLIYPddwo9T+ngD6WTBuoJAHtLmSJLiAwgUmeLquPIwJcA51YE2Rw==
X-Received: by 2002:a05:620a:7085:b0:858:f75a:c922 with SMTP id af79cd13be357-883502b7b36mr60557285a.6.1759854072907;
        Tue, 07 Oct 2025 09:21:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777a7e02e7sm1561434385a.62.2025.10.07.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:21:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v6AR5-0000000Feae-1YWw;
	Tue, 07 Oct 2025 13:21:11 -0300
Date: Tue, 7 Oct 2025 13:21:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Shay Drori <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Vesker <valex@mellanox.com>,
	Feras Daoud <ferasda@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5: Avoid deadlock between PCI error
 recovery and health reporter
Message-ID: <20251007162111.GA3604844@ziepe.ca>
References: <20251007144826.2825134-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007144826.2825134-1-gbayer@linux.ibm.com>

On Tue, Oct 07, 2025 at 04:48:26PM +0200, Gerd Bayer wrote:
> - task: kmcheck
>   mlx5_unload_one() tries to acquire devlink lock while the PCI error
>   recovery code has set pdev->block_cfg_access by way of
>   pci_cfg_access_lock()

This seems wrong, arch code shouldn't invoke the driver's error
handler while hodling pci_dev_lock().

Or at least if we do want to do this the locking should be documented
and some lockdep map should be added to pci_cfg_access_lock() and the
normal AER path..

Jason
