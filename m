Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208529406;
	Wed, 14 Aug 2024 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605174; cv=none; b=sqPXeIUlr8lZFqNsGagx12zA1rWOFcXiJvwIOJzd4mzsMrYZ0j/FF4neGus5L/pbFkEtCbz50JPvAZgV7OT9w/Xs25nWnJK8TwTcTzVkgB+qPm/BqvhE2lExN4J/LZoChgiY84Zk7JZ05L4c9XuJuQAspwgCTzr/EgDrGyGR8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605174; c=relaxed/simple;
	bh=AVrX6k53MBacTO/M1J2JKm+SRYtUWK2E3iOwy59rz8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT01pmRsx7lPR9kbHmKU7rXeFY1TMi/X8pY0Bg1yUqPT1dQiQC60cBSX5uWo3M+AWyfVUxBnJ4GhOJCkhMFPCrkeo6uLds5VxmkSBGUnx987C2XW+IP/u/gIvQo9/LpRjKDQK5Ct+p2hVVBzYuyA64K3XFZRPIHba7oAdZVqK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hGVZ3EAZ; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hGVZ3EAZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723605163; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sSJiNq9BVB6VoPCfZ/LCuxYrsadHPpHshralsjcp3Lg=;
	b=hGVZ3EAZy5Nasu6cg44P5LR2gqI/W2UGRbVmav+QC2aMyvtSGMYQDXLn9JRbYx801YJOO8jSDsE5SLMGrETJBYxhL49lhplK1VjqBD/yJej+nywS2ffrrhAE7lOcf+RI/B52k4N0W/GWD8w99PtFUKmV5nQcfOg/rVtLTG5GlzY=
Received: from 30.221.129.40(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCqfUrB_1723605162)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 11:12:43 +0800
Message-ID: <586beba2-a632-4fe3-9fb5-e118af384204@linux.alibaba.com>
Date: Wed, 14 Aug 2024 11:12:41 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/smc: introduce statistics for
 allocated ringbufs of link group
To: Ido Schimmel <idosch@idosch.org>, Jakub Kicinski <kuba@kernel.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, danieller@nvidia.com
References: <20240807075939.57882-1-guwen@linux.alibaba.com>
 <20240807075939.57882-2-guwen@linux.alibaba.com>
 <20240812174144.1a6c2c7a@kernel.org>
 <b3e8c9b9-f708-4906-b010-b76d38db1fb1@linux.alibaba.com>
 <20240813074042.14e20842@kernel.org> <Zrt4LGFh7kMwGczb@shredder.mtl.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <Zrt4LGFh7kMwGczb@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/13 23:13, Ido Schimmel wrote:
> On Tue, Aug 13, 2024 at 07:40:42AM -0700, Jakub Kicinski wrote:
>> On Tue, 13 Aug 2024 17:55:17 +0800 Wen Gu wrote:
>>> On 2024/8/13 08:41, Jakub Kicinski wrote:
>>>> On Wed,  7 Aug 2024 15:59:38 +0800 Wen Gu wrote:
>>>>> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC,
>>>>> +			      lgr->alloc_sndbufs, SMC_NLA_LGR_R_PAD))
>>>>
>>>> nla_put_uint()
>>>
>>> Hi, Jakub. Thank you for reminder.
>>>
>>> I read the commit log and learned the advantages of this helper.
>>> But it seems that the support for corresponding user-space helpers
>>> hasn't kept up yet, e.g. can't find a helper like nla_get_uint in
>>> latest libnl.
>>
>> Add it, then.
> 
> Danielle added one to libmnl:
> 
> https://git.netfilter.org/libmnl/commit/?id=102942be401a99943b2c68981b238dadfa788f2d
> 
> Intention is to use it in ethtool once it appears in a released version
> of libmnl.

Thanks, that is a good example.
