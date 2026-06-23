Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42E367F25;
	Tue, 23 Jun 2026 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210927; cv=none; b=ebSGcXbx/l67SkFoMjrlQT82oI9IYdIOB0W7XnxCV6v6zEabElbL2SI/CceMb66FANHQn6yNbKR4SV+CxCd4bC8FDv+pY/F2KBTHR5A0l8iTh3Pdu/2KgbybLDxLSxAEP4pP+wZmF+C5GWURbvrLcbvwE4jLVNMmRjn4b84zkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210927; c=relaxed/simple;
	bh=unbp3Qdl7OjR7KX+r6pg0fxZL4o2LWbd944xISuFwhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYPWZkhDocqL8AKvimkl4CTKWKYMhznEJva6VJzppEzFuaCjabsNTQKjSLy4oTeFvqiWqG68CizkohFY/JeBXixxVObtFhyyn9nJkHImfEytGrRiFLgSPadlCncYBCvfygsPEmKNYN+k1Um6QdbMT5URtxywy8W3uDcAhnGqtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NpOWRzVT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NpOWRzVT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6mOoX1078815;
	Tue, 23 Jun 2026 10:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2UbpxU
	XruavK1sFGjBIkSX1WUFf7QhZwh/CQEFEwx74=; b=NpOWRzVT88yHI8xeju5bHq
	SiFV+Ug26VhuYbhABBl0mxcklVfEbYS8dTGUJKR8IQfPUdYN1VfE3fAJV9afhWju
	/yTPfAgcTUJoX06l2ihGAJFY3oDNNi5PXXSE+tsen7sqxM/TjBy5E//DnK9xIU3T
	X86ok2RZvVOze5sKDwMhlLjgMYcHOYPQ3Ytmcm9hqVA5eIJO5xirTo4Qolhg5hF0
	RHWjRZGbRFqHy62+iFr+CLiwK5AkRAJ8dww4lY33bGmJ5dTdkHEvTUQzCpwWbLGt
	pOZfT09ZTvSn67OfoHz/xP0EuxgDZrLuQYfkDmUHBZYe+WuV6EOLFwteeBwZyKLg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsntr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:35:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NAYe3m001271;
	Tue, 23 Jun 2026 10:35:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qayvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:35:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NAZIXc43778342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 10:35:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A363B20043;
	Tue, 23 Jun 2026 10:35:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60D1D20040;
	Tue, 23 Jun 2026 10:35:18 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 10:35:18 +0000 (GMT)
Message-ID: <1668d093-9260-4e60-9260-598324221398@de.ibm.com>
Date: Tue, 23 Jun 2026 12:35:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] KVM: s390: Return failure in case of failure in
 kvm_s390_set_cmma_bits()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, hca@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-10-imbrenda@linux.ibm.com>
 <117d0a80-345f-43d0-9b8d-b86c12eafc05@de.ibm.com>
 <20260623123357.677d98c5@p-imbrenda>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260623123357.677d98c5@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfXyCF5FJC7kQPw
 NhxJgAEF0RRkifGBoH3x/DqWiz2yOFPkd7Q353Iqlc9tnI+PH1TkXeemBQVSmwt9SHjtdet4xNo
 4djuB09+qcCPQtxQqvGoJJMqC2uej+stgNQIFUv2uIU2mk2i+RGl8xd+was/bu2hPVk6oBsmi/X
 OGQHnkJHQT+XA9Uw30+gGNpy80Bs3UJBu3J3/tnVr5NJoiRR67SU1yfTEAYEd6StgTxdwPTS0bt
 ztQd0OPUp/lHgsQU3EcBbetA+p6YhJSNIaQ1eWFziy0UPUN4jA4+0Q/xp4hunAXGV2BW02C6EsW
 Mh666F6q8vY998S6oiAdwcGQPy2GtOP283vInIJ+OzH72fBRO6Vc2WW71gXNXWRpUyO3ZFrQP09
 X5ztowmwDt0DfIKGVlUTVeSDkhkvIVY8kr0udSKzG0CtGd3kgE0bcgDMgTVZjGyDowYpVPAu79v
 B2XwRgow5gv6FIUvEwg==
X-Proofpoint-GUID: Ns28ZVJIhmqDvTdPx0x7vuHJk6whxM1T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX3OuJ27Gj5ATO
 KKDMIsj08FQqvVx4Qg1slp2Pop7OhERO74ZGZ3emiLMYJaA8bEoZMpdoehB7IJdqs92cClvIrbj
 abGKuH26WXHXM1Talm/guGfj00ldvaA=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3a616b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Vbk74Uj51r1O-sTaw60A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ns28ZVJIhmqDvTdPx0x7vuHJk6whxM1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230083

Am 23.06.26 um 12:33 schrieb Claudio Imbrenda:
> On Tue, 23 Jun 2026 11:30:24 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Am 22.06.26 um 18:07 schrieb Claudio Imbrenda:
>>> If the allocation of the bits array failed, kvm_s390_set_cmma_bits()
>>> would return 0 instead of an error code.
>>>
>>> Rework the function to use the __free() macros and thus simplify the
>>> code flow; when the above mentioned allocation fails, simply return
>>> -ENOMEM.
>>>
>>> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
>>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> ---
>>>    arch/s390/kvm/kvm-s390.c | 18 +++++++-----------
>>>    1 file changed, 7 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index cdd8b41d24ed..27d6004132d2 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -2282,8 +2282,8 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
>>>    static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>>>    				  const struct kvm_s390_cmma_log *args)
>>>    {
>>> -	struct kvm_s390_mmu_cache *mc;
>>> -	u8 *bits = NULL;
>>> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
>>> +	u8 *bits __free(kvfree) = NULL;
>>
>> why kvfree and not vfree?
> 
> because vfree does not exist as cleanup macro: __free(vfree) would not
> compile
> 
> adding vfree would be outside the scope of this patch

With that

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

