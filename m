Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E633C518;
	Fri, 17 Jul 2026 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279122; cv=none; b=kiK+S38F6mugA1o9rUSDdw/XKUetltgqxVw9EZ7S5w272cjiDYvUgEY8nFjHcsQujnb0ou2YO/FfdhqtecwzGoHPY29OYF1TmoIoFedLPxBHiix8iKIGENxwmtOFxBSQ5d1Fedp/XxgxBbA8aU4s/VRTmsv9jkAcEgglnFg28uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279122; c=relaxed/simple;
	bh=duervrsXsempBqbm0OWKWBcN2NT84vcay8Uab08FJ0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5A1TErCluxK9OIPPuLmBYzIviNu5pQg+TKzzwIfuqm+AfvxWeoADQ/cpmlYcYWx640VGlX6OZ3kqouneV9a/jTbw3H4n30dWFjv3f8+jlEwPV6QsfPrue6Q7VfcWjc6Sh6a5a11D7mOXXuY7KOmxrF6Rois0Hm9bjr79cyxnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ASyniwHo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ASyniwHo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6fbBu3602047;
	Fri, 17 Jul 2026 09:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j1mCeF
	4U+u244jn5iAkFoGO6ncb6yfVP0T4Ela+HT98=; b=ASyniwHocK+TBhRmwZ8x1+
	Niu6sWO2LYN4oSvppeT+Ir1w/l8zRbOPnD7hzjo2qaq6eHcDUMjctaUL4riOVqmW
	209oG6LBYhQ0a3Qb28zGYCfvRIw2jwvmkLyo/8t6eWmbewD7/svYlPLJsmYoa0dj
	9nih0JXIjwlKr1/+PJgWaWVUvgAgPRtS9pA/1RLm44faUKpHZxMFl+NwiBBRkgy4
	hRxqHHEBNjiSue7yhXzyfTjOnbaocPLHXWmR9c1QPjdrYPcRw2/jCEpfSMi6AO3m
	qgB/mn8oQP+Wv1jmnn5bC4yeoc1o4oA2Wj35upDTtkSehT7+5hDFGKBsQngcGOsg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33p6a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:05:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H94cKP026520;
	Fri, 17 Jul 2026 09:05:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhrvy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:05:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H95CoY52494592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 09:05:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9898120043;
	Fri, 17 Jul 2026 09:05:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 557B720040;
	Fri, 17 Jul 2026 09:05:12 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 09:05:12 +0000 (GMT)
Message-ID: <1e04d9c8-ea80-4b19-8f56-9d622261964a@linux.ibm.com>
Date: Fri, 17 Jul 2026 11:05:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] s390: Reintroduce support for DCACHE_WORD_ACCESS
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260716141436.2125703-1-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260716141436.2125703-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA4NiBTYWx0ZWRfX3+sT3RiDj2b7
 +6P4bQNYxEIacAjcT3gqETtLKim65IJxGKCTx6A6JrnCm9bgMKJFeVozpuPjFvGUPNYDHdTPY/a
 xY1ajAOlB0gI7F9D6s9qJu/a14wydYM=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a59f04e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=yUqyZBMAralKIz-t7gkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EIbV_yYe33i9iNS7qZQjXH9_wsZdEmCY
X-Proofpoint-ORIG-GUID: EIbV_yYe33i9iNS7qZQjXH9_wsZdEmCY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA4NiBTYWx0ZWRfX/Z1c6Llf73pq
 Gv/rE+9Nkg6Sv4CL+diZ043ntjsfthZ+2z5FE2YpR70vT2iXhPPLsIEY/S7dELAPh1xiRco7KB+
 cPVUVG/md27oRP+lXRc615durnAQ/AOA8XAMJFsowbVrwgSQWyW2Cu69/rm8nUVQGWXjjIXhmcT
 Z8uVLfYLtfgdKN0AFS8TCw7kvUTHQBpx+LeRKYX7WZdYvxqHSYlkhE9T8ZmK7/3Ij+vBZOC492g
 swM2bOZhWGE90UVhTbFbEkJccLJvkl68M8ZkHZ8pI+b4mYmsjNz+IYoRA83yzlADc+6ogLpxLWs
 b/+nhY0jiGEWnyVS/jJOKE7AvW9WsJ3DRH+JaYw6GYRFXlKdWNpUyPwZ+XnYhehtOedKaPeSEd+
 JJl/qtH9gFJw9Lq36ourzkTjuYtv8/5H/rVFgC4hFm8E25UYyVa5ZCrdXatlsopuui4kP2r6rWu
 iXqUPIdiQ8MGZp8tsiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170086

Am 16.07.26 um 16:14 schrieb Heiko Carstens:
> Support for DCACHE_WORD_ACCESS was recently removed [1] since it caused
> problems with the incomplete handling of secure storage access
> exceptions. It looked like fixing the exception handler would be a larger
> effort; therefore support for DCACHE_WORD_ACCESS was removed as a work
> around.
> 
> Address the potential problems that exist with secure storage access
> exceptions and add support for DCACHE_WORD_ACCESS again.
> 
> In particular address the following problems:
> 
> - Reading the guest variable storage area via the /proc/kcore interface
>    results in short reads. Address this by using a VM_SPARSE area for the
>    guest variable storage area. VM_SPARSE areas will be handled like
>    memory holes (zeros will be read).
> 
> - Fix handling of secure storage access exceptions in vmalloc area.
> 
> - Remove folio handling for secure storage access exceptions to avoid
>    potential data corruption.
> 
> [1] 37540b8c287f ("s390: Revert support for DCACHE_WORD_ACCESS")
> 
> Heiko Carstens (4):
>    KVM: s390: pv: Use VM_SPARSE area for guest variable storage area
>    s390/mm: Fix handling of secure storage access exceptions in vmalloc area
>    s390/mm: Remove folio handling for secure storage access exceptions
>    s390: Add support for DCACHE_WORD_ACCESS (again)

Whole series
Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
with a kernel module and a hacked up kselftest.


> 
>   arch/s390/Kconfig                      |  1 +
>   arch/s390/include/asm/asm-extable.h    |  4 ++
>   arch/s390/include/asm/uv.h             |  2 +
>   arch/s390/include/asm/word-at-a-time.h | 22 ++++++++++
>   arch/s390/kernel/uv.c                  | 59 ++++++++++++++++++++++++++
>   arch/s390/kvm/pv.c                     |  6 +--
>   arch/s390/mm/extable.c                 | 18 ++++++++
>   arch/s390/mm/fault.c                   | 10 ++---
>   8 files changed, 112 insertions(+), 10 deletions(-)
> 

