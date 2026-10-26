Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024388;
	b=0NC0AxHMq1gFsEBwrLoVKiMvmcVZOu2z6MzGrvg9XcHh6d6yK7ao6bbA06CiI2l2Zo9d
	 qLKjcqN+WI6N3j7AWe1ptLniQozM/pOJsiyoCBrcM1Mbx4WTMv3zdrZoV5QRIAp5H4gfo
	 S0U/4JTqVpyO3EYnEG6byn5HTC2TaymBNpqaV7zJeunb4ag2f/rsIzm9wpB2igL7KENTa
	 /H2nsbq03NUHi4SfThlzKNRKqyDg4nwZIh2BuioB/6oxaISkdaR94jY54vgP7oe6jj96P
	 /PqrzMkPipfEdfJq5wC9xKfR+qHCec5btPPNiiUCAFmqf7H7lRL2cvucbzObFSPme/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024388;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7S8NrrFO+UcOoRR9G69+5Hxw1mUIhcdGNj6WbI3avqw=;
	b=nBLey0RC8fZwgldW1eBhZ8tgvnSu2boeYbG5C0BtGVhLG+yzwRBB87h4MP++/04hUj4r
	 rwjzLGNYbGctgJWv3sfsNbC0G0LjSQaCqXp5TpEWT8nyolkcpsA05v0QIFPVRKCTPzdmY
	 3SGhcz+sQUrQOczOKHO27Lccv5iei06fBOIo/qpD34jKAW3NquuhC3BZghWaB3hKkzYyQ
	 MRBTE7mzEAugbw01ogcN64jP85/GfGLY1Rd0ELGCX+lybba47GLMm2JLhhkER1cXa/p9g
	 122s94JHxOz7pjoa9CDAkej7gKWqnT/Yd09S2OGHsvBTCcChC9kIfqUTlSs2oZsZNEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hs7snhHz;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E3606A31A;
	Mon, 26 Oct 2026 14:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B36E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hs7snhHz
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBEXAl3336377;
	Mon, 26 Oct 2026 14:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7S8NrrFO+UcOoRR9G69+5Hxw1mUIhc
	dGNj6WbI3avqw=; b=Hs7snhHzGSKJW5eeAVrQLMKqzJGz4rkvt19mPqi6xfMdR5
	CzAIpbcKM1OTV1/9ouxf9C3I+6r8IEgB/vYgiI1301PHy+ed1RhA5ATvp5e84F5H
	86FLL76CDsZDkpQvee/hjwrDp/h69gm1zYWJeUD5ni1wGlDwLVVhD9BsdE6E9GOn
	jgXPdpnKgd4Ja0UmSIWpW4rQAL7pJuYiOIs8/5wvOMtc6JgyJCHJFA1pcgjNrUv0
	0WHRWEeY0M0ii3CQc/J8d02ml6Md1FIi/VrSP0XGjsQtyz763j23G3OOQp98HJlZ
	7f8NKLoM4Ai0unL/Wut4n7LyG1il6jTftxjRUTPQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6tdfe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 14:19:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB51rl2397576;
	Mon, 26 Oct 2026 14:19:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh80je9n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 14:19:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QEJfZF36045226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 14:19:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A43202004F;
	Mon, 26 Oct 2026 14:19:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56B432004D;
	Mon, 26 Oct 2026 14:19:41 +0000 (GMT)
Received: from osiris (unknown [9.111.54.64])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 26 Oct 2026 14:19:41 +0000 (GMT)
Date: Mon, 26 Oct 2026 15:19:40 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] s390/maccess: Remove spinlock from
 __s390_kernel_write()
