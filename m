Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417A33E1;
	Wed, 25 Jun 2025 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827043; cv=none; b=TJ5lY8EC2DqzQTTdk6qEuCfGX05gtIPCcdr7hJN9xYcg+qj5Zay7P5gzecTJ80qKk6/SPhWk1vrITqPfuinck0mQF/cJa9cvwIHgKCF8NEQN7ivaULy/TSVT3dP7y/MiMo2ZVdRaCyj5H2MQs9r9k8w0HUUDQEf70oIuPe7rVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827043; c=relaxed/simple;
	bh=aqc+gMpA1+DN/Tgx5x6Ya26P2nW7j0pFtfe7QzjlQQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6IfYiDwZT7jnf4ih/woS9aUpPMlt4OtA5/H2Zd7FIONLehDIDMyhnB6oBn2d+rrDyNXf6z25dKVUHZopnLLJ68/HUj2OWSQit0emwPw77D0iacSFzuMjLfwlzOXG3wFTxW6W2HdmgEhvOr1k8lC5vixFXJFCJfE6rLvXF1LTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MUEcDAHu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MUEcDAHu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHo9tt012444;
	Wed, 25 Jun 2025 04:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Gl2wiN
	HMAFt67+IRnkJBFBrLINO7jV0ZGXoIV4h5SFU=; b=MUEcDAHuC94c2fXhhbmN97
	JURgjCfOSkUbzfvC1w2la5J8rRXPPDQdJcpEmCNaP3elTN9tFIjRqcZc55REMEYP
	YALjywxZ5JHsvi2ID6ckDd1g9RqE+q+QSPFOR4HNJK2J2TnOXW9gKH0O3mBeL1fN
	mp6vvGwYl5HdOVC7Nr1rm0mddT/AzVbpQXIG28P0p54XjD5D8sOsj/SaFYe85yGg
	roSXuQ5Ax3pId9vV/VPKaBAq3RGKqFtpPWwO1jLjd93cZmCvJwjtZ/oR32FpIvg9
	fDXEkNMBUSsHsvtj/CxUzlzIqyzdIHlATBvqEkTSOj1mI+GnRtSR9Zyi/9AP2udw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmfed3h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 04:50:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55P4d2Fi006952;
	Wed, 25 Jun 2025 04:50:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmfed3gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 04:50:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P1lQfN006497;
	Wed, 25 Jun 2025 04:50:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82p7kpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 04:50:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55P4oNet24511216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 04:50:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF6D55805C;
	Wed, 25 Jun 2025 04:50:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BE0F58058;
	Wed, 25 Jun 2025 04:50:18 +0000 (GMT)
Received: from [9.109.246.12] (unknown [9.109.246.12])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Jun 2025 04:50:17 +0000 (GMT)
Message-ID: <f2e3188b-02b4-4e23-8910-a180661dccba@linux.ibm.com>
Date: Wed, 25 Jun 2025 10:20:16 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: update smc section
To: Jan Karcher <jaka@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Halil Pasic
 <pasic@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>
References: <20250623085053.10312-1-jaka@linux.ibm.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20250623085053.10312-1-jaka@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bWdCRdCC0O040g0SDJB3bfhSIJ2cT4os
X-Proofpoint-GUID: JqIB68JLk1AU1IpRxK_2PzTWzGThMiH4
X-Authority-Analysis: v=2.4 cv=BpqdwZX5 c=1 sm=1 tr=0 ts=685b8013 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ThVKj-xsHEq-ROeZF2sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNCBTYWx0ZWRfX+hXs07Y7fe72 HfrsRPeqB7/JzSAepNkvavzObo0PXhUaDCkbTBmUtYsPS1NHpkweAJWC+dWTK9l91INc3ZzfPx2 tdbaqk3BqggyCMCwV8UTS5NZbE5JQLHKRzjJyeTIzCG2qVwJNb09ggAOOwUs9rK24AnseHtM/8/
 fPSKtz48LwjbhnmoVbAcRhRy5gi0Fvl4uWPMXuPxrDDiYmeGNnPkpuj66yZYUu2GiC8lX5MzqwJ NgOWvkZvtszSQ6PZ+HCDbkXqFhU5OoRPpWwgDjgqC+jnb//21O3wWXq/FdThJYnMt+QKWtd8EBh UOvNJSG8dMFQbsWbMIRd5E9SLKYy22DBB7sFEgBJS5JU7PKm6Nf+YTO/nDj0ICtTcIol0cmVFVO
 mjuZiJiVcONKcCcbRDQrT/5kwPAWGrDM8Ggmv65wu8TU4AewxTkLL/+h8TN4G1M+zU2BwuWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250034



On 23/06/25 2:20 pm, Jan Karcher wrote:
> Due to changes of my responsibilities within IBM i
> can no longer act as maintainer for smc.
> 
> As a result of the co-operation with Alibaba over
> the last years we decided to, once more, give them
> more responsibility for smc by appointing
> D. Wythe <alibuda@linux.alibaba.com> and
> Dust Li <dust.li@linux.alibaba.com>
> as maintainers as well.
> 
> Within IBM Sidraya Jayagond <sidraya@linux.ibm.com>
> and Mahanta Jambigi <mjambigi@linux.ibm.com>
> are going to take over the maintainership for smc.
> 
Hi Jan,

I would like to extend my sincere thanks to Jan Karcher
for his long-standing and dedicated
efforts in maintaining the SMC code.
Jan's contributions have been instrumental in driving
its stability and adoption. Contributors from Alibaba
have also been actively engaged in the development
of SMC over the past years. We look forward to working
closely with them and the wider community to continue
evolving SMC in the upstream kernel.

Best regards,
Sidraya
> Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa16..88837e298d9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22550,9 +22550,11 @@ S:	Maintained
>   F:	drivers/misc/sgi-xp/
>   
>   SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
> +M:	D. Wythe <alibuda@linux.alibaba.com>
> +M:	Dust Li <dust.li@linux.alibaba.com>
> +M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
> +M:	Sidraya Jayagond <sidraya@linux.ibm.com>
>   M:	Wenjia Zhang <wenjia@linux.ibm.com>
> -M:	Jan Karcher <jaka@linux.ibm.com>
> -R:	D. Wythe <alibuda@linux.alibaba.com>
>   R:	Tony Lu <tonylu@linux.alibaba.com>
>   R:	Wen Gu <guwen@linux.alibaba.com>
>   L:	linux-rdma@vger.kernel.org

