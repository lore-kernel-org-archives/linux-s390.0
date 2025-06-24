Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A185219E0;
	Tue, 24 Jun 2025 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808648; cv=none; b=mnGAQPQt0U/DKalh599GqxVVu/jSE2RjWAFh2YMJB2Wh71D5tVbe1HnCeb50E7LU4ht43XWkWcwdzBg3q/BLkRMTMg9N3XZGxCJlFZ5DFzLoI+ZawPCxraH4nkVtn6v7gBudPdT90Z0laIJNLbddDdp1k/11tktnGALOqde9cIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808648; c=relaxed/simple;
	bh=ej10MD6VTDg4F/HpyfR05DAO+QCN2orPQNAY/v8mqL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8Hrm33ea/7iM3DX1MgOYFISw6lRSD+LdfLH9vGfqlRDSu94M+/Ko4tT5xvslRkjjjjGCn5vOl9luyU8LCVPmcpVK+6saNGkZXFy1ItHNugholXwZ8mRN0r8j2EaAPnDtLFZWlQxBQyhlBOSFA7gBgcp79OOcd0Ltg18IvlfkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+cfIINX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+cfIINX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC0DC4CEE3;
	Tue, 24 Jun 2025 23:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750808648;
	bh=ej10MD6VTDg4F/HpyfR05DAO+QCN2orPQNAY/v8mqL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B+cfIINXfAOxkv1Unc8BHAcIxE1wFulngU5K5i/Gk9U25ixUahfclsi4nsKsMpIVS
	 mU15HJBOMfCIyOTWk3+b4f4nO54jA+c2/yFY4uSRKvT8TBG7rtrnZgtDATMntn+KYp
	 xEt/K9uRQOiDA6ePLulN70CBEoqlYbB4f7RBe8AoM10DsQLOaD2aoquRtc/8K4pj55
	 NBAPqX1UwiNGPXxXS1mI37xFIkoJx0AuuvTjcrnT1PZiLFdg9o+tUa5832BJqndxy9
	 WK3PL3VsS10vpm0FWA2OqYCG3WcTTFd2lXVJ40gmfrDTGb9nt76mW6DdQUtPAcMJyU
	 iM0L7IMPCaE3Q==
Date: Tue, 24 Jun 2025 16:44:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Karcher <jaka@linux.ibm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>, Sidraya Jayagond <sidraya@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>
Subject: Re: [PATCH net] MAINTAINERS: update smc section
Message-ID: <20250624164406.50dd21e6@kernel.org>
In-Reply-To: <20250623085053.10312-1-jaka@linux.ibm.com>
References: <20250623085053.10312-1-jaka@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 10:50:53 +0200 Jan Karcher wrote:
> Due to changes of my responsibilities within IBM i
> can no longer act as maintainer for smc.

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

Great to see the cooperation with Alibaba!

I'm not sure we can add Mahanta Jambigi, according to community
standards. Quoting documentation:
  
  The following characteristics of a person selected as a maintainer
  are clear red flags:
  
   - unknown to the community, never sent an email to the list before
   - did not author any of the code
   - (when development is contracted) works for a company which paid
     for the development rather than the company which did the work

I think the first two bullets apply:

$ git log --grep=Jambigi
$ 

See:
  https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#corporate-structures
-- 
pw-bot: cr
