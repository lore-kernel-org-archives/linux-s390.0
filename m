Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59935191F91
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293981; cv=none; b=py6I5V4nMeAK5K4a+9mOomiQfBVku23cEKsFCWpees7MNAHOUA0IE5ATrezCRNzQUxeBA56z25XgjhzuE3fv2NvsAPBa9QyPNj20GiWCv1k1mTD5Tgf6PMZyMBx4e2IJJ7swEL98Zl9xl1jSrOpqBwi8LaOFALMwwiwDCbB5Gqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293981; c=relaxed/simple;
	bh=XfpX90WC1acwRpql3odTtRX61O+go/Dd0UV29hGoPnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2ArVCdUe9UBd7TZTDRmh4TFbYDM1Rw5plX9/Ziyanhu2ogC4daE36et0BxJ6j7W1AY6dtOGT2qAgeG4TUKkjyz6Xd5+4rHLr383nowBDdUfYk3rjZg1o8ZhXTLSqggxPtfmci69DLicUhXflGqylm0MRP2IhPQSsz5QnBs4CDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XIq0RC33; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XIq0RC33"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696DZSdg3867894
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 13:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6NDLn/zMlw5zPsJiztj8ztbjQVhK0j
	gZneN9mpWneoU=; b=XIq0RC33IBGgyE4iorLaEMtgLIk5zSVcPFVd6owFO7Rq7k
	EiN5gyKfCjW/3GZr5sR4qWokKZpJSQP+JnrqlWh5iujJWlXqNy8OE/TT0wi4MjWX
	WKhfu+WzxbRuP22eK6c4Fkp8aEyeMgSyqB/MqCXmjnWu1J5I57916VjwHXx/NoTZ
	MbIEYSSIN1cQpHPOJoVl/KEPvqsHcApl6ewTFqvwnvtXvmkgr5FNo65V7KhsJJHY
	Q0Mu2jAWFzEyuHD4fjMOyC21ReJRRGa3IxG936lzLDgIZ7Jec8t++iT8RC+As+h3
	jlxxmaZBaKJ6qwJbKHCxfsRMSLkWS+9GZrmB2r6g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv78cu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 13:39:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696DWmCR403703
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 13:39:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgt1hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 13:39:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696DdXoM42729836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 13:39:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 279AB2004B;
	Tue,  6 Oct 2026 13:39:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD76D20043;
	Tue,  6 Oct 2026 13:39:32 +0000 (GMT)
Received: from osiris (unknown [9.111.2.28])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 13:39:32 +0000 (GMT)
Date: Tue, 6 Oct 2026 15:39:31 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v1 1/2] s390/cpacf: Rework cpacf_kma() to return
 condition code
Message-ID: <20261006133931.17402Ee9-hca@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
 <20261005141417.65822-2-freude@linux.ibm.com>
 <20261006083029.17402Acd-hca@linux.ibm.com>
 <137730ff3385fca1febcab3006c17584@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137730ff3385fca1febcab3006c17584@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Blwqxkt3uh53ugh-18oEWTUuCqwZbCcL
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac4fa19 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=iXYo06MOrnUnWJV5c40A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Blwqxkt3uh53ugh-18oEWTUuCqwZbCcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX6dB04zfQzGTf
 G7/BlEwu4bbAR/9ehR2PHN1Ef4gEJlF1RZsi32FPKKcjVw93vIaOkSdJPXBbQ+nH6vSIubvLlwn
 WhASfc61rsyn3wTdP8SzWK/lG0eRfZBxm/nIDisR50fRC/C7dJdVzESohXGKSuSzcugiD4UuxnC
 9BdA1jQ2/eG48T60XAL1FL7xq4obKiPbXwDnz44X/jYzJu5bOaO68+LbROzbunmH+HHNxcoVqUr
 sPHeNNP+whI+qz8lj+RZRO6xSqrVLWhfL9L4whQ7m9c9nPilQS0qg5P1ofCQRo2kUjqh1SA6K8U
 VNGWps7Z16tAsUuVvbdOzlpzSmIguJXucLMIGV1S0Ow0qWqWLPHx3vA3Fh2iIOZjOCFI6XPyvjp
 hflz/vYFeviwFYyEcHVWyTZCbKwjfV/cm1wRi6lUWm6zZ+/nL//23swEhWvneTkeVXwgnFLqlKz
 BKMN94S+IBAJUAWkR7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX3702Ga6gWYgM
 8+4qTvrWtZgunKnfIJLNXnK42sVXYyxRkdQcszZG7ZXV45yaKBM3mhA7Ti963R9t1tx87hOsooN
 pQTRUPnJZmpXNIqDH/HUZs4W10KxA+M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060054

On Tue, Oct 06, 2026 at 03:29:28PM +0200, Harald Freudenberger wrote:
> On 2026-10-06 10:30, Heiko Carstens wrote:
> > On Mon, Oct 05, 2026 at 04:14:15PM +0200, Harald Freudenberger wrote:
> > ...
> > > better readability. Additionally add an kmsan_unpoison_memory()
> > > statement to reflect the updated memory by hardware.
> > ...
> > > @@ -731,12 +739,16 @@ static inline void cpacf_kma(unsigned long
> > > func, void *param, u8 *dest,
> > >  		"	lgr	0,%[fc]\n"
> > >  		"	lgr	1,%[pba]\n"
> > >  		"0:	.insn	rrf,%[opc] << 16,%[dst],%[src],%[aad],0\n"
> > > -		"	brc	1,0b"	/* handle partial completion */
> > > -		: [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
> > > +		"	brc	1,0b\n"	/* handle partial completion */
> > > +		CC_IPM(cc)
> > > +		: CC_OUT(cc, cc), [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
> > >  		  [aad] "+&d" (a.pair)
> > >  		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
> > >  		  [opc] "i" (CPACF_KMA)
> > > -		: "cc", "memory", "0", "1");
> > > +		: CC_CLOBBER_LIST("memory", "0", "1"));
> > > +
> > > +	kmsan_unpoison_memory(dest, src_len - s.odd);
> > 
> > Since you added explicit instrumentation here it would sense so add
> > kasan/kcsan instrumentation by adding an instrument_write() call.

That should have been "...it would make sense to..."

> I have no idea what you mean here...

See include/linux/instrumented.h - you can the kernel about
memory accesses also kasan and kcsan. Your patch only adds
that for kmsan. See arch/s390/include/asm/fpu-insn.h for many
examples. I'm aware that such annotations are currently missing
for many of our inline asms. But since you are at it.

Up to you if you want to add it or not. Just a suggestion.

> > Also, given that this is in-kernel crypto, shouldn't this series go
> > via the crypto tree?
> 
> Well, this is to be negotiated. I first wanted to collect an RB statement.

It would be helpful if you would add information like that in the
cover-letter. This saves both of us a bit of time.
