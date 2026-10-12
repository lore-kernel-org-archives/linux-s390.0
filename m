Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B447C10F;
	Mon, 12 Oct 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807495; cv=none; b=ms+oJb0mfvofJn9o8Lw8fFH5KvGsIrbfx9e8doCog3kkS2tqs7/26uGtpcNnEAcU4KokfSaidyTKewY6nRfxRwsTtjRVjrLhw26RUv+jOErF4yNvNO9Dk2/E/hGT5PdxblD7Z8Cv2BZ+lljwtI4ptFqtyu60Xb5R2l62jHm59/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807495; c=relaxed/simple;
	bh=bOUL2wGh61VL2EgK+Y9UFVu6yJD4EqRwwm0hGvOkgBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvC4hzTHXqIVMTPqHnmGRkwnBLnh+7Tk5LhcitImo6WxZuFiO0wYb2l6Hhw1N80xmccXB7mt/NMjXrSI/eP6/CZAqCNF734RQcJX24hPNNpO1klBlw+13xoGOzYjMSGj9t3wXbdIIaQwvnLT4l9al2kjqo+jeu0+PyeWcJvno6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i3dVSDfj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i3dVSDfj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEQMY317098;
	Mon, 12 Oct 2026 12:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fGJH3jNocGZQwL64ksMh+UvMq3ur6H
	/xGuTm7I+mlvs=; b=i3dVSDfjt+lTbrrL4wq8hx+GG5b25UkF7BPeDu2DyWGumz
	POZ9SXUiv0nTbJ/ysmzsLka+lD9v6WUsdBPu8aTQV8Md8lQX1XoEN5p2UUKlf5V2
	XNNoub/d7mx+Ml8wjcDT3a0Mnf9dmF18m7DAD1SEk9Pwn/jIN+EODPk34rYXTEaB
	7O0ZTofO6UuIw9Xuw5uliZKJfTlTqKNh4AFrlDC8AmUpOKM6FVR5+yxG2KlY8dDf
	Toxa4+SpwenzZCaE8BnD9+xZj5gTU5Wf6U1j11+Jj6gxHXBxQ1gJaRyaHBt/PRKY
	YKshPMHpEHvK7Tgp4ef1p590/7lba4T1Au3oa18A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug8suc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:18:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4vG31286256;
	Mon, 12 Oct 2026 12:18:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyctb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:18:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CCI9bG49217866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 12:18:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09D1720049;
	Mon, 12 Oct 2026 12:18:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C39E920040;
	Mon, 12 Oct 2026 12:18:08 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 12:18:08 +0000 (GMT)
Date: Mon, 12 Oct 2026 14:18:07 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 3/4] s390/percpu: Drop unused output register from
 arch_this_cpu_to_op()
Message-ID: <20261012121807.19350B93-hca@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-4-hca@linux.ibm.com>
 <sashiko-outbox-168033@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-168033@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accd005 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8Cetu1QKsA3-N6jwZBYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mrLSsYYXxwsAg7WmzOu5jR8nhQrasyhY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfXwDv6eKH+4jlb
 bT3ANejBnM7mPdk/1TjWLLoz2HNap5jfpxEg7gI5WpWTTS7dGFNuqAxkPpVbVIFpq15bzncpiK9
 1I39UuF8vbVXtCR4nqlmXsUIu/RKOdI5A3YnbuOVKvTVad6UMPv+bJSsON1OcXsBF/ePxcFrAJK
 X1TZSiO322594ogWH893uUh2xV5P1QXtqPdKtJdyRoOXjtOtAR6embZcrBTHm5evKu3cHgUEc+K
 js4DYoyr4NAWKpQYrNcVezxJBX1qSqkz3bQQLCMZlp69rmCFU8Br1fbXV8PiGcDvfTp0HVJMO9u
 BehLAtmGWWsrOEcuJ3ah7CpUpQg05ljjPu89Uad4bORXhrCDMa8/eX7ccfV7Rt7KBSkXvkJJVFW
 rgxGQkwfwBDbuEgJRXeezf9afs7rYlrtYGPtLc4XT6wUF7q8f0kUDU6vHykaM9mus4/Bd3Y9IrM
 uyElPRFjYXcbuKwGCKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX8InpZPbBRN8Y
 +TzCPPO9qb/2u5HYS5YTtlcTnV2K7E4mQHDeIg9xlQ+JatUFyf292RNyEKYkXWltVCcWGgUXCn7
 MS6RBkUg89vrK6mT5fhMwfl1AvhYIHo=
X-Proofpoint-ORIG-GUID: mrLSsYYXxwsAg7WmzOu5jR8nhQrasyhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120048

On Mon, Oct 12, 2026 at 11:54:14AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] s390/percpu: unpredictable LAN/LAO behavior from R1==R3
> --
> 
> commit 657f51d5e5b9873bdbdaca586024d213577edd7b
> Author: Heiko Carstens <hca@linux.ibm.com>
> 
> s390/percpu: Drop unused output register from arch_this_cpu_to_op()
> 
> The lan/lang/lao/laog instructions return the old memory content, but
> arch_this_cpu_to_op() does not need it. This commit changes the val__
> constraint to use it as an input/output register instead of a dedicated
> old__ register, aiming to reduce register pressure.
> 
> > diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
> > index fd0a3a9951ce7..7d87e0a262c37 100644
> > --- a/arch/s390/include/asm/percpu.h
> > +++ b/arch/s390/include/asm/percpu.h
> > @@ -257,18 +257,18 @@ do {									\
> >  	typedef typeof(pcp) pcp_op_T__; 				\
> >  	union register_pair rp__;					\
> >  	pcp_op_T__ val__ = (val);					\
> > -	pcp_op_T__ old__, *ptr__;					\
> > +	pcp_op_T__ *ptr__;						\
> >  									\
> >  	ptr__ = PERCPU_PTR(&(pcp));					\
> >  	asm_inline volatile(						\
> >  		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
> >  			     "%[pair__]","%N[pair__]")			\
> > -		op "    %[old__],%[val__],0(%N[pair__])\n"		\
> > +		op "    %[val__],%[val__],0(%N[pair__])\n"		\
> 
> [Severity: High]
> Does this inline assembly string force the compiler to emit the atomic
> instruction using the identical register for both the r1 and r3 operands?
> 
> According to the z/Architecture Principles of Operation, if r1 and r3
> designate the same register in laa, lan, and lao instructions, the results
> are unpredictable.

Not true. According to the PoP this behaviour is well defined.
See "Programming Notes" on page 7-306 in SA22-7832-14.
