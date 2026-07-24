Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2702264C7;
	Fri, 24 Jul 2026 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859606; cv=none; b=b+J2CSq0gdhvzvpKCXNpjBq27JgVxz0caJJd5Q2mkf0/ft95SgN9bMsGbUEv1Jq4htS39PY5FEdIvQJC9B3Yfr/lJNfoA/WtVv/2pwNxNqN6BUEOstMWuyF3Y6wGU+VwAJSqkhu2lyOAX9OTXXafqF7Sa8bRhaGXJTwXxtTvCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859606; c=relaxed/simple;
	bh=bM2MgJfTIioxRshsgRfGzzQyaCY2MgQJwD/dZ2+KstY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLw0H/kASVp/ef1k51iQA1LAHh+TB1qeHSPWwqvAW0R1ojvo1TxgjlkZF6prOK6rnd3aWAExWwwX/uAc8uGS89V0AYJe6DA36FaYYMmMoayh+7YoiGWC8Jae3Nj7B3zaXoJxpxLSidfsnF1sYSKeS9nXYNibRtn6/ZLShOGkq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KFpvUZUx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KFpvUZUx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLffOX4185747;
	Fri, 24 Jul 2026 02:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CBlL/9
	1XBU2q/RX5vZuRSTItVy67EPFxa9Rb0vPTSwo=; b=KFpvUZUx62Q5Otdgs41VZv
	xd5XzsaL0Ku03y5t3qFFKkmBYSbOAhhsi8YDCoaZbko9h4LsACnsqxoPLIhZPdbg
	+1Cbq8csCEqSDRBcQlSjDBvI/VndqdcsTA8Qu6CNn8mu9LAsjUzUz9rYspAUmNMq
	bf7h50DeRPtgWV1hHy5B5lvxDoz70bOVjq0lHJUraJPWwP2NkEjdlXLrIuu0dxT/
	PcL8H4IQTDIkBbLx4CPUH+Oi/jt6vPtknjoCpqEmEjdd9pXDbDeSO9rHA14my+Gh
	yIJ+y8oGosclrvaDBGlZ4uCe4NN/9rzFCGWG/gOeszVmWmDCJK+L0HiBrmC2TOyg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abtm60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 02:20:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O2JeWU026168;
	Fri, 24 Jul 2026 02:20:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk70ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 02:20:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O2K16e31392310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 02:20:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A650558045;
	Fri, 24 Jul 2026 02:20:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC08558050;
	Fri, 24 Jul 2026 02:20:00 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 02:20:00 +0000 (GMT)
Message-ID: <a37a5d44-fc74-4177-a55a-0b56035d531d@linux.ibm.com>
Date: Thu, 23 Jul 2026 22:20:00 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, stable@vger.kernel.org
References: <20260723221409.5874-1-alifm@linux.ibm.com>
 <20260723221409.5874-3-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260723221409.5874-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAxOCBTYWx0ZWRfX7WjJv9bzTyW+
 s32xZ1Jw2ho0oPZkqGxvme45s0Hpvu3q/qIZBJJGssmcirmSiQLf3NxhwIa9JY1ksAYkMS7zoTQ
 2bcc5SF5vrjQRnJF+x1HzUUoRWtYva9EqsygcmFqD7gOnS2BcoVoGRumSmSJlcOiCAzpzshMCv9
 CK2wLzdy302JSblOON5fAoWxNu7rw9ovSznYmr+9KiYT8PJ4QRANd2YEAmIqsy4m8ZXrQ8z7rnW
 oIMs/jIRGKSFvtbSWcz/r/GI8S5EFlRCQHGiPWT9jjuq7PJzDrtDCKOpz/TnLpmfxdQvIqYyKmv
 mm0MCT3srf+bdfZzwH9/UAE2qVnsGt2xYANov78cOeNDwP3N+vBXQdlNX8WmLQMhN5LYQt0b5oK
 hXEGO6zuyROp3sUaSlsf+LM5QrN8L9mxIpB96YxJk+r4kBtM+ArzR5lWzQkYXpolkFkfeUV3/I9
 F4BHtbGD+OSLBz+ZqrQ==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a62cbd4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=CjOyVlOpW9aXjeM8vA4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2LTPQsyPqL8An-BVztsHj87TeCps2YmB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAxOCBTYWx0ZWRfX2eBrxmdVIT2o
 r3f+7URBQ3aw9UudF2hUTVM+C30+0yAz1urx/SY3jiNnGPES8i3O1mJTJEax3JoZjgp6IbPL6/F
 BE6xI+k4R32QaXVVyAcDGJLuamu0M60=
X-Proofpoint-GUID: 2LTPQsyPqL8An-BVztsHj87TeCps2YmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240018


> -static inline int account_mem(unsigned long nr_pages)
> +static inline int account_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
>  {
>  	struct user_struct *user = get_uid(current_user());
>  	unsigned long page_limit, cur_pages, new_pages;
> +	int rc = 0;
>  
>  	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  
>  	cur_pages = atomic_long_read(&user->locked_vm);
>  	do {
>  		new_pages = cur_pages + nr_pages;
> -		if (new_pages > page_limit)
> -			return -ENOMEM;
> +		if (new_pages > page_limit) {
> +			rc =  -ENOMEM;

FYI there is still a double space here, Christian maybe you can just fix when applying?

> +			goto out;
> +		}
