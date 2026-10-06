Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C263BCD17
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296208; cv=none; b=Md54vlXwa//T0QLeg0er7rVIly12aeVuwYldWRRe38WUXd+GeookY1e5kwSGNzB8fwoJzbCeZQFn6uPfAIMBk8ZoZ1I7EBRdXXYUEequmNH6VnZVId4qhg8wrZvsWWtMOJhgwAuaQ4yeRhWvl4SjK5MThHeiFEIio2SF2D1UhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296208; c=relaxed/simple;
	bh=iVbc/2bDrqu96hDuL2bwQcCG7/QgkrDOXOIohrhSdpM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TkgOYmSWJH9bBFdNouQdlWF9ZiBY0t4jHBE8q6IyLMTvlo0qkSxcqfW5ivGYNZ6WE0koiemnDT7HLtIr1teh8NBDEqKBjTrf0OyHBd0IUekwH1lXk7Pp3ifMaxOQdfgoIzp23n4HyEbGMJc0kxCkJLeO8wX6oTHC6sziTowtXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I6Vz9C0g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I6Vz9C0g"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696DZJEh3932080
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=2ANi2FQv+Af3sjxbpDNxlI42CNHmKTviFP8nJKY91w4=; b=I6Vz9C0gHbQx
	SeFOiAM+gN2AwJI+gYAd+fTgZLIZG3O4F3rtwtNBzt0K8/sq0Rt5udFwyhHZwgHm
	WML3nl4xgS0f1e43rI7JjpibqZJI15zjqoT15zSzoTN72I9f9OzfczHXHXM0ClKB
	tHNv5Do9PifVY+9T2g2UCLKTCaRTkmzf+e9HpD9VgAbodty0mbSdjMSfB0U9VcYb
	dJjj28Q54PfhoeYhhbT/Qo/6W0nyLqTeH2FjOjQMDflzukQns7H+lkbbk99muHxZ
	4Q7mfJx6xOw89+OpM7EaB5gKDJK+71he6qY+Me5iqecKa6EoX+pyR5rfQDX9jc8F
	nxWRKhp/2w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74rgbp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:16:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696DWYhN3293816
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:16:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8ga283-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:16:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696EFwUl25231998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:15:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C5EC58059;
	Tue,  6 Oct 2026 14:16:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2D0F5805C;
	Tue,  6 Oct 2026 14:16:42 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:16:42 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 16:16:42 +0200
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
In-Reply-To: <20261006133931.17402Ee9-hca@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
 <20261005141417.65822-2-freude@linux.ibm.com>
 <20261006083029.17402Acd-hca@linux.ibm.com>
 <137730ff3385fca1febcab3006c17584@linux.ibm.com>
 <20261006133931.17402Ee9-hca@linux.ibm.com>
Message-ID: <48014bf5d6cff03b25de57bb6474e71e@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FahqiEwHtva2KRIEAGpk0XGhx6QQ1BTZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfXxX4CV98pdPtK
 ZgJFxqpSddrV8on40prmCuL1+ApYC7aJtlVKAzhpuDPK0iAcxJLFgnaTJuJLuR0v7eP8WQFa82i
 9Pkw9PxUNN8n84g0UIP2YfOTw9XVvlY=
X-Proofpoint-GUID: FahqiEwHtva2KRIEAGpk0XGhx6QQ1BTZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX5W0cO5CPxYAL
 Ji1zOiUGZGQliO9zSB9kP93D/LxB2ofXNjqLBYA5/vf5XeR4ONKZ1KNAE1MFR9Ks/dZwj3p/rvx
 NbBayulZAEGYMAqikmyYRR9AmXz3LTyiBKunK819QWK++hiEz8kUnGoCjNaD5xQZwFwLQelP96A
 JT+82uDvBAgEtdJY+BUZ/xTN209+hR4msrR9Y8YDCypCyPUfV+7ohxIItfRuZMH7ivrjLDRp/L0
 H8ffU0qi9cG8wibf0fmmTOewVhZp2ExRoqnTDts/t2HggJhDGAwXagvrfd7EqurDffqau8IRuyv
 8yfW8ktpeVRHJvUmcOtomxqW5biM2Zq5lMc0wfPOIidoMOzyZ2snahdUpD2o/La54C/+RcL17Dw
 iDwgFpumU2pzOj6TnF7M0bzh6hKQ7VaoMQlfu0c5Z9tyVmjVTgWcWZJzkw2Zohs0Yk/QrCrR0cc
 OUOOFERZK2yoVBWSb1A==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac502cd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=EvesU8KXUYCMoYIoi0UA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060056

On 2026-10-06 15:39, Heiko Carstens wrote:
> On Tue, Oct 06, 2026 at 03:29:28PM +0200, Harald Freudenberger wrote:
>> On 2026-10-06 10:30, Heiko Carstens wrote:
>> > On Mon, Oct 05, 2026 at 04:14:15PM +0200, Harald Freudenberger wrote:
>> > ...
>> > > better readability. Additionally add an kmsan_unpoison_memory()
>> > > statement to reflect the updated memory by hardware.
>> > ...
>> > > @@ -731,12 +739,16 @@ static inline void cpacf_kma(unsigned long
>> > > func, void *param, u8 *dest,
>> > >  		"	lgr	0,%[fc]\n"
>> > >  		"	lgr	1,%[pba]\n"
>> > >  		"0:	.insn	rrf,%[opc] << 16,%[dst],%[src],%[aad],0\n"
>> > > -		"	brc	1,0b"	/* handle partial completion */
>> > > -		: [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
>> > > +		"	brc	1,0b\n"	/* handle partial completion */
>> > > +		CC_IPM(cc)
>> > > +		: CC_OUT(cc, cc), [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
>> > >  		  [aad] "+&d" (a.pair)
>> > >  		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
>> > >  		  [opc] "i" (CPACF_KMA)
>> > > -		: "cc", "memory", "0", "1");
>> > > +		: CC_CLOBBER_LIST("memory", "0", "1"));
>> > > +
>> > > +	kmsan_unpoison_memory(dest, src_len - s.odd);
>> >
>> > Since you added explicit instrumentation here it would sense so add
>> > kasan/kcsan instrumentation by adding an instrument_write() call.
> 
> That should have been "...it would make sense to..."
> 
>> I have no idea what you mean here...
> 
> See include/linux/instrumented.h - you can the kernel about
> memory accesses also kasan and kcsan. Your patch only adds
> that for kmsan. See arch/s390/include/asm/fpu-insn.h for many
> examples. I'm aware that such annotations are currently missing
> for many of our inline asms. But since you are at it.
> 
> Up to you if you want to add it or not. Just a suggestion.
> 

Ok thanks. But I would prefer to have this seperate from this kma 
rework.
It would make sense to have that notations then for all the inline 
functions
in cpacf.h.

>> > Also, given that this is in-kernel crypto, shouldn't this series go
>> > via the crypto tree?
>> 
>> Well, this is to be negotiated. I first wanted to collect an RB 
>> statement.
> 
> It would be helpful if you would add information like that in the
> cover-letter. This saves both of us a bit of time.

Ok - will do. I avoided to have direct address people in the cover 
letter.
But when you are ok with that, let's run it that way next time.

