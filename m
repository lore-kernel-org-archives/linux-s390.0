Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781641;
	b=1mOJsnSQxW2s8ga9zAct9e+qMCS8JStAIqCRMD6vFDxGDt0yB8iUXSvTF2N+jnQRzRyB
	 8FADeMWutivljIJ07QLTDxD0LfoEYuGVZC6YUjW0v5MPm//vVyzfapl4GhM6IcmpXaQ9j
	 uWYSodd5sulZh5N54RL28R/GY+JU21rpxuZ379aFapsJrLNegyRIzONWNkrY9Zh/Jy6NE
	 1Ywr69Lje4+cMS2VlA2kk6ObYj/RTnoO0/g5qDPMKElsdbgW5P+tVObiy0NWilEr8tZTu
	 bLmZIkCM57o17XPGF2NrTv4N4FenJlycmnYAacIUVxLS63V+bKtDp9VBv/dhYMWkINQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781641;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tfR0FKTN+uU5fcPMsb7pxWzxgjzor2iYbKrTURNoFjA=;
	b=dOztCC5x50rJVUzTYzEoD5Em+FV5jEw+VIh8jYkvjFteAa6WM4x7C2bFX0zbt6r0rWHM
	 5VYkFyJdWgpvawJHh/15uKwxrXLZ/3VzIkbixWln48qIevlIFM6dJzADGnyDfBVh6r5SC
	 /8HmmamNbEuIxhKOoa2Y7CC9LiLBh5jqQ8QxP8osAFvR0Ra8UkpHVGKngGaQE4P/eUBzp
	 rmstJXQquO4fbrR6y1lFJE7WiMKIEXkaAQrFCSJE0oyPnsjZ7PWFEp6UsDDy6a4AlixdJ
	 xhxYE3s3I4XH7YTyCkBidLEwwas5l4lM2KBNqAAuQRgZuf1q2SEPPmMOT85FbyNxoZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WcRMQscY;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8EF606A331;
	Wed,  4 Nov 2026 08:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB8EF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WcRMQscY
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40i7Tc1712601;
	Wed, 4 Nov 2026 08:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tfR0FKTN+uU5fcPMsb7pxWzxgjzor2
	iYbKrTURNoFjA=; b=WcRMQscYgLpPCLnNMuZQdUoRtOVZdWP957mZvFjUV1sImm
	s+HP/gtTEJPdrDWrmUhzw9inS39NKfLr2DssguwAkTv+NV/IbZhIr+c1QZWXhtxf
	90Q7Kix2Aok+w9GlCWLeSB9SSFm2qTfo0QsPGUqqbRW+257yG6a08QGuGUjRulY0
	En8km38Lq6uKIjJt8Qr6WYghq+Tunr9zgav8aggTaw2snQphhK4Q+p8H0I/OeQBf
	d22TM/VRNwHgUVvVc3jhjure43lyt+2UHYXGUMiejMN2Y5E8/aQjXAT+s5XwTizB
	lTYaTnTBVEHxgYFqksJwdjRz/hbH5tyF0ZOV8TKA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sts4h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:40:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48K5En3889991;
	Wed, 4 Nov 2026 08:40:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqf0gcpe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:40:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A48eZeO46268674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 08:40:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26DB52004B;
	Wed,  4 Nov 2026 08:40:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F394C20043;
	Wed,  4 Nov 2026 08:40:34 +0000 (GMT)
