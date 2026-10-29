Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271488;
	b=ZlbDgIiphpaKHnXD4TFJiEdMq+Kga+geAQdQahUn/+x2LnQUf6+2+398eDqcSi6Mthdj
	 4GN7haQ4j1N3p7cFXdayi3+10G3Se+eCUuXPkDarbDlMmTGDz4PRptAK6sS3bEJXMeY0M
	 swLgHqLN4aj0QieyoRStA5hWaTltqrFuqJJ9n5GFl7GIz57YOQLBjkMEg9a7Qj1cfulAa
	 o8VrodVOuaaAb6M6fzZdx8ejoJIo79QyaxHJ6RFmUQ3KwDWKKqjvP+/YFCcXNBXXPdE16
	 q3eKHDLhuG0xMjv1eWKTd+OeSDIa1W0ZRQawtseFCXYqLCcSREnxMSV0BfFc0wlrZQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271488;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XDklzb9gvQ1GspRWCspuPTLVlFG+zCbQzRS72KSJzOc=;
	b=JhcNEXVQtWGpMvUAt3+clzPkwyT6cVNVhkHfopEgMaLhYKUecjjUyI4PYppmMmmdqNBy
	 L//eHR9BWCohPilPryo+TAZhjfhUV+pk4PXYIrarzDzexmFOH2x+dqaKYVS5w0+7Xi9Bz
	 Na+UDl3Wprybe5ALryk85UYoPiO9Fjr8xmig3GMhuL/z5tG5RJF24pCS/RPyIgibhFLlT
	 X9/vbEFGMzj8YLY94NEcCtZtUNbERsblZI1j4TIeM5Ei9NJzBiclcFwMnWjQAEfQTtMU2
	 Ka9Ga/giUdmZ5qqK9pyNzDbctWrDPUZ9T0qLNiTepRX0LPO4T6rU3C70/X/FxEAv63Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="LEK/lA2c";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C5606A321;
	Thu, 29 Oct 2026 10:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE7C5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LEK/lA2c
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T9E6vg3962695;
	Thu, 29 Oct 2026 10:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XDklzb9gvQ1GspRWCspuPTLVlFG+zC
	bQzRS72KSJzOc=; b=LEK/lA2ct13CJArUK4pj0u5Xaw1CqzCewAXaOqeyryUKNc
	UCSg+d976WjZqopjAECIsUoPQRnLmh0gJOoqU7UI8jdnyrx/ckw0zXk75rCj7/SL
	N8ka9b7H1jVfwrGyFZxD7cWbHGk+Bs5D0VCTOrc6mReyK7c3PNUeL2UesL4kPR/0
	Q3vvzpHce4oml8tr3YHWvExMbT3L3qr+0qcTDnmsVHmts8eAL+zpiNEHbHzujUbL
	6e3NV1rXYLKEVmDyffUQ1pcpsoxIGuhkoHvWbrYwOi5HnrNTWA2H9TpqkWWAuiA7
	l9+9+IcRuXeOXvax1AH5pezYkfv7cT+HYLMQHHrQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm649na8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 10:58:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69T9K4KY2914955;
	Thu, 29 Oct 2026 10:58:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pedp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 10:58:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TAw1Wh36503926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 10:58:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A37752004E;
	Thu, 29 Oct 2026 10:58:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 542802004B;
	Thu, 29 Oct 2026 10:58:01 +0000 (GMT)
Received: from osiris (unknown [9.111.38.86])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 29 Oct 2026 10:58:01 +0000 (GMT)
Date: Thu, 29 Oct 2026 11:57:59 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 10/10] s390/maccess: Remove spinlock from
 __s390_kernel_write()
