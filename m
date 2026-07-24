Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB7279DAF
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902389; cv=none; b=exFBNha+tZzU4FxdAQt8ys0bxS62yHrIDbzwlG+nKyn1ywARCOvdjs9pnIfxfuMboTrscUZV+u4Y2QtXFxtuWHLAS86Nejh4VnWqmGwzekLzyrQeptirynL0mzE6BydHE3RKYxhZzvVw6KKP4jj2FSFv0RiQHO77JfTszPkUQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902389; c=relaxed/simple;
	bh=1D3jTkNCamiIZop4o8VaBod7s1gM43sKcoub/gFcif8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KueqLfKCi8X6CHfLNeTtQ30O7BlsomUGZyQ50ekPRCxwQHJrIQrOKHnc1RG+ep09sfUWLHlUQRzenca91V/tBFCG8sOluZ2Rsx0xgOvzrPqlXvT8mHoSmgozOwg5WlV3YP00JvO+ESttRltZphAmO5DMu0DbgJh7pAM+VttAY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q5E8ZHBm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q5E8ZHBm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfckP1992724;
	Fri, 24 Jul 2026 14:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=8zd+V+ijzPRyTmIG6/QBBQwF8d9RWZCNyQkBMHd3qRk=; b=q5E8ZHBmGLvF
	H/Fs0K+Zs1Bz4KwoO9aMsvfvq6loZ76DWC2X6I09EBLGaOsIelBd3KJevu/IRdjz
	pTO/L9gCxZvPjIIctd3g+o+9q0bHOT7E9dLj4vhFIKKQfWBZH4ZUtk+Obb8n6Q17
	FEa5gykvQuVrFphmhlTrGAnds3ihRap3aKT09e9/qbQ5tftp1ZLea0X2adKHSHYm
	VaLftm64XuheF2gUnSxhHsYGINo8mFZkpTF5ig1yGVKlgoLxkYIeCa9oKJoSoK0t
	RvlEaEyDC6OgYFareSuebg6ns8m4mi7T5LytLniai8OlhhAU1zUCAppFHBsINb6r
	9e6EfH6mjA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h00ak8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:12:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4hVh014551;
	Fri, 24 Jul 2026 14:12:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk97f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:12:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OECIlI66257376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:12:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DA7358055;
	Fri, 24 Jul 2026 14:12:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BA1C5804B;
	Fri, 24 Jul 2026 14:12:53 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:12:53 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 16:12:52 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v12 04/17] crypto: Add aes-helpers file to support some
 AES modes
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <13fa7159-9757-4858-b824-6507494e0876@linux.ibm.com>
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-5-freude@linux.ibm.com>
 <13fa7159-9757-4858-b824-6507494e0876@linux.ibm.com>
Message-ID: <6fe4d22239274e4f0616f79ae780cffe@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a6372e8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=fuWslyhyJ77BdVGGdxcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: q8nV75USnp17fDY8AdoN501HmkCL5EaS
X-Proofpoint-GUID: q8nV75USnp17fDY8AdoN501HmkCL5EaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfXww6KHgRQEQmt
 XNNRRKOhAJXmICAoyKIVPiMnI5YhFfJk3+adRM1p6cP9O9+uU7QR9mstB37XSW9XKJ8nMmC/ZdV
 ES8Rx3hzxgUkBY9ZHLiVTt3+/UwNo4IcdV0vD5yD2+PnqvpqyME9xWaPMoUoVlj1L/5LsmBAuki
 Ee/gWykHfSPYAFBiKL17tX4W/8+eZywl1hvJG9PHRig6PzWsXjyaIssUWrWA7jn8m7iWgTlB6bI
 oqtOL7ZDs0FsUyzComL9hpCMzHmUSk4/WELbujpwi4flwvZFpRpIu5c4fnLXdTFi1/4WNRzCZ+A
 04umIRPvHM/joSdQSNxl5IkND+GHZ1fWGpwtb7OAbcTlKp9K0uvF7WKlCDezk7cy9Tj4zqGPeMP
 QWkkndg89OdLLeBDTjrTmblP+EuBDmMkn1U+k6mUsmxQRhTnlWtQEZ0mZYN+rPQaZ0KxG7+uyXt
 ifi3eXDH9dICjLaXnbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX0MM92gLqp1Rr
 640pfL9sLWoY9CupYgzTM2gr4/h9ll+JMp8YImZ9WV75iubbf3uuCzvcg2TLKHvHbWl3C/wvr/T
 ju4m/iOuuRViKLyAAwBWMyyI4QHL2mQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240128

On 2026-07-14 13:45, Ilya Leoshkevich wrote:
> On 7/10/26 17:28, Harald Freudenberger wrote:
>> Add a new file crypto/aes-helpers.c with simple functions
>> to support some AES modes:
>> - AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
>> - AES ctr: AES_ctr_encrypt()
>> - AES xts: AES_xts_encrypt() AES_xts_decrypt()
>> and some AES related helpers:
>> - AES_xor()
>> - AES_xts_prep_next_tweak()
>> Add header file include/crypto/aes-helpers.h for these functions
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> ---
>>   crypto/aes-helpers.c         | 106 ++++++++++++++++++++++++++++++++
>>   crypto/meson.build           |   1 +
>>   include/crypto/aes-helpers.h | 116 
>> +++++++++++++++++++++++++++++++++++
>>   3 files changed, 223 insertions(+)
>>   create mode 100644 crypto/aes-helpers.c
>>   create mode 100644 include/crypto/aes-helpers.h
>> 
>> diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
>> new file mode 100644
>> index 0000000000..ff4aa0a385
>> --- /dev/null
>> +++ b/crypto/aes-helpers.c
> 
> [...]
> 
>> +void AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
>> +                     const unsigned char *ctr, const AES_KEY *key)
>> +{
>> +    unsigned char buf[AES_BLOCK_SIZE];
>> +
>> +    /* encrypt ctr => buf */
>> +    AES_encrypt(ctr, buf, key);
>> +    /* exor input data with encrypted ctr => out */
>> +    AES_xor(in, buf, out);
>> +}
>> +
>> +/*
>> + * Tweak calculation for AES XTS.
>> + * Multiply tweak by α (x) in GF(2^128) per IEEE 1619-2007. The tweak
>> + * is a 128-bit little-endian integer (tweak[0]=LSB, tweak[15]=MSB).
>> + * This implementation has been verified on litte and big endian.
>> + */
> 
> Nit: do we need to have this comment twice?
> It's already present in the header.

Well the text is different. aes-helpers.h:

   /**
    * AES_xts_prep_next_tweak:
    *
    * Tweak calculation for AES XTS.
    * Prepares the next tweak value for AES-XTS mode by multiplying
    * the current tweak by α (x) in GF(2^128) according to IEEE 
1619-2007.
    *
    * @tweak: pointer to tweak value to be updated (16 bytes buffer
    *         containing a 128 bit little endian integer)
    */
   void AES_xts_prep_next_tweak(unsigned char *tweak);

aes-helpers.c:

   /*
    * Tweak calculation for AES XTS.
    * Multiply tweak by α (x) in GF(2^128) per IEEE 1619-2007. The tweak
    * is a 128-bit little-endian integer (tweak[0]=LSB, tweak[15]=MSB).
    * This implementation has been verified on little and big endian.
    */
   void AES_xts_prep_next_tweak(unsigned char *tweak)

And the idea was to describe in the header more the usage whereas
in the c code describe the implementation.

> 
> Also typo: litte -> little (but I'm not sure if we even need to state
> that in the code).

fixed the typo -> see v13

> 
> [...]
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks for your review
