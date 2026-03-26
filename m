Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA23F54CE;
	Thu, 26 Mar 2026 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525635; cv=none; b=KyRIeELxlgbCEOq90wzmeFYZ12ibddRwLEAr0OErafQ9HjmfDVvrZYwxmv1vl1ufe72aNcaPfG9haSHKVlLLHj+6vcKwu1vFtiEOHM5F1czKAxssJe8rDTIQKz0akiyjoiMgwjAAmn4264qccYibAxDWe6NFsbZqrq6qLU7jAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525635; c=relaxed/simple;
	bh=dlPpGXx//n5T5moUjI+rO8vg+0GZiO4OZd9lEBC4jLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZYWkw0S/PcW+1gdE9NnsOl8cU/AdOTy7UnPWcx72GzITRF6YOsv3dzk+JMqRGLUFGdFD4sT7RKSF3T6yShHkNx1xtK0V6jp/S79MKWlCdpVhAWOnFlC1W4h39nV+H4Z13AncMxCxnfeaZBzYXqAu4EiOMQTmv0JrQYtglvk+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LjP1ckdD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LjP1ckdD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PJJqWP3448655;
	Thu, 26 Mar 2026 11:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hR1ylY
	3zMBgOobS+1fYUCgcaE9nWbk6Z8AzHCQhiqv0=; b=LjP1ckdDxJ8fjhSYmHtjFg
	BnB5cFfAgydDDaoJf6n4J2qbCYrYl9qPKXT/uYQ9T0J8TNWhDIouByuDIGmSo/YA
	P+XNjuaCUdULw2XCxS0b01pfJA6B9xcPeYVsuF5dbJw1MEr/l2cS4AhSpcMq+anK
	YZvQGjlKLELOPmpxjJ8Xv52eyWX932XvTji7VeW6KJzoaRmyhAJL8FW2bJbtJn2q
	+M1ZFWOP/oTYRu1MWiUdgRzrIYLTnmyk53t6r8puW0i8l/cFK9QAmzb7uC6RsxGl
	MSLvXXbkpqSCj9/9y73MBO03I2mMX64KjWB/dwS8d4bCyoTRva7TBqPNrg0PCA4g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa50qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 11:47:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QA8qJX005969;
	Thu, 26 Mar 2026 11:47:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ytw1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 11:47:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QBkvFB30605758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 11:46:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9A9620040;
	Thu, 26 Mar 2026 11:46:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A4C42004E;
	Thu, 26 Mar 2026 11:46:57 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 11:46:57 +0000 (GMT)
Message-ID: <1948daf3-9e5e-471b-94fc-c0aed00b4c09@linux.ibm.com>
Date: Thu, 26 Mar 2026 12:46:56 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, imbrenda@linux.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com
References: <20260326014247.2085-1-freimuth@linux.ibm.com>
 <20260326014247.2085-2-freimuth@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260326014247.2085-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: br7yJ2G1qbPiBXcEs3YXsnX5VTQkZWi_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA3OCBTYWx0ZWRfXxRWupNfcEfEp
 r8NKce1UWZfNyiLBBouuuI5HkuMi1FT/33O3WzWU6dqrvJBUnlSAQO/yhX3ep5r4SLgoHThGH/Z
 y/QrfSNlwP8PhQbOoh/X1D+pizh2XCvhh2tG92lvLd/z3L/GZhyrhj+b1/dM8LgbDgZe6x/qvUo
 esWRy2M4R2557j5MWPLci6M/Xnwc8kImp3IpIkvBEbFOctgQsh5vGtoDqTBQzCrM7U5M0dL4/Q6
 q8/nXGzdO80dUpQnYlmjXnHKgnkd+dtXc2oSt83+qHT07wP6OjOa5DLtr3pB3DlVQ0MaPIRIGKA
 rj5nta1W8Djq2Q9JNN3oGvw6kr6bU1PQK+OB/5dyHSvQ+M1FCYp1aDfmMS1qcSjFLWxDv3UyHxn
 ChTngR2HBlzGhAf32VuVu+wuPgjNnoldJPRtpvHQNNNbFi754oekfCzQ5jgHhptADpwFCIKUK1M
 ruUcj3sTxdXsxtRCTdw==
X-Proofpoint-GUID: br7yJ2G1qbPiBXcEs3YXsnX5VTQkZWi_
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c51cb6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=X-nRS1ZJXlCkhuM_9n4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260078

Am 26.03.26 um 02:42 schrieb Douglas Freimuth:
> +static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
> +{
> +	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
> +	struct s390_map_info *map;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;
> +
> +	map = kzalloc_obj(*map, GFP_KERNEL);

GFP_KERNEL_ACCOUNT certainly makes sense. Depending on other feedback can be
added when applying.


