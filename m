Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88838E8B1;
	Thu, 13 Aug 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636286; cv=none; b=PUh+3W6idIcncc4v2UNCYBNDORhqddywufqrcL1csoZanlVJDUzvapGdPmJe+qJHE3/MuPk3bG4j/OhyJgSdEm1jY+CKRLY6V0jTXxKxVXGsEv70mMihIT0dGAGUYbQ/79FH7GQQ0yEZYuucR1ZFDrKOLRfn2q8sZAS92P4I/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636286; c=relaxed/simple;
	bh=0KRROr6kTvEuWDwdkKoWzrybJ2cx3FJ5OM0SEDlmehk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M87b+cLQPwoRi5ARHhuQiZizPF/Fp+IAAllQVQUuUfr83tr4PRzZwtD4qrjSGn8zUTvSGvNSWDjdCjSSsQ6f3wzTjZ4HupACsJPJUiiaCFVUaJeHrYgvOU2n5AOpWIANkOhGid9tPS/+mEBym9iDw7KRo/XTeZbOFfWP8dSOpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mSJnnpOr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mSJnnpOr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFWmtE2737145;
	Thu, 13 Aug 2026 15:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ejkdlWoHEUIMV4iyEVIWCS4wkwZ5ISKKk1TPH73Beh8=; b=mSJnnpOrNmtg
	O7tk7wXwfbetVeOwcluyaZo06LJFlMj1VXLg3QYhJTh0GiJA2se11N1hNXUY10as
	d1hL1y9q7uOHwwrkyYWcyXH0spm64gEG+7z/4Cl9sRy3gZ54rwdJWuyIhF9ptieX
	Mk2yd99licZcdiP4JEjPF+WTpvDliANBzFjRcgivtwhVRHe6r8pydW0xcstkZXNo
	85k6T3/UBQjR3FRxdfmOhGvo3Qm1OSyVRZfVD8NmemJpTj/9GYOUHTBQ/q+CP4gj
	+Kc7FkNBpoMExpdAQ5iKf1ZaM7Cr7SGpUI/LwbyPBZajd+FWBN4YX7/WKMpHnFZc
	YPRPBdvbBg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma0rg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 15:51:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DFfr7K015065;
	Thu, 13 Aug 2026 15:51:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfybd4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 15:51:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DFpAa258851704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 15:51:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAA825805A;
	Thu, 13 Aug 2026 15:51:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E69C5805F;
	Thu, 13 Aug 2026 15:51:10 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 15:51:09 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 17:51:09 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/cpacf: Unpoison instruction results
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <9d274d01-67ee-47f4-bcc7-8ddbfb8b8812@linux.ibm.com>
References: <20260807122132.3592583-1-iii@linux.ibm.com>
 <6a2841287fe60bf310d302b6f4293329@linux.ibm.com>
 <9d274d01-67ee-47f4-bcc7-8ddbfb8b8812@linux.ibm.com>
Message-ID: <bb96ff5abb8ee0e6bb53a0402ce8a468@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExMSBTYWx0ZWRfX8AUvMs2ahhrf
 YYnybWiA5PbNU6vunOF2VWZhmaAeU6ormDnHemiPnSx7QjwprPdAbSbVryavUmuxUWOPe2Dxqxf
 CnfzDHc+pJQ8a4uqjOyMZ9ocQOKHAuKPkoEzK7Fcgc+kcPGvmF70+QHb9mo7/1zRNT8sTs67TpL
 GjCTzAuJT6uiGX18yYU5A2mzKR4uj+axVc7Py/e/yFw3IV7U1QE0lSApi6XXIgWi9688Q3mD40x
 xfx2d35Qicqf9dw4PaK8NcSH30AoAbQWCHznJnjRGzGKrkxMOao7merZ8lG1eo2cr56rLxkvyNI
 k8m86OxqM/YxGqCzvYEjGDsjRAG9E6u33kQjVc4rnke0yfuFwh4fFc1Mwzso8s8XOUnPRCdFydU
 A2FzsDp+5ZWUOAmCohhziAVTSCth0dz+echSLWAyz5arziJu6gXXXuMp2eaFZeOickDeJtTsMM+
 +fxef6uCwfU2L81KzLg==
X-Proofpoint-ORIG-GUID: Nn7ucuPR7VSuGX9Xzak1QdUu4_Myld7Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExMSBTYWx0ZWRfX11R0NZP8nCn6
 A99IjP8DR0YRHcU8FHWpH7PZ1Ut22wJW1B03msG2hzdGe6SYKR3bMN5gofrHGMbtzWngksgcdLN
 PCKQlH1wOXrqeEiL2CngQbHT11YwqNE=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7de7f1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VudzLZF43Om9PxUgfyMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Nn7ucuPR7VSuGX9Xzak1QdUu4_Myld7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130111

