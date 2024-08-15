Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF47BA53;
	Thu, 15 Aug 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704696; cv=none; b=qAIx/Crg0hi1QF9WMjJLiohUY/y5RUyy43mPknoOiAf2SQlQa1hqCTjCWlIFCtOEiiJ/RRMzoMLKlbo1bVgVHxaPGaJrxwXKpaJAirI8JRk7M+2N5KXWz++qj7pNrlD6jk952kbise3+oAEIwD7l1WnNXgxF42YOmUeeYnwg7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704696; c=relaxed/simple;
	bh=jUNeEXuGLV7Q3Bl+nBUUmQTRgIB5zpxHzwTaW+3lySk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KawEjxhygoZrV3WA9cmzRT8TMGIB+yE33YtplwciuDHQ45H/ISyGsXX4lNr54QFu5opbdDqRxCujhR55Fj4eiYJUebHnuZriFjhEBPcvnWQe9vRi/1vPOgSBGyjMmjqp50uDphQbx1Z7bEw4wVNnY7J1pHWcvKjVt33eJzFIoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YzSS37eV; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YzSS37eV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723704689; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0bxGifhOCL3kBvGwkWFfGBzMDdag2ojN5AC+n5LYzD4=;
	b=YzSS37eVyiXFpnUVojFPf+NVefCMwrCNxrB3j1BNgbsLWd60tl2L5y6tKcsbkvD4NhAWuAr0XprSRNFh+by7duiLS6EesMCo8dm0BDUFtAPAxIqGsPfXerrDvRV0ErwoTCC0psxXdMMJdtbEcsss5/ZDhOHNofqJ2P+Wty9ceaQ=
Received: from 30.121.30.177(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCvrUwL_1723704686)
          by smtp.aliyun-inc.com;
          Thu, 15 Aug 2024 14:51:28 +0800
Message-ID: <c1f916ff-5433-4ee7-8c27-b2d749750829@linux.alibaba.com>
Date: Thu, 15 Aug 2024 14:51:26 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/smc: introduce statistics for
 allocated ringbufs of link group
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, danieller@nvidia.com
References: <20240807075939.57882-1-guwen@linux.alibaba.com>
 <20240807075939.57882-2-guwen@linux.alibaba.com>
 <20240812174144.1a6c2c7a@kernel.org>
 <b3e8c9b9-f708-4906-b010-b76d38db1fb1@linux.alibaba.com>
 <20240813074042.14e20842@kernel.org> <Zrt4LGFh7kMwGczb@shredder.mtl.com>
 <586beba2-a632-4fe3-9fb5-e118af384204@linux.alibaba.com>
 <20240814074826.38f211e9@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240814074826.38f211e9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/14 22:48, Jakub Kicinski wrote:
> On Wed, 14 Aug 2024 11:12:41 +0800 Wen Gu wrote:
>>> Danielle added one to libmnl:
>>>
>>> https://git.netfilter.org/libmnl/commit/?id=102942be401a99943b2c68981b238dadfa788f2d
>>>
>>> Intention is to use it in ethtool once it appears in a released version
>>> of libmnl.
>>
>> Thanks, that is a good example.
> 
> FWIW - technically the kernel version of a uint / sint are only either
> 32b or 64b, because smaller types get padded to 4bytes in netlink
> messages, anyway. But doesn't hurt for the get. For the put make sure
> you don't narrow down too much.

Understand. Thanks.
