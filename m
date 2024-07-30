Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F618CBFB;
	Tue, 30 Jul 2024 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365756; cv=none; b=H4JuIAwdnSXC1r9mNYdsXwAfvRmzwtbP9/ek4ngtKdtCUqQgzRpvtBIM/auwnQU4PlI56Q5hctOB05b6lUa2gxX2SdfwqchjuLrT3u54G5iJssvatQUrgg7DwnyIlo8sXPM2gdtfiM1Qk6QXe9tr0MoEzbIcBGWQcupyhD5adLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365756; c=relaxed/simple;
	bh=iMPC0uOGY/qCEBWGZUG8FOeMmwxGLbSnq8PUmLDtKxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfbM4D47BV84Ga9I76vW4FuZuQmCdVEKsty4pxAPB5cpYT4Q1KaUhLTLtLPVe+EKTf7nW81l0C9cKvoaiVyHpUVuHVrITgQUmpLOzZPfAPSm2NuY0pVJfIWIHDVqXb9+hjXP55egvv7c0RZGvodjPbq8vjtxvTcWyN0gugJX4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKj5JSDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKj5JSDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D6DC32782;
	Tue, 30 Jul 2024 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365755;
	bh=iMPC0uOGY/qCEBWGZUG8FOeMmwxGLbSnq8PUmLDtKxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKj5JSDX4j+nJJGmrOorBwhIYn6wrx5pLq0E9PBq5qXHz7+Q4E2D2aeOMOfBqjq9C
	 2ZxpSABp67D1RyZmruVa5gcz6UvPoMjj0dc5Y4Dk4wtH0G9aIHM5mpnvya8/Gy5+Nu
	 ge/i2Ydh2dcq3PeG3BDVoZ6eDk81aNsWr31ftTAFvplxCCPk105ZSQ9lvGfxyfPXTh
	 0hEqwkElYMCQh3Kj+MCcDbAVo7+Xg/rwjBpa8iJAGd6G72C7wsp/BCYRV3m3LB87Fu
	 XT2GVTbXVn97c9yBwcRdMg+aVuS5qGjRBhT3JMYTU10T3DCxEXthEnoNH9L7E0Cafq
	 VembjpMyHazMA==
Date: Tue, 30 Jul 2024 19:55:50 +0100
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 1/4] net/smc: remove unreferenced header in
 smc_loopback.h file
Message-ID: <20240730185550.GG1967603@kernel.org>
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
 <20240730012506.3317978-2-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730012506.3317978-2-shaozhengchao@huawei.com>

On Tue, Jul 30, 2024 at 09:25:03AM +0800, Zhengchao Shao wrote:
> Because linux/err.h is unreferenced in smc_loopback.h file, so
> remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Thanks, I agree that noting provided by err.h appears
to be used either by smc_loopback.h or files that include it.

Reviewed-by: Simon Horman <horms@kernel.org>
