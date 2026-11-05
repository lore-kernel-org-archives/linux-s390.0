Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877753;
	b=YWg+IWjMQJuz0XhbtY5sErfH6WLJm1/E+XELwzT+wKEo8mb6eFXiMZDvCgRkFUnqQp70
	 Dg/aj7+ta5vOkr4wh/wIrXToN7/hMEyvhn40Nzknh8LUd6LfN0gAH6hcAKDYPobumoa9L
	 BinFJ7VOv3zfy5JllkdiXLD604483gmn+OdGiyuTEihQfaFMVzZozCDkiQrswVyla7Ejv
	 rVtxZXfVr/UvZJknMxi46wwA6mQ3aU8+N6PGc/YG9qb1Aj/F4kBLzb9G0qjIURYwAfmxa
	 KkE2ft4w5VV5OVoRrmukd8G4kjsGQa7E4jkwyhxGnQ/SOIDfr9ROG746vj6vmyzgukw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877753;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7Jr2hfiqdkgzDhPN6ycxYTdw6NLZoNdrGltw7lFH7pA=;
	b=r+P2UOOkuZfhZDvdfMSAcgdkS1AocMwxAnSePAuqqaGhzAcs9BH6MRaLGQWtPs1NDWMp
	 g8WmGkpO6bp3MEF/eLnlVDzOt007Yfg7HizVSjseh/6aPaLCd5cmuAqGTLor5AGaewJ4H
	 0H9KEo3c0W3lfGO5Olk13daXBhjQQbmV+9PKpXk7xpC04Wy+75qRIRzo/aA0hzf3jyFLi
	 +9+9ahDs+/480/loof0MJAo9ocHNWkIijpKIu377+0xLWDAKIuF6aYNBTY0MXP5F2rArC
	 4zAuuFQAitm4dQa8lQp7yaxDNotLfp1TsHmG1diXIIdRcLP2m2ayliFLM4oeTfhulNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fkaYZqhA;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC6D606A31B;
	Thu,  5 Nov 2026 11:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EC6D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fkaYZqhA
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AE4BG3219933;
	Thu, 5 Nov 2026 11:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7Jr2hfiqdkgzDhPN6ycxYTdw6NLZoN
	drGltw7lFH7pA=; b=fkaYZqhALQd2+4ZjFcQQqeQcXgRJkoVHD570SqTVtD/RbA
	Bz41DurgqyX3ErqnrKJsDDO1UJeaMaYpuAh+5iC/xVczQ2zoW2TUgnqsMK7335Ub
	CRMqyp9Ty08xIp/xeAem53jwBNo7uhXKDGjpRPkejWePO3oipFkoe7yNmVMbGlFB
	Kjk9OTP8x0oYBMS/57xnxBpXfE36A9hBClyKKtfwaEVHUQ3YnHF4nmP5Xj3d3YE6
	7ENO0L+ORPIphuL1/R/CvYte4tcTBJoKluJHrpflLrl1vb4nhiqFYaLMWfAsVYXU
	1fw2QFGOBD+cOMkq72S8AjTO81KKSTWCsndk14Ow==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn8271rgw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 11:22:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A4tb91509427;
	Thu, 5 Nov 2026 11:22:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7k02s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 11:22:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5BMQbK42926584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 11:22:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B4620049;
	Thu,  5 Nov 2026 11:22:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6999D20040;
	Thu,  5 Nov 2026 11:22:26 +0000 (GMT)
