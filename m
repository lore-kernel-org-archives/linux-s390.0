Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580F2EA731;
	Wed, 11 Mar 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238651; cv=none; b=q8p0W4b3k6bBaUk5U8JQJzen8pATWHa5ppTauinIb9TpbMKr+eP7irbgITQOU7uDj0s5fCL7szsrg6k7HY3co/myorbSQeLX9x35ZBiPVEcEZSAsJzkTYpgH8BH0yfnE1puuj56mN8PCM+iiltArUafJEibrplWeatZXssFoOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238651; c=relaxed/simple;
	bh=dKo+fnuh7Yj7wenc/9UNxc8BdIVpEoYmSPAM++mdC9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/ee3BkVsITWA1eSis2gJEeHYxFOneoSjPU9e4HXGaFa9lVmEcOr1597hlWGsyb64g/VnOw8lLZ20b9VXGnBLSMMIOUDM8btCJ8EGWL6aSMPx4lvSoJpWQTXiATmAzT+pdCieZtz5VAl8f0nWePcewR4S4lQ7w0NKYYyQTC7jgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hV7sbKMB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hV7sbKMB"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BDrjTF1596414;
	Wed, 11 Mar 2026 14:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X1BIES
	gnU9xzDFBaEak+yg6GIfpD/6Xo0+VZk6ZJqyg=; b=hV7sbKMB4WW+GrFO49kgu+
	v5jq3Dr24CvoM2OgHYXhRzgK0UK2bmVGZGpGW9NST0Tt7IhUFjdabqbrneZSRpiX
	LL3uIVp5u53soIdXUQMlBpOIiCUl3FxuoRjMm6YI1tYh0YP+QoA2UIVZo3B0tkua
	HHONEX8fLJic1L8AYy6Wk3JrDS+3U3bmMbYDzfWf9V0gsxlXBQMrEvsvVDP4/69Y
	FGpCsZVwWKPCJ+59qkPLiGGN4EbmdgOeUkwe7G4lSZ0JklRjJBSC3DU7n6bdoXnZ
	H6gJiqKEuSZVIEcQn3cTXSA/57taRdDua8w4ml1et1Qc09ppkk84FaE8nWlCzwyA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrft19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 14:17:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BDDe4b015771;
	Wed, 11 Mar 2026 14:17:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1225h0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 14:17:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BEHNMD24642068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 14:17:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAEDE2004E;
	Wed, 11 Mar 2026 14:17:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA4420043;
	Wed, 11 Mar 2026 14:17:23 +0000 (GMT)
Received: from [9.87.134.111] (unknown [9.87.134.111])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 14:17:23 +0000 (GMT)
Message-ID: <799ed972-6527-4cc3-8c37-30c07d30adaa@linux.ibm.com>
Date: Wed, 11 Mar 2026 15:17:22 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/mm: add missing secure storage access fixups for
 donated memory
To: Heiko Carstens <hca@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20260310150408.160722-1-frankja@linux.ibm.com>
 <20260311070053.9469A4e-hca@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260311070053.9469A4e-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExOSBTYWx0ZWRfX/cWxUQ37VTql
 FUbwtQfGYVItMEDA3B4Btpwds/LE9gqlQz2vKTALoaWlOeuU0jAA5Kx8uhcW7q88NqdFXe4G8OI
 hyFxJoNHM80zhIOrPG6IXCwgacc7kHl9HyT37WHXD22zMUFvd0BtydN0LYGYJnFGmR/Yb9gSKpt
 VijB4kcytiLCWIUi0kRQjkFQe2PkOn/yUcuXazdcRt7aS8fBAZIbOVpjWDP7W3DaLm512ZW9ukC
 TGBTcukfjDv4CO99OL8yM+FA5CtXo5g9bYZJTiyWGmP5iFjLyT5oea5UlUD48R88fPtHwACVvqw
 3L6NSsDynJj3Lfbs6RFOKx/uk8xVEeOGroVyMZ3Ny7U/Wi7HmdxLiWkDS5iIVINeKMIsDW8Rsye
 59DJQp+WoLCqyfIkj127x++Rv43WpC5Br/BJ26l2alZNBUg8nOzSEYXpxAEi9mWmsUyrSyukFe+
 Et6by7aR6dEWyGMSRYA==
X-Proofpoint-GUID: dC8RpSQF2Ke4dOdI4KgdlHu4AUjRWbel
X-Proofpoint-ORIG-GUID: dC8RpSQF2Ke4dOdI4KgdlHu4AUjRWbel
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b17978 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=FYqZePZFWLRCczkUEhwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110119

On 3/11/26 08:00, Heiko Carstens wrote:
> On Tue, Mar 10, 2026 at 03:02:42PM +0000, Janosch Frank wrote:
>> There are special cases where secure storage access exceptions happen
>> in a kernel context for pages that don't have the PG_arch_1 bit
>> set. That bit is set for non-exported guest secure storage (memory)
>> but is absent on storage donated to the Ultravisor since the kernel
>> isn't allowed to export donated pages.
>>
>> Prior to this patch we would try to export the page by calling
>> arch_make_folio_accessible() which would instantly return since the
>> arch bit is absent signifying that the page was already exported and
>> no further action is necessary. This leads to secure storage access
>> exception loops which can never be resolved.
>>
>> With this patch we unconditionally try to export and if that fails we
>> fixup.
>>
>> Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions handlers")
>> Reported-by: Heiko Carstens <hca@linux.ibm.com>
>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>
>> Changed fault error handling to nolock. (Heiko)
>> Added PG_arch_1 cleanup requested off-list. (Claudio)
>>
>> ---
>>   arch/s390/mm/fault.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
>> index a52aa7a99b6b..191cc53caead 100644
>> --- a/arch/s390/mm/fault.c
>> +++ b/arch/s390/mm/fault.c
>> @@ -441,10 +441,17 @@ void do_secure_storage_access(struct pt_regs *regs)
>>   		folio = phys_to_folio(addr);
>>   		if (unlikely(!folio_try_get(folio)))
>>   			return;
>> -		rc = arch_make_folio_accessible(folio);
>> +		rc = uv_convert_from_secure(folio_to_phys(folio));
>> +		if (!rc)
>> +			clear_bit(PG_arch_1, &folio->flags.f);
>>   		folio_put(folio);
> 
> Isn't the clear_bit() racy? That is: another CPU could make the page secure
> again, set (the still set) PG_arch_1, and then clear_bit() removes the bit,
> and we end up with a secure page where PG_arch_1 is not set?
> Which in turn would arch_make_folio_accessible() al
> 
> Or is that not possible?
> 
> Just wondering, since __make_folio_secure() requires the folio to be locked
> when setting PG_arch_1, while clearing happens unlocked. But chances are high
> that I don't understand the code.
> 

__make_folio_secure() checks the refcount and if the comments hold true, 
it should protect us from a flag being set as long as we have the extra 
reference which we should have gotten via folio_try_get().

It does not protect us from a double clear.
