Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363D175A99
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976633; cv=none; b=GgfkXjjcWAfWJ+0+DFuBkiCXqQ+pkMDM9ypD1seC0eY/bgkyORND1WZLIUSaGbMXo0eZsIAWL3yLHNPGC5Fs9xP9vwbzo2w4d9F+ZiTP/Lg5p7u5uhRYZfO6ley+NiT4J4Mq6ywGa9Ec8rUvsACPxGF51EbArhdX/DIqgOOkZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976633; c=relaxed/simple;
	bh=qREnTMwQeQC3pRRkEFjZPpWA2z+vCApEI+TV98j0dEw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uxoPG3CvOYfnsHQb6B9F6/iluwuLMo8dm0uVo5X7ZfXWFA7foxmnhzgahcRGx8yvZUbYbYWh2gSFrIAGr3iDa2fpGj7qq/VY2IMjhAoGJMZIE4ooF8YvM6260rnXkjI14S6FREOniKkXd8DEHTFh+tPvqjSuWgRvJJzlyaTlZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZhMfpvtu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZhMfpvtu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HCW2PK288077;
	Mon, 17 Aug 2026 14:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=X2HPiCjnVt1tLMxk372INQiyxrvemgL4OP55VEzkYws=; b=ZhMfpvtujK1N
	D3IroGYYscjeKiCccZ8FqGSOwbdnfsfq0rVn0Gx2ceQ8zvGyfu+2QA04PJxixImc
	VQRaR3L4nYUpu1LyHcD6R4DmbXOkEGwsjBjx6eJ23lQqaK1NTUSvfLY7Ob0ny8Hy
	P1wVlwlLz2Vu8dLye8Y8Ap8W1x5xyPFwGqimM8Y8jT950vlQId3j9RaTsmAvrQV5
	+O/b+qW5e6xHX3Dc9chqohgR/pID1pmDguRCQo+JZ/UsLLfKjHfqMB02zY0nAwB7
	Eg2lBt1vy9H90oN/4CJcPhKL5HfP9R0WpqLFMIxiHE1QeuA6xHodsUI1zQ39HD9U
	sl1Uzmmtlg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe2ft7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 14:23:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HEBJ2q023436;
	Mon, 17 Aug 2026 14:23:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejxccf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 14:23:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HENRgg24904236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 14:23:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAE4F58065;
	Mon, 17 Aug 2026 14:23:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 361D75805F;
	Mon, 17 Aug 2026 14:23:27 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 14:23:27 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 16:23:26 +0200
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
In-Reply-To: <e95ee364-3e48-44c4-8c7b-5d306f417c16@linux.ibm.com>
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-8-freude@linux.ibm.com>
 <e95ee364-3e48-44c4-8c7b-5d306f417c16@linux.ibm.com>
Message-ID: <192e2ce59d17947e5556dc54e3b3c781@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwNyBTYWx0ZWRfX2OlIqyz08nhC
 hYZ4CTCaBDvobkLYuKD6C9qB04lzHpxzdIJFTX/MS+fPMHSOVBCN9xuxaiI2eYwmXICkBfXffYY
 C3FAkrzlwGeU69WlOHC3VMfzhMiZvb6XHA3nmmIhUHeakWsL3HEbefEAymSVeGhIF1D4lS4ZKce
 K3p8Hf4Y2kA8S33Hjw8/ntKtZt18Sx1dg2SEE5GlJAfoQBmCVLtvoBV2cAyO/maXRohBQCCCNmu
 jv2e6IZSOkP2PlL0i2Tu8QBUwnDtFYNYsY82WIWFw59Nrot96u5E14/7NlfiTCXbNw/iRgw2VsY
 ItKT3ZCMnYdN265WDLYU1yK9CePHHWfC2o10rDrH+2lMIeyrCEZKs5MBcxsVBE8vpOm1yIEoIMA
 EipsLxTVXlYUs6EB/ZpssYQjy0eC5ZogSWwjBbNXK6gTFoJMieV991oJKOwF+c12WsacE7QTL6y
 L3Ho0gVoOJbu6HcYLDA==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a831961 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=IOLgoV1oOz-xrUi0nb4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: vUHXDkZI7QuNjZg0GXxSpMY1qkFcCqS8
X-Proofpoint-GUID: vUHXDkZI7QuNjZg0GXxSpMY1qkFcCqS8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwNyBTYWx0ZWRfX9fMMbBW82A6a
 k1aj7HX5InvpmFv2+wdlYqE7OBEVmRb385NkavG+9uoVqLCL9l0p8bt6J3wqb66YYzYMqhMuuQ5
 vtmwm5M7F/uC3/XI3D32OvoZGGULVhQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170107

On 2026-08-17 11:17, Ilya Leoshkevich wrote:
> On 8/6/26 17:12, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
>> and CPACF_KM_AES_256 for the cpacf km instruction.
>> 
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |   3 +
>>   target/s390x/tcg/cpacf.h         |   6 ++
>>   target/s390x/tcg/cpacf_aes.c     | 107 
>> +++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  24 +++++++
>>   target/s390x/tcg/meson.build     |   1 +
>>   5 files changed, 141 insertions(+)
>>   create mode 100644 target/s390x/tcg/cpacf_aes.c
> 
> [...]
> 
>> +int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                  uint32_t type, uint8_t fc, uint8_t mod)
>> +{
>> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>> +    uint64_t len = *src_len_reg, done = 0;
>> +    int i, keysize, addr_reg_size = 64;
>> +    uint8_t key[32];
>> +    AES_KEY exkey;
>> +
>> +    g_assert(type == S390_FEAT_TYPE_KM);
>> +    switch (fc) {
>> +    case CPACF_KM_AES_128:
>> +        keysize = 16;
>> +        break;
>> +    case CPACF_KM_AES_192:
>> +        keysize = 24;
>> +        break;
>> +    case CPACF_KM_AES_256:
>> +        keysize = 32;
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    if (!(env->psw.mask & PSW_MASK_64)) {
>> +        len = (uint32_t)len;
>> +        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
>> +    }
> 
> Just noticed something, here and in all other patches. POp says:
> 
> 
> In the 24-bit addressing mode, the contents of bit
> positions 40-63 of general registers R1 and R2 consti-
> tute the addresses of the first and second operands,
> respectively, and the contents of bit positions 0-39
> are ignored; bits 40-63 of the updated addresses
> replace the corresponding bits in general registers R1
> and R2, carries out of bit position 40 of the updated
> address are ignored, and the contents of bit positions
> 32-39 of general registers R1 and R 2 are set to zeros.
> 
> 
> Seems like we are not zeroing out bits 32-39?
> 

Do we support 24 bit mode? Isn't that ditched some years ago?
At least we definitely do not support s390 kernel in 24 bit mode.
Maybe userspace is valid.

>> +
>> +    /* length has to be properly aligned. */
>> +    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
>> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +    }
>> +
>> +    /* fetch key from param block */
>> +    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
> 
> Another weird nit, also here and everywhere else. POp says:
> 
> 
> When the second-operand length is initially zero, the
> following occurs. The parameter block, first, and sec-
> ond operands are not accessed, and general regis-
> ters R1, R2, and R2 + 1 are not changed.
> 
> 
> I guess we need to bail early if length is 0.

I'll fix this.

> 
> [...]