On 2026-08-13 16:09, Ilya Leoshkevich wrote:
> On 8/13/26 16:06, Harald Freudenberger wrote:
>> On 2026-08-07 14:20, Ilya Leoshkevich wrote:
>>> Stop KMSAN from complaining about CPACF outputs being uninitialized.
>>> 
>>> Do not unpoison variable-length parameter blocks: mapping function
>>> codes (like CPACF_KIMD_SHA_256) to lengths is ugly. Let the callers
>>> handle this once need arises.
>>> 
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>> v1:
>>> https://lore.kernel.org/linux-s390/20260806190223.3292580-1- 
>>> iii@linux.ibm.com/
>>> v1 -> v2: Unpoison outputs of more instructions (Sashiko).
>>> 
>> 
>> See my comment below.
>> 
>>>  arch/s390/include/asm/cpacf.h | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>> 
>>> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/ 
>>> cpacf.h
>>> index a83683169d98d..13d6a6344802a 100644
>>> --- a/arch/s390/include/asm/cpacf.h
>>> +++ b/arch/s390/include/asm/cpacf.h
>>> @@ -301,6 +301,7 @@ static __always_inline void 
>>> __cpacf_query(unsigned
>>> int opcode,
>>>                        cpacf_mask_t *mask)
>>>  {
>>>      __cpacf_query_insn(opcode, mask, CPACF_FC_QUERY);
>>> +    kmsan_unpoison_memory(mask, sizeof(*mask));
>>>  }
>>> 
>>>  static __always_inline int __cpacf_check_opcode(unsigned int opcode)
>>> @@ -370,6 +371,7 @@ static __always_inline int
>>> cpacf_query_func(unsigned int opcode,
>>>  static __always_inline void __cpacf_qai(unsigned int opcode, 
>>> cpacf_qai_t *qai)
>>>  {
>>>      __cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
>>> +    kmsan_unpoison_memory(qai, sizeof(*qai));
>>>  }
>>> 
>>>  /**
>>> @@ -422,6 +424,7 @@ static inline int cpacf_km(unsigned long func, 
>>> void *param,
>>>            [opc] "i" (CPACF_KM)
>>>          : "cc", "memory", "0", "1");
>>> 
>>> +    kmsan_unpoison_memory(dest, src_len - s.odd);
>>>      return src_len - s.odd;
>>>  }
>>> 
>>> @@ -454,6 +457,7 @@ static inline int cpacf_kmc(unsigned long func, 
>>> void *param,
>>>            [opc] "i" (CPACF_KMC)
>>>          : "cc", "memory", "0", "1");
>>> 
>>> +    kmsan_unpoison_memory(dest, src_len - s.odd);
>>>      return src_len - s.odd;
>>>  }
>>> 
>>> @@ -587,6 +591,7 @@ static inline int cpacf_kmctr(unsigned long func,
>>> void *param, u8 *dest,
>>>            [opc] "i" (CPACF_KMCTR)
>>>          : "cc", "memory", "0", "1");
>>> 
>>> +    kmsan_unpoison_memory(dest, src_len - s.odd);
>>>      return src_len - s.odd;
>>>  }
>>> 
>>> @@ -619,6 +624,7 @@ static inline void cpacf_prno(unsigned long func,
>>> void *param,
>>>          : [fc] "d" (func), [pba] "d" ((unsigned long)param),
>>>            [seed] "d" (s.pair), [opc] "i" (CPACF_PRNO)
>>>          : "cc", "memory", "0", "1");
>>> +    kmsan_unpoison_memory(dest, dest_len);
>>>  }
>>> 
>>>  /**
>>> @@ -731,6 +737,7 @@ static inline void cpacf_kma(unsigned long func,
>>> void *param, u8 *dest,
>>>          : [fc] "d" (func), [pba] "d" ((unsigned long)param),
>>>            [opc] "i" (CPACF_KMA)
>>>          : "cc", "memory", "0", "1");
>>> +    kmsan_unpoison_memory(dest, src_len);
>> 
>> I am unhappy with this kma thing. This would only work properly with
>> CC 0. But CC 1 and 2 are not handled properly. However, I had a closer
>> look onto the AR for kma and ... well this inline function should
>> handle CC 1 and CC 2 somehow and it should similar to the other inline
>> functions return the number of bytes processed like for example 
>> cpacf_km().
>> I'll open up a bugzilla to fix this kma inline function.
>> If you leave out this kma hunk you can add my R-b.
> 
> Will do, thanks!
> 
> May I ask you to add a proper KMSAN annotation while fixing CC1/CC2
> cases? Alternatively I can do it myself afterwards, of course.
> 

Yes, I'll do that.

>> 
>>>  }
>>> 
>>>  #endif    /* _ASM_S390_CPACF_H */
