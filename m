Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A8438C41C;
	Fri, 13 Mar 2026 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396688; cv=none; b=GTy1fF8sa5OWPJEs5pifTyaVwXpWfIs/XE4v49lgt62fHD6lTk+M6ZOl/GxpxgbahxANL7X+Gm87Lx5/owJcmBg5BJVF02+CeKHOlBv9qY0+xbt2+nOIhr0xY10AH7T+B5q1OcvuTMVON0me8wVxnXciSjl9h69UqNL/1F/cXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396688; c=relaxed/simple;
	bh=w5IzxonWrKm2lznvGNAIa+dekQxpfGuqCPinal0N5eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc9v5/pX5v9fvraKiQBfCwTJG701QeSQsctAJM9om9qN4D0jX4HPKwxKGuRgQuO+Beak1d+EM9qc9oIOeAhtyNalKZVePqrYi5SnKJ6e7FUdglTtpartkXKFhtRs4e2MSGpxhUmCBYGcyFproR31Fhmu4HO31jRiMBDCWlDU7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M3PDeF0g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M3PDeF0g"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CMOXgx1007198;
	Fri, 13 Mar 2026 10:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Gkf4rOT4CFaHfJxJ8D6AnxUn1V1vbC
	NLe4eo89TKRVk=; b=M3PDeF0gXGFqD48QC2BpkNs1MMLp/DRkX8ixVJrAeH+Y81
	W5LBdFxIMnOijR8IPo+U4OfZ3RJzu81EufLpCnV2umrJMy4W4Xznce+EcTi8oBFt
	MK0TkwABzoihI34EBFwcHOUyC0v6nsSk8OBVH5yTgpXrMJYZtePhsEZa3y/b2f6H
	qNvNaaTu439Owg9EOALvJ69qMo/2kORyEyuS+LSFflGOK8CcemELgnkhF4KlyQ8j
	b13WVQdZlyWMU1VZMA+ZxByLSS5T5uerSNEy/1fyW7N/PlM0ucUP61Qv/xnFqSyt
	O29mnQBIbaUXaxOi7al5ZNdBxiaBitAA4nNaYrYA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91q6mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 10:10:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D5UuVS008897;
	Fri, 13 Mar 2026 10:10:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha766vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 10:10:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DAAQ1Q53608886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 10:10:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD84F2006C;
	Fri, 13 Mar 2026 10:10:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3578C2004B;
	Fri, 13 Mar 2026 10:10:24 +0000 (GMT)
Received: from osiris (unknown [9.111.5.66])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 10:10:24 +0000 (GMT)
Date: Fri, 13 Mar 2026 11:10:22 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de,
        shuah@kernel.org, kees@kernel.org, luto@amacapital.net,
        wad@chromium.org, kevin.brodsky@arm.com, charlie@rivosinc.com,
        macro@orcam.me.uk, deller@gmx.de, ldv@strace.io,
        anshuman.khandual@arm.com, song@kernel.org, ryan.roberts@arm.com,
        mark.rutland@arm.com, ada.coupriediaz@arm.com, broonie@kernel.org,
        pengcan@kylinos.cn, liqiang01@kylinos.cn, thuth@redhat.com,
        andreas@gaisler.com, schuster.simon@siemens-energy.com,
        jremus@linux.ibm.com, jgross@suse.com, mathieu.desnoyers@efficios.com,
        yeoreum.yun@arm.com, kmal@cock.li, dvyukov@google.com,
        akpm@linux-foundation.org, reddybalavignesh9979@gmail.com,
        richard.weiyang@gmail.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 11/12] arm64: Use generic TIF bits for common thread
 flags
Message-ID: <20260313101022.13729C56-hca@linux.ibm.com>
References: <20260313094738.3985794-1-ruanjinjie@huawei.com>
 <20260313094738.3985794-12-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313094738.3985794-12-ruanjinjie@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: BCADzvpbkvwpu6qt2LtTmNdZt-NTgdEB
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b3e299 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=i0EeH86SAAAA:8
 a=VnNF1IyMAAAA:8 a=yb_icw7U1PEggasoSeYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA3OCBTYWx0ZWRfX204njEZ7La+7
 lopLeqJAvBsdIgcWc7JF7JKlYJi59Je0zliAQV0GcuRR3gN8/wyQtSb5D/ATDtU4sWZjTKpvV/l
 AcZwh/tIq2vjmMDaZTwOouNhNy9OmALovQnv4y/8OVc1k10fK7hCIWjW71P46WpjhsNMvxnoJX8
 ELxU/zlYAj8DS3iG5RHANoiskwvgvoNssJ4Zj2rUgNy64CX7p26+epoqWE7fBG/jpSSPXrNkvE8
 N0LPr9ll7usEul4bSWf48Mko9DwYOBWC2IDjO6WjkJfnM28Dk2cKDO9UE8iC42p2RfBae+FZt88
 6fbwgNuzR84w8Qig2mu4VEY+10CxhBs4B+MJoPOm9wRbPIl6f6lSoJP8qpvKfmEKOhebB6UI/Za
 BnTSAx5nmkxfhFIeEF605P9Wn/XMUWyROrvIxXzdbXmodCskURFIexm+D3qtOVKFbs/laAiG614
 18vCvat/UhZ9R8rwL4g==
X-Proofpoint-ORIG-GUID: jxPi3LKPbFj4QvC6Ms7r0r-sH3yGugOe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130078

On Fri, Mar 13, 2026 at 05:47:37PM +0800, Jinjie Ruan wrote:
> Use the generic TIF bits defined in <asm-generic/thread_info_tif.h> for
> standard thread flags (TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME,
> TIF_RESTORE_SIGMASK, TIF_SINGLESTEP, etc.) instead of defining
> them locally.
> 
> Arm64-specific bits (TIF_FOREIGN_FPSTATE, TIF_MTE_ASYNC_FAULT, TIF_SVE,
> TIF_SSBD, etc.) are renumbered to start at bit 16 to avoid conflicts.
> 
> This enables RSEQ optimizations which require CONFIG_HAVE_GENERIC_TIF_BITS
> combined with the generic entry infrastructure (already used by arm64).
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/Kconfig                    |  1 +
>  arch/arm64/include/asm/thread_info.h  | 62 ++++++++++++---------------
>  arch/s390/include/asm/thread_info.h   |  7 ++-

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

>  arch/x86/include/asm/thread_info.h    |  6 +--
>  include/asm-generic/thread_info_tif.h |  5 +++
>  5 files changed, 38 insertions(+), 43 deletions(-)

FWIW, I guess you want to do the same for loongarch was well?
