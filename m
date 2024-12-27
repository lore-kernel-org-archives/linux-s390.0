Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372E13BAEE;
	Fri, 27 Dec 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286044; cv=none; b=pKeHJC+I0n5JDt1nBvRTZ0ATOALcBv6Kk249tfXPqigsMcQmKt0HHnD9n7E59xwyf60Wz6s/vpPPQ8TyiNyqeH2PcwnYvVzjNarQRmhb1LEb//5NVhT02FX51ZAFoibxAQL/biCvki/dvT2u+qJdUM5K5h0kWutYd2Kn0q7zO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286044; c=relaxed/simple;
	bh=u9I1yYZ1gyQtn5cLWif1hJeiYLGC+o4EwSUkPOkGCjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=COJRjI6VlyTvgmmsbATMpP4kfDNGPa+If8tpR5zUYpPTtmo/LjmH2h7J1VMq7CbcJn1ZX3H2eBmVNeLCAkPZKPhjaJViwWSKDhR5CHAlvU1zzHhgk3s+JFefiumQpxgAS6L7hxvtyoGfq8UCn4FOBRfDHjq90Pl7+vP9zwgEdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YKHky3GLxzRkQw;
	Fri, 27 Dec 2024 15:51:54 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id A495B1800FE;
	Fri, 27 Dec 2024 15:53:56 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Dec
 2024 15:53:55 +0800
Message-ID: <11f8088f-7605-432b-b90b-f8d16c145565@huawei.com>
Date: Fri, 27 Dec 2024 15:53:54 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/1] Enter smc_tx_wait when the tx length exceeds
 the available space
To: Wen Gu <guwen@linux.alibaba.com>, <wenjia@linux.ibm.com>,
	<jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>, <gaochao24@huawei.com>
References: <20241226122217.1125-1-liqiang64@huawei.com>
 <20241226122217.1125-2-liqiang64@huawei.com>
 <08096620-5c6f-4e39-b5e4-6061ab8fc0a8@linux.alibaba.com>
From: Li Qiang <liqiang64@huawei.com>
In-Reply-To: <08096620-5c6f-4e39-b5e4-6061ab8fc0a8@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf200001.china.huawei.com (7.202.181.227)



在 2024/12/26 21:20, Wen Gu 写道:
> 
> 
> On 2024/12/26 20:22, liqiang wrote:
>> The variable send_done records the number of bytes that have been
>> successfully sent in the context of the code. It is more reasonable
>> to rename it to sent_bytes here.
>>
>> Another modification point is that if the ring buf is full after
>> sendmsg has sent part of the data, the current code will return
>> directly without entering smc_tx_wait, so the judgment of send_done
>> in front of smc_tx_wait is removed.
>>
>> Signed-off-by: liqiang <liqiang64@huawei.com>
>> ---
> 
> Hi liqiang,
> 
> I think this discussion thread[1] can help you understand why this is the case.
> The current design is to avoid the stalled connection problem.

Yes, I read that discussion and the problem does exist. So we should correctly handle
fewer bytes sent than expected in user space (like netperf).

However, according to my verification, in the TCP network or loopback (without smc),
after increasing the memory sent by the client at one time to a large enough size,
a connection deadlock seems to occur. SMC processing will not be stuck due to the
expansion of the sending memory.But when the socket is blocking and sends messages,
its behavior is different from TCP socket.

> 
> Some other small points: issues should be posted to 'net' tree instead of 'net-next'
> tree[2], and currently net-next is closed[3].

Thank you for pointing out the problem, I learned from it.

> 
> [1] https://lore.kernel.org/netdev/20211027085208.16048-2-tonylu@linux.alibaba.com/
> [2] https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
> [3] https://patchwork.hopto.org/net-next.html
> 
> Regards.
> 


-- 
Cheers,
Li Qiang

