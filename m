Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6741DEDA;
	Thu, 30 Jul 2026 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412545; cv=none; b=K6Pt6/PyJoSGmzoSZAJjsmCMwxmba9apl1TZwsjjlhLbYo/IKBoSJESl29gJidhKQgdIrLMYprp1hbOe4Sg1Iykn4xTaFd/OrIlVfCL58pROyqHOWkcaAvVN6w74z9FZf9Ixr/irbJguxF+l0AwUoqPDm3WT4Bhk0YEIq/x/mgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412545; c=relaxed/simple;
	bh=m+RjMTV/oPukgMnbmYSqlkYLDOU9QVYABdNwSBU+Yds=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Or/nYWcbt5rpk3BA6VgsQPahmvVODgtEioGlTQyF5eESuCDGR7lNEwrRVcAyVjI4+g+lkuv2Ejx1taAe9cM+ObxGoVdjK2VzW+bpGwrFUiAiBVZxQKaya0yfb+XsHr5zTVtwIAFA/+cqWQOpxDCZoR1jE0VY10RtcMU+pujSyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EVP4nlMC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EVP4nlMC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHoa32638756;
	Thu, 30 Jul 2026 11:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ubXW6QX8Ev1SJ32yxXpKc3GN7z0fGPYjVaunOt/FDnY=; b=EVP4nlMCBSnH
	QXbMPvu/PXKv9tkGlcdZ3azDN9HfbhFfii6zXm5vU55hXh9P4N3HQl+W/19mPfVc
	E8KA8hembQtvwZAv8gRCT8ytxLVDQU+7CrwbWCnhpjk02Eq7ZERzzKbPF4nbhaGF
	SCJBASUP1s+LodLw0E1prDBDn/KcPvgC9J8L0N6ubWkJixxt2krKoS31IkohBG2c
	TJRvE2L5bXoYQEHbhoA16H2MIR/TSPNioqkF7ZA2pNe0bQPkb0hjLEQad6wkO/lK
	XWVefl3B+t1zGWF5QloZpjLHk7tITta54BWiO5xl/LqXqYAPu6y9f+n1zFgyZa4k
	UPde7bujZQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nxmsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:55:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBfHJU027324;
	Thu, 30 Jul 2026 11:55:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqkbbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:55:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UBtdhc29229706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 11:55:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6D745805C;
	Thu, 30 Jul 2026 11:55:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D40A58054;
	Thu, 30 Jul 2026 11:55:39 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 11:55:39 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 13:55:38 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v9 4/5] s390/zcrypt: Improve EP11 CPRB domain handling
 with ASN.1 parsing
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729164647.60ED81F000E9@smtp.kernel.org>
References: <20260729154458.195135-1-freude@linux.ibm.com>
 <20260729154458.195135-5-freude@linux.ibm.com>
 <20260729164647.60ED81F000E9@smtp.kernel.org>
Message-ID: <281815f0c6e4ecf971c80d03622af6c6@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX/mvh2tPSLpuA
 haTEeXUgshzGV+CNV1aETfRjq/imwMwAC9NX3EYNd6Kqrfw/iBpauaM/i9c5S4Dd2lcC489NvbW
 0xuh4R+2XLVXXByQTKHod59z74gQBm8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX1BfGX2+mqc5G
 7tqaU1rNmMFAQZ1LyhscuPKffckC5KO5W2816quICt5tONuQ2qzVhMCAjhGEbvj9DFZqV4W0aL3
 xWIygPuXigjicvRSIpph7HxTMBvZ32qIlEssd2tubqRuJIwEqbN1v4MVs/zYK2hCZ/U9cEh8ewD
 ZJufz2+VP5JUID8SVWDD8lJGcOXJOnS/KmnLp1fcK3AVeosOPV7xtpm1kK7wo5ow8nsxQuEn1g1
 Uft/pXgXSejbQHMTvTQJF2i4MF1TQAD81nY8/Nc6SsjR2DO1uQYggIq/xseX1fXAQ6DSdivFkw6
 XIPUR8IOgShKSURjcm+zrXif47gPlORhaXuKcb73P9Oa4pJARPi+zm50C+sZfmLsUhxAJHZup0N
 2FWo32fm6sSdN0pa2iHX1eVQOdTIYHom/5Dwi8sye/1ifeahoiOR831GGnIkzRVm//xZPzHfCY/
 QxlkWm4rqE/e860Xn3A==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b3bbe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cjGM8bYk4SjidVYFmNIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: uUR3telO5ZjcBqfe8plqjqnWfrfRtYWM
X-Proofpoint-ORIG-GUID: uUR3telO5ZjcBqfe8plqjqnWfrfRtYWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300089

On 2026-07-29 18:46, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Critical] Missing bounds checking before reading `pld[offs++]`
> causes an integer underflow in `pld_len - offs`, bypassing bounds
> checks and enabling an Out-Of-Bounds (OOB) read and write.
> --
> 
> --- Patch [4]: [PATCH v9 4/5] s390/zcrypt: Improve EP11 CPRB domain
> handling with ASN.1 parsing ---
> commit 750aceaeb85ad5fa9ff8e2614110f89a4c147522
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
> 
> This commit replaces struct overlays with explicit ASN.1 parsing for 
> EP11
> CPRB domain handling. It introduces bounds checking at each parsing 
> step
> and adds a helper function to safely write integer values.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> 
> [ ... ]
> 
>> @@ -1235,51 +1258,90 @@ static long 
>> zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
>>  					   struct ap_message *ap_msg)
>>  {
> 
> [ ... ]
> 
>> +		/* payload length field */
>> +		i = asn1_length_decode(pld + offs, pld_len - offs, &u);
>> +		if (i < 0)
>> +			return -EINVAL;
>> +		offs += i;
>> +		if (u > pld_len - offs)
>> +			return -EINVAL;
>> +		/* function tag */
>> +		if (pld[offs++] != 0x04)
> 
> [Severity: Critical]
> If the ASN.1 payload tag and length encoding completely consume the 
> payload
> buffer, couldn't offs become equal to pld_len here?
> 
> If offs equals pld_len, does this array access read out of bounds and
> increment offs past pld_len?
> 
> If offs exceeds pld_len, it appears the subsequent pld_len - offs
> calculations will underflow to SIZE_MAX. Would this bypass the 
> remaining
> bounds checks, such as pld_len - offs >= 3, and potentially allow
> asn1_int_encode() to write out of bounds?
> 
> Additionally, it looks like a similar pattern exists in
> xcrb_msg_to_type6_ep11cprb_msgx() where pld[offs++] is checked for the
> function tag without a prior bounds check.
> 

I'll add checks about exceeding the payload for these both functions
into the next version of this patch series.

>> +			return -EINVAL;
>> +		/* function length */
>> +		i = asn1_length_decode(pld + offs, pld_len - offs, &u);
>> +		if (i < 0)
>> +			return -EINVAL;
>> +		offs += i;
>> +		if (u > pld_len - offs)
>> +			return -EINVAL;
> 
> [ ... ]
