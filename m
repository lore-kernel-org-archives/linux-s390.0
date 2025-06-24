Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288EC24678E;
	Tue, 24 Jun 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750749194; cv=none; b=QOD2YRvhIEtpBPMh6AraIM/i0LvQ3QIQtGEhiwXEWT8Kq1Jwg751kBeVeJfB3X3GYzw6UFahMgm8Tt67aGZJ4JCHyjivfP3q31OgNOy2rd902q1P8w6y8l7ezYbhDJWy39XDbgwgTT7BoiPIKKuHtY2TGyhKZRiUuhz4ascwnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750749194; c=relaxed/simple;
	bh=90OBtY1ZpMx7eKxSsX+qlVfyk0uhDIIf1h74NXuOWbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AN8S3sNAH2otluMXTsKBbPxhLVd3/WA+YafjxWEZIQRrdL7aoD0uEnA5xpB2Qz3Cnbnd400nf2WBSM6hbtIRxbBRFbZJMtfaWTWVoNzblIh8kp695zwqjt0lhIIrj/m+sLI8tsB2zbn0BwiSWFotJXnlhHWAzzkdClMyut/CjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jV7hIDNL; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jV7hIDNL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750749182; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=aCfxa4LWc2GD9SkR7BPqFU/nHYaAqImE0tysoA4ViBs=;
	b=jV7hIDNLQpCux7sBa+49yt4s5CRRg4r8Td8LNX3riK5VrOsW8NjiNBalWV7pIoMrY9cxakfN4832fMZpqztF8PcrFSnmi137iJWE4h6HO7+N8xb3E7jvlhFSNHRsaZvUoXNF6EEYeVuHRCPkIIFB57JLpBjEI4n7t5S0sjDdf0U=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Weftavy_1750749180 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 15:13:01 +0800
Date: Tue, 24 Jun 2025 15:13:00 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Jan Karcher <jaka@linux.ibm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>
Subject: Re: [PATCH net] MAINTAINERS: update smc section
Message-ID: <20250624071300.GA65586@j66a10360.sqa.eu95>
References: <20250623085053.10312-1-jaka@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623085053.10312-1-jaka@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jun 23, 2025 at 10:50:53AM +0200, Jan Karcher wrote:
> Due to changes of my responsibilities within IBM i
> can no longer act as maintainer for smc.
> 
> As a result of the co-operation with Alibaba over
> the last years we decided to, once more, give them
> more responsibility for smc by appointing
> D. Wythe <alibuda@linux.alibaba.com> and
> Dust Li <dust.li@linux.alibaba.com>
> as maintainers as well.
> 

Hi Jan and smc folks,

We are delighted that IBM has entrusted us with greater responsibilities
in the SMC project. 

Over the past years, Jan has helped us achieve multiple pleasant
communications with IBM, and we are proud to have jointly implemented critical
features such as the SMCv2 protocol upgrade, loopback device support, IPPROTO_SMC,
and more. The stability and robustness of SMC have always been our top
priorities.

To be honest, the SMC community is currently relatively inactive, and addressing
this will be our initial priority. In addition, the future evolution of SMC will still
require sustained collaboration among all of us, let's keep working closely to
move SMC forward!

D. Wythe

> Within IBM Sidraya Jayagond <sidraya@linux.ibm.com>
> and Mahanta Jambigi <mjambigi@linux.ibm.com>
> are going to take over the maintainership for smc.
> 
> Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa16..88837e298d9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22550,9 +22550,11 @@ S:	Maintained
>  F:	drivers/misc/sgi-xp/
>  
>  SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
> +M:	D. Wythe <alibuda@linux.alibaba.com>
> +M:	Dust Li <dust.li@linux.alibaba.com>
> +M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
> +M:	Sidraya Jayagond <sidraya@linux.ibm.com>
>  M:	Wenjia Zhang <wenjia@linux.ibm.com>
> -M:	Jan Karcher <jaka@linux.ibm.com>
> -R:	D. Wythe <alibuda@linux.alibaba.com>
>  R:	Tony Lu <tonylu@linux.alibaba.com>
>  R:	Wen Gu <guwen@linux.alibaba.com>
>  L:	linux-rdma@vger.kernel.org
> -- 
> 2.45.2
