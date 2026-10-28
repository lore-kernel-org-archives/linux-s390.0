Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195045;
	b=wUQTAglQnb6INNQbXTrP2aKPrRzNspwi4+bKER5yFI8thDTuTY1gRpXYZfK/ZytenqwA
	 m3Oh1qJzGE5LT7mkzfmDn5IIFQy3AIcwV7OZZPo7M1E4stbcd2RegreMwPvFkHgkiqnOw
	 SBKVAVP96w7Hbm07sw+dLb+ZQxSNb6D+190c7jieC9JbvI5VdUb2AJ2NDyeQvvOhed5mG
	 ijS1VKEJL+CpVtrCCr1jYvU3LiWxuxvb+T40JChvlK4wCbHdP7CBrZsPExTpH5f4cm5iv
	 Rd+XyqL5bC/QCVrHHs2LuYwXx1GFWb2iatFJKBwz6Ol05Iw93J1GxPb25vV2x2dQ2wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195045;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Jo5q6dulHzwuHAQGXXzo+AUQBJOKU1ngsYkW6Rj6zTs=;
	b=CxZ6YaWyC/l7poScAq5NsD8PcyS0c73qq/w8oK5p3fq31zjCqmRrF6jIAAi6N8cK9Myi
	 0y/350vkMOYMpAAqIRnXJqDwVGKHnpSi9nCYNK16OwL3M7hauTG6Gt39TJDaUc8j78C7D
	 XRllFJ1mApejPepJRLhcz93GZwllBeLx+4iLTUcGfBVWo5kXds3u7LcBR9/3k7B0zRbcv
	 wn2ezdhCDQ5hf45nOP8CgibmZ7qxmdJEnLMuPo2NRz88Dh+TsMMefKhBU/zFeF0XMny9l
	 jHnr5HnldwmqoEa9+23dsbf2/j9g5aEYf/Th0c+g3buTv0b7N0alrSkRyjHzjUKS5Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gfUUJpN2;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA20606A31E;
	Wed, 28 Oct 2026 13:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA20606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gfUUJpN2
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBiEYG4175125;
	Wed, 28 Oct 2026 13:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Jo5q6dulHzwuHAQGXXzo+AUQBJOKU1
	ngsYkW6Rj6zTs=; b=gfUUJpN2CLPGGoKVAE0yaCEPKNZ1dT/9fT+CA05DH/BuwZ
	X4FyOIVNgEy/7e6N29VVVfCqJ3nF7uFY1pamX+gMtX/JX/0dvzolXgnIh2JsGx5f
	thCxTnydnsr2hoE/z1FJMYQSsSzKnpIsvanaq+zvLhIzThw3eAzjJniSbIiztLie
	mpH8F0qMUE4tNkMg7wxfFOUIny1TSdvDkHHysEcyF3/6KmPxG4sDEAPthS1tEBPw
	iheNzj1X6Fy1+00KY9Yqi1UWDzXZApccIASGMMiKn0BIDY24KTaZEiR5+tqHL/l2
	V9W66xg/w8JSMY9q8Lt7zfLbp6/3HHYYC6KcoQuA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g4s9j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 13:44:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBntJJ1441982;
	Wed, 28 Oct 2026 13:44:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnd7bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 13:44:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SDhwaM44892516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 13:43:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64BAF2004D;
	Wed, 28 Oct 2026 13:43:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4248A20043;
	Wed, 28 Oct 2026 13:43:58 +0000 (GMT)
Received: from osiris (unknown [9.68.31.201])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 Oct 2026 13:43:58 +0000 (GMT)
Date: Wed, 28 Oct 2026 14:43:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 04/10] s390/runtime-const: Serialize text patching
 with text_mutex
Message-ID: <20261028134356.8417D0b-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-5-hca@linux.ibm.com>
 <034dc4fa-520b-4ad5-9d9d-8ae469692698@linux.ibm.com>
 <20261028110926.8417C5c-hca@linux.ibm.com>
 <48b38efa-86df-4654-91a9-88c3118ae372@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b38efa-86df-4654-91a9-88c3118ae372@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae1fc23 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=sdVNXsAZ8R04oH_nJ-YA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: sroLhmCdr0Edsmksvub_bg88hNIr5LVt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NCBTYWx0ZWRfX9yQv8GBDQVyu
 CTJnIS8lC/qbuL1xeFx5f93wkP9P34x+MCSLmjyxWiDL90MXCpbVzbZx5DCr+fMhLFD1tSd5Yi3
 BduhGlwJv5q+LbZOwSinDysRvytSyGejQn9EZf3b/oN7pVREJsUnfOyOD6kABEW72wllKwXqQu9
 3ANgxMjEtfOyM8y1QIFBG+LYPg1Jy/b0jvztXZwCP2sbw4w8FPpcg597p0v9S3cpzpMCAbJFP5l
 E/+LI5gWEZ4/5HfKy1d+e3++AQwc2mgcFCprL1gvFdLXFoaxs7GdtW9F/1LuR+p4NjppIoaJWeo
 SFmsO+girwmgif0NxhO2gcjBX2vVzsS7K0Z+CiKKVdJUXKlzxtwJu3lwXIAz85Qo8IU2W+Unm8W
 PCallGtEB9MKa7GptSPNQowP2kvbq23kc2VBrXb9iT714a31a7iNYyAR65f1dceIYX3P5Yk7Tdi
 wjxTmjumiKWPHdm1N6A==
X-Proofpoint-GUID: sroLhmCdr0Edsmksvub_bg88hNIr5LVt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NCBTYWx0ZWRfX4doLCR4J/cE6
 HFHRb2s5zYBN/rP/zf17zZPD8OYT6zTWbyugHzovZG340hs8K9PYV7B6Jl+A+SHVIeVu4UkUkLJ
 TNSNPcnQr00GnSd1Fzjc8+WXF7s6p5c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280054

On Wed, Oct 28, 2026 at 01:22:30PM +0100, Ilya Leoshkevich wrote:
> On 10/28/26 12:09, Heiko Carstens wrote:
> > On Wed, Oct 28, 2026 at 11:58:27AM +0100, Ilya Leoshkevich wrote:
> > > > @@ -88,6 +89,7 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
> > > >    static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
> > > >    				       unsigned long val, s32 *start, s32 *end)
> > > >    {
> > > > +	guard(mutex)(&text_mutex);
> > > >    	while (start < end) {
> > > >    		fn(*start + (void *)start, val);
> > > >    		start++;
> > > 
> > > Interesting, so clang is able to propagate context even through indirect
> > > calls without explicit annotations?
> > 
> > There is no clang context analysis involved here - this is purely lockdep
> > based (with the last patch of this series, which adds lockdep_assert_held()
> > to s390_kernel_write()).
> 
> Ah, I see, it's stated right in the first line of the cover letter.
> Did you consider using it though?

Yes I did, but if I add __must_hold(text_mutex) to the inlined
s390_kernel_write(), then clang cannot prove at all call sites that the lock
is actually held - so plenty of additional annotations would be required (if
possible at all), and then I decided to drop that approach and rely only on
lockdep.
