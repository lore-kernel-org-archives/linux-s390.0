Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F43B14AC
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218197; cv=none; b=pUQxCxVRPmDnWJWofOaoIvc2XRMmau5ZASJV9Al7ObMwXgpYtMI4ea/ialmMQyd71LcorX7n1X9n7bHVcRyTriD6Lhl8STxAbXu/3xPoydrg+2qC6dMAzQ7KeC2wcuSLWepX7HqsS1trD83VQ76Brw4tJk4Jyfr9xv0K3L8b1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218197; c=relaxed/simple;
	bh=NyJ087qZJM0pyXfxI5Vkger5iaSXuHygZ92/UnJq5BU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=f/FCmTqI9LCyhcv7Ci+u81n1nBIHcc9/ilmlp0+0QDeVfZS1klr6rlRke1/8oEMDm1XYQMbye46n7xy+YcSooIDY1Z0EMseLwxDH2OlyWnBxD0TLuXJgWFl8rlqBuMve/KpClm8L/BCv2zg/FuAPi0MA062cXkvboHQEdV1q820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fq2BCzy1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fq2BCzy1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmIHv1983848;
	Tue, 23 Jun 2026 12:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=DjfEkMvW1+uQtps6mRowBedfj0COVgdR2lDQWdQvZws=; b=fq2BCzy1V7UB
	d9+qN7MtFirJO71+ZN7XpcVrRqoONKT0mel0HShbdQSFGR25EkASc3B6KSwwPC0X
	2tDZrl8Yni6r+YeqOcRUFpwWGqGRfDxSEf2oeWjV+12K/3Yzy84AYkAMKgL/tNe3
	03ZXHqgHHqenTJmdihW501CjR+ZeVMshrD/ULENH/ch1BtYl0/41hyQBXTR4WdLi
	9TWLzhbuZFnbbMDADb7TRvf+46R//nDmr3Q0yb6vz3QvgO9H44/a9ULqRnU4asHg
	gKbs7ikncz5siikp4HW+zPQFUnJiIqw8QDEZoqR20f7p6i2a0KFhdyACE2myYWxb
	+eR3ELKepw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3efyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:36:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NCYfge030784;
	Tue, 23 Jun 2026 12:36:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qbdn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:36:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NCaEj421365302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 12:36:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D1058055;
	Tue, 23 Jun 2026 12:36:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8EE5803F;
	Tue, 23 Jun 2026 12:36:13 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 12:36:13 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 14:36:12 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 14/17] target/s390x: Support protected key AES XTS for
 cpacf km instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <66653376-f6d7-4370-b963-201053d7e903@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-15-freude@linux.ibm.com>
 <66653376-f6d7-4370-b963-201053d7e903@linux.ibm.com>
Message-ID: <7a8fed33ff59b4f663a48f18280c5740@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a7dc1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=h9qcHH6SNZZdh75yfzwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfXxZ2JflQrtrmD
 ZM5WC9wN63lXsJERmcV0/DmagH+S9INn1Piu2OPUZQu9SFQtbc9QXmkBcU6ncSNd6Gp6Ajiacme
 z7bB+glSV+HVHuxb1kbvEQWfTxgGfHY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX9R8Xlzh529Hj
 Nt/dGPV3cMTD0UjDfxw+/ZQI+BFE3CGshRmOD5v9apuHqxMF+bsxo/2d2AW2qjE/0Pj19x7NcAF
 7yBpxOu3UGTFQws4d1pLYQbNAeUE/xK9d8tZV9/dOMoveH0GQRRQF0XEF+flv6cYySEp7VnC89v
 MbKl9yrZ7MJT8ziTTxc53abaIJFlu6JrH8I2nA9K2a3mSXFWBDZBnCkVsvQ6KsFbWz9FF2ijTEY
 eoKVs18Ut33nr2fwhobSxY3cVaiZ02xEjx1hpLnsOhZqZvpxVRdpg0a8M93EbL/Vw+uIap++2VZ
 zCvNwHkJvzOj+xPRKcNpErq6bJheSL1kEUpSRN/wGokrOCy9AJ2R01b6GH8GTgKWovZoEX3FeL0
 MmYhEN4sZO964jMTCtnuxK7/x8z5h7LFJ5wLZDaxe1XaX9HNI8y2ZtlT7P92VmOIZnR7Iz2DwLf
 cKMZQDHZntM0nCPnPOg==
X-Proofpoint-ORIG-GUID: WiVLvZ_4k3u4_iWI48m2q88HydO_TboP
X-Proofpoint-GUID: WiVLvZ_4k3u4_iWI48m2q88HydO_TboP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

On 2026-06-18 08:22, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KM_PXTS_128 and CPACF_KM_PAES_256
>> for the cpacf km instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> 
> With the suggestion:
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> 
>> ---
>>   target/s390x/gen-features.c      |   2 +
>>   target/s390x/tcg/cpacf.h         |   4 ++
>>   target/s390x/tcg/cpacf_aes.c     | 106 
>> +++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |   6 ++
>>   4 files changed, 118 insertions(+)
>> 
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 126bacb281..c4c59c3504 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -929,6 +929,8 @@ static uint16_t qemu_MAX[] = {
>>       S390_FEAT_KM_EAES_256,
>>       S390_FEAT_KM_XTS_AES_128,
>>       S390_FEAT_KM_XTS_AES_256,
>> +    S390_FEAT_KM_XTS_EAES_128,
>> +    S390_FEAT_KM_XTS_EAES_256,
> 
> PAES or ENCRYPTED_AES

Again - not within this patch series.

> 
>>       S390_FEAT_KMC_AES_128,
>>       S390_FEAT_KMC_AES_192,
>>       S390_FEAT_KMC_AES_256,
> 
> [ snip ]
