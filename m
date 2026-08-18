Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760253D25D2
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052717; cv=none; b=J8kvGWB0UPNQ5XiHpkKKcAG1+gCa3x8sKor4qRGihj55sslMOAs6c7zm/y4gim0igOWZlkE6empKx9kWs8ETMn96XPj54aSqHEGCHs5FlvXwJ+GLtJDaF+YkY0t7L/WdvTzopA9ftKlskLmW3df8s5TMLW5koj++orPjBkY3RM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052717; c=relaxed/simple;
	bh=Ok41hEWvU/WeK76BOumTunhOCMPYEJizmV9ilcoXQRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbPK7DOOn6E/B0R8beW3cHCi0tAKfxf1WuRS2FykPHy2WbTqKHnmon5SmNKgUtz25gQ1QIN3m/l6oxLU6vZGLfFDIkV+JOhpXKfrjL+7rsSh5U02PzNu/wVw4w19MC9O8P2CYehuQS087/U649QZmnM6ABYwnU2tY/nIwPbwj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VtFnzjNy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VtFnzjNy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAVdFQ028671;
	Tue, 18 Aug 2026 11:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wY+2an
	M7Ppk+kUeUku3ZLhZJ+XWCOjSZzLxN8H15F0Q=; b=VtFnzjNyNKIjTulWe9ZGtx
	65x2jOmEVoRRXDhybgKMXt3NYkJlNdwGmRfR3LPbzYTAUAXTneUBTMaorVPpAs23
	8rIBHuN2CiXuEG3HtxaRLSfawnUqZPXEANQ5f+u1D1IiSefDubWPPECoGkqNFD5R
	1actAzru1g9uZiiUs/5up5i86He60/zG87xnWa5JpKRLSYDb1Ozo/y119IeaxkL+
	CkI7axxJyqqWGlx2Df4Coi/7kaQS70jnpMKgrPXtgZYbrwocmDgXwHxTrkf15vWs
	73Z5ccPg5qVx+qJ9C6s7UID8H6jaaVDrPlw2iZLmt/HvEbLSe/rOiG4gw8uX1sBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4qv01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:31:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IBQNVE005925;
	Tue, 18 Aug 2026 11:31:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh2wg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:31:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IBVcbY45875522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 11:31:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9118020043;
	Tue, 18 Aug 2026 11:31:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3076620040;
	Tue, 18 Aug 2026 11:31:38 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 11:31:38 +0000 (GMT)
Message-ID: <8452a841-9bb8-4a88-83ab-f97297401c13@linux.ibm.com>
Date: Tue, 18 Aug 2026 13:31:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/19] target/s390x: Support AES ECB for cpacf km
 instruction
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-8-freude@linux.ibm.com>
 <e95ee364-3e48-44c4-8c7b-5d306f417c16@linux.ibm.com>
 <192e2ce59d17947e5556dc54e3b3c781@linux.ibm.com>
 <145b0ed2-8b3b-48d5-97a7-a5addcdf6481@linux.ibm.com>
 <4dfa9e976a6485dd2b1ffa93f04e1bd7@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <4dfa9e976a6485dd2b1ffa93f04e1bd7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pk00rHtvPe7yU1ZqTgUMjwyHsFGHEdA3
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a84429f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=W2MhfUumii-zuiLuurUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX1ddaLIqMeZ8M
 b4A7QUQlGnmxIzVwqdvUtaCXo2IIlnDkSd8YDKYE62AhdSEnQQ4CodR6CLD5FVlT7aJ/bJ+ifYu
 xclHU52ICjqV+sJvuBjlxL2ppnhx9nM=
X-Proofpoint-ORIG-GUID: Pk00rHtvPe7yU1ZqTgUMjwyHsFGHEdA3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfXz+WJtxHjJcsw
 T3afe7SQn5uTjx9lxfBJLnqP/KFtlJxpLH1zP/4VGAktSSz4Ivjp2i9hs5W41CJ7QRNvecGUovd
 1VWH7xkzfFThyFIVBN+6q27kxmPPp3rNyqutldnoDRwniesvR6O/JBGM28ME9cJE10ZSL5dFQvr
 0Rk7QlVtrPmhVLuKj8HsLPd0c0jL69/I9ky4jQMw6DNRkQ0xFUdFVaGrfh09mkkAYFAhaypHW7p
 UjSzPnNztqCodim1gktiu7DN9dQMxENGCUkpDykzw5EonMlmadm0LnTyWYPkxddC7FY+bZgTVYB
 9ji7TjGEgthqQB2DmZCckun1RZNp1t+B0kdpvUAcOBFmSE/MkseTkg6xRhpw292fAUW4ngdjMfX
 Qp6cSUTbULKbZyxmbKlAffVGZa9owL0nGMln8fCpHQPM/mtnaDkGDTqpbOXeuvEAAEWdQWWTUwY
 evvu8Ot7SeXK5ZtKAFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180085



