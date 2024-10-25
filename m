Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE31FB886;
	Fri, 25 Oct 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864611; cv=none; b=h62W8Jevmh4tpuQmSAOzfZvC44HURI5ribV59hQTKNuGFu4LL3X2XJv4bZJ5lXMP10aUmcVs0MZM01auzqs58CydA81iq4YML/PpBDZfJkEMVsLXzViT7GUC2/ifJJR2NwTOdh4GyywnDY5uVn05pLCxdWTc2BuMNDYtZAdJO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864611; c=relaxed/simple;
	bh=VOVthntb2aOe9RBecJRGYMjMbQDWDpKNZr66qOOPCxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoAWOzsbzGx3XALSatij1tFsEjDXSJ0k8Socd13xKbmwPmBk/TuuJF75jQG2sQNsklVGdMhLRF0WxaHJHrg1E6MRQCv3w54tOvPuRoZUbMkDwoj2Oai5kfuYYnfkzi4goG78R2ZvH6w8rmN7GrbKe6XV3SSYpMBJKa4knpZy8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNC5khJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNC5khJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26270C4CEE3;
	Fri, 25 Oct 2024 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729864610;
	bh=VOVthntb2aOe9RBecJRGYMjMbQDWDpKNZr66qOOPCxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNC5khJ1ECcRsOZ/SIXMh8Ozb4M0UoNCAkqaYTY5hqYOLSnVIoZZCaSONHeMY90DI
	 xl3gcoLDoi603XhvDCI7XRlBvyOuwBVa01jAX+GQzzxvyYTyhAYT5U8+kgA1f9H0Cc
	 LRDKTJl4KoWFKMtoM6PxouqqRMbWCEY/qqtQ+wz9TYtSh9RXrXk1CEssxosgsSV2yT
	 D7c1D87hwlbZJR2Wc1DLu91acwxRRb/TWG6GixcXtAEF37owiIT7lWPIVlayFb4pFm
	 ydrUcTYQh0dkc6pUb23CIJybnCnOjX8PttNsxNDbmKNZhWp4xeHsqTrY5gZmW4lYoG
	 b0OmbjjxtZa7Q==
Date: Fri, 25 Oct 2024 14:56:45 +0100
From: Simon Horman <horms@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>
Subject: Re: [PATCH net-next] net/smc: increase SMC_WR_BUF_CNT
Message-ID: <20241025135645.GA1507976@kernel.org>
References: <20241025074619.59864-1-wenjia@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025074619.59864-1-wenjia@linux.ibm.com>

On Fri, Oct 25, 2024 at 09:46:19AM +0200, Wenjia Zhang wrote:
> From: Halil Pasic <pasic@linux.ibm.com>
> 
> The current value of SMC_WR_BUF_CNT is 16 which leads to heavy
> contention on the wr_tx_wait workqueue of the SMC-R linkgroup and its
> spinlock when many connections are  competing for the buffer. Currently
> up to 256 connections per linkgroup are supported.
> 
> To make things worse when finally a buffer becomes available and
> smc_wr_tx_put_slot() signals the linkgroup's wr_tx_wait wq, because
> WQ_FLAG_EXCLUSIVE is not used all the waiters get woken up, most of the
> time a single one can proceed, and the rest is contending on the
> spinlock of the wq to go to sleep again.
> 
> For some reason include/linux/wait.h does not offer a top level wrapper
> macro for wait_event with interruptible, exclusive and timeout. I did
> not spend too many cycles on thinking if that is even a combination that
> makes sense (on the quick I don't see why not) and conversely I
> refrained from making an attempt to accomplish the interruptible,
> exclusive and timeout combo by using the abstraction-wise lower
> level __wait_event interface.
> 
> To alleviate the tx performance bottleneck and the CPU overhead due to
> the spinlock contention, let us increase SMC_WR_BUF_CNT to 256.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Nils Hoppmann <niho@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

