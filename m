Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E93164D6
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049256; cv=none; b=hN2jRyCN46CkTCYPWASbnrXBcQkiSgjlyBWdtFOGpXvg/DrSL1qm8IPSw/b3eTFwUUUIrYeZz+yqgBPdU2A1oFAgICiuaaPw7jxH0+EmyMpof4d1QNqhWkQxOKVhdR7WLlvj2gnF2HkO2sZGnPfGVDmz4MlQ1WYfxILzNvFotlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049256; c=relaxed/simple;
	bh=Pt/qOSNSsQjnoCnMGW7fC6O+q989HOgQyuFDznl0H8Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QtFKl4/HbbIky3ib/tISZuTR7aIsFZ1g3wLekMA/ALL0HTv+/D9Bsu0jnXwHoofd16pVjeUzfDRs4WDQlQVnRZ63VF46pvs1lhTsE7v069JlV6iHzbYKEXq9xQDbzhJ743/XJQMMyjglxq+Lrzl/5qSUHuYLhbR8LslVQORMb1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hihfn5iK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hihfn5iK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAW4OA4122635;
	Tue, 18 Aug 2026 10:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=LwO4VjJ7lU0beL8ryNMY4sUfRMUeY3JOlTiJfzJ+7I0=; b=Hihfn5iKDTh8
	Ln/Z2XA9i6GU5yN5yJqNu75xn4CbDw2ye8h8uotESSboPaIHZ1YbRDklYfvD6ISs
	SlngbVa1IO1Dfm0nVdzOYZaecawfAgX4x5xJXl1zzpg0b3zyvmGtPoMsRZZi52T7
	ovOhr5loLD89Gj/f2jqpR2pmu094Gpx4TmBS40Wv5mkHv4ZigHnJLP/GliDkgQIO
	cWDTmz9JVaBEsXQlMXDEt5j1UfN09aXe7/pG4NDSbtKjVLQmsnOGzhnLNt2KJ/Tc
	NvnhFp/K68wTvfS48dpHAkgoStGKdcR0r6Mfx7AuCm8EJqNAZKIXvyu3+vxbjAwM
	G7L6tadkHw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkyf0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 10:34:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IAQLdo001061;
	Tue, 18 Aug 2026 10:34:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngagub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 10:34:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IAY4R612452566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 10:34:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABCFD5805A;
	Tue, 18 Aug 2026 10:34:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2644958060;
	Tue, 18 Aug 2026 10:34:04 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 10:34:04 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 12:34:03 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v14 07/19] target/s390x: Support AES ECB for cpacf km
 instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <145b0ed2-8b3b-48d5-97a7-a5addcdf6481@linux.ibm.com>
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-8-freude@linux.ibm.com>
 <e95ee364-3e48-44c4-8c7b-5d306f417c16@linux.ibm.com>
 <192e2ce59d17947e5556dc54e3b3c781@linux.ibm.com>
 <145b0ed2-8b3b-48d5-97a7-a5addcdf6481@linux.ibm.com>
Message-ID: <4dfa9e976a6485dd2b1ffa93f04e1bd7@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfXy9KYi9Hfhhtl
 j8//wj6CzESVylIWq2Ssi1tmFpS33X0J1crvRfAPIVmYjMLE0EQquA7gpRXPHjwDu2ztxtCTtQ/
 YQ1BeAg7DSzkstUfIrZkpC/VS1vIlIrQjCsVhW8FNBaxafmWDZlsLL3NyBLYh36JK3n3L66QHn9
 jgynbh7tKC7uWcBnOpuN29KEN4Qd6tDfB5r3wnHBejrlqqd8zpYJGHiRIbFnVT3QEyekpjX3+/C
 lrAuXgENdbG8QO2uU7i/upOHVfuqS/INpGq/8dkW+7r5y89aWRO0MIZn8urg9T2V9k+2+NFFh+k
 44+AocMCToijfYYXPWBgPEd8hDRWolsrgDuAECK6DSD7srKFu130/BxRbHP9e//9UJT0rRdAGlB
 aceYoiDI3EPQIpEnBFpR0LKZW4/FdvazBa5VbBWVtj2MrexY/PV/2wE1XB32wmbVxksKJsBLpHn
 Mv+wQpgM9JMsghfbhHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfX/JUrvWLmMSbQ
 vBD1tkT0l6kU7Dt4as52rlivqC/MrGwebRV4CAmq9rfZ2Bpo/ynaRClhCnFkNKMq2IVgoGaUv+c
 2BSCb2+IiBFKbgi2iYXE9zR0p9lIReA=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a84351f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=6fOq7FXWUXZ_nh3H2MkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jMmM1AKY1jf25TbIyMo6leZTxtpjpMXb
