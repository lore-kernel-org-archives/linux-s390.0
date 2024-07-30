Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0810A0D;
	Tue, 30 Jul 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365872; cv=none; b=GQv2vTPmTNp0hjSM6WGa/rRVUV3x83IJ5Zg5Ns77F3m/r4hvmmJJ7e572e7zwdFanNfxcYxBSYjGEMgZROmMe2B1A6yVZ4E0M1Cl5N6a5xzqJSoeU90Y7hahKMxw1mED++gqpjQ+PiDCK7yB3bRE7xvbW5YGYNG6lq5tr72CXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365872; c=relaxed/simple;
	bh=zwNHAUAR98WLTZ+HhN3NvglpYiz7J9QRex/zSLHv3f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPZ/h9a1g6n59oITfoUvfxTxLQoHu/9Q7RiV1T0kmWIMbZ3xgfebhG1dr1ykRHpgpc+/bGs4gzssuEZHWNr86SGb5zYadn2WNytliT3nUuoL9QvJqetjnrXN8x75ZUPe210ZRLqPLH7X1cpdRlNsAfkz3PJykEtD31nSsKFV1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZElvMyk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZElvMyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A12C32782;
	Tue, 30 Jul 2024 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365872;
	bh=zwNHAUAR98WLTZ+HhN3NvglpYiz7J9QRex/zSLHv3f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZElvMyk2TffLM+tJF3zBtHayV0cGyzJdEcJzzt+PeZJtIxTA/njJJBXoz4TcGX6u
	 gYTWEatY3UJxvvbF8ffCg7NP8nNrY2e5Xmrdj0ejPGq6VHkrl5Wbpfg58gfh7pdiiC
	 rfIs5do1rM6die10rg7La12Y0QRbkJOG5avvCzoMoa+2iwvVQXfbTg/U53rS0UkFrC
	 0VRG7rFqcgFilQXN8nd1l0t8hlnvvKvbOK3C311vpq+a+ItOJcoWj9Chyc5fGe4z5p
	 U30fETqiIq0+eX7SmvfecQdHspfTHo9AnCJqVvULJieULWVR4C8kJacK/g63THaiOL
	 maSSIKvMB7Ltg==
Date: Tue, 30 Jul 2024 19:57:47 +0100
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 2/4] net/smc: remove the fallback in
 __smc_connect
Message-ID: <20240730185747.GH1967603@kernel.org>
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
 <20240730012506.3317978-3-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730012506.3317978-3-shaozhengchao@huawei.com>

On Tue, Jul 30, 2024 at 09:25:04AM +0800, Zhengchao Shao wrote:
> When the SMC client begins to connect to server, smcd_version is set
> to SMC_V1 + SMC_V2. If fail to get VLAN ID, only SMC_V2 information
> is left in smcd_version. And smcd_version will not be changed to 0.
> Therefore, remove the fallback caused by the failure to get VLAN ID.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Thanks,

I agree that smcd_version, which is initialised just above the code
modified by this patch, cannot be 0 at the point of the check removed by
this patch.

Reviewed-by: Simon Horman <horms@kernel.org>