Received: from osiris (unknown [9.68.29.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Nov 2026 08:40:34 +0000 (GMT)
Date: Wed, 4 Nov 2026 09:40:33 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Add assembler-level include guard to
 insn-common-asm.h
Message-ID: <20261104084033.8132-D-seiden@linux.ibm.com>
References: <20261102-insn-v1-1-df048a0be0d5@linux.ibm.com>
 <9b3348d9-7510-48e4-8be8-31efabbf152c-agordeev@linux.ibm.com>
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
In-Reply-To: <9b3348d9-7510-48e4-8be8-31efabbf152c-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A8jsXwRNkvO_zH-nzuRwptBHxqQDER8h
X-Proofpoint-ORIG-GUID: A8jsXwRNkvO_zH-nzuRwptBHxqQDER8h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfX1yoS31jHqXNt
 vmon99VRCKGOaqQZg+qO40cVx64ZK1ufggHwqYoWesLJrB8KANcSYv32S3bkk3yF/MDQtapAv33
 KJv6KG1VQK4VFKLjqiYMjzntJYm328RidUx8dfWnbQZWGpzVPAqBMkXBiHyCMPSp0dAiwdPJzjy
 aobPOHEqfeb0Gm2nLptnOrxnFdSJAfYyDNfJZgV8FrC4a7i6kyMz/uWTNdj7Eo7jc6LlTYCKHPq
 3iu1RAXuOC0M0185hUMtobChy7DqOMRn8ysmMooXuTzGnYZNtqycQyWwPOR6bll2J6kemmdWWum
 O+T7fOOZfTImdUl/9Yq5wxEJ3yP7pt+oXWim6c9c4LcLf/jLgJOI+wt9hEoQ4gz7kz4gk6gzaVX
 wS/4/OfHCOCgKj0kICFgGf/IPA88MCjZoxa7pv8PflJ421R6Yvk14SSjIDMF+50zFYmzvJq45/J
 MFgdz/W43pdOc8S7fcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfX0q4GBphw067t
 zRXk6zl+G+8s5nSdjDSZg2yP3lsZpoqr1cJJxulJA/O5snxGewepN+KYA8+/Cp7eQuYbdDegJqG
 caKoPUmYSvOV4jLA/kb8NFu/QABoyuw=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aeaef87 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=t8eBQLlhE5FaPN_M90QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040032

On Tue, Nov 03, 2026 at 05:39:19PM +0100, Alexander Gordeev wrote:
> On Mon, Nov 02, 2026 at 05:51:03PM +0100, Steffen Eiden wrote:
> 
> Hi Steffen,
> 
> > The CPP include guard of insn-common-asm.h is ineffective when the file
> > is read via a gas-level .include from inline asm. The assembler ignores
> > all '#' lines, so every .include redefines GR_NUM/VX_NUM and fails with
> > "Macro was already defined" if a translation unit emits more than one
> > such include. This is not the case right now but may lead to future
> > build issues.
> > 
> > Add a .ifndef guard with an L-prefixed (local, non-emitted) symbol so
> > the file can be include multiple times per assembly unit.
> > 
> > Fixes: 495bc70aa3225 ("s390/fpu: Move GR_NUM / VX_NUM macros to separate header file")
> 
> I have a problem with Fixes here:
> - as you noted above nothing fails right now
> - the same behaviour was there before 495bc70aa3225 commit
>

I have no problem with removing it. You are right this does not fix a
problem right now but prevents future issues. Let's remove it.

> Is there a real problem this patch fixes?
>

Yes. The second batch of arm-on-s390 patches use the GR_NUM macro as
well. I'll send an update for this series soon. And it happens that the
same compilation unit that uses the GR_NUM macro for creating a new
instruction format (not supported by binutils) also uses some FPU stuff.
So the asm marco will be defined twice. That's how I found this issue in
the first place.

I sent this as a separate patch in the hope that this fix gets into 7.4

> Do you happen to know why some other archs use .purgem in similar cases
> (aka though appears ugly, should not we use .purgem too)?
> 

.purgem can be used to undefine a macro for when you want to use it once.
That's how the other arch use it. Define a macro, use it once, purge it.
All in the same file.

We have a different use case here. We defined a reusable macro in a
separate header. So if we want to use .purgem instead the users of the
macro would need to purge it after they used it. This seems to britle
for me as purging it can be forgotten and the issue can manifest way
later in a complete separate patch.

	Steffen

> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/insn-common-asm.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/s390/include/asm/insn-common-asm.h b/arch/s390/include/asm/insn-common-asm.h
> > index fd9b3cacb7c5..060116719846 100644
> > --- a/arch/s390/include/asm/insn-common-asm.h
> > +++ b/arch/s390/include/asm/insn-common-asm.h
> > @@ -9,6 +9,10 @@
> >  
> >  #ifdef __ASSEMBLER__
> >  
> > +/* Prevent duplicated GAS macro definitions. CPP guards have no effect for GAS.*/
> > +.ifndef .Lasm_s390_insn_common_asm_h
> > +.Lasm_s390_insn_common_asm_h = 1
> > +
> >  /*
> >   * GR_NUM - Retrieve general-purpose register number
> >   *
> > @@ -49,5 +53,7 @@
> >  	.endif
> >  .endm
> >  
> > +.endif	/* .Lasm_s390_insn_common_asm_h */
> > +
> >  #endif	/* __ASSEMBLER__ */
> >  #endif	/* __ASM_S390_INSN_COMMON_ASM_H */
> 
> Thanks!
