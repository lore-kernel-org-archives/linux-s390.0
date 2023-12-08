Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9D366;
	Fri,  8 Dec 2023 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMEcxC3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5458BC433C7;
	Fri,  8 Dec 2023 00:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701996589;
	bh=EHTPFrjAnUcFE5n/Ico6Xo6PnZAf3NpCXQrBkMkxcMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMEcxC3dD1bhKGVlnyXeOfTfo+bK1YjU002o2xhG1LsBfyb1ltPY/P6nwVmJQHkZU
	 qEjCUyH/nF5AWxndYQ6P6YNFWakU2OGuilMxx3Qd3sNFI7vkTfKRgjNHRD8Ob01wE3
	 tttm3p4HHJddq4BSUO5UowJcPEl1/CQqO/of4I9sUlQ0q1tpkl1+zikOSa7WEUZ6fB
	 LuKbp8GZjunBpU12rwo5UDft4ffydgpyGvF4Pf0IyzJGNMVoNrhx1tbdvd9U6PUjVa
	 PXyvIJAjZoaL1feVgcym8RghbASu2HyuCi+WuvjrATDJG2pvcw6jK8Rr9RnhcRfrJR
	 FZgFEA6LbRvNQ==
Date: Thu, 7 Dec 2023 16:49:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/9] net/smc: implement SMCv2.1 virtual ISM
 device support
Message-ID: <20231207164947.3b338de4@kernel.org>
In-Reply-To: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
References: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Dec 2023 11:49:45 +0800 Wen Gu wrote:
> (Note that this patch set depends on an under-reviewing bugfix patch:
> Link: https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/)

Post as an RFC, please, until the dependencies have converged.
-- 
pw-bot: cr
