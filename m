Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384DF35E930
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218098; cv=none; b=QOXLVE7sTncnt2l+YXeRXxKBk6eKzxSsMwP+wwETavb5jHRlmBJNuuziHcyq3dBLcNpvT6xaADDsSufIU9eD2dRX8Y2p+7PLrD9tZSsUPOPNtNsvsbwBTwdUTxvvqO773dFADY9drbg0J6IskN2MTHlXMIPaqxLq5BLt8nMM5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218098; c=relaxed/simple;
	bh=5rh563sQnEltBsXjWKXHNYG9lgaP/e8uLAUD+w1oeOc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VKmHPq9TepR+13JYm+bDt8iQ3ovopI5zH9buRpHPqkNAjyouiT+2xYBCAIzJKCRQ9BadWGooFykN4ImsQK8DxUTxMlsQFg6y951fIlbnYZLoN1CkReHzP80OWkhBuFfSgXIN2AAbYcMGdwOVrThhN/jokB/OSFMxQg3ZAY5cFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E9mOSODO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E9mOSODO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmwcR1827016;
	Tue, 23 Jun 2026 12:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=SCn3pyGemlFZuGyBQ1NlnZs2XDzpcVnszVFrsVtuf2Y=; b=E9mOSODO23m/
	caQJG+75yyKzUkb8L3wsiBSeAgZWJ3U5gP5As9QnGxUZ7YJs7j/+I6XhNShgx8ij
	+L2lmrwP62TrbEZq9d8tJAWm/Z8zbGFRgJuqqpNftCbr72uS9ckkqUHxwOg5W3MF
	Gq2aygQf+usxfP5dsbLj5plxl5djfsdSbLFli7bkVvNFoR2DQLoKv2K7w5Ymj7mt
	ZtRsDUVTWpig60u8l4MmFI+Iir9DXLv6rqUNHsrFpL+DMVdBGI1gbvW2PR5Hj7YX
	8zShnxXS0Vw+KOnK6WSUMI0hm99OC2mU0K7tKMNPTN3h7q+lNaC1m5qcnjujtkbf
	KRXI2E6s+A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsp9m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:34:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NCYhxI027019;
	Tue, 23 Jun 2026 12:34:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k36pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:34:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NCYAXu16057070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 12:34:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E33E5804E;
	Tue, 23 Jun 2026 12:34:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0116858055;
	Tue, 23 Jun 2026 12:34:41 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 12:34:40 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 14:34:40 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 13/17] target/s390x: Minimal protected key AES XTS
 support for cpacf pcc instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <e427e3ba-49e0-4daf-820a-62942173fd88@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-14-freude@linux.ibm.com>
 <e427e3ba-49e0-4daf-820a-62942173fd88@linux.ibm.com>
Message-ID: <abb4e8dbf9e2acd9204fe3a5ce2ebe8c@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX75wjXz89S7gw
 4QJQozEYEZu2b8/gTOHCxgglrXIOYvVRuJfALRNF09S5AFjdizfkK4sdhHY9e8rItozw4gkax7H
 U0/YRI5Ll6azAyKrKWSOnCIy+6LiskI3jUegXtAxApmtYs1OREJqfq9CXHAS9MEHN3A7LQ6y4DA
 9RAK3f+RoOu1aO4Y66uyMg/ZnvNARUnt6d1aqSDNLiOWT/0pQ2LyHnds2jpAJ4pJDdkOeWegAWw
 /JYdtLrTS0Tz1vwZZ5QLJLNzquYB3HEhNC4YJiXDVwt6QUSIcBxSZfV0drkXqWPIxZBYsI3iYpz
 e8yGZdtcrlaqfj7/gQvsR9RNpwQroZDDkhxuqXTP4LBD5zkkCxiEX16kEGTPXni4A3Iyhn3PRL5
 LVoOoj3Id/6AtgfgStmHhxS56+l+0MdIy5fK1+4eoWEg3r6JnNddv2xKIsN2U5pwjertIU+FpD1
 ld03kyl6zsfq0lX98Ng==
X-Proofpoint-GUID: hB5OyHr0_Ghn_WYo13OMOmPm31eqTgBV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX7XoryEvUZix3
 cbEilxeSOiyhBMY11XaWXLElfK+zmFtH4jepwNs2sACcE1INpdXrN/45/9/C3rKa9hFMQKYo7Ru
 2IC8VDLc4C+qtIZ8N0RwBCc1LplCd8A=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3a7d64 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=1Fm_wTa0bgUU076MjTYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: hB5OyHr0_Ghn_WYo13OMOmPm31eqTgBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

On 2026-06-18 08:18, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support CPACF pcc subfunctions 
>> PCC-Compute-XTS-Parameter-Encrypted-AES-128
>> and PCC-Compute-XTS-Parameter-Encrypted-AES-128 but only for the 
>> special
>> case block sequential number is 0. However, this covers the s390 PAES 
>> XTS
>> implementation in the Linux kernel.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> 
> With the suggestions:
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> 
>> ---
>>   target/s390x/gen-features.c      |  2 +
>>   target/s390x/tcg/cpacf.h         |  2 +
>>   target/s390x/tcg/cpacf_aes.c     | 80 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  4 ++
>>   4 files changed, 88 insertions(+)
>> 
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 4a131dc191..126bacb281 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -943,6 +943,8 @@ static uint16_t qemu_MAX[] = {
>>       S390_FEAT_KMCTR_EAES_256,
>>       S390_FEAT_PCC_XTS_AES_128,
>>       S390_FEAT_PCC_XTS_AES_256,
>> +    S390_FEAT_PCC_XTS_EAES_128,
>> +    S390_FEAT_PCC_XTS_EAES_256,
> 
> EAES -> PAES or EAES -> ENCRYPTED_AES
> 

Again - this change is outside of this patch series.

>>       S390_FEAT_PCKMO_AES_128,
>>       S390_FEAT_PCKMO_AES_192,
>>       S390_FEAT_PCKMO_AES_256,
> 
> [ snip ]
