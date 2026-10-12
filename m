Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA6220F49;
	Mon, 12 Oct 2026 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812550; cv=none; b=NVs4BixbNMiYMBUyGawolj3ulVQWLVYRRvCJfYl+xoFm6zRuvRAPpPBk4M4jzlTE6VmkpwvyXycOSQHvsSVEZqgc86ayum8NU8DcsbR0DZBZfIyEFbONFy6jYu7LtiwKL2t1HupNpXHMdMMTPevviiM2mvUXU/7qjRtQ0UVb8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812550; c=relaxed/simple;
	bh=2DSQ1qXfWt14OcuqhQ/nk4z8Falr+oK1aZuv4qHvrY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uebG15rFWYEmoaUy9eNtEaKC6IBms37Ajq++nrDXVyWIVBAubrjYT0wMJ7ZDfkzd9QWk0AHpvH1xphzhEtgyD/sExsi+5fuzrA5kWnwvrzH0hq4i7G6qYiiYrfbfMBBjQwhJHk7GjQfDPFa9BPuTTmsam48tWOkiqennwZByRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pQZGQ7fT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pQZGQ7fT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEEuD3209697;
	Mon, 12 Oct 2026 13:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qk+y1ol5v87Bmy/esSnm/FFTSp9V94
	NvFHNoHcN9UI8=; b=pQZGQ7fTwY5tlon23xA4rGOvlS4GrXGoDIbJ6SYOkco/1s
	uQthaYUEWJFTl5fz9bILq1XrIpJSpHKxJ7GLne+hieYDGkwUNGq3760/6Sd/M+rA
	KL2JnnkDhBdvadjH5rhtvmHCLdLJBzzf8wutMNXEMjVPxvJ412OfWszmO1qJFgVb
	Z7MwjblqOGluu3dKRN/0YaakzVEwf8qO+R/YmGNi0PkIjkDXR4dRTERvgofE49cs
	wbHTfl0sry9vHHUdSMa9OTk55C6u6tsikuY1iasg0Xcov/vAGfGdB6siJpTR5Zs1
	cg7a/8JwmHOg4JmXXj3uaKDO1mqsk33N/wFbd76g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv08ufg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:42:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC51Ts1287108;
	Mon, 12 Oct 2026 13:42:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwanm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:42:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDgNdn53019128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:42:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AF0020043;
	Mon, 12 Oct 2026 13:42:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9BCA20040;
	Mon, 12 Oct 2026 13:42:22 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 13:42:22 +0000 (GMT)
Date: Mon, 12 Oct 2026 15:42:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/32] s390/traps: Handle nullifying program checks in
 get_trap_ip()
Message-ID: <20261012134221.19350F50-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-8-hca@linux.ibm.com>
 <f7a81358-0ff9-404b-9b27-1ea11c095694@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a81358-0ff9-404b-9b27-1ea11c095694@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX6c5REcaT9zMT
 NDvNk4/cDCiJCdiR3oWvptJ6SFbRoACtOZIHcwOQUv67yR9j/KdCGVsYzQ5ETvk/2o6FyXYjtxP
 RzCzVNR2Prk2yw61aAkvTfHz9ZWXvFCrh2/5+VGVl+8mHHBYvTPzBmeHrIJ/eQ0yIUemKieC2vy
 rG2w2j2JOmEaWvB/dJgbAoE29LP/xrt0zTDWdrUYnExZ40/qd//IfIW0dZPetPA81sGM/k9MLBN
 jnVyjQ7tRkvn060rJzWZxUuWKz/Fw+ZsDVJGi7Fv3kzGh0UKaITMz/8pGDLdvjWHFqcD61M1byp
 bnRn5yNXGm5VsfOMGVtIVNXsyLxl7KASR7kdvhXH2BnF25vyhEvYfoXm3WgEKx4NPZOcl5n4LgD
 o4vLyQFwCNYLwbyZh/ultYkxp99ewGNvThsak+OClSyFSVFTKo8jaU0s02ErI5OrdIpI3xr37uH
 hE/kywbe0FQSpwW2rIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfXyvFLhY1arFfC
 vMxcqZ/5xfMBs0elL/1xkd0luWIvR3UjbaIr+59ojIMGkCZ2o89Ug1TcLsafN4KoQ97zxf3+TOl
 FRCnpAcQhHkX7z82vBC6p/QRfQqToGc=
X-Proofpoint-ORIG-GUID: OEWAXhjvHj7akbntqQF5raeO50Z8jWbZ
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acce3c3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ssxVvcqxAlbxuuaQv-IA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: OEWAXhjvHj7akbntqQF5raeO50Z8jWbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120052

On Mon, Oct 12, 2026 at 03:01:56PM +0200, Ilya Leoshkevich wrote:
> > @@ -41,15 +42,19 @@ struct pgm_stat {
> >   static DEFINE_PER_CPU_SHARED_ALIGNED(struct pgm_stat, pgm_stat);
> > -static inline void __user *get_trap_ip(struct pt_regs *regs)
> > +static inline unsigned long get_trap_ip(struct pt_regs *regs)
> >   {
> > -	unsigned long address;
> > +	static const unsigned long nullified[2] = { PGM_CHECKS_NULLIFIED };
> 
> Maybe just [], to deal with the possibility of expansion in the future?

That is also intentional since there are quite a few hard assumptions
in the kernel that only interruption codes in the range of 0x0..0x7f are
supported. But I do agree that a hard-coded "2" doesn't look too nice.

I guess a follow clean-up patch could address that.

It is similar to the hard coded 128 here:

static void (*pgm_check_table[128])(struct pt_regs *regs) = {

in traps.c - which is also not nice.

> > @@ -152,7 +157,7 @@ static void illegal_op(struct pt_regs *regs)
> >   	int signal = 0;
> >   	u16 opcode;
> > -	location = get_trap_ip(regs);
> > +	location = (void __user *)get_trap_ip(regs);
> 
> Should location be moved inside the "if"? Now it reads weirdly: we cast
> the pointer to __user before checking for user mode.
> 
> >   	if (user_mode(regs)) {
> >   		if (get_user(opcode, location))

You are suggesting to move the assignment like this:

	if (user_mode(regs)) {
		location = (void __user *)get_trap_ip(regs);
		if (get_user(opcode, location))

? Or something else? Sure, why not. Just let me know what you prefer.
