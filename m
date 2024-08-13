Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0554184537;
	Tue, 13 Aug 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542930; cv=none; b=qw4e2UQ6vrP+sWxv+QRIO9dhojXYIJF+/831cCOmhcEuh5DGdZzGaA5vyPcqNYeTPTq7cn4Xj4JYEFUIvUgEaJ8KJA7US+gcOVRr3BbbvryB4dArj3FxMlq6j05m9CkdF5ALX70ttIKz6dC642U7XI43LufxQk4ifAzEEXSnVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542930; c=relaxed/simple;
	bh=mBZjPsIip8ChxWqV/5GWGXSHC/8iHBTHDrncClDOvA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPlDxxl4h5wXZNAyqM1YKAPZUzdxecULSZPss5iEmaqA4M/rvFhkHEbYzg3yiCA/MtYPe7r4/0/VzuseFdGFzdzugJ6zeickTECXUGcz7SGiGRgt+qlOzc+IKYm0Zm5jBk7dlgKwbMzoa/LY6yeqI2f6ZXnTtoX2kKomW2ExrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bAqzeJzF; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bAqzeJzF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723542919; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PciOPByFQj1IHN+EiM5rFX59Gxp74CyWVTSVv+ptmmM=;
	b=bAqzeJzFZY3sHWGkdPLoPAXX5Sp6KRAi0TH5rknVYePWj907SBuCeovDAjhOsEgYa1+L+0MteYr8TdYrBjeTa+v6Di3bix0lU23/tjqRx+97r1NaM4T1TDQD9I4lpOoPZmxwtui/74c9Q6QnKFhLttBRxTz1OXnJeLkVTscikDM=
Received: from 30.221.130.54(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCod0x1_1723542917)
          by smtp.aliyun-inc.com;
          Tue, 13 Aug 2024 17:55:18 +0800
Message-ID: <b3e8c9b9-f708-4906-b010-b76d38db1fb1@linux.alibaba.com>
Date: Tue, 13 Aug 2024 17:55:17 +0800
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
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240812174144.1a6c2c7a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/13 08:41, Jakub Kicinski wrote:
> On Wed,  7 Aug 2024 15:59:38 +0800 Wen Gu wrote:
>> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC,
>> +			      lgr->alloc_sndbufs, SMC_NLA_LGR_R_PAD))
> 
> nla_put_uint()

Hi, Jakub. Thank you for reminder.

I read the commit log and learned the advantages of this helper.
But it seems that the support for corresponding user-space helpers
hasn't kept up yet, e.g. can't find a helper like nla_get_uint in
latest libnl.
