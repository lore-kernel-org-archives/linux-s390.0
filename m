Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89356CDBA;
	Thu, 24 Oct 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769491; cv=none; b=rhqA3Me9CxWejF8IPrp0AaDfCFPBObdR5GJSQM1yPRBJD5LsDunpc7uHEDefbMh+doqAs2I3sqiOTwsQWH1mO3b/HpFC9sdEwEp2WSMeiEplz63a3EVc7wVrZDqE4mO47KrqSp8OCGw+bb0gPXBMGcvqs7MC1WtizWfekBFsx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769491; c=relaxed/simple;
	bh=EzG65p/3mG90J13jANzUL0uJE9ckeo99l3zD9kP4JbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP3CtPwZtX2NVaSHJAws0Hh0k7mZWk4zL5/RRvp2dtjY8mCyKZ93GQvkva1oC3pC4g9e/DRAvD9jSY+Ho0CD3j4ryQ/3+8kGS7mKos4W7/QZlmFAWScFa/TT0iF+kEeu5rBcfTMGNmCYAjWRGFVqDZxgVHXRAJV00bG1qaCkw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CxjxkFRg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CxjxkFRg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O6RLN9002694;
	Thu, 24 Oct 2024 11:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OQjayV
	YYXot5uUkMNP0kQpMjfxCNsi209ZgK94ElUbs=; b=CxjxkFRgiyQW1TvBzgMKce
	vNDmVqjkDc2nLWmKKrENNOofwNzvIyLjmfBpSLy+aXgz7sESwrR1Yx+5jj+r+gIb
	yCok34ySnNO8ZU33GKa7RFeLLmbJ1vgsKP+nA4dSG8AQTL0CAybkwMPlQsDuaDra
	7s8qeeqjt4hXewLkDpkfSKNdMywF9CJ1iGU56nOGdC9rmriY1Zyox20m+uiMuiFJ
	tdlRB/W/M4P3fiCdfpNNby5r8S+RrQJZH5rXylUL5a6XjafoUjPunnkRQ1jOa7RH
	m8wvj5LKAau2vlgx6HzZa3n0FTGRNUhmX704lAzXj0pLdGLBi3Ii+jErm9d3JpTw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fgyusda5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 11:31:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49OBVE5O024065;
	Thu, 24 Oct 2024 11:31:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fgyusda3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 11:31:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OANwFv014286;
	Thu, 24 Oct 2024 11:31:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfr5b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 11:31:20 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OBVKUp3277418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 11:31:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BB585805A;
	Thu, 24 Oct 2024 11:31:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECED858054;
	Thu, 24 Oct 2024 11:31:17 +0000 (GMT)
Received: from [9.171.35.241] (unknown [9.171.35.241])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 11:31:17 +0000 (GMT)
Message-ID: <067ca6f7-a5c0-48ce-a3f9-81de115f19f0@linux.ibm.com>
Date: Thu, 24 Oct 2024 13:31:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: use new helper to get the netdev
 associated to an ibdev
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241024054456.37124-1-guwen@linux.alibaba.com>
 <61cf578f-020e-4e0d-a551-98df5367ee27@linux.ibm.com>
 <ec3a2232-7787-4e0d-a0bd-a75280c3982f@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <ec3a2232-7787-4e0d-a0bd-a75280c3982f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0AFiR2aQqgCnk10om8Ip1O6D4JeLAmm_
X-Proofpoint-GUID: Ys0FXCP4IUSAaZbHoYsrfEJGae1ndhpR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=655 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240092



On 24.10.24 13:06, Wen Gu wrote:
> 
> 
> On 2024/10/24 18:00, Wenjia Zhang wrote:
>>
>>
>> On 24.10.24 07:44, Wen Gu wrote:
>>> Patch [1] provides common interfaces to store and get net devices
>>> associated to an IB device port and removes the ops->get_netdev()
>>> callback of mlx5 driver. So use the new interface in smc.
>>>
>>> [1]: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev 
>>> functions")
>>>
>>> Reported-by: D. Wythe <alibuda@linux.alibaba.com>
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>> [...]
>>
>> We detected the problem as well, and I already sent a patch with the 
>> same code change in our team internally these. Because some agreement 
>> issues on the commit message, it is still not sent out externally. Now 
>> we (our team) have almost an agreement, I'd like to attach it here. 
>> Please have a look if it is also for you to use:
>>
>> "
>> [PATCH net] net/smc: Fix lookup of netdev by using ib_device_get_netdev()
>>
>> Since/Although commit c2261dd76b54 ("RDMA/device: Add 
>> ib_device_set_netdev() as an alternative to get_netdev") introduced an 
>> API ib_device_get_netdev, the SMC-R variant of the SMC protocol 
>> continued to use the old API ib_device_ops.get_netdev() to lookup 
>> netdev. As commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and 
>> get_netdev functions") removed the get_netdev callback from 
>> mlx5_ib_dev_common_roce_ops, calling ib_device_ops.get_netdev didn't 
>> work any more at least by using a mlx5 device driver. Thus, using 
>> ib_device_set_netdev() now became mandatory.
>>
>> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
>>
>> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
>> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev 
>> functions")
>> "
>> My main points are:
>> - This patch should go to net, not net-next. Because it can result in 
>> malfunction. e.g. if the RoCE devices are used as both handshake 
>> device and RDMA device without any PNET_ID, it would be failed to find 
>> SMC-R device, then fallback.
>> - We need the both fixes, which would help us for the backport
>>
>>
>> Thanks,
>> Wenjia
> 
> Hi, Wenjia. I see. Since you're ready to post a patch, and this one has 
> some problems,
> I think you can supersede this one with yours. It is totally OK for me.
> 
> Thanks!
> Wen Gu
> 
Thank you, Wen!
I'll send some fixes this days.

Thanks,
Wenjia
