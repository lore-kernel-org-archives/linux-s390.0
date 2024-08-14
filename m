Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23A38FA5;
	Wed, 14 Aug 2024 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605049; cv=none; b=a7o/c9g7WBRNJYxnxzssY4/xagnVyhvgCy27MqcYxx92ZXncWDvX2Zepoao0M4Xul4k2vFTqf2NT/9KA7YZzlQk3wLE4SxkVBjOA+Rwcdfn951Q+ARbIHi/72AEVXlJHAKqdhRgyKQWZGbHhw6NS75V7iKJiym7i4W1DAlAiOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605049; c=relaxed/simple;
	bh=Sp9QeoCH+OAWLbotM9vmelTluvyKiSyKF1wEmoKlCtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlYSMkdiQsAIQl/qVGnUvQK6mx6GoO1hAKZHJfhkH4B3Nw6Y6IUue56GK99Jf4U+wgwOD7bxX7qT2f71EVyCcXl9/gpahmf6mcNocsE8g0cN/Ne6VPIIDH4+O/mYkb7wY9ays80rnPgmOGq/0kZpYktO2AfPD9GTdla7uJEwxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Aek8ympG; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Aek8ympG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723605044; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IvhaOwfpnX4EGPnmGOD93Do9ZH9TmzwKIVGhZOoyXB4=;
	b=Aek8ympGqw51/A9XQWkUYJ8pLdPQLHcnqkHZn2dhh/W1myrOavkTfORh4xVOIezL4+tY5/h226Jf/ch1zXGjTH06v25LgMTKoXHKyzNOOwOIgra4wSqDhNwhOjIBuGGXs9tbwOgX3XXulX5mvo1ANjlSYZoCzOxI1iLV90aEgk4=
Received: from 30.221.129.40(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCqfTyh_1723605034)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 11:10:43 +0800
Message-ID: <b680756a-920d-419f-92ec-4be06aa3d8f5@linux.alibaba.com>
Date: Wed, 14 Aug 2024 11:10:33 +0800
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
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240807075939.57882-1-guwen@linux.alibaba.com>
 <20240807075939.57882-2-guwen@linux.alibaba.com>
 <20240812174144.1a6c2c7a@kernel.org>
 <b3e8c9b9-f708-4906-b010-b76d38db1fb1@linux.alibaba.com>
 <20240813074042.14e20842@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240813074042.14e20842@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/13 22:40, Jakub Kicinski wrote:
> On Tue, 13 Aug 2024 17:55:17 +0800 Wen Gu wrote:
>> On 2024/8/13 08:41, Jakub Kicinski wrote:
>>> On Wed,  7 Aug 2024 15:59:38 +0800 Wen Gu wrote:
>>>> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC,
>>>> +			      lgr->alloc_sndbufs, SMC_NLA_LGR_R_PAD))
>>>
>>> nla_put_uint()
>>
>> Hi, Jakub. Thank you for reminder.
>>
>> I read the commit log and learned the advantages of this helper.
>> But it seems that the support for corresponding user-space helpers
>> hasn't kept up yet, e.g. can't find a helper like nla_get_uint in
>> latest libnl.
> 
> Add it, then.

OK. So I guess we should use nla_put_uint for all 64bit cases from now on?
