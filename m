Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D93AC0CD;
	Mon, 21 Sep 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974402; cv=none; b=r0Gs8CaSpmRIIWur8LvCtPBwWISdyYovx/7ZK7RDwik6bcKe+eYXSvX3/OzmnAA16RZ6WfYPLaA7IFGPwPYhR4EbLdbo3kwIXoRF/IDPomqbok+RdVyviLfuggAuaHfFkAQ3isytJYj67VhpawtNV4163cZoTtxVgUR4vkWsE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974402; c=relaxed/simple;
	bh=bPFctwbE6NbE958TS53SJjhUXr8bObgY2FGH1qFcCEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqfQR3SmZDlpZWoPVyk5lzPDIMgTwr7EnWBiAcPvVjFnCUQ0Euu07BOfV6XACyGc/Zc6RnqCVRqfFu5N4UqsHKoC7lQ5JdycExY9Cnh4QIIi5iVgCv8MwV3hOpS0Rwd4KprKZBYERYNildEk5t+eEEd5ngGG6h5zOzFmVVNB1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S2n/r1UD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S2n/r1UD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3ZgYa265483;
	Mon, 21 Sep 2026 07:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mJp+DU
	vQW3PJ0dBQYyzLoX9Z1L7YVSe7JJAr6wex5kc=; b=S2n/r1UDmm13k8Fu8BgFPk
	GVhiKaUvXGR4j8JRSIQ6PJOOwOqiRyGtUpvFHL8cq7dkYjbVhbhP85imMFUzb2Jh
	GzZ8tryenMz7OhCM4rbBd31rZFoB1oqDzYv0gxcK60Q8lUo5X7sTkFS6RnBTMQBy
	V0d+2k1Y00IVV2ixCNh68m7Eyv43pE6hxrCVfTt/pIhE4Uw/qSjdiWsKizH8ZfgP
	i6xxWmpmCK1BCP4eCVycrK4oNBaDHAEeTKZ0atRLBAtxSXYVlL/jOcBrBBjuP3Nc
	z6lIm3cQ8nBd+vNibEAw1xv+KYM6exF5BVfIsf4IatRe3+9+mGakM+mhbGK515Mg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg277pq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:06:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3XYYE1596418;
	Mon, 21 Sep 2026 07:06:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy3yf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:06:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L76ROq51118422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 07:06:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC2B82004B;
	Mon, 21 Sep 2026 07:06:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45B8320040;
	Mon, 21 Sep 2026 07:06:27 +0000 (GMT)
Received: from [9.87.147.142] (unknown [9.87.147.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 07:06:27 +0000 (GMT)
Message-ID: <06158c64-6d2c-4dda-a742-0ef7b2cd0583@linux.ibm.com>
Date: Mon, 21 Sep 2026 09:06:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: gmap: use assign_bit() where applicable
To: Heiko Carstens <hca@linux.ibm.com>,
        "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260920022642.3145674-1-peng.fan@oss.nxp.com>
 <20260920161808.18515Ba3-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260920161808.18515Ba3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z-Jv3k5KItJsQIGYjSeI0Z4-iqq8Q86W
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab0d778 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=8AirrxEcAAAA:8
 a=RxYoiiObWgdx8EDIwDoA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwMCBTYWx0ZWRfX7iTHgGr9/FYz
 2lsHuS/ZWLgpa+kyzt4FP51ZzDkKImS7LTnxp/c9vP6d2JwKk+BiJoEhUx/ls8ZkcYMpWvOkpUm
 hf20HP1WB71BD6JWg8DbcR+dfqxoFIy/7uxJ6+0uv/84ZfAu5EtE4/7V6UYEnC3pkzC6itRH6sA
 7FetI4DIj4zpJYquTONfonHxX0ReU8s15pCR9IwrbxWttdJsyW767lkh7Cm0xAsZzG2V8784Xba
 2tZu4fLB1hXdbh1x0Oeqm/wJF3ry/gfF8BT0sPrpYIS7NXTgoGi3U5lASc/O9Bu5KVUxNex3foU
 CzTCRmaFwgqL1/LZ2WlO9x5EIXksvKJuCaMIsQKNQyKmnbOnPFB/Ety75+krt4y2EO86+Zhfsy7
 bg1Vi8afW73pk++ohuF9IQWnf5xFOf/pubLT9JovqZoG/iWbL2J/9tQNJS7rzcy4XmEHNhucwTr
 3fECrgk9YKzzHo/uxiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwMCBTYWx0ZWRfX5pfWzPXQ6n79
 mPFSm7oihYJfib50oLRDAyH21tsqSgM4u5iTJK1yvDWqwE5/zZOOLH6CC1smHBF9nn8gk1p4z/E
 ekkzlNHV/ylhDShV578bGJ4slH5x034=
X-Proofpoint-GUID: Z-Jv3k5KItJsQIGYjSeI0Z4-iqq8Q86W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210100



Am 20.09.26 um 18:18 schrieb Heiko Carstens:
> On Sun, Sep 20, 2026 at 10:26:25AM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   arch/s390/kvm/gmap/gmap.c | 17 +++++------------
>>   1 file changed, 5 insertions(+), 12 deletions(-)
> ...
>> -	if (test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &parent->flags))
>> -		set_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags);
>> -	else
>> -		clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags);
>> +	assign_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags,
>> +		   test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &parent->flags));
>>   
>> -	if (test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &parent->flags))
>> -		set_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
>> -	else
>> -		clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
>> +	assign_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags,
>> +		   test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &parent->flags));
> 
> This turns something which was easily readable into an unreadable mess.

I agree, this is not a good use for the assign_bit helper.
