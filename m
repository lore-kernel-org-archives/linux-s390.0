Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075479;
	b=2Dsq6a4QQ8pmT19qzv1iTLbxVkG+2AewLTex5PD1R9442aHrp6kBtUdx+cAjt07Q9Utf
	 6NbCP3tY0aJhvqnvzYh3r7Gu4+mQ4Jblheeq70soCteEIFMe5O1S7FZHV6siPPCcfGkLJ
	 ByvlQ4vJyPYIWWKM5XdKUIYY/t4zDGWqEVwGBWKL1ykLn7OaT69lTLS7es0pKcBU4E9Uo
	 EpbWjjdW1iprmYOWY9LlrgujcMdn7CwTENCNur46ktq3N4YufSUMcpkrx9Tr6DxgYyAKU
	 XAKVJrwqTj0vIEktPKeREtcMA0IBrhqXLV48xsgeZUETqTjlIi45HlFAbniV+7rPgrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075479;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KJVj/kj9TUfC5U25moNOJpfG8IeN1Z/DKDptskt/i9I=;
	b=I/VC99aAlm7ussfe2hKrzOkiWgyHbaF6P72V8cXcOqsq7aGU4SEIA0IHn51OVj/5xurT
	 wGrrSvZnQy3Qem09u74YSf2e96IRhQB5odvug8p6nKlwJYgfiqFYlrvjmYCPW4x2KaBPg
	 wh5wCsP7h9VvrgvIbpD9+2VUb0ccmKgsqtYkFiTyxkBtHxoE99l/hxxUeclKhbcOUJxqs
	 kVY74+/SvI4oyIggQ0LObPsi3yGmBhbIZIIpk3ZSvQnFSUbhcqQzAFhSRn70gmeNJIuEt
	 pRYYa1o8EQF5w3/fYoyQSbtEoBazh7C4ie4LtrHF1YYsScJl8bvh8we0hhvO8qzIP5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NNXYf4Is;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21A606A324;
	Thu, 19 Nov 2026 08:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF21A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NNXYf4Is
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6uX0n3598174;
	Thu, 19 Nov 2026 08:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KJVj/kj9TUfC5U25moNOJpfG8IeN1Z
	/DKDptskt/i9I=; b=NNXYf4Iskp9aW7wh9wp5+yD++njdn0lJ9UHUxyVtLnGcOh
	+imeaNzLylMStHs7rWLVAS/6zxMvGlf790mWbLINInkhlMr5NPZfjBMEo93R6TDo
	v1DieXnPNHqmI2iGeOfK2qN8k+7IyE/kJf5EkWt7mNkDf6dP4/w4u3TpBCrupPQ6
	pDqkt+RQPiyksep4NBjfa54jrMrXYOPKvNmCqIAXAWDBQBpMyufCtsh83WEqcMFN
	ht4aQkWJNRHECdzT4s6B/WQLa81T2r3p9hEXy2PAyIhG1A3SoyH2PU2IMB/IZTHN
	Q9Sl/8Ox0awQGrT5FVxR6BIilCP6EhsnMa8O+44A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nfft6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 08:03:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ74was179507;
	Thu, 19 Nov 2026 08:03:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3htdru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 08:03:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ83T0246989662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 08:03:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53ABD20040;
	Thu, 19 Nov 2026 08:03:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB2B2004E;
	Thu, 19 Nov 2026 08:03:28 +0000 (GMT)
Received: from osiris (unknown [9.68.31.201])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Nov 2026 08:03:28 +0000 (GMT)
Date: Thu, 19 Nov 2026 09:03:27 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
        Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
        Alexandre Ghiti <alex@ghiti.fr>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in
 Kconfig.kexec
Message-ID: <20261119080327.12916Ac7-hca@linux.ibm.com>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
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
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMSBTYWx0ZWRfXy8bDEZD/HzO1
 Ej6fSCUmufwaGVs8qDbsLLSFspAjGF8EV57/b1UAhhkJVI7XRX4gvSjQSKfcSsiK74DRTfmozkt
 /ROcpv4UPzkhercU92Bv3pOW124/C4PyRRuMx/ikvSMd1AE3EG9BKsoxjRjGUkLK9hw7IJKrg4/
 YRAYeEUUMXCqn82c56PVhZptydQWuHKP4jJKXE05r4eSXDJU3z8jTciGXLv0tpOPm13aCmj/f0c
 VlJi7ZYKgBQELDj74CX57DaiLHPhuPSCjFRc6oLUx8NvurAyLoOAcOcizOtr/oEPqrKfVSGXr8Z
 I+pWvX+KMJTvAl1hPVIiPa366OqIAmWq2w0D6SVFoDpZkCddgcNowB9MS0YkiNpmHwVIKkH3Aig
 TSWl3fJ/fu21seeQCA7tRQxlIoKvqNtJGr/wq/mpgR9CL98J1JRMfDEC9Y0n62mBzCDYUXdtbhh
 6zgnLpz9nmHYhElrFug==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afead5a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rNe8aJYx3auY1A-cjiAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6EMbp8-aufz9djOo_kjz6yvOKs-gD7lm
X-Proofpoint-ORIG-GUID: 3vzaEwyOTJJHOeKIPx0B_GRjewJ73XWm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMSBTYWx0ZWRfX+jzSPCVdQB28
 e9b6AO4bXKV5KrHOR5wnZ38l6ryoyS9P0QgO17Eyyj1+OKhehU8TYsQNMNVX7bkCr++NTblrk4q
 XKZmhJevMP70D8zhZsJSq4dAvRO2bY0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190031

On Thu, Nov 19, 2026 at 08:16:58AM +0200, Mike Rapoport (Microsoft) wrote:
> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
> 
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
> 
> Selection conditions are preserved, so there is no functional change.
> 
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/arm/Kconfig       | 12 +++---------
>  arch/arm64/Kconfig     | 36 +++++++++---------------------------
>  arch/loongarch/Kconfig | 20 +++++---------------
>  arch/m68k/Kconfig      |  4 +---
>  arch/mips/Kconfig      | 12 +++---------
>  arch/parisc/Kconfig    |  8 ++------
>  arch/powerpc/Kconfig   | 30 +++++++-----------------------
>  arch/riscv/Kconfig     | 28 +++++++---------------------
>  arch/s390/Kconfig      | 28 ++++++----------------------
>  arch/sh/Kconfig        | 16 ++++------------
>  arch/x86/Kconfig       | 48 ++++++++++++------------------------------------
>  kernel/Kconfig.kexec   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  12 files changed, 101 insertions(+), 183 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
