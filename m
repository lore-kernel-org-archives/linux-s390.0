Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803335FDA7;
	Thu, 13 Aug 2026 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580452; cv=none; b=UzAG2bcV4w8KkRy16CMiB6kmVH7Qd9L5gIUqm3NcJcwj1sOOxEjoJch/PdK6nn1rH+wj8bZu+1MLxj1pNx1RpGsG+iymQmBGHnWsw0If0Ow5gALduc3cjH/x7SBuGG+VQsAXRYqBwRfR7j+Uumcmm9rd2ah/nf2IT7liyu6hAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580452; c=relaxed/simple;
	bh=OAuraHfr7QQWMvb6hWiiLwGpiEMETGBQZmyNaXAaRCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H2r7QwkQKhnIJ6guDjMZSnHn1gvja/SD9kzY5q3kKTP1kKcFsNvoGPgSyxJZvqf7NFZz1i5oqirVR+YP190OKWx6NK39NpY0DpU6HUWVqLkC9CsbIOplfb3Di22jlHy+fF3sqWRQ3VwkUgjU1F2fZJJZqwgmHyZAzyGs2vAl3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTvEWMWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTvEWMWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AA61F000E9;
	Thu, 13 Aug 2026 00:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580451;
	bh=oNiDOvlf2OwW3wKxa+Xf8Lvk413j+h2XVgOhF2YTeFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HTvEWMWOOF/bxhv7av247Pki6jDP3M/z3i76QPgxOKzBuyz4UM+EZd3tuw3O76MOx
	 nweNaSBNGTuTmWlSilTwdBqtZoI+GSHjhmBtecXQdcLA1q986zgirThpSD97o9c7kB
	 7grAcHbbEM8AfrVLb3eJ18ZaF4QLw0uB9cUvqcxv4fx9fHWWjC+/Pf86FX4gc6zg42
	 ZA36Ts9lI9GWKTNbRYqbQPO+CoqgMZHBdlYvdlV/GB6McqrFjsjZRGXM79DI2hCUMM
	 cYLG3YA06nwXhxcYIuv+/qhwPh4yaI2tSngJ3GL77e+oGEWJLEH8vjJ818q/qRLtEU
	 0nv9BPCTJfEag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939FE380CED0;
	Thu, 13 Aug 2026 00:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/dibs: Correct freeing of dmb_clientid_arr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658040641.2159598.1552033045335501888.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 00:20:06 +0000
References: <20260810111432.2334900-1-wintera@linux.ibm.com>
In-Reply-To: <20260810111432.2334900-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, hidayath@linux.ibm.com,
 dust.li@linux.alibaba.com, stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Aug 2026 13:14:32 +0200 you wrote:
> A dibs device interrupt handler can be active after dibs_dev_del() and
> may still access dmb_clientid_arr. (UAF)
> 
> In case of a failure in dibs_dev_add() being called by dibs_lo_dev_probe()
> dmb_clientid_arr is freed twice (double free).
> 
> Free dmb_clientid_arr in dibs_dev_release() after last reference is gone.
> Note that allocating in dibs_dev_add() instead of dibs_dev_alloc() is ok
> for now, because no dmbs can be registered before dibs_dev_add().
> 
> [...]

Here is the summary with links:
  - [net] net/dibs: Correct freeing of dmb_clientid_arr
    https://git.kernel.org/netdev/net/c/9e6869be4906

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


