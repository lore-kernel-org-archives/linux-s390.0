Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7B2D3ED1;
	Wed, 12 Aug 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549005; cv=none; b=o8koMkikn+K+WcDv475MKUp2GSuMk0Y+GQ0VbLAWETcJKosXO+Jt7X1BT3nGIwGtkqqo1OEHuBIvPmGvWTnp6ZbSPdJMRO1KonyQMcHcfOrPtYkYIS/tHUHlybrFdqenIGg9GO1nhBJwwq4cL6DbDSUrZrjXpewh9dNVmhqhheU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549005; c=relaxed/simple;
	bh=Z4aWhybO8QyHscTL+FfeVldumdpj57eg6iiNLjR08e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7UvBT4oB/WW+8Wc5/kEvLxERcA9h6UlnTj1PVACKpxwqBMlp/Wog7AwkungqWpkOXUvewhsjILwlmE8JsGmJVJq4IBRVcGYhBCaTfwJwCG5lCxeRQrRrUFqd4BG2Ezh+rAXiDcVFIIeCp4U9Fp3how7ObBNLn1xFyq01dMnxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WRoBoHMm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WRoBoHMm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1uFf3594446;
	Wed, 12 Aug 2026 15:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NhNEQc
	z76y4duudzQ8IfaOpMZZ+iu5utIKN/qAbRk8Y=; b=WRoBoHMmxb+akGHTeyYZG3
	vVup3oguiscbindm4w1wfo/FfLtlmpUjfPOvkZ9pqHoDs+ifPsbPR5IiVbGq4vht
	XJuErWftC721p+PZQ5AC1gHQBXD3RzF3Oe1e19270kg/La1S6+nqHzxfNe7C+OXC
	Q3RTIaO1XyGXKQ24RVsuTzhN0XVERlW8YyBJFRT2zfH2ecmWxoUsxPapBk8fJj+X
	h3txXeVtJcl/R0cgDamy7g0UKy/kVq6nPzd8qs9GN0yAOLGYwHFr9+HopXllYjNX
	/k/ouMtIw2HcQiD3cCYvuHU0Qjk2eL7CtLMKh17niQDXYdU0H7jYBFE3loC0Acog
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32e02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQGe5021692;
	Wed, 12 Aug 2026 15:36:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6g2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaRMR23659208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8E6D5803F;
	Wed, 12 Aug 2026 15:36:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEBF158060;
	Wed, 12 Aug 2026 15:36:26 +0000 (GMT)
Received: from [9.61.74.89] (unknown [9.61.74.89])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:26 +0000 (GMT)
Message-ID: <4edf514c-9044-4530-ad47-4fb468160835@linux.ibm.com>
Date: Wed, 12 Aug 2026 11:36:26 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] s390/vfio-ap: Fix bugs in vfio_ap device driver
 callback functions
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        kwankhede@nvidia.com, fiuczy@linux.ibm.com, pbonzini@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, agordeev@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <14e82371-8e39-4af6-b220-6f0d1bdf25d4@de.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <14e82371-8e39-4af6-b220-6f0d1bdf25d4@de.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c92fd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=epKttwDpbV6lW6S5-OMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2oLfxmlaanfYIDEPaZ_fSb6uG8c9PzRE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX1/cdd5AW1zoa
 NUf2osL5qzrH+RqeBjce5JuUqdfWeM8/J8LRzinSHUhxUhkikBIrTC7+P7F350At3HTA5xI3s/G
 0cOWQjUH9LZtywP8P6OrIrCmUSPtwV3loWjytg0lhYGTqcqDbDEKlAdcDCwu+OiopwTV8DZcGOr
 bbxMQjvAR3yX3f/mgkKGwojAoza8ltICOKvTUT/rJmR/jb5k/4l4PQtQUU/HtHj+1N1fqvPB37w
 rUQLC84TRi4qNR0bP5sGSMYy+FecOzqDuqDU600Xkk4Gbv/B91ReyCvmyBwIEAVs4frG9Zas4FW
 6LSFfEbvobs59FH4jISHkwGSn0l/1IHH3fLsdca1McY8V0+gVdpqMojXw2th96hQHMhzOHkbZKk
 xZkSqGuRio0sN6JntjOd/2xhY/CoqiF/TeYgE5Yw3nVlUa06jxCvZJh0Faaff2VrXQfmyLzEilA
 7e+DDgmTXal0jugvgmg==
X-Proofpoint-ORIG-GUID: 2oLfxmlaanfYIDEPaZ_fSb6uG8c9PzRE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX5wGUS9lRWdnk
 9X/Ce/HwASTPQmTS5ah/nQDsTtD+VbkRbWdkzsCjwtUxgf52FNP3Rntr53q10acGP+GywVXDL3G
 FRUmYSBrl3T564IGkS1O3HLmBvA0DHA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

On 8/12/26 11:30 AM, Christian Borntraeger wrote:
> 
> Am 12.08.26 um 13:51 schrieb Anthony Krowiak:
>> During review of patches by the Sashiko AI, several pre-existing bugs
>> were
>> discovered. This 9-patch series fixes those bugs
>>
>> Change log v2 => v3:
>> ~~~~~~~~~~~~~~~~~~~
>> Patch 3: Fix use of wrong lock in mdev probe function
>> Patch 7: Fix required lock not held during display of sysfs status
>> attribute
>> * Squashed these two patches into a new patch entitled "Fix missing lock
>>    required to access list of ap_matrix_mdev objects"
>> * Added two new patches that fix pre-existing bugs:
>>    ~ s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>>    ~ s390/vfio-ap: Fix memory leak when queue removed from host AP config
>>
>> Anthony Krowiak (9):
>>    s390/vfio-ap: Fix stale do_remove flag across iterations in
>>      vfio_ap_mdev_cfg_remove
>>    s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for
>>      NULL
>>    s390/vfio-ap: Fix missing lock required to access list of
>>      ap_matrix_mdev objects
>>    s390/vfio-ap: Fix required lock not held during update of
>>      ap_matrix_mdev object
>>    s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
>>    s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
>>    s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain
>>      removed
>>    s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>>    s390/vfio-ap: Fix memory leak when queue removed from host AP config
>>
>>   drivers/s390/crypto/vfio_ap_ops.c | 110 ++++++++++++++++++++----------
>>   1 file changed, 75 insertions(+), 35 deletions(-)
>>
> 
> 
> Sashiko has one new finding for patch8. Everything else is unrelated.
> Will you do a respin for this?

I am going thru this version now but yes I would like a respin that
fixes patch 8.

> I plan to take this for the next merge window.

I am also going thru all of the Sashiko reports, most are already
resolved by this series.  But I will send Tony a pruned list to
investigate after this series vs adding more fixes to this one.
