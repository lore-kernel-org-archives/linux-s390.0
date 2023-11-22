Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6875C8F5;
	Wed, 22 Nov 2023 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzgTnDuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517C8C433C7;
	Wed, 22 Nov 2023 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700680052;
	bh=uVl7nTlOM0+msqDAdm3xWe+pC9hYDXS7ELazxBmwybM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzgTnDuKDNNI2dRTWMKvM5zYKH+Hpi+NupYJ34h4+8zUd1hf6idxMdSswFWMqeKfU
	 48rcSLdxqrCZZIL9AP39WVkFTub17R8lcUv2l7mDetSSotS6IooqzdjIkMxuTN9FZ6
	 olz7dYNj7+jdqCIbOvOhmlo1r3Uhepy1nsPgrLnpdUHME2+WdM5mKP5tVu0oEeZ2t9
	 uhWw8IXHpVujmXqiytKyBY0V569vdYww4ToNiLHMz6T5Bi+Gnrg9hR8DDqpfUIrdhv
	 30/uvy/m/YYen77xPm0Ey3ZlsswsI+qLuGwurfs4LvvnBWOaUKgKsajKeECn5WNvMs
	 1xzHjSWZwIFRg==
Date: Wed, 22 Nov 2023 19:07:25 +0000
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kgraul@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, raspl@linux.ibm.com,
	schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/7] net/smc: compatible with 128-bits extend
 GID of virtual ISM device
Message-ID: <20231122190725.GB6731@kernel.org>
References: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
 <1700402277-93750-6-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700402277-93750-6-git-send-email-guwen@linux.alibaba.com>

On Sun, Nov 19, 2023 at 09:57:55PM +0800, Wen Gu wrote:
> According to virtual ISM support feature defined by SMCv2.1, GIDs of
> virtual ISM device are UUIDs defined by RFC4122, which are 128-bits
> long. So some adaptation work is required. And note that the GIDs of
> existing platform firmware ISM devices still remain 64-bits long.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

...

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c

...

> @@ -1522,7 +1527,10 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
>  	/* run common cleanup function and build free list */
>  	spin_lock_bh(&dev->lgr_lock);
>  	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
> -		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
> +		if ((!peer_gid->gid ||

Hi Wen Gu,

Previously this condition assumed that peer could be NULL,
and that is still the case in the next condition, a few lines down.
But with this patch peer is unconditionally dereferenced here.

As flagged by Smatch.

> +		     (lgr->peer_gid.gid == peer_gid->gid &&
> +		      !smc_ism_is_virtual(dev) ? 1 :
> +		      lgr->peer_gid.gid_ext == peer_gid->gid_ext)) &&
>  		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
>  			if (peer_gid) /* peer triggered termination */
>  				lgr->peer_shutdown = 1;

...
