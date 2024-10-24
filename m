Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5314B088;
	Thu, 24 Oct 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764051; cv=none; b=tL5n6zTkrJcCLHoZej2RUZHeD+9xnuMrCeXPRrDLQ1nXtFSlXMNqnNgioLLVSIbGSQJ3qwIqmy1ijdQAKUaOPCb7ODZBNJoRElUeTy4pEoxAeEdHov17tn/IN7jKQg+wRov1EoqPCO107lB89T9CqI8T+isc8jDeeSggXM17R/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764051; c=relaxed/simple;
	bh=/MzpiqBK5uBE0u3FoqrrKUK+jiIckyJWA0U5/GOwrtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXd0BjXfm/w5V9kjRTXzGy77/tncEs633VHCVZNETlybRkhOANo7rasXwfLZvNcEB33uW/q6Z1k+/apotmzM1Zw0eRTVTviJ93LU2Aaz3IpcLX9FniYgQ/ilKYzouGLy6dwPnX2n6BR6bc+Mr8xl/dSm5fQ2Bk7n8cdrt/YtVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U/vNpmrB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U/vNpmrB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O7WvcO026027;
	Thu, 24 Oct 2024 10:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dhKHsS
	XcbJQEnePonUcJC6X9r2M3tUpNdJGkfNo7KOA=; b=U/vNpmrBO/I2wbUNvlnwiR
	5pbGWWG1unLK/QzasCK3rOM+qGOZAqteSlhNEUf3lkJofK3C3pwBt4JhgMNAr+j8
	piXXvnBxtot1j2OXRsO9u5CEAppRdBdyg6lp5sQV4iht4CD/BOhtfqmKpeCOWgWG
	mBA2ohDnN6NjUmSuwwb6D80CLnR/cMcfeDca9DEz/NkJ1gVqLi/Dj6r/7JsPYhMJ
	LSnGjrDDzt6Qc6tN7Xf6ygZQHgeRLyWiC2s+NL8OE0s7h+zi0mRNJEObZB6cWj8S
	O8eaicqhsHybIHrg+BJB4NJE2Gh/0/2ovg7BWcZ8NJZnAiNp3f9mOQ8+MjfiRRZw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fhxnrpk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 10:00:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49OA0iWI013147;
	Thu, 24 Oct 2024 10:00:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fhxnrpjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 10:00:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49O6npRh014576;
	Thu, 24 Oct 2024 10:00:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk7ysjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 10:00:42 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OA0fhh35193304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 10:00:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4E1658054;
	Thu, 24 Oct 2024 10:00:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B478858066;
	Thu, 24 Oct 2024 10:00:39 +0000 (GMT)
Received: from [9.171.35.241] (unknown [9.171.35.241])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 10:00:39 +0000 (GMT)
Message-ID: <61cf578f-020e-4e0d-a551-98df5367ee27@linux.ibm.com>
Date: Thu, 24 Oct 2024 12:00:38 +0200
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
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241024054456.37124-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xV3DHfE8zzSz7iSyun__0WW7cfMcBbu2
X-Proofpoint-GUID: xOBevlq1o5fhyrsUS31uY8OD-MlLYglO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=544 malwarescore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240075



On 24.10.24 07:44, Wen Gu wrote:
> Patch [1] provides common interfaces to store and get net devices
> associated to an IB device port and removes the ops->get_netdev()
> callback of mlx5 driver. So use the new interface in smc.
> 
> [1]: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> 
> Reported-by: D. Wythe <alibuda@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
[...]

We detected the problem as well, and I already sent a patch with the 
same code change in our team internally these. Because some agreement 
issues on the commit message, it is still not sent out externally. Now 
we (our team) have almost an agreement, I'd like to attach it here. 
Please have a look if it is also for you to use:

"
[PATCH net] net/smc: Fix lookup of netdev by using ib_device_get_netdev()

Since/Although commit c2261dd76b54 ("RDMA/device: Add 
ib_device_set_netdev() as an alternative to get_netdev") introduced an 
API ib_device_get_netdev, the SMC-R variant of the SMC protocol 
continued to use the old API ib_device_ops.get_netdev() to lookup 
netdev. As commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and 
get_netdev functions") removed the get_netdev callback from 
mlx5_ib_dev_common_roce_ops, calling ib_device_ops.get_netdev didn't 
work any more at least by using a mlx5 device driver. Thus, using 
ib_device_set_netdev() now became mandatory.

Replace ib_device_ops.get_netdev() with ib_device_get_netdev().

Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev 
functions")
"
My main points are:
- This patch should go to net, not net-next. Because it can result in 
malfunction. e.g. if the RoCE devices are used as both handshake device 
and RDMA device without any PNET_ID, it would be failed to find SMC-R 
device, then fallback.
- We need the both fixes, which would help us for the backport


Thanks,
Wenjia

