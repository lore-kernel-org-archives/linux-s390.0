Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6722BE7DD
	for <linux-s390@vger.kernel.org>; Wed,  1 Oct 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314607; cv=none; b=Xgzlds8wDCI66+xwSE5ExyVRAUZZQ6yAUstSiveHdxGlTBmBn+3DUjg3100hMRjTCQV9mRUH/ksAKbedZ6Py6VKpp5BBacBU2jk+zwEDldfVAKWITMblGj7HWjP1fH6EIbJ3Xs0LjHf8dp+C5noEe1LIv5DIKxuxuxrivqPrKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314607; c=relaxed/simple;
	bh=lpcbaTnRUfRuUjlxvKbi7MippNxGb5EWhV7oCbjdFdE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNcXyo+moS/iA24HiT5uDzPr62h/jXBKPZ6n3fsu+Ejh6duam72fwscCePKE66dRmzXb8tv1/MUvTu29JvvDd5km+gw1dOAJCmVdS2aCfADOgi66Mm6213LRZYuusAb2jo4gR+KkE51raAQhs+Cocfy5eqn3TR4SKAhSSmjd8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN4oECF6; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN4oECF6"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33067909400so5366297a91.2
        for <linux-s390@vger.kernel.org>; Wed, 01 Oct 2025 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759314604; x=1759919404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fvvc2wJV4y/adOnS6TVe7Zorj1unil+xBTIrzA8bkw=;
        b=LN4oECF6HYqrTDe+J/1iFgvvBgpF+ylX/BvnGJ2gzWGqCOLBwZWzVdVZe4YDBcofmA
         WRGYXuZgjyGX4wJyaCo5qH9daAPc+L9Z+dZ0coRPFX88n5596085TpgMmfcSrQ1pr3Rs
         qG07v2FlTmy/4HxWEeme1eptGO9PgQ8Nay2iwYnvZkCGT3tkx3q09RPAibF/iUnJDh/f
         HrnFByyQmiinRkIQTG/Fdk2pxRRbHCBd1HnnJ5w6llR8z+uBoaMMa9xPQ3mpcXhdMtDx
         t9EWKjOEyjBE1uwIVJ3ayJz4Wy4TzVgev76WVQNCUfKGxwCRmivNXvrpXEVfypdWca1/
         9EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759314604; x=1759919404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Fvvc2wJV4y/adOnS6TVe7Zorj1unil+xBTIrzA8bkw=;
        b=Z7aiIKEQmC1ljiPB/uverLBYwxfVPprLGO9Hi3VjUwCpbHUJ1TKOpKBxjAsMDcsAG1
         +voc+PKrEHNaRnvB/CMnfUNq11SojHeZecyMxF86Ut9bbgg9uYUgYruiyQmKUcFZClm5
         leLIsThMq1J3tXiwOonSx4xcxcWbbVcYMgZWLgJ8uONMUi9YBMvMgZt6sHoqINOgAfgR
         9jNPhusao47SWGl4MfiK+MlHaiEGAQZpTiKU8lt4AGaJsymAZItnZybwKYIX49W+REMV
         LWbM4EhrvzhMfNyik9hLX37mQ+Cod5bDhCjK3KtfTDiEBG176t6lItMrlQQ+6p7yVNtX
         Z2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQj3Aw2LyS/YDVSt/cWKSQy1/hCQNLzhx6rvUxJ0lpVMargnSuXxyVEWolKiPi83MW0/B22F5lB4Ec@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNJIiGX9+0N9CT13wAJx4qHMjLN9IXUdLKpVIgrUpKtx9f0id
	irBg9MpQgzbGsxa3sdVzC2USdCfJyaFfC2VrEea/XXdqbo0lnXmwqYPK
X-Gm-Gg: ASbGncvJSCbCwwMEsm0AbE6nSOT4sfkTUdaTGdpTgr0X/Wz+vWdx473LYx3e4kRaGpA
	NeT7/ED70iMfPbxhTwvNUgnL86vc9n+FYOH1tRzYJyPfMls2JyIJsdPCo4LOOY8jj6x/NZpA/e2
	3h6VvnbuObSlk1V2dIVNVkzLZ5CKGLE/jsTko56F4HkdOcs0X59NGtr/y9Vg8s7g9jIJ0I3A73u
	IhR7gGi5eufB/TllhFTaU59K1nuF2gIwflLmkDvc968YFN8FmmdyqDKAFJpw/NYArJ1KSoTQtpR
	dEA9dg91fzt8zywAYIr+zQ2f31excOimqNN+jbP6q+b1Z55xyq3C1Hvfe7q2t0Dii0efyP1YaK+
	JHmpd4Fnh1/0LrwHGgBPVlcEWJM2bruw2GlyIeQkjRZRRri1SHw==
X-Google-Smtp-Source: AGHT+IGlOP08FechFri9XhBd09rOWOVrXywqRW8pZP7UrkJv21iqrkorW0M3GD4lm+V6u0a1W3KkFQ==
X-Received: by 2002:a17:90b:4d06:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-339a6ea3208mr2952898a91.9.1759314603841;
        Wed, 01 Oct 2025 03:30:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b608f0fe65esm643463a12.0.2025.10.01.03.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 03:30:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E93B544507EC; Wed, 01 Oct 2025 17:29:59 +0700 (WIB)
Date: Wed, 1 Oct 2025 17:29:59 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Halil Pasic <pasic@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <aN0Cpw7mTtLdnBMZ@archie.me>
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
 <20250929000001.1752206-2-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XTnKR8OXozLogMib"
Content-Disposition: inline
In-Reply-To: <20250929000001.1752206-2-pasic@linux.ibm.com>


--XTnKR8OXozLogMib
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 02:00:00AM +0200, Halil Pasic wrote:
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/netw=
orking/smc-sysctl.rst
> index a874d007f2db..5de4893ef3e7 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -71,3 +71,39 @@ smcr_max_conns_per_lgr - INTEGER
>  	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
> =20
>  	Default: 255
> +
> +smcr_max_send_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
        So-called
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can be a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the send path used to be hard coded to 16. With this contr=
ol
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physical=
ly
> +	continuous array in which each element is a single buffer and has the s=
ize
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 16
> +
> +smcr_max_recv_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
Ditto.
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can be a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the receive path used to be hard coded to 16. With this co=
ntrol
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physical=
ly
> +	continuous array in which each element is a single buffer and has the s=
ize
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 48

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--XTnKR8OXozLogMib
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaN0CowAKCRD2uYlJVVFO
o0wMAQC5im7T2Vp9QlkibFW/54g3imCkfNlm7IUNsqBjTp2m9AEA1GNBLgxsziTy
v2vNJmcJSA7s6ugOR+dFS8j67OYO3Qs=
=jHsY
-----END PGP SIGNATURE-----

--XTnKR8OXozLogMib--