X-Proofpoint-GUID: jMmM1AKY1jf25TbIyMo6leZTxtpjpMXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180077

On 2026-08-17 17:00, Ilya Leoshkevich wrote:
> On 8/17/26 16:23, Harald Freudenberger wrote:
>> On 2026-08-17 11:17, Ilya Leoshkevich wrote:
>>> On 8/6/26 17:12, Harald Freudenberger wrote:
>>>> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
>>>> and CPACF_KM_AES_256 for the cpacf km instruction.
>>>> 
>>>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>>>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>> ---
>>>>   target/s390x/gen-features.c      |   3 +
>>>>   target/s390x/tcg/cpacf.h         |   6 ++
>>>>   target/s390x/tcg/cpacf_aes.c     | 107 
>>>> +++++++++++++++++++++++++++++++
>>>>   target/s390x/tcg/crypto_helper.c |  24 +++++++
>>>>   target/s390x/tcg/meson.build     |   1 +
>>>>   5 files changed, 141 insertions(+)
>>>>   create mode 100644 target/s390x/tcg/cpacf_aes.c
>>> 
>>> [...]
>>> 
>>>> +int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t 
>>>> ra,
>>>> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
>>>> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>>>> +                  uint32_t type, uint8_t fc, uint8_t mod)
>>>> +{
>>>> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>>>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>>>> +    uint64_t len = *src_len_reg, done = 0;
>>>> +    int i, keysize, addr_reg_size = 64;
>>>> +    uint8_t key[32];
>>>> +    AES_KEY exkey;
>>>> +
>>>> +    g_assert(type == S390_FEAT_TYPE_KM);
>>>> +    switch (fc) {
>>>> +    case CPACF_KM_AES_128:
>>>> +        keysize = 16;
>>>> +        break;
>>>> +    case CPACF_KM_AES_192:
>>>> +        keysize = 24;
>>>> +        break;
>>>> +    case CPACF_KM_AES_256:
>>>> +        keysize = 32;
>>>> +        break;
>>>> +    default:
>>>> +        g_assert_not_reached();
>>>> +    }
>>>> +
>>>> +    if (!(env->psw.mask & PSW_MASK_64)) {
>>>> +        len = (uint32_t)len;
>>>> +        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
>>>> +    }
>>> 
>>> Just noticed something, here and in all other patches. POp says:
>>> 
>>> 
>>> In the 24-bit addressing mode, the contents of bit
>>> positions 40-63 of general registers R1 and R2 consti-
>>> tute the addresses of the first and second operands,
>>> respectively, and the contents of bit positions 0-39
>>> are ignored; bits 40-63 of the updated addresses
>>> replace the corresponding bits in general registers R1
>>> and R2, carries out of bit position 40 of the updated
>>> address are ignored, and the contents of bit positions
>>> 32-39 of general registers R1 and R 2 are set to zeros.
>>> 
>>> 
>>> Seems like we are not zeroing out bits 32-39?
>>> 
>> 
>> Do we support 24 bit mode? Isn't that ditched some years ago?
>> At least we definitely do not support s390 kernel in 24 bit mode.
>> Maybe userspace is valid.
> 
> No, userspace doesn't support it either.
> So neither qemu-user nor qemu-system + Linux will need it.
> Some weird non-Linux setup might, I'm not sure if we want to go out of
> our way to support them. I think we should either drop it or
> implement it correctly.
> 
> [...]

It it ok then to assume 32 bit mode if not 64 bit? Like this snippet:

int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod)
{
     ...
     int i, keysize, addr_reg_size = 64;
     ...

     ...

     if (!(env->psw.mask & PSW_MASK_64)) {
         len = (uint32_t)len;
         addr_reg_size = 32;
     }

     ...

Or check for 32 bit and if that is also not the case abort() or 
something ?
