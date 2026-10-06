Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084D45D5E7
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293373; cv=none; b=noaUBLzoB8AmppwCsvtKWrAaEh+1Qo63n3C/1aM4QxFN6tuLQ2pl40VeH9qQF2DxZf/3IEcdcNK81qdDP/pIcM9zV2ucoc9QyFxJ2PuNVV44rsUT1ZrerXwHyBAM/fSagLUSsKBCQX9LQU5p7yapYcQIckf0+JWJ8QzB25tSxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293373; c=relaxed/simple;
	bh=HiaCS/Um62d7SUoEoiUS3treZlxrG13etAsQrIk24i0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cxhdOFqiShLfmDZpNXTAnJh4r2Vlj8wfZvvxxfYlR+iBh4yYQ5GC/koSClS5Lj540WqKIvX9Iz3KZWSOu44j5hlLMB2OEeOBBx4Z1m1C2SSGXYWyMKKXNPOBfQUMQNSX1aA+/VyqeM8RIf3uMKBNspXqou/JMFToijK+5fziC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g2Ol6MS2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g2Ol6MS2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BZX7R3473974
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 13:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=/zEefy2WOx0xVNpzy56fn56o9JHtzKQQwOlUvCM9QXg=; b=g2Ol6MS2w5gJ
	7Iq6HkaJvUghzOWf3NcpdSajCzAzPVemr0WaRqb3CL7mIL9OgmsoeIifWnehM0Nu
	G1HWTQfWNIIGGJrN9axQgSaGHFFEnxej2GTFrYxSPYNbPdmk5x0kkY2U5yOw3m+5
	MmJZTrYuo2M7kcnSBLqQ7aXCgYD7vvpb3U4G6EsrtfCsLWGZ7TITX/D9KC//goqn
	BOctgIAvTQf7z3PuM/0DcZourxBsRb5t8tRPyAovcdPhKkF7pqjKJWmP4gHXemoN
	SGvD4HhzTRMV8qzRX/P8KxPpPp4Ze/Kzmar0aNeVxsTwYH/QgRn5rwpNpCQUoXAL
	KCkim58S/w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jqn49-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 13:29:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696BWV47242252
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 13:29:30 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy9u8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 13:29:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696DTTYF31916730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 13:29:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75C145805E;
	Tue,  6 Oct 2026 13:29:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2276758043;
	Tue,  6 Oct 2026 13:29:29 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 13:29:29 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 15:29:28 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v1 1/2] s390/cpacf: Rework cpacf_kma() to return condition
 code
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20261006083029.17402Acd-hca@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
 <20261005141417.65822-2-freude@linux.ibm.com>
 <20261006083029.17402Acd-hca@linux.ibm.com>
Message-ID: <137730ff3385fca1febcab3006c17584@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5XU7u35lwXUkMNqWbA5AsLDsipu7Qz64
X-Proofpoint-GUID: 5XU7u35lwXUkMNqWbA5AsLDsipu7Qz64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX4nJ2gkHphjKs
 IQvoZ46cfzlpDzSZxi3olJgZ+hpxM0P2X0KDoxoeN6g71b56cQUJAW5Dgd/a8PUmB6gf4FTAjSb
 f/z8/eXitMnyuNMwwHhMexZhTsWC+N8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX9g0Ddij3BUic
 UpEEp7kTZjYuvH5wSV/6RYvPY6mwVza32X0nxN0OAyDetTjRc9Xti+StAW4GBfsY0JI8KKFeg2Y
 rXBIoSKBjETfnmRZkx4cipTPCuPW/4hkW/z4VDkGoFcp3q30GXOB+aXmuxtyaYsFJrumymXzw0z
 L4+mYb/88FEFpiS9x4NDiczXWlLYnORZLF42tusN8xa6j8n87z2eD+nt/T3+CRxI8ZDn533lobh
 jbuK0NmVcQVo2rnxLgkY2sCwTBEC+dn6zZms0IjLW9MAIcDJqbDP6/qoRZlSWUuAQa38L5ElKyb
 cb3d5/aiFugHQAszdA2XlsgJXxgiZibY4ZKjphGvv2rmFh0S+Hv+EjzdIHxE6vge8Kkw/lfaq8h
 25VF9tfMJJN5pUa/5bxds5eAP414TbHZYPl8vgWnA4fGBKOG41FM8aQrZcGg11y8/jl/jZmAepB
 ZPg5PX7zW8TXbxb23wg==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac4f7bb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=zFS4TZLf0ArDYHn6N2UA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060052

On 2026-10-06 10:30, Heiko Carstens wrote:
> On Mon, Oct 05, 2026 at 04:14:15PM +0200, Harald Freudenberger wrote:
> ...
>> better readability. Additionally add an kmsan_unpoison_memory()
>> statement to reflect the updated memory by hardware.
> ...
>> @@ -731,12 +739,16 @@ static inline void cpacf_kma(unsigned long func, 
>> void *param, u8 *dest,
>>  		"	lgr	0,%[fc]\n"
>>  		"	lgr	1,%[pba]\n"
>>  		"0:	.insn	rrf,%[opc] << 16,%[dst],%[src],%[aad],0\n"
>> -		"	brc	1,0b"	/* handle partial completion */
>> -		: [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
>> +		"	brc	1,0b\n"	/* handle partial completion */
>> +		CC_IPM(cc)
>> +		: CC_OUT(cc, cc), [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
>>  		  [aad] "+&d" (a.pair)
>>  		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
>>  		  [opc] "i" (CPACF_KMA)
>> -		: "cc", "memory", "0", "1");
>> +		: CC_CLOBBER_LIST("memory", "0", "1"));
>> +
>> +	kmsan_unpoison_memory(dest, src_len - s.odd);
> 
> Since you added explicit instrumentation here it would sense so add
> kasan/kcsan instrumentation by adding an instrument_write() call.

I have no idea what you mean here...

> 
> Also, given that this is in-kernel crypto, shouldn't this series go
> via the crypto tree?

Well, this is to be negotiated. I first wanted to collect an RB 
statement.
For cpacf.h I see this in the s390 realm but the 2nd patch is clearly
in-kernel crypto. So I would have asked Herbert to have this processed
via s390 subsystem as the important changes are in cpacf.h. However,
let's first solve your "instrument_write()" call.
I was just following the other kmsan_unpoison_memory() statements
which recently were added by Ilya. I do not see any instrument_write()
in the whole cpacf.h.
