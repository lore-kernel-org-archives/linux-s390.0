Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1723A8;
	Tue, 13 Aug 2024 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723509706; cv=none; b=eCl5ExRSC7cr1E5owL49dT80h9wTAQvk5MHzqgKE/Ml1HqEIHqjX9e4UmyVnOGJAoxNSwGnAZOEmoyZVpynfUcXnT75kL8YyQ3KCLTKH9qbZJZ0a4GYq6IBj1hW52ZV/KyDd8Qbf/fvrE9fnh2o+PlxI3QX6W+HKXRZwB6QeGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723509706; c=relaxed/simple;
	bh=UfIukSUM7bhMLn23Zb+oA3f6KHmGCIoN6Tv+keOqMKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWmHdQz21EWdHGzCxWXq+yXA3Vvh6sSC7JAWSrRfOQa1ftBj92OQVAx4S4V4qtsy7QHhbx/XOm/wTa+nsNEr1pvQdJQF9jWv875k6UUREb87EtGmeL28prCBtdnZQJ8RTW9a4U7xwFXbb09vsVHQkwvHQOUJONHJqVv9cdjUhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1B6Otpf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1B6Otpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8956BC4AF0D;
	Tue, 13 Aug 2024 00:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723509706;
	bh=UfIukSUM7bhMLn23Zb+oA3f6KHmGCIoN6Tv+keOqMKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L1B6OtpfUwM4iYvO2qL2HuydUZ14CbNU7U5W4wxg6IPb8DYAsSPoIBZ0Z/6V6Z5Rm
	 EZw7p7smtC5VxVeHvQH2DdNZT04I6x+purSNUKm5Nf1Pikzbw+7JjdiHdkqKXE0Ym6
	 bEPsm6Vk/wzKYOI9txolEi9TizcIdOiIm5kv4F+y7/mwFq3wML4dlIKsB33QzCEMks
	 AarPvPYgX9+/yoFn7vCw0tN7Jfcm3Q/1KotcqOV2uiRTnSrv9wNN0i6LmWrmVqTITo
	 By4h7bysF7NFmCTXGPxAktWUTpmHlRP7BLiFRdvX5NPN0t4JML3/m2sBfDP9sH+Dfa
	 +6IvszBrGncuw==
Date: Mon, 12 Aug 2024 17:41:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/smc: introduce statistics for
 allocated ringbufs of link group
Message-ID: <20240812174144.1a6c2c7a@kernel.org>
In-Reply-To: <20240807075939.57882-2-guwen@linux.alibaba.com>
References: <20240807075939.57882-1-guwen@linux.alibaba.com>
	<20240807075939.57882-2-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 15:59:38 +0800 Wen Gu wrote:
> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC,
> +			      lgr->alloc_sndbufs, SMC_NLA_LGR_R_PAD))

nla_put_uint()
-- 
pw-bot: cr
