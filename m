Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87924212;
	Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIaqMbmi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DEECC433D9;
	Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700828430;
	bh=OmLVtp+cGn5eWtwGfr7ol+CQUUfqXShKVoDMBch4ZJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YIaqMbmioTMtdsLuyddfm/8JS3ojJeySLIqw09GDYRL3IXAm0yLs0EEBoaJ/prEAB
	 R5sitbmnTTDs0h2CckJXCuuBJLtm73cxHjilswNFjT8Xxf5xyyohVUk4+qo0A2wJim
	 ObpmvJ/Gpsy8foFvHD5wk1/TQGGtwwJa1pPXJEHhy0L7cA+fIoWULk4s7JH54tazYa
	 OElKwZDFIujt15q8uGpUSBMBvkLI/oRPHi6CWgksPa7PFI/BNPknl4VuHTUa410rc8
	 8WmxiDBkaLU/gupbNo/JjHY5zpDyOwPrhTck0jpmktvBf4Et7AJIQOTqBq76hx+Ob4
	 MBEoG5GUkpSpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D041E2A029;
	Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] add two sysctl for SMC-R v2.1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170082843004.28500.18077234087153896761.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 12:20:30 +0000
References: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
 corbet@lwn.net, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 21:52:56 +0800 you wrote:
> This patch set add two sysctl for SMC-R v2.1:
> net.smc.smcr_max_links_per_lgr is used to control the max links
> per lgr.
> net.smc.smcr_max_conns_per_lgr is used to control the max connections
> per lgr.
> 
> Guangguan Wang (2):
>   net/smc: add sysctl for max links per lgr for SMC-R v2.1
>   net/smc: add sysctl for max conns per lgr for SMC-R v2.1
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/smc: add sysctl for max links per lgr for SMC-R v2.1
    https://git.kernel.org/netdev/net-next/c/f8e80fc4aceb
  - [net-next,2/2] net/smc: add sysctl for max conns per lgr for SMC-R v2.1
    https://git.kernel.org/netdev/net-next/c/1f2c9dd73f0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


