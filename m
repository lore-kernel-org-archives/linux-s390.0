Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B220D3D332A;
	Mon, 31 Aug 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166390; cv=none; b=kxHq8/hTpdP3faLGxp9mUPTLvpx7Anr3dUuBqEXIy63vLTr3ug+4yufQ+r2Be98cHxjl9ijQBWH00rfUvxqhlU2WgnX7nj4eIke81Q5OHpnmVrKW1FajYX9H2kIJQv2RjWnatJ2VaWZdEaLaVqMzaeLC0kYCixEbfeWah/vD7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166390; c=relaxed/simple;
	bh=CVbYk0gj5KXQ67iRLFH6F++pXSWYVzV4bNLBCZkNVy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMjqQqrQsw1Kut9lizc5JofwoupICLFbhmOsVtuCehoBflwsStmfi1ku6KApr70v8L3Ur9ebnY5B4N1S344fbsVpA3O3FJ5zg+GRybNyA3RQ7y+77BNOfc/lX6O1xHDhWIEO8RVLWpUrFkWpZfe2JgMkvxSo++P0NKaOlru9gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ybb5RZzS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ybb5RZzS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82Hp11697480;
	Mon, 31 Aug 2026 08:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CVbYk0gj5KXQ67iRLFH6F++pXSWYVz
	V4bNLBCZkNVy8=; b=Ybb5RZzSRXxH50tJV/HBUhrjVmIBDpR4ZbNq1+HWNZhvB9
	5HFz5fRUyA93c16kA0wp16C+QRBksBq4Z2KEuh8Av/VE+KpkeZ4uGIQUuFwYp8uU
	xXuqtLg0wMfNjYZFaPxAZCnM2V/o7hGSST9533aNdTPRiEx1JiKTCYt27zmk25J7
	Qw4/U6qUdjt1S5siGQniStMxnMLzif3hA7fIxhRdTsEHTdlIJlnFntrVxKha/qic
	jfLVcJD6XvtrKnI0i+4S97wyvEoc8kTmGGZfn4idvJs95XCVMPcS/yo7mKOpHgTT
	AC11isR2/K0RsQ0eMx0d3i4xR5MWVk3oiovvNb3w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t00t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 08:51:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V8fIDE023473;
	Mon, 31 Aug 2026 08:51:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexvpqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 08:51:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V8oxQj46334272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 08:50:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A75F2004D;
	Mon, 31 Aug 2026 08:50:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CAB12004B;
	Mon, 31 Aug 2026 08:50:57 +0000 (GMT)
Received: from osiris (unknown [9.111.81.24])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Aug 2026 08:50:57 +0000 (GMT)
Date: Mon, 31 Aug 2026 10:50:56 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry
 handling
Message-ID: <20260831085056.34274A00-hca@linux.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <ed8b99e6-4d90-4622-9d43-451bf6a8db2c@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed8b99e6-4d90-4622-9d43-451bf6a8db2c@zytor.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a954078 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=2rmWDWJpZfqxup52QhcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfXw6StCSqGUaXh
 WvbpCQlGtz7BWihs+RH7DTv2WTOPxVyCWDhiSWtYE+xXgludqixVfK/gU8MUaWS0fxPWdxy86vH
 qJzG6nhsABnZyATt5K5eJawaXFm8xNE=
X-Proofpoint-ORIG-GUID: bDXbK4NJXMMf6_5R5lg1wFJEO5GSpFz5
X-Proofpoint-GUID: Fhr_wfi5ePHh4Bqv3MhKtt0iPRZ1Mvkg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfX/htDxJBtEHnv
 Z5NhKYazvuvBRJ72zC10F4fqCuZQvNxl5T1bxWCM9YyDyUuOyarWnRe1p0lqpKZl/OmyRFcmZLf
 ktLOOUR/RrJ6H/n8LU3DyRN14Rj88+RKLatjVJj6EvUm7yCYuy01GuzOqCiTMwCDp3qPyD8ygcz
 8e7DrOBxrdld6/gHT5EMTdlMQoVKjlCd8tRGftrZtFR0eBrKEt+PFXrl5pqVW+wMvV30DgdS65s
 FO2OVicoQhWTWZLtRydH/w0eDM4R+aziyu8zv53VSgwZjxKL71DDEhdZB1VFr5JeZaTp0hNvCNd
 fL1C2mdKKTto6StljkY/Esj1kJ2CLVmDhxayGEQpB6INuQ8vyDvgd1hcoKr++IMzU8bbI32PX2p
 erwW4FtLz+3ZSzAofzRUQ2Kh1tXMYtSiayqZ9s635kOCihBZsW9PohTK3Pmd5E5U5z+A/YfXl7T
 OPEW+V8lEUn+zLxSJdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310072

On Thu, Aug 27, 2026 at 03:22:35PM -0700, H. Peter Anvin wrote:
> This isn't a hard thing to solve in any way: replacing the pointer argument
> with a two-element structure return would do the trick. As far as I know,
> *all* architectures that support Linux support returning structures with two
> register-sized values in registers.

That is unfortunately not true. The s390 ABI defines that structures,
regardless of size, are returned in a return value buffer allocated by
the caller.