Received: from localhost (unknown [9.111.35.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 11:22:26 +0000 (GMT)
Date: Thu, 5 Nov 2026 12:22:26 +0100
From: Andreas Grapentin <gra@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Add assembler-level include guard to
 insn-common-asm.h
Message-ID: <auxlzfQe32jZHc_4@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
References: <20261102-insn-v1-1-df048a0be0d5@linux.ibm.com>
 <9b3348d9-7510-48e4-8be8-31efabbf152c-agordeev@linux.ibm.com>
 <20261104084033.8132-D-seiden@linux.ibm.com>
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
In-Reply-To: <20261104084033.8132-D-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NvruZDrgTqvOn6LjyUrxahymfTspG9hG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX97QlyxzB3OG+
 94DUnmv17qTeiiz7EoQXRb+/ulNERP4Ae/7zfWexegYiPSGpn9gcMbn9PYA/RA9/F3Na/GNiLL3
 hsiFKIysldDKhkLkTBj8+mE7jFPQv/CYjGs3G6Cgxq0smycIMEhwQLw9i8z/BYF7F0+6u7nUw2I
 +H2MQ7e7uUWbxkM7Fe+pXs7rCWh5ViZ3K8OEAtGhC5MBMW+AOJugZYGqtallEXD89BcvoKSdcXm
 Jb8FWDNZc4EDmtZsk3YjgeO19tnAA63eNa4z6A4/HzweoPsnPlmhTe3SinEWjETKufNeN+DK4pT
 EHZtMQmrlPWevrN17SNW0COI6oi+57Ai7WXD+xM4F6QB2A5DNfsIqqbgd4ewqALBdhX60DV7DHG
 3yVV5aVZAVRQkl9KpLxnOgKbJOV/PR61ZrhGgxKO3ztL6d8VLHijMWt0Xe+XFUZqI++aAauPivH
 TD79bgwlzouwd4AimeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX2p86Z5JVerW4
 mnIGkk0sBaXSKOVr4YX1nYPqJ4uFTpmVnV9vI+W3FUynGxIaTadQUYS7nC/Xm2YytYrzD5rY6NP
 tqaiEWLV2jqi+R1KX813UwmQoP84dAU=
X-Proofpoint-GUID: NvruZDrgTqvOn6LjyUrxahymfTspG9hG
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aec66f7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=QxOGSBOOUP-tt7WAx3EA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050044

On Nov 04 26, Steffen Eiden wrote:
> On Tue, Nov 03, 2026 at 05:39:19PM +0100, Alexander Gordeev wrote:
> > On Mon, Nov 02, 2026 at 05:51:03PM +0100, Steffen Eiden wrote:
> > 
> > Hi Steffen,
> > 
> > > The CPP include guard of insn-common-asm.h is ineffective when the file
> > > is read via a gas-level .include from inline asm. The assembler ignores
> > > all '#' lines, so every .include redefines GR_NUM/VX_NUM and fails with
> > > "Macro was already defined" if a translation unit emits more than one
> > > such include. This is not the case right now but may lead to future
> > > build issues.
> > > 
> > > Add a .ifndef guard with an L-prefixed (local, non-emitted) symbol so
> > > the file can be include multiple times per assembly unit.
> > > 
> > > Fixes: 495bc70aa3225 ("s390/fpu: Move GR_NUM / VX_NUM macros to separate header file")
> > 
> > Is there a real problem this patch fixes?
> 
> Yes. The second batch of arm-on-s390 patches use the GR_NUM macro as
> well. I'll send an update for this series soon. And it happens that the
> same compilation unit that uses the GR_NUM macro for creating a new
> instruction format (not supported by binutils) also uses some FPU stuff.
> So the asm marco will be defined twice. That's how I found this issue in
> the first place.

I just tested this and can confirm the problem. the fpu and sae headers
both asm(.include...) insn-common-asm.h which bypasses the cpp include
guards and breaks GAS because the macros become doubly-defined.

> > Do you happen to know why some other archs use .purgem in similar cases
> > (aka though appears ugly, should not we use .purgem too)?
> > 
> 
> .purgem can be used to undefine a macro for when you want to use it once.
> That's how the other arch use it. Define a macro, use it once, purge it.
> All in the same file.
> 
> We have a different use case here. We defined a reusable macro in a
> separate header. So if we want to use .purgem instead the users of the
> macro would need to purge it after they used it. This seems to britle
> for me as purging it can be forgotten and the issue can manifest way
> later in a complete separate patch.

also, .purgem itself errors when the macro is not already defined, so
won't help us here anyway.

However, if the include guards in insn-common-asm.h are too ugly, we
could also guard the asm(.include...) itself:

+#ifndef __ASM_S390_INSN_COMMON_ASM_H
 asm(".include \"asm/insn-common-asm.h\"\n");
+#endif

The same should also work if we wrap the asm(.include...) in another
header.

Best,
-A
