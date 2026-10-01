Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C133DA7D2;
	Thu,  1 Oct 2026 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859047; cv=none; b=MTWfTNvoOZQAdU2Ipv6vr/dfvNo/JvS7GHjAIFZs0N+bXwb0jqICsOhS45e4yEx+Ima8WtBN3h1VjYUgd48k/N7znB8+dfweVObm2laIDsz1osBoGRWihfWoVQFXV88XveL32dSmRdlQ4hIe6FhHjYVLdJipd7OtEutkMb92XUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859047; c=relaxed/simple;
	bh=ZCy35iQaL/AoggCKNogfxYo4f/HeuiJhJdHyYThiv5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSPegjMCyOE/Bfrx89RmKSIc4c2SvuV1scbcLzK5pPLFzzr0cICMkPEqP3S1DyWBqE8AF5myRwyuvkm5atYxcpVebTpt0+UX2vd7hEswTPrp64hxctccVKLCrJRgtjcsMwED/igrRhKl3oP5sAkKVJV/3B/iB4X4C3PwgJGs4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DFqZ0W2K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DFqZ0W2K"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175fbl1119395;
	Thu, 1 Oct 2026 12:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hRBEH4IbF4NdppaXKddUnLVNA72Cv1
	mpe3KugTX05Hk=; b=DFqZ0W2Kzw811AHvoqclZ2LUu8brBgiuTW11dO/wyGmMbM
	VMqfLbcP8868boOS3/9II+HgQbN93mZs9QN4PpAR/ut6McvcD36Fl5w9A/b2lHv+
	gMOnjV+R99nZu7pgOcIhOSK2RxKEg1GkUNXSubcBfXMxTtmZU67OFO5xdLSJ0LCB
	p1KZCv/tCxLDmwex6jSKrFmSCqueiirAW/OhTCo/YwzIx6VY8EChMZAzczEIoCm8
	wLGeYcZm4iaqh5Vv8tQHBisJ3Leq0HFOJAYjsjpUnyfoLq9Xgolf93QYdsJnM42X
	LubdNItyxoNmCzkCkxgNH707Uqmott76VQ7saydw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5kd3s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 12:50:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691BDj5Q589647;
	Thu, 1 Oct 2026 12:50:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7ty78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 12:50:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691CoekA53018962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 12:50:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C9FF20043;
	Thu,  1 Oct 2026 12:50:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430EC20040;
	Thu,  1 Oct 2026 12:50:40 +0000 (GMT)
Received: from osiris (unknown [9.111.57.16])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Oct 2026 12:50:40 +0000 (GMT)
Date: Thu, 1 Oct 2026 14:50:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 08/32] s390/dis: Improve show_code() output
Message-ID: <20261001125038.23106B29-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-9-hca@linux.ibm.com>
 <20261001104832.A2F561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001104832.A2F561F000FF@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MCBTYWx0ZWRfX/nxQI/vKSiAl
 6PE4MJ6tcLWo0cu4i5i9WVOu/4pqJAvJ4qeXFm2nUbM0ozbXj1lhERwuzHX+dqFBVONItYpbVuf
 8FpE7/+yTeBbsjseTSimlr3UIf8ysZY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MCBTYWx0ZWRfX5Lwxx+xklEya
 SPJ3Exr8mjAmacipt5UVXPwR1cw6ZvdiodDK+ps4q/98e8xia2tg5aEDQ+4q3gCW96qeRSTUbsX
 EKWSJdUnEPPnIDXIDr4KSj/4E51yahgp4h4ClcHHKGASOC3SPdbaLNuN+cHV6fpkTq7T6D2gHMw
 MzCDRbM0XsW2LNnbBUUDQUM1ami5aLxHBYkzWHvNmxo9VOOEW9sCd883DUUmTDvDlZwXp+r9mtp
 m6IEyPQsUqD9r4WUoYyqHuKJ0jzqUIyxX7goxesDVFBIO7JxG1sc5NT7iXwhmd6Vj2tZO12YH4F
 Gvk8KTc5qGoKmArQqVkCbl6xOMiaNOp84tFITQvmRduvl3QLOngFukBGR8MWWFY4XKLDJjsRdP6
 eFRx1lz6QGOiWJOPMWZYfM+jhb1Ctj6B6p8nMk1O46Rj9kwyhoWP7fYGKgRnxZjtf+Erx2mjSSf
 B+FKGgFk7XB9ulkYKjA==
X-Proofpoint-GUID: Y73gZvn7pTUjQph6mRjQfRCn2iHPbq3W
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abe5725 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=gi8WgnqM83tjWKFgJRQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Y73gZvn7pTUjQph6mRjQfRCn2iHPbq3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010050

On Thu, Oct 01, 2026 at 10:48:32AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] s390/dis: NULL pointer dereference in get_trap_ip() during early boot crashes
> > +	pgm_check = test_pt_regs_flag(regs, PIF_PGM_CHECK);
> > +	if (pgm_check)
> > +		trapaddr = get_trap_ip(regs);
> 
> [Severity: Medium]
> Could this call to get_trap_ip() cause a NULL pointer dereference during an
> early boot crash?
> 
> If an early boot exception occurs with the transaction abort bit set
> (regs->int_code & 0x200), __do_early_pgm_check() will handle the exception,
> set PIF_PGM_CHECK, and eventually call show_regs() which calls show_code().
> 
> In get_trap_ip(), there is a check for the transaction abort bit:
> 
> arch/s390/kernel/traps.c:get_trap_ip() {
>     ...
>     if (regs->int_code & 0x200)
>         psw.addr = current->thread.trap_tdb.data[3];

This is not possible, since 0x200 is the mask for TX abort evented. Since the
kernel doesn't make use of TX itself, this bit cannot be set for the early
program check handler.