On 8/18/26 12:34, Harald Freudenberger wrote:
> On 2026-08-17 17:00, Ilya Leoshkevich wrote:
>> On 8/17/26 16:23, Harald Freudenberger wrote:
>>> On 2026-08-17 11:17, Ilya Leoshkevich wrote:
>>>> On 8/6/26 17:12, Harald Freudenberger wrote:
>>>>> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
>>>>> and CPACF_KM_AES_256 for the cpacf km instruction.
>>>>>
>>>>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>>>>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>>> ---
>>>>>   target/s390x/gen-features.c      |   3 +
>>>>>   target/s390x/tcg/cpacf.h         |   6 ++
>>>>>   target/s390x/tcg/cpacf_aes.c     | 107 ++++++++++++++++++++++++++ 
>>>>> +++++
>>>>>   target/s390x/tcg/crypto_helper.c |  24 +++++++
>>>>>   target/s390x/tcg/meson.build     |   1 +
>>>>>   5 files changed, 141 insertions(+)
>>>>>   create mode 100644 target/s390x/tcg/cpacf_aes.c
>>>>
>>>> [...]
>>>>
>>>>> +int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t 
>>>>> ra,
>>>>> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
>>>>> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>>>>> +                  uint32_t type, uint8_t fc, uint8_t mod)
>>>>> +{
>>>>> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>>>>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>>>>> +    uint64_t len = *src_len_reg, done = 0;
>>>>> +    int i, keysize, addr_reg_size = 64;
>>>>> +    uint8_t key[32];
>>>>> +    AES_KEY exkey;
>>>>> +
>>>>> +    g_assert(type == S390_FEAT_TYPE_KM);
>>>>> +    switch (fc) {
>>>>> +    case CPACF_KM_AES_128:
>>>>> +        keysize = 16;
>>>>> +        break;
>>>>> +    case CPACF_KM_AES_192:
>>>>> +        keysize = 24;
>>>>> +        break;
>>>>> +    case CPACF_KM_AES_256:
>>>>> +        keysize = 32;
>>>>> +        break;
>>>>> +    default:
>>>>> +        g_assert_not_reached();
>>>>> +    }
>>>>> +
>>>>> +    if (!(env->psw.mask & PSW_MASK_64)) {
>>>>> +        len = (uint32_t)len;
>>>>> +        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
>>>>> +    }
>>>>
>>>> Just noticed something, here and in all other patches. POp says:
>>>>
>>>>
>>>> In the 24-bit addressing mode, the contents of bit
>>>> positions 40-63 of general registers R1 and R2 consti-
>>>> tute the addresses of the first and second operands,
>>>> respectively, and the contents of bit positions 0-39
>>>> are ignored; bits 40-63 of the updated addresses
>>>> replace the corresponding bits in general registers R1
>>>> and R2, carries out of bit position 40 of the updated
>>>> address are ignored, and the contents of bit positions
>>>> 32-39 of general registers R1 and R 2 are set to zeros.
>>>>
>>>>
>>>> Seems like we are not zeroing out bits 32-39?
>>>>
>>>
>>> Do we support 24 bit mode? Isn't that ditched some years ago?
>>> At least we definitely do not support s390 kernel in 24 bit mode.
>>> Maybe userspace is valid.
>>
>> No, userspace doesn't support it either.
>> So neither qemu-user nor qemu-system + Linux will need it.
>> Some weird non-Linux setup might, I'm not sure if we want to go out of
>> our way to support them. I think we should either drop it or
>> implement it correctly.
>>
>> [...]
> 
> It it ok then to assume 32 bit mode if not 64 bit? Like this snippet:
> 
> int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                    uint64_t param_addr, uint64_t *dst_ptr_reg,
>                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>                    uint32_t type, uint8_t fc, uint8_t mod)
> {
>      ...
>      int i, keysize, addr_reg_size = 64;
>      ...
> 
>      ...
> 
>      if (!(env->psw.mask & PSW_MASK_64)) {
>          len = (uint32_t)len;
>          addr_reg_size = 32;
>      }
> 
>      ...
> 
> Or check for 32 bit and if that is also not the case abort() or something ?
> 

I would raise a program interrupt, like you already do for, for example,
non-zero block number in one of your patches.
