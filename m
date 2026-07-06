Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB6374A0F
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345332; cv=none; b=RRqQWdxLMw44191/vN0Bnjn2+yROE66y86HrrsBbvVeX6snHOpKq23WcGspr2kZ1CUVBYFhajglUA2smtia6BbJVUpm3upbe6ETvPakWkFZ7anofP5yX0TUjRzUneIz2Y8jOux47eN9wluvJ3kzwWuK5jMl8yLNOoOZ9WQX4D64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345332; c=relaxed/simple;
	bh=iQjDnwnHgBP90hupcsmOHVuzODqf2y5FcOaIB7wfyzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQ8NaEDOlU4DMYokBZHs0hVJeUzQYn4uPbM3oErj3GW8NXjHPOZCSy3LNUmC1ih+DUYuK+PzlgtbstILeDNK4bMBBIwsx92rEmSNJu7LBOfBcXBYPhlQF68NOG0EJMtjBUo8XiVNQ8KGlH288G0rPtwDK3IdHOfrvF6Wd7CTfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ogmiglOA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ogmiglOA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIvwM042139;
	Mon, 6 Jul 2026 13:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f1zyI2
	N5BiStVzfRR+ln8Poq2VHM34y/RkM1l6h5T2Q=; b=ogmiglOAWqvSgGb1FSW4r0
	hME9blWdn3+RHqEJN8cxSHyLOzYGvaHR93tSwgl/imbKSKfeJt/Ig3Jd/YWtQks3
	VKZBqe1NQydnb9jHI3Q2eXaCIWGP9+Hp+X91WAy7CgBHhXAEVsczp5VpLgc7O+Jh
	0x0R9EZzA8y9TNk6WcIlK2nfWlKisNf+ZrD/zpBo2RecPlCTwzSe+MiMn07zbV6N
	OnFdYl2XU4V3RHcL2jWCfW6UyAdigMqyANwyVBQDEGgV+SPuJmWIp83Q8BOrfGQW
	IGlg0txZf7x5aaGymdfuPqZ2FIxx9/cwkAlvnST8+5JHq7mCfMcK8BM4aWxBVZug
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn9sje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 13:42:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666DYnUA031829;
	Mon, 6 Jul 2026 13:42:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h5pr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 13:42:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666DfvGZ48365828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 13:41:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD5FB20043;
	Mon,  6 Jul 2026 13:41:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 434D620040;
	Mon,  6 Jul 2026 13:41:57 +0000 (GMT)
Received: from [9.111.8.43] (unknown [9.111.8.43])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 13:41:57 +0000 (GMT)
Message-ID: <aef2ba66-407f-4206-9fd3-838b7a23c63e@linux.ibm.com>
Date: Mon, 6 Jul 2026 15:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/21] target/s390x: Move cpacf sha512 code into a new
 file
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-4-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260706094317.17032-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4bb0aa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=rt_gzxHzaU2pJR2MlBgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aaYHxcZODM1zdNBiEPdMHM9Xx3YQ7pbW
X-Proofpoint-ORIG-GUID: aaYHxcZODM1zdNBiEPdMHM9Xx3YQ7pbW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNiBTYWx0ZWRfX5ZBUgpuGlUzn
 dKji45y2hPPOVzhskTwWAX4R5gfNvF3eFihCnUsqdX9/MLLgj6oOLLUjDRHqXaIyuGDqXOf4bdo
 gAJQ6vziDGg5FNcoYAgJuxdYgzAd2Dg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNiBTYWx0ZWRfX5C+imzUMg/x+
 bnau44Dg/H9ql+ORh86f4h1zptnyr4LFiPTXpEfXtUbWI6kVBp7uo7Cn6UJHmf+JAVnERHVZ1ev
 oBIAd+HXLUZ3TwFh7rGZXufJCeh1doaj7in4vYr4K4p+ovfgeJx35Iv0KBMvK8hgb7n5bFwzGFT
 QolIFNXbnyw2BXht3n6LMnJ+mptLSEE1cMcKfz4DFLCwxhwqapBZJ+yGgD4kMvRfS6DvSmyLocA
 HlqU7I+EelydQclRRTlPuNNykt8VM+QlDBSL9Og/EskxoCO+RuT3nKvvkzYjsERR4ThvevNmxmY
 o9mCb/FUEK0m/Kvb4MpvR9SjenjClJOwWL912e0cTOXPYhIaXpPCGGo10IqfyQGBllIfdIG8kNT
 nX5D2xZTZ+aA3ORoKqiWx3EqDyJofY3YSVjLM4tu+jBr2JZDZXC027UQ+jhUE9CQxCMxkhUMZwx
 KJdDRTbJT8HYeNMXkXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060136

On 7/6/26 11:42, Harald Freudenberger wrote:
> Move the cpacf sha512 implementation into a new file
> cpacf_sha512.c. Add this new file to the build and use the cpacf.h
> header file storing function the prototypes.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

