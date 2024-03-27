Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6612F58C;
	Wed, 27 Mar 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549970; cv=none; b=qdWZz1VQA/x7rpGPFzDQbmhgut8Pf9NtyOu3nj/5NcUa0mHXy0mG4xcicw9Qi78UOJ2SnlsJ3P1CtwoSF4Vo3dIL0HwUdtj28MvtQpVyz3XtZ1XhudX31d0J2rY3sC5PtD5ZxbcLrLs8wbFkX5vEwT1bEQ32xhf7KeVpBHF0oOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549970; c=relaxed/simple;
	bh=aDzk6N0Eg0JayEPDDPOoekP2H7sSnFAgPvaTT9fChkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/JUGdlBa6RDPH3AI05ISajioBRtD0YI6jbK+l+fj1dWG1bpyJ+6yIdrmrT3KQqBeXr6zp/qlrpcknK48Gk/or/qN1uQcSJC3ieMNASRG3VP82gdQS9xVBWRU3AhXasaswOTfIGkVity1BcnEf9xUIjmHnRsivEFVjKQFr2vCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlHP78GT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlHP78GT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC38C433C7;
	Wed, 27 Mar 2024 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711549969;
	bh=aDzk6N0Eg0JayEPDDPOoekP2H7sSnFAgPvaTT9fChkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlHP78GTNeAI/E02NLM2zfOZyrZOL/5oOp2VIX6bi4/azKUzPVKB+c+yqgig015u1
	 YT9e5seAbNVMtCmzaTEsGmAh6+3hoiAHfB5GDngMmhwHCv3tGiWCY5/Rzl7M13ecg8
	 nCwpUxtJCXol3daTX1UKF9Pie5RFvcF1gl+dsefZ+rUSd4ntEwv5QqhTXmWIH2yjQO
	 Jrd/4xj/J9bF8INSwR9fldfwe+dTZiaNMQWJQyjSm4HrrG8sdeTDorOZ0XfJAoQiVn
	 MdDrvELYtqosRtcneIXO9XtvYw9riOXx+W/6J/K1C8R9PzpF2ERUFfK0f3ST7458Ea
	 s0pthhP31xhjQ==
Date: Wed, 27 Mar 2024 14:32:44 +0000
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,RESEND] net/smc: make smc_hash_sk/smc_unhash_sk
 static
Message-ID: <20240327143244.GK403975@kernel.org>
References: <20240326072952.2717904-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326072952.2717904-1-shaozhengchao@huawei.com>

On Tue, Mar 26, 2024 at 03:29:52PM +0800, Zhengchao Shao wrote:
> smc_hash_sk and smc_unhash_sk are only used in af_smc.c, so make them
> static and remove the output symbol. They can be called under the path
> .prot->hash()/unhash().
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>

