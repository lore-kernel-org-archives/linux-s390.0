Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3E3246E8;
	Mon,  8 Jun 2026 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935088; cv=none; b=Q1xpmiy6kwlxN7EXdQGPWyn2IHsfSaeqD0Q4OeBQ7r8dv6dA+w77zYH8KJkZdkI8ya1b85ZPPtTI2PeG97wpWtgjcT8wmQsfg6RHXXhRi5Y/F6i08fG8f6CWwWu92NLWW0luFHuEqgly0/jOHPBKe5uVXBszoVBnU3+bSFDOJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935088; c=relaxed/simple;
	bh=Zvo+f1ZSVqNgiIUI4BRRAmffKghL85/zNphanjUzYns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZIgpT4OiSeJugBCpebbd/TjRsH0MrNrQDAzdbTSnIdH6W6z2znYMc3+OhYYCFi2pFPyi/xFWbQhqggHjQUsQblmBnKQZ1Q4SIKAq6i6D0O5iDdyQyrNdNTeVzlOjkDGrCkyQ8J+SWE0nWVic214dxC/mFxOcvEmmkazNWZYcwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jbV2UoRb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jbV2UoRb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658AJA7H2240271;
	Mon, 8 Jun 2026 16:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wkBOABf1SALZVGZR/nj+fZqmKCLgOC
	42UzYaER99zik=; b=jbV2UoRbFObag/5Iq+jNjr5KsHOuryRvM+jA9qZ96Z3gPh
	bgEQGWHXoFCgB5okcD1RmM5Hpufh/e6OqA2EROZjR3CCabhKxKzHHt+BJY+WSbi/
	42QROQseoONGOOmNtzz+4sXt+MIZ8aV0egj4Xa1FVEFThTwMhPCPjbHkjtCPm3wG
	I7L3+94qy2HgmIRMZ/Y4ofEAe/nceyimV1DjCFFoI98PkA3Lz2wORPis60RaV48H
	fNKOgFJ+9vsbkiZW2aDPi5umXLyv3kRGX5X0AvBYpZjlI2OyudX6g2dUReF9pYmK
	nvJa0tqgcHCudYZ8RmWWBpJN2cgz7PMW8kobou8w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qg5e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 16:11:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658G4gbm000504;
	Mon, 8 Jun 2026 16:11:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy5uar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 16:11:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658GBDPX16777550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 16:11:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ACC320043;
	Mon,  8 Jun 2026 16:11:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E37920040;
	Mon,  8 Jun 2026 16:11:13 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 16:11:13 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>,
        Peter
 Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: Remove GENERIC_LOCKBREAK Kconfig option
In-Reply-To: <20260605153206.2397521-1-hca@linux.ibm.com>
References: <20260605153206.2397521-1-hca@linux.ibm.com>
Date: Mon, 08 Jun 2026 18:11:05 +0200
Message-ID: <yt9dldcpt3l2.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a26e9a6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8
 a=otxGPKif3PPhFqwVwwAA:9 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-GUID: M_JFT91W1Xzo7FlsQk-vTceUo04n7BP2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1MyBTYWx0ZWRfX/IulBOrD5/Mu
 zyBU3rklXHN3JVbBkbpkDt5CwdHaJX8n2k9a8+PNclNJ5L95GwTExRZcMSY0nQ+YtTyG6F0rQtb
 bldHkbfBuccongR0u8XOaWigx+UzhXByRfiBKTWnJoTYSQESTPRahci+BZVwYbvQ52WoGi67Rje
 3vSp5/SVfRqv+WlPvfxI1rV8rYh+U6GA8r+OnEZyIlEOiznDKyrlljXaEUzmdSrR8QvwqZCnXuR
 lqcSYC++9iKGUz2+rWdb1Z5EEpKPngO1Kq5xs50UrWi7oFK2hZHhr+B3HtLo/QdjmHK9WzEG+Hm
 3k8mf2KjWCdjTbq0p++sZaQDGyU82CMNtE377BjKR8YM5idLsUQ1gTU4jaUs3Pj6E0Pb7lycyRl
 RvuYoESuaXijxiFO9upnYHlsAf7RNAEUWISxanQF+k1+ELCAiLzwXZJ+G6ZAQXs2J0Fq4DXUsMU
 UtTFK3n1HTmo/xp2eZg==
X-Proofpoint-ORIG-GUID: M_JFT91W1Xzo7FlsQk-vTceUo04n7BP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080153

Heiko Carstens <hca@linux.ibm.com> writes:

> s390 selects GENERIC_LOCKBREAK if PREEMPT is enabled. Reason is a historic
> 18 years old commit [1] which fixed a compile error for PREEMPT enabled
> kernels. Back than only PREEMPT_NONE and PREEMPT_VOLUNTARY kernels were
> considered to be important for s390. PREEMPT should "just work".
>
> However, since recently PREEMPT is always enabled [2], which also causes
> GENERIC_LOCKBREAK to be always enabled. For some workloads this leads to
> massive performance degradation; e.g. a simple kernel compile on machines
> with many CPUs may take up to four times longer.
>
> To fix this just remove the GENERIC_LOCKBREAK from s390's Kconfig, since
> the compile error from 18 years ago does not exist anymore.
>
> [1] commit b6b40c532a36 ("[S390] Define GENERIC_LOCKBREAK.")
> [2] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>
> Cc: stable@vger.kernel.org
> Reported-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ecbcbb781e40..9921a3772bf7 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -29,9 +29,6 @@ config GENERIC_BUG
>  config GENERIC_BUG_RELATIVE_POINTERS
>  	def_bool y
>  
> -config GENERIC_LOCKBREAK
> -	def_bool y if PREEMPTION
> -
>  config AUDIT_ARCH
>  	def_bool y

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
