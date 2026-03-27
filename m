Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8B303CAE;
	Fri, 27 Mar 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624932; cv=none; b=A628SB5NkQXOI+zNSYIEOT4sLlthiB3THjO5m7FYhmDDL2QQd9RvTrVw2fI4U+YRenHsmXQ1r/uUtLSP+p4IIS652F25b35CBDL7luVM5okR54o8GkVeQYr+Lqp+8dYYjzDuzNc+sr2m0c/bVuN16ubfflmsNw2tzzH5aOoPBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624932; c=relaxed/simple;
	bh=zq/uFpgNPcQlFhlrC0AY41Tsgqx4q0cvxx5P1zuWSWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORNE/XKpZ2IYDhhvzEwCuI1ZbdJW6JWg30mi/gvYIr/xcqW3Iw01xNkG9BXYwRHlWNbaIngOFo3MxXOWOD15ont7Q5FqE+b70ZZ5KHonAowgez4imxBLf1bkOVsUwaSeNiM9PkGfqUD+Za7mssGvXAjONJY0XN+qNzZhWEa/s60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UJ4rmuqI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UJ4rmuqI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R4Lced028990;
	Fri, 27 Mar 2026 15:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nAcQ2y
	K2e3da86z0cfYxeS+6kqQDQ+wVnhOdssA91A8=; b=UJ4rmuqILVxhpJ4VWsJbwt
	WqmWVGwz7POousRiY1En1da6ILxEG4c0C0hz2guWZjyq3/gWr5RxDebDBzvMsbvJ
	oDCNji7+GlDsS7ADCP0nLecOaLdiznDyF27rAdC78gH5WiI0dHUQsF/PVo+IxvPA
	3mN2bvppV3mJswiGpN98Ha7mFE+4JfBhrL7dxctUQa93bAMi16EirDjRZ8j6QybL
	6Yl4cQKymDqL+My0+4p7LpEIb2+j2lIRU/vX3foUizFw0qAKVzNAwWKUkO4amIt4
	rVDCXSjYxW5CVR5wz1/DI1xuV458M9WvqPEQ/3VlRIwCQunHTsZAKfFHwn7txh6g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqtvkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:22:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RAsSBC008745;
	Fri, 27 Mar 2026 15:22:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26np00y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:22:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFM5Qj37224868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:22:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E77A55805C;
	Fri, 27 Mar 2026 15:22:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B23775805A;
	Fri, 27 Mar 2026 15:22:03 +0000 (GMT)
Received: from [9.61.244.240] (unknown [9.61.244.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:22:03 +0000 (GMT)
Message-ID: <fd8f5702-8118-4db5-b3be-d68a79fef0de@linux.ibm.com>
Date: Fri, 27 Mar 2026 11:22:03 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Christian Borntraeger <borntraeger@linux.ibm.com>, imbrenda@linux.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com
References: <20260326014247.2085-1-freimuth@linux.ibm.com>
 <20260326014247.2085-2-freimuth@linux.ibm.com>
 <1948daf3-9e5e-471b-94fc-c0aed00b4c09@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <1948daf3-9e5e-471b-94fc-c0aed00b4c09@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PFV2DQFsSr_8ypF90HRZcMtY9_okb9G6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX4vq0vtY/lAfK
 3CU2rPsLRSouYVrgDokCWV5GmhNgrEihFQwWpxW31cyQ8r+lqZ2mBdkAo4X77KNpl+cSDwF/yG/
 Hv/E9hvEWNjgIpPSy/fsN4LaQJBWDKzM4SzT218Dg8zF2Gmd/g7jmvpdp0r6bysxFHbYifOvqZo
 pYMLSewgk9Gatd0vXxA0LtnQ9Xps79LSmjVAh6BIv4EUYtC9GmxPAdl/lhJfNce+LCN0ZOfLrQB
 kaSCnVaAVMXorxMtanB04yuSoJSUAJ6MgXmQFqUy1HULq5Rz6jh9xAWPkwpTHXNjMT1NN8Q10SJ
 cm0A8H4hdtLMjPQET5PKGuYGrfJQmvjfWuyA/w/Oc5HPKWAYfJf+DPdYUTO7bYXLhlG80ZDCdWo
 Wwwo9bGcZDh0zHnWWa/VPJSR2+id2NMw/SWqESVtLdR1Awqq1M0hh+tgyubv6pofFRCsXOXXoOy
 +ePAfzfoGzJnmpGF4eA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c6a09f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=yp29nr4wFdSsSxMTDoYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PFV2DQFsSr_8ypF90HRZcMtY9_okb9G6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270105



On 3/26/26 7:46 AM, Christian Borntraeger wrote:
> Am 26.03.26 um 02:42 schrieb Douglas Freimuth:
>> +static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, 
>> __u64 addr)
>> +{
>> +    struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
>> +    struct s390_map_info *map;
>> +    unsigned long flags;
>> +    int ret;
>> +
>> +    if (!adapter || !addr)
>> +        return -EINVAL;
>> +
>> +    map = kzalloc_obj(*map, GFP_KERNEL);
> 
> GFP_KERNEL_ACCOUNT certainly makes sense. Depending on other feedback 
> can be
> added when applying.
> 
> 

I will make that change.
