Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD81420D7;
	Tue,  4 Jun 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499604; cv=none; b=UavOWi7urgB4eIwHHYedDMKJwcGDwmFx30HMZW07eSZJlYh+gmCDxe8lxLUj9Dt47gDVC7PuElHf4EIi5EuVGO6nMcqlsEkj3CfPgyWv7vgh0H0jRjKUDvL57oFr+mQO6UtNswv33xo4zG3upYw070QcXrCvXqmFVZi4ZepYP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499604; c=relaxed/simple;
	bh=rGoLCX1QYySnp5WODctYy3wdo/rDyPEq2AVRp8GdPdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type; b=KshcFMW6opnXmUL+C3NmMXVTAC/1FN3r/60fRkShhzFCTT5dj3CV+scNa9oZReh2nuNHNlA/5woW5K0WIDJGP0Sqyi6R9GsB9z9Ha5d46OIa0MV9lPy5+E65DsIdt7eUMqZgVlTghf0WwbkJLm30JIlfhrNDWchCOI2eHSbVWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CsJtr6d4; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CsJtr6d4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717499599; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N5NUh30145zgOTyWygnNBSJ5byygJdHeU6hO+TwHwK0=;
	b=CsJtr6d4n7IQfu1oAXMBVdRjjdDN9lbwDR3fAXbWb9F/G17jbFbNFQlBINERVv9p2MDhApj/htOQh+tegyUdSaUBq/F240VMmK5zChkmrtitp5FikpOJkDP9kVHvEWNIJsV82fYzl2FBJo6OQstSfSgc4CLJvBVONI0ZJVOsmrE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7qye4e_1717499588;
Received: from 30.221.129.74(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W7qye4e_1717499588)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 19:13:18 +0800
Message-ID: <bebf60d1-866a-495b-b218-05e0aa5128a1@linux.alibaba.com>
Date: Tue, 4 Jun 2024 19:13:08 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: avoid overwriting when adjusting sock
 bufsizes
To: gbayer@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Wen Gu <guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/31 16:54, Wen Gu wrote:
> When copying smc settings to clcsock, avoid setting clcsock's sk_sndbuf
> to sysctl_tcp_wmem[1], since this may overwrite the value set by
> tcp_sndbuf_expand() in TCP connection establishment.
> 
> And the other setting sk_{snd|rcv}buf to sysctl value in
> smc_adjust_sock_bufsizes() can also be omitted since the initialization
> of smc sock and clcsock has set sk_{snd|rcv}buf to smc.sysctl_{w|r}mem
> or ipv4_sysctl_tcp_{w|r}mem[1].
> 
> Fixes: 30c3c4a4497c ("net/smc: Use correct buffer sizes when switching between TCP and SMC")
> Link: https://lore.kernel.org/r/5eaf3858-e7fd-4db8-83e8-3d7a3e0e9ae2@linux.alibaba.com
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
> FYI,
> The detailed motivation and testing can be found in the link above.
> ---

Hi, Gerd and Wenjia, do you think this makes sense? Thanks!