Message-ID: <20261026141940.23278A26-hca@linux.ibm.com>
References: <20261026120329.1792436-1-hca@linux.ibm.com>
 <20261026120329.1792436-5-hca@linux.ibm.com>
 <b27e1bb4-9112-4df0-9595-90b5419acafa@linux.ibm.com>
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
In-Reply-To: <b27e1bb4-9112-4df0-9595-90b5419acafa@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adf6182 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=TeQbl-Lp8jTY6H95fDwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NiBTYWx0ZWRfXzwv62KGbtYPz
 aCyzgA9lO36PIiRPuMHQ4iNY0oRp1YhdNDXVv8Lgf2nEC2RNYnxj8ZfdnEp9NtHggBs+W5A2fSN
 JoJgxgdpW3sZmXYktegFi3rxWdnZnGfU9vnhR/I+iZhc+H2wqXQFpSG3gO1XU3z3dM6QC9kW7EJ
 2VkUPs2w4c6KzarPLPzZJlY+xAyIIGooo+GUnvKpJPMqMlAGfZNmrhfNrYcvappwZcYDMohzljn
 rg7DSZEWDYoJDZDKoyZX2BCZIJn/zVKPNICByLpT044yUy7hbp3RFDNFjLJ+YzxykyWocGVVfrC
 PzmCPCWPd4pOoeNg66xLnssxOkJilM6L7ScJ1k3Okiavf2aKQLJP6XyxjWmjn0508sqVtWTXIS0
 BGKfKnEyeAqN3RuYKKvPUtF74oK59zWFPWtxg0b1sHCIj8sWGCLzKZHbiBc+TWpzd4qP/rph+IV
 yTtjK79AW0sRxajpzFg==
X-Proofpoint-GUID: bygq6PpUqhuJ7q5ug-0wX7pVSyDoS53j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NiBTYWx0ZWRfXx7F7wKbYik0O
 /esmZv+ieJuCYHlpYndnSMqxBVI2xZNu4Mucq0eDxirITlBmJwb8dJgAlKgMKhA0VwCVZtRBZzk
 A6yqTL2j57JL+g20POWnFODyH8eFtzo=
X-Proofpoint-ORIG-GUID: bygq6PpUqhuJ7q5ug-0wX7pVSyDoS53j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260056

On Mon, Oct 26, 2026 at 02:04:02PM +0100, Ilya Leoshkevich wrote:
> On 10/26/26 13:03, Heiko Carstens wrote:
> > The spinlock in __s390_kernel_write() was introduced to serialize the
> > read-modify-write sequence against concurrent callers. Now that all
> > relevant runtime callers of s390_kernel_write() hold the text_mutex, the
> > spinlock is not required anymore.
> 
> Do we want to enforce this with __must_hold?

Initially I thought that wouldn't be necessary, since "I know what I'm doing"
:) But Sashiko already complained that this might not be safe. So I'm going to
had the mutex to all callers of s390_kernel_write(), and add __must_hold too,
like you propose.

> > -	spin_unlock_irqrestore(&s390_kernel_write_lock, flags);
> > +	sync_core();
> > +	preempt_enable();
> >   	return dst;
> >   }
> 
> I've been looking at sync_core() and started thinking about the safety
> of this interface w.r.t. CPUs concurrently executing the code being
> patched, since locking protects only against concurrent readers and
> writers, but not executors.
> 
> If there is only one active CPU, for example, during ftrace
> initialization, then everything is fine.
> 
> If there are other active CPUs and we make modifications within a single
> aligned u64, then sync_core() is required, because even though
> text_poke_sync() nominally takes care of this, it may sync our core
> last. However, I wonder, what would it take to make it always sync the
> current core first?

Maybe I don't understand your point, but I added the preempt_disable() /
preempt_enable() pair exactly for this reason: make sure that the writer syncs
first - only calling text_poke_sync() afterward does not guarantee anything
due to preemption (well, that's not true since there are many implicit
synchronizations before the next CPU runs, but the point of this was to make
everything explicit, and not "hope" that things work).

> Finally, and most importantly, if there are other active CPUs and we
> patch multiple u64s, then we are broken, since the other CPUs may see
> partial instructions. I'm not sure if it's worth bothering with, but
> maybe consider adding a WARN_ONCE() to guard against this?

Initial alternatives patching might indeed patch multiple instructions in a
row, and that's a valid use case, since the code is guaranteed to be not
executed anywhere...
So a WARN_ONCE() would at least find one false positive :)

I don't think we should go this route (when is it valid to patch more than one
instruction, when not). As of now no code is doing that.
