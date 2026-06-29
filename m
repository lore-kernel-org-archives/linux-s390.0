Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459640149C
	for <linux-s390@vger.kernel.org>; Mon, 29 Jun 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736037; cv=none; b=PlKJQUOa3RLpSZkJSO27CNonQaHBD+HES0Zr8RX+VLFGrhEl0lqg/HIoZI7THKJ35brlPeiA0qkVb0prBwAgcUvh/Ow110Rw1ciwk6Nr/ijv7jCPsGpdENU0Hvfrsmg0HVszdzmrgviN1jxU/49cYoeY3LNQhMs9ENHi2Ktrbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736037; c=relaxed/simple;
	bh=QlYygICxNBpQ/Ptt+sQFjmKa+pBN5UVNdo9uDRsic7Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=buXqUX0e3Wv24zWCLnIlcWPB0lvmPYc4gScicY2shIbyi9asrRjWgz006arNhMqNMoWoBqoiPJ2TbpEx6nsaQfEkt20DyadYc5+Wv+JodjWfm/iwdbH9hNDJdq9GIrd5ig6+bKmMwEOWSQ+58mUEkseZfPQn+ZGo5WMKVnYh1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PpuUX681; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PpuUX681"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmJ4l3030319;
	Mon, 29 Jun 2026 12:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=AhvgWBqBK+gyx3Qqoia17/KZeoYe0d0Vgb6jf0VEkgw=; b=PpuUX6814gB8
	zzWw2fS+UzyY4KbVw5s05ntVqn0xC9X1ouc89NlDyr34PJn0ZSEWr/cJDVNB2Qzx
	pfHRXHyyWKDl4kNhghKAZgBU9kc+Vg6SoMGTDMcwzmXogwrVxmdg1DXvFU2Zxph+
	xilG6DwB5+InrCBwvjPXvXpjJqvxPkaXNvR/sR+xaENqBS9tYinBfyBimhaoV4kl
	igqyKalwvIvGftPtSd4hsuVqc83supUp/Rl0S+imQReHzLybUwQ1U6+OuRWzktme
	SJR5Wun5IpoKkEf9+7c67zqHlYKDR/mCqESyzaz36AmMtWKoAmWruVOX5MvFBySo
	6zDts7gJwg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pds9js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 12:26:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TCJmee032478;
	Mon, 29 Jun 2026 12:26:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq5j74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 12:26:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TCQt9618285158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 12:26:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1E385805F;
	Mon, 29 Jun 2026 12:26:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89DD058062;
	Mon, 29 Jun 2026 12:26:54 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 12:26:54 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 14:26:54 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
Message-ID: <4d2925e1d9f9f2cb78601c65fefb621c@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GxuyfIghLTY5NmzupVbslA-cW1v7HlNr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMSBTYWx0ZWRfXzkSKdlI7oOJi
 yF+J02GryK8HTWHo69DBeeWZHGs/E9HmEywj5Mgfp8b391UUvmPw8XVPv/aXjcIKb7MSFZtm8Ur
 MMdrpqfbBs8xiFbOo0YoaK7D6g6wvMI=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a426492 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Wqay2uD6u1lBzW4eh1cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMSBTYWx0ZWRfX+ImgEoRC7qI3
 9um/vzSQcRExqIwkProFOb0frGswV5h6KH1lN8UL88iVyVBEuQ3z6oiZzG+y8yCdJ6KUftDfxvx
 KOPxFmxRYxedzVDyG1BW18pAzsCFZxicYBSP15RhlVL2MgGCEUODoPgwOF3jQo7GnBTmHeiYCC0
 SJVrPDjNMAwBFL2c+xc4IDJ6VgoAkyg2HTT0uanzjmZfABNxGdNAwM8Wkw6J2kHLIzpOwQV2lNC
 R2RZLC8JTrNdW+C6Nf5cHnst1uTLHqB4lkHGZ0E3HUZFP/GMdY/gLlva7rPfbcvNX/YWH0F+8pe
 X9ZytQlEgcw4PVXuL6ymwdRwlzedlJ2kRqN6naZt0rC8H58vtg3HQcUY4UBFaKufirVkkCjcl07
 uVDnKQU88v5Khzzoig1RT6XhN68DV4tgL3I35lcRCZvw6hu0VWMcID89nC0uR+JPxW5/raQU8dz
 bXmI7FJTj2zwcCcrFbg==
X-Proofpoint-ORIG-GUID: GxuyfIghLTY5NmzupVbslA-cW1v7HlNr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290101

On 2026-06-24 12:05, Philippe Mathieu-Daudé wrote:
> Hi Harald,
> 
> On 24/6/26 10:09, Harald Freudenberger wrote:
>> With the introduction of the address wrapping function
>> wrap_address() the result can't be used to walk the
>> source address any more. So introduce a new local variable
>> to hold the wrapped address to avoid mixing source and
>> wrapped address value.
>> 
>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>> argument")
> 
> This commit merely added an argument. I suppose you meant
> 9f17bfdab42 ("target/s390x: support SHA-512 extensions").

Yep, you are right. This addr overwrite was introduced with the
original code - thus the commit you mentioned. I'll correct it.

> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>> 
>> diff --git a/target/s390x/tcg/crypto_helper.c 
>> b/target/s390x/tcg/crypto_helper.c
>> index ae392bce0e..29ad2aff43 100644
>> --- a/target/s390x/tcg/crypto_helper.c
>> +++ b/target/s390x/tcg/crypto_helper.c
>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, 
>> const int mmu_idx,
>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>> mmu_idx);
>>         for (int i = 0; i < 8; i++, addr += 8) {
>> -        addr = wrap_address(env, addr);
>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>> +        uint64_t _addr = wrap_address(env, addr);
> 
> s/_addr/wa/ or even directly inline?
> 
>            a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
> 
>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>       }
>>   }

Yes, let's make all these occurrences directly inline.
