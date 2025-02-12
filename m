Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5F1F8BCA
	for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2025 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388942; cv=none; b=lv/A8p0206BeH/HbshFIJmamtM9aZpAEZA3ASRp+HksTBuS9Twf9G7BxgXaxfX6I7hqX7rcrd1QQCVFidigsIZOhJndoUiJdQQOs9xXW6kVkG9x081YzU65XoBvB8SzJMLReQuH4RkE2XFUOn5lCGFbVuwHSt54BCx4/wHID3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388942; c=relaxed/simple;
	bh=vmAvWbsGdYNKRmni5mBBWvqq4sSKlumOWOmZ0JYXLzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0zXE5MFoTkBQgR/CaQ0sdoDzuW67B3uJVNJj7/GcOiLt1jd6yIEuQfZ83vL4yZNfE8EMR/92qMfRbA1Si+ALhGE4l8dYm0OlYkz381OOTzf13l0kilCEcVHFZghA8wvZmUL7edjTrWVIzhJ4GJax3TLrSvYLNr/kdN+dOTQ5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XG2Gk+9G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XG2Gk+9G"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f49837d36so345195ad.3
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2025 11:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739388940; x=1739993740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gM8cfuxuqg3cm9VTQK30nhz59V/mbnlWePA/01igcE=;
        b=XG2Gk+9GoSkTYjSUzDPl+TKQmAoOdcpgWRmB3LUILlgocLW3+QjsDjAs16PBgwAQAi
         ONP1OBnGPRwgEal+YDj1ZfzhgkPc7JKAy+EPnZQ/qE/yaTHWHbi0wcq/fHH3Lj16NR3w
         WHgfYPkXJgEA20ng0vbQRvwNaxEp3fhuoBpZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388940; x=1739993740;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gM8cfuxuqg3cm9VTQK30nhz59V/mbnlWePA/01igcE=;
        b=ZjZbuzJqjmSOZJ5mABobKwxkcfF2rjtra3uNr3iAF+7NtmNxLYGaSemHH6HA30xlsv
         78u+m5rwcU5GrlUg8zuV4J6tMJvcdJtQb1iMCi+bFBLa3S78VhQ36/See5BQecqOHbdQ
         MyZ4E6Xlmo2ADFCwVQ6CbBXt37wTTraMB9P4Bzv58uRJzbwHdEnA3wWKXx7vk7XFdR3c
         dwg/JO1iVqv6MB+vv6SoL6uImRbEVm3flu3ZMLHd2f2CTcGLZSfpgRpdpQ6s0sBpWN7m
         VhKwRmHFrybIeQQ2uUF05Wim1Na9bqwu8pvLNqwrTx8wgh0N5d7OoMPSXLcgWajoMwF+
         lRTw==
X-Forwarded-Encrypted: i=1; AJvYcCWTbchcw4gp0HQIv/IbehzAa+CohoqwW+1G/I3ZAGYsrBwZtn68ob+ezh1joHQR1elutTB1mWaFlnS/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzau0N4kwhx89FDX4tTJgaL/4et1Y5HA01sJaZTjEc48PauJhmT
	/3dCTS/zNq1Kfff/GROAuFYYZI+CbLOvn2mWWHQ1cj8NFuiZVuqTj797TglBoIPRM4coBy2Ayv6
	o
X-Gm-Gg: ASbGncszzeYHcD/PAbAr3vP5ZPC4YHxHqHqjvBGvXKGzML6IfkYHu9qVfw3Yv91OQY1
	LbQTn2uZRs7uNXV6JYicBRKoYfsguKVhc2b7qLszQBxBZhAHeBpB/dBxePDUnwo3g5OspEKntbU
	t4vlOuulCjXpYI+pzNbZyAlVVrf7U/F9icIPRAqouQI3peJyBsChYn9vafnxD1J+tFUAP9U79Hh
	I1R8htlVu7NyzlJpNh7Ih8AXRcupRB4lSKqsZm4u14ebVNJS+rgpcr9sVLHTJtXYjPfH4umYBo3
	fYwXP71zFJjhNz8hqTFiig3iZ9dnLQBmtLx6++oj9oh9jd41qHNQEWh6SQ==
X-Google-Smtp-Source: AGHT+IEg+ioBMU+Ca/G1OAdLCJnP2ms61SibWzHwbJn0apwKLa2R4j3/nJXUxKb9+FoRp0a41HzDeg==
X-Received: by 2002:a17:902:ecd1:b0:215:9470:7e82 with SMTP id d9443c01a7336-220d1ea097emr9340915ad.4.1739388939724;
        Wed, 12 Feb 2025 11:35:39 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220cd96ae5asm3486845ad.247.2025.02.12.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:35:39 -0800 (PST)
Date: Wed, 12 Feb 2025 11:35:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net] s390/qeth: move netif_napi_add_tx() and
 napi_enable() from under BH
Message-ID: <Z6z4CMhLo0aj5YEN@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20250212163659.2287292-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212163659.2287292-1-wintera@linux.ibm.com>

On Wed, Feb 12, 2025 at 05:36:59PM +0100, Alexandra Winter wrote:
> Like other drivers qeth is calling local_bh_enable() after napi_schedule()
> to kick-start softirqs [0].
> Since netif_napi_add_tx() and napi_enable() now take the netdev_lock()
> mutex [1], move them out from under the BH protection. Same solution as in
> commit a60558644e20 ("wifi: mt76: move napi_enable() from under BH")
> 
> Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")

Hm, I wonder if the fixes should be for commit 413f0271f396 ("net:
protect NAPI enablement with netdev_lock()") instead ?

> Link: https://lore.kernel.org/netdev/20240612181900.4d9d18d0@kernel.org/ [0]
> Link: https://lore.kernel.org/netdev/20250115035319.559603-1-kuba@kernel.org/ [1]
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Other than the above, I briefly scanned the driver source and the
change seems reasonable.

I am not sure whether a different Fixes is needed or not (I'll leave
that to the maintainers to decide), but whether this is fine as is
or is re-posted with a new Fixes tag:

Acked-by: Joe Damato <jdamato@fastly.com>