Message-ID: <20261029105759.23372B93-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-11-hca@linux.ibm.com>
 <11f7072d-3c4b-4ed5-9954-49c39a012d8b@linux.ibm.com>
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
In-Reply-To: <11f7072d-3c4b-4ed5-9954-49c39a012d8b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MSBTYWx0ZWRfX7XyybQB5fQFh
 MhWxB913qVex8DOHs+xhI0+wvOunnco46sBOB5hmD9YRlT43/8rbUSuDe5PwcOJwlWAYYkTU4Jt
 gqcSFZTgOjWtXtVwKwrLd7rCPFxgZQk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MSBTYWx0ZWRfX0M+TCopkPeN6
 IroWBOpMWNV+vr4j2wCsIkstvXu4pGBPtXxVDSb6lyRx6w9Tm3Kvr7cp7svb9wyijyJ7Ny2R7mk
 nsruuXYjSVFa7F6sZPbuezlmtanbOn+Wb6pPh6M8Vek7aJKaocGK1R6dsBy4Df2wU9egp0/Czh9
 iVD3mUVULtVTzFTfE7wmRiFtNHUcWCKlGEA/Ok91oLfZ9dqNW7iP79ioSMkfn9Ni1C2vkRgrfDu
 rePP4y6A7Y9WKEUtnNTqJdzn4UISfxJUv3/LVvYrfZsLNt09xAFoNSt1iTCcWJl+VOqe+zx8fke
 9UwL4r5D95EuN4RpmLxAci4kHx652JCXLaeb4wlFj+r1rlfiuvhWdGpJAyyVWzaw5ivIMVENWcA
 xGpnzGNVAFELOEFfarofaYSbDO1mRyHVp61mM4ZseKVSwtA10I5ngsqyNHudkZJonb2wFw8010p
 kKCzVSnX5ICiWwvdU+g==
X-Proofpoint-ORIG-GUID: 3gVxxP-ZTZ6c99rw6w9VsvHfko1ZGLoJ
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae326be cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=LVeCw0fSqMdSN_YE6mYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 3gVxxP-ZTZ6c99rw6w9VsvHfko1ZGLoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290041

On Wed, Oct 28, 2026 at 09:59:46PM +0100, Ilya Leoshkevich wrote:
> On 10/27/26 15:30, Heiko Carstens wrote:
> > The spinlock in __s390_kernel_write() was introduced to serialize the
> > read-modify-write sequence against concurrent callers. Now that all
> > runtime callers of s390_kernel_write() hold the text_mutex, the
> > spinlock is not required anymore.
> > 
> > Replace it with preempt_disable() / preempt_enable() and sync_core().
> > Previously, CPU serialization was implicitly done by other
> > instructions. Make this explicit with sync_core() instead of
> > relying on that.
> > 
> > Preemption is disabled so that sync_core() issues the CPU serialization
> > instruction on the same CPU that executed the stores. This completes all
> > previous stores and makes them visible to other CPUs.
> 
> Doesn't preemption happen only via interrupts, which always serialize?

Yes, but again, that's an implicit serialization. The idea of this was to make
the code not relying on rather subtle architecture details (as written above,
the "implicit" part).

Even if interrupts wouldn't serialize: when scheduling the task away there is
almost certainly a compare and swap instruction for taking some lock executed
on the CPU before the next task runs.

So this part is more about making things explicit, instead of relying on
something that is implicitly happening.

But the main point is of course to get rid of our private locking.

> >   static inline void *s390_kernel_write(void *dst, const void *src, size_t size)
> >   {
> > -	if (__is_defined(__DECOMPRESSOR))
> > -		return memcpy(dst, src, size);
> > +#ifdef __DECOMPRESSOR
> > +	return memcpy(dst, src, size);
> > +#else
> > +	lockdep_assert_held(&text_mutex);
> >   	return __s390_kernel_write(dst, src, size);
> > +#endif
> >   }
> 
> I assume #ifdef is required because lockdep_assert_held() is not
> available in decompressor and there are no stubs?

To be honest, I didn't even try; I didn't want to rely on even more things for
the decompressor.
