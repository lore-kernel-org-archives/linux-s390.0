Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A56480DD2;
	Thu, 13 Aug 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630169; cv=none; b=WwOtSlWgQgizx8jdlEn58HRg3BpDT7wizSC2BxaTI78F0tVqoGLDFF43piN7fqOdkVkDWXoTuuRkbAosVV1aFv41+6KrwOeBokv0dE5VpTZcPnG093vfePCyUzOkgfE2ASDA+Y1OaG+EKPtEP3xwv7uLxjOCBHYKpgnZrhQq3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630169; c=relaxed/simple;
	bh=OoVEVxOdGI4moE5XwQTycMED5lU4hgAtivQFZoVRSnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDjJsP8hU3Y1HKYP/E+YNLk4rcrQOZEnzyd8JUxIQLY7oY5zxIwKj01/jyPJdI6c20zUruro4dL/UA3E2djoLzELotJD8yCSdjcQRpoQ66gupYUoXhtzACY44s3PNzaCQpMGz8c6eb3bxKnx5hoM67nQ7WMRBMpMgwrmOMJeYqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SGDgnLOk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SGDgnLOk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCW49r2376822;
	Thu, 13 Aug 2026 14:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=adVEPd
	H+En402LC3d3dQdADVGbpl5fkmxpcqNTqdsgU=; b=SGDgnLOkztPSTqPq6hDlgb
	3CvmmDQA53e9o2udtbijwxtWBgbttvnUSlsAQDvdIkQVMt19ibF3hhMSgda+uYmb
	HwGZIpGY1lFclFYXaoPz99SAE9RXNKuMLBNYDlW5IfiksioXWM4l3092Z3+unaeY
	KLHfgWt/rowRSA2un04qW/1K77hFRtO7JRrssQf2r5qqMdgY0NHPvctgus7yO2pD
	bYQ3Rg9IG2x0eDToZ31nZq+TzPMk7uvOa+Ftfo1Mwc/29+SsXpg7CjSctiQrycKt
	B3SOnu8hbI05y6e6lEDmZsP1GR/2oneXU5yzOTl+rgeZiWoL2Wu2Lyd7JP2EtTsg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwf7ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:09:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DDuPeL012595;
	Thu, 13 Aug 2026 14:09:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hb7b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:09:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DE9LZn35455274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 14:09:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BC9620043;
	Thu, 13 Aug 2026 14:09:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61AC620040;
	Thu, 13 Aug 2026 14:09:21 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.4.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 14:09:21 +0000 (GMT)
Message-ID: <9d274d01-67ee-47f4-bcc7-8ddbfb8b8812@linux.ibm.com>
Date: Thu, 13 Aug 2026 16:09:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/cpacf: Unpoison instruction results
To: freude@linux.ibm.com
Cc: Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260807122132.3592583-1-iii@linux.ibm.com>
 <6a2841287fe60bf310d302b6f4293329@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <6a2841287fe60bf310d302b6f4293329@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7dd016 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=RnH0bYvw7ho3qMamFLQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dST06yLsiR9fmzHm6rWjPFGOXGZKnlvc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfXxRfk8NN7TPvw
 EMvHO+59bm8e1jjDUl5lQWPog0LA0kEP6D31I6HifR7hPadr2p3lZFprerV0Taiuk4Fxzn1x2bc
 48p/q5ZOVGpB+wyLoO7pdgKUnH2KNJd8V7B0AQLW6HyJakXIVjr6QHLp3zbJCLaUtw1H+6Gy4Ln
 81QsjHIHw+kKZNVBNkmg/tZjwo8l/y4QmOmsr/Jz3FkIM9bAzgczhVxI7FkZpLfKZUnW7fAkuIl
 oGXNP0Sl6WNuKZ3TI04aLLxQbZ5fduT/Md2uXEi9FchElGMLtAkYtExm78SGTaLnI8Pr+LWDrJa
 q8xYJc34wRnv9R/uJhaJR/eS/iBSqpGVuZw62ilBr8PXGGELxN/hLqDQqr89AX4xscD0Tm5xRzU
 EerFXaEzwaCtOyQOxP3gYw0Fhkw9IdQwK9m5U1NEGxIPr6+vOLcqyrybyjxBMSpPIqvYCxUztIs
 mMcwPATJH/Kr660xeQg==
X-Proofpoint-ORIG-GUID: dST06yLsiR9fmzHm6rWjPFGOXGZKnlvc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfXzVIlH/9mNAKR
 2vVgQfAnMkjnbWBSUQ4zez7hR3D/lH7O1riAgo24cim6+NPZJ/iKJD49o5p5saxJHCcO1oRIvAp
 FmpN9P0GCXHU4jJyBE3ZRIGS/Rx0wik=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130100



