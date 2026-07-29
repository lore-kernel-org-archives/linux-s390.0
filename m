Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C83AAF60;
	Wed, 29 Jul 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338765; cv=none; b=UGFFto6zsSlrtKt05hgsY1vOt6HYDDPmVaki9bCmYcCH0GvoieHlJ+ajVzdGa96t2Cu2E6Zr3lOVEABQLN78fJyQUdFoD+KXsfqqQBzvTf1j4W6kSJHHOVrBnkpWv2th2AscxM19HiPDIRHnNEFWKk8dhXphh9fCeQ696Z1+Mi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338765; c=relaxed/simple;
	bh=157GS3JGaPS7KZkOVWedShWW4BPOeeikIwkSrfnNXKM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KN0a6XjeaHf9Gd1CNqdwpfwQwD39Y81pGaumkiHQYnlEaLEoaoqPZK0gTNqdK0NJLS4Hx/EIGAodKBFfbff7kvNw/g+YkzEdOoJ8GWF1Yj4i8qLjVqaihzlHY0nhk1f6428Qr9LbR79ZSKYzXRq1+v7PXxFPdonDtKcrMOOP07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jNLP6CgX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jNLP6CgX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHtwA283153;
	Wed, 29 Jul 2026 15:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=RfG7QeHSC68loDUldQbRL5V/jirRHwr5RRYVp1tS32Q=; b=jNLP6CgXOT2B
	k3hRdKUy4Vw23OVA9BG1+qOKPU1QsymBrn8IfWtjwlZNvTN+KxQTdsKhZR5gOoyN
	pBClPl9Zpn7GnwKGF2UutIGrXz5lnfzfSWF6Y87FhiHq6gD3dkXsxgqckGZPLe/J
	1WESla55TRjvqDHcesgN/xEriL7zfjuFDfAThhdW2S8Ue7PK3CIm3/Zqspf2LwB3
	OV7W8W9QMU/IdqxoriJ8Ph79xmUweCvUPBfTbRC2627+9pI32L8TmfF54Ghf0iH2
	k8mg4pefL3tsM6gwEBNd6qwY9YDOGDdm0xhte/9pdIMXU9KMw29ELXsCoQTokCrv
	MO3COh/0Fw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntkbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:26:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFBcPm001568;
	Wed, 29 Jul 2026 15:26:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk79jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:26:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFQ0Fe29753932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:26:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 742B85805A;
	Wed, 29 Jul 2026 15:26:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F9BB58052;
	Wed, 29 Jul 2026 15:26:00 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:26:00 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 17:25:59 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v8 4/5] s390/zcrypt: Improve EP11 CPRB domain handling
 with ASN.1 parsing
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729145016.EB7061F00A3A@smtp.kernel.org>
References: <20260729143928.191969-1-freude@linux.ibm.com>
 <20260729143928.191969-5-freude@linux.ibm.com>
 <20260729145016.EB7061F00A3A@smtp.kernel.org>
Message-ID: <a1d610107f013b57aed98c288c43b77d@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX2FJZkoc7FiP4
 IKr0Y9WntVOG28EIWKNoIFMTO7GFlYZSBrcCPkHvDFm8j7dvijDnuAU9lVppt3DG1sh8+rmeh6v
 TN6yf6nyCF4xW4dViCPJ65DMtH5L4jE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX5njuqXZiALwO
 2U243SLcVYneftZTdD9zTuEi59p43UommYLoB+iF2poTMHw63M6SlZBLWcL7P9AhkqMeyL9MOSx
 O/uHENJrFo32sE52fYdnZ6YyC5QLa+i2tvItA4OICWlGSpLrrLNnZbvbRNm/YkzBdgi5wAGwJWB
 VbX1iCGhyfNhWqONsmecB2R/IATPZewjhZcI4Ct8DrFxptiPvUBZbKKvj+9IQPiiVxvvUtDhI6A
 qYMObEBtg29Mms0etcNYgcbYkpzzmkT38XVGYJaihjC6hnm8v+ni/OvUx8lKlBBGGF/FphKyjGC
 udJgNgcDKdMCFvWpHXkd94PhMGykhd3Y+GB+14N1LhoKk/gyPviCDECjeB9U1pxkHoaQDKNuJ3T
 FX9gwkqXF8stKXav03UJ4NXOWmUebM8SafNFvaqKnku1KAP71VpVVUwZgcupHaI+yqMLvREYHmM
 fcvClV5ZXkY45/YPIzQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a1b8a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nK6qX-PPXt_hqBXmbB8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 19vYZv1neSzs4cR-hro6EW4MCcdOUgad
X-Proofpoint-ORIG-GUID: 19vYZv1neSzs4cR-hro6EW4MCcdOUgad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

On 2026-07-29 16:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] Undefined behavior due to unaligned memory access via
> direct pointer casting.
> --
> 
> --- Patch [4]: [PATCH v8 4/5] s390/zcrypt: Improve EP11 CPRB domain
> handling with ASN.1 parsing ---
> commit 78d69567226ac24ed3207a9812dbc20b238a13e1
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
> 
> This commit replaces struct overlays with explicit ASN.1 parsing for
> EP11 CPRB payload domain fields, adding validation and a new helper
> function for safely encoding integer values.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index c4b5d9b85f7a9..59e182d1bddf9 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -1223,6 +1223,28 @@ int prep_ep11_ap_msg(bool userspace, struct 
>> ep11_urb *xcrb,
>>  					       func_code, domain);
>>  }
>> 
>> +/*
>> + * Simple asn1 int writer/encoder helper function
>> + * Returns number of bytes processed or < 0 on failure
>> + * Only accepts int length values of 1, 2 or 4.
>> + */
>> +static inline int asn1_int_encode(u8 *buf, size_t intlen, u32 u)
>> +{
>> +	switch (intlen) {
>> +	case 1:
>> +		*((u8 *)buf) = (u8)u;
>> +		return 1;
>> +	case 2:
>> +		*((u16 *)buf) = cpu_to_be16(u);
> 
> [Severity: Medium]
> Could this lead to unaligned memory accesses?
> 
> When asn1_int_encode() is called from zcrypt_msgtype6_send_ep11_cprb()
> using pld + offs, the offset is dynamically calculated from variable 
> length
> ASN.1 tags and lengths, which may leave the buf pointer unaligned.
> 
> While s390 hardware handles unaligned accesses, directly casting a 
> potentially
> unaligned u8 pointer to u16* could violate C standard alignment rules 
> and
> potentially lead to compiler misoptimization. Would it be safer to use
> put_unaligned_be16() here?
> 
>> +		return 2;
>> +	case 4:
>> +		*((u32 *)buf) = cpu_to_be32(u);
> 
> [Severity: Medium]
> Similarly, should this use put_unaligned_be32() instead of a direct 
> cast
> to u32* for the same unaligned pointer reasons?
> 
>> +		return 4;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
> 
> [ ... ]

These both unaligned issues will be fixed with v9 by using 
put_unaligned_be16/32()