On 8/13/26 16:06, Harald Freudenberger wrote:
> On 2026-08-07 14:20, Ilya Leoshkevich wrote:
>> Stop KMSAN from complaining about CPACF outputs being uninitialized.
>>
>> Do not unpoison variable-length parameter blocks: mapping function
>> codes (like CPACF_KIMD_SHA_256) to lengths is ugly. Let the callers
>> handle this once need arises.
>>
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>> v1:
>> https://lore.kernel.org/linux-s390/20260806190223.3292580-1- 
>> iii@linux.ibm.com/
>> v1 -> v2: Unpoison outputs of more instructions (Sashiko).
>>
> 
> See my comment below.
> 
>>  arch/s390/include/asm/cpacf.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/ 
>> cpacf.h
>> index a83683169d98d..13d6a6344802a 100644
>> --- a/arch/s390/include/asm/cpacf.h
>> +++ b/arch/s390/include/asm/cpacf.h
>> @@ -301,6 +301,7 @@ static __always_inline void __cpacf_query(unsigned
>> int opcode,
>>                        cpacf_mask_t *mask)
>>  {
>>      __cpacf_query_insn(opcode, mask, CPACF_FC_QUERY);
>> +    kmsan_unpoison_memory(mask, sizeof(*mask));
>>  }
>>
>>  static __always_inline int __cpacf_check_opcode(unsigned int opcode)
>> @@ -370,6 +371,7 @@ static __always_inline int
>> cpacf_query_func(unsigned int opcode,
>>  static __always_inline void __cpacf_qai(unsigned int opcode, 
>> cpacf_qai_t *qai)
>>  {
>>      __cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
>> +    kmsan_unpoison_memory(qai, sizeof(*qai));
>>  }
>>
>>  /**
>> @@ -422,6 +424,7 @@ static inline int cpacf_km(unsigned long func, 
>> void *param,
>>            [opc] "i" (CPACF_KM)
>>          : "cc", "memory", "0", "1");
>>
>> +    kmsan_unpoison_memory(dest, src_len - s.odd);
>>      return src_len - s.odd;
>>  }
>>
>> @@ -454,6 +457,7 @@ static inline int cpacf_kmc(unsigned long func, 
>> void *param,
>>            [opc] "i" (CPACF_KMC)
>>          : "cc", "memory", "0", "1");
>>
>> +    kmsan_unpoison_memory(dest, src_len - s.odd);
>>      return src_len - s.odd;
>>  }
>>
>> @@ -587,6 +591,7 @@ static inline int cpacf_kmctr(unsigned long func,
>> void *param, u8 *dest,
>>            [opc] "i" (CPACF_KMCTR)
>>          : "cc", "memory", "0", "1");
>>
>> +    kmsan_unpoison_memory(dest, src_len - s.odd);
>>      return src_len - s.odd;
>>  }
>>
>> @@ -619,6 +624,7 @@ static inline void cpacf_prno(unsigned long func,
>> void *param,
>>          : [fc] "d" (func), [pba] "d" ((unsigned long)param),
>>            [seed] "d" (s.pair), [opc] "i" (CPACF_PRNO)
>>          : "cc", "memory", "0", "1");
>> +    kmsan_unpoison_memory(dest, dest_len);
>>  }
>>
>>  /**
>> @@ -731,6 +737,7 @@ static inline void cpacf_kma(unsigned long func,
>> void *param, u8 *dest,
>>          : [fc] "d" (func), [pba] "d" ((unsigned long)param),
>>            [opc] "i" (CPACF_KMA)
>>          : "cc", "memory", "0", "1");
>> +    kmsan_unpoison_memory(dest, src_len);
> 
> I am unhappy with this kma thing. This would only work properly with
> CC 0. But CC 1 and 2 are not handled properly. However, I had a closer
> look onto the AR for kma and ... well this inline function should
> handle CC 1 and CC 2 somehow and it should similar to the other inline
> functions return the number of bytes processed like for example cpacf_km().
> I'll open up a bugzilla to fix this kma inline function.
> If you leave out this kma hunk you can add my R-b.

Will do, thanks!

May I ask you to add a proper KMSAN annotation while fixing CC1/CC2
cases? Alternatively I can do it myself afterwards, of course.

> 
>>  }
>>
>>  #endif    /* _ASM_S390_CPACF_H */

