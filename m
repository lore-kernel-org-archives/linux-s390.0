Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349FF55D87F;
	Tue,  8 Sep 2026 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876276; cv=none; b=tOWj2UI+ox0aC+Vopi4tdt4NQz8xuW6i6TNMX1jrdw/nSX8pmuCCsMtnjH4AAD/Xuwl2/993+Gu2Y4LrzsjJiFIL3zHPrUloUYPris4fc/XdS+z08T41MjxYwfSvbxapLLNNu+f5vyDFSLL2SKL4W/1ayX8xMH/jlzIAKGWBfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876276; c=relaxed/simple;
	bh=zZMgvC/qllob1lzqJZsYR2NMG6pmoUsjGgBTSnsgJq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrYcvc4qbxSSG1dtXRDkAmWhPD0t7HkU/pW54PcDTXYAQ+TUULuht0fHkD1fDC4aPNoWrsb9tBTUtUhp+OwbvsjJSrrFAp+uV8rpZ3LuNYtuIo8JRXEcv9fd9FaGOPU2is7kiE64CFRGxr/b99Jij5ewJ673DhuiykQ/h6R2YVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YIKyU/c/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YIKyU/c/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688D1gN04008041;
	Tue, 8 Sep 2026 14:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kqndma
	W8DL9z5lUDZrm9whEknryFxk+Tb/v8/jM4l2k=; b=YIKyU/c/H2YnhGEjQBTa9F
	dGyW1cMyR8KPdeMzvyf7ZKByaoGiinWEyo8cS/v1j4OLIntRGtT+aycfFi9HZZ6g
	IupqGgQQhmriK5BQzjtXIQitZ3Z+sXnY8CEvS9rMjYVQJdO79qCnhyuEuhxaEH/L
	y+XM+TuWHWlUgF/DdA25SyUq2zqec4Ah859o3SI1mkj803zNxzFQXTnZXH4z6GLE
	ZCdp0TVWF9z+RXUIcyQXhlJ4E87Ct2Ss67T8WynuRHDsn5Zcj1PRqHRCOauCdw93
	69kR/q7nng1XtMu11UlnKvVgFf5b1Y2ze3gWAWRYrRGHhnZXjCl6aK3G6NBYCpRg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrq4a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 14:03:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688DuE46015482;
	Tue, 8 Sep 2026 14:03:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03ybyjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 14:03:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688E37pW45154618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 14:03:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C5972004B;
	Tue,  8 Sep 2026 14:03:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BD1E20043;
	Tue,  8 Sep 2026 14:02:41 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 14:02:40 +0000 (GMT)
Message-ID: <264436d6-4a2a-4fe7-8b10-bbbd69cf7fd5@linux.ibm.com>
Date: Tue, 8 Sep 2026 19:32:37 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/24] powerpc/vdso: Enable the vdsocheck tool
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Christophe Leroy <chleroy@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Nicolas Schier <nsc@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-17-3a93791af1cf@linutronix.de>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-17-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa015a0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=0oLV-YkNZL8bY7TGgZYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE1MSBTYWx0ZWRfX3KyouA8o5rAD
 ByjA/dZC1Xn2n5rWH2E08Rby3F+ieH1b8xVcBpTsx0Pq3F1Kh8H6gO0eZ56x8axONjS0M7Vrmnn
 1W+1YJV6A3rf0XXO5ICf/YfbKJvemH4=
X-Proofpoint-ORIG-GUID: pTJswYdOioXws7GKWQycoAhrlwYXMjr-
X-Proofpoint-GUID: gTxGanC_PLNk6Cp8fvurHqYNODghYxXb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE1MSBTYWx0ZWRfX+h8v/6PDKP+Z
 jAdm1rpGv4OhJjZsh6igckQQoLJoC7k9srOWBrLXydyr1uM/ouNV0nG/uX0KMsRisoyR2/cj7Mb
 Hy2sciE8csHY6RSCpOx2nHtrmmW9Bn3O8HYVkQEH4zuSVA5NUU414f/b1P3dY2Y9XVnEpbCvJEP
 gZdPdvU+PEg2VuiKByiM4jecbnLFEgaHV5/AHo2rbC0Fn3xseCHAZ0BYnJpQACipja6Fj5ZcajM
 9S0iR7edRavzStHw3Bl0kcStsnMxiBYTJV59jwjjZrHbhDEDVEGjtlhKJlGMl7XI9iVT6tVB69E
 /bcJ2zCAI+cma3BesLX1c2J13X5ouAGoXJs8yD7QAv6QzEAtvkL7oWFOsTBNu+FkE5yVjZH/1kZ
 OZGjxAMbcSHhLhthhYM2mHEV+LTIa+3ZOqkA9IE9Sq7oBPMJ8eRmrGM9/yOAAzelV4MYH0qfW5K
 8wt2O27vBLIE4mVUxeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080151


On 08.09.2026 12:03 PM, Thomas Weißschuh wrote:
> The vdsocheck tool validates the object files and final .so library.
> It can detect if the compiler created relocations which are incompatible
> with the vDSO which need to be worked around.
>
> Wire it up for the architecture.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   arch/powerpc/Kconfig              |  1 +
>   arch/powerpc/kernel/vdso/Makefile |  4 ++--
>   lib/vdso/check/vdsocheck.rs       | 27 +++++++++++++++++++++++++++
>   3 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2580e27e4328..f19e225cfc5c 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -330,6 +330,7 @@ config PPC
>   	select SYSCTL_EXCEPTION_TRACE
>   	select THREAD_INFO_IN_TASK
>   	select TRACE_IRQFLAGS_SUPPORT
> +	select VDSO_CHECK
>   	select VDSO_DATASTORE
>   	select VDSO_GETRANDOM
>   	#
> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
> index 368759f81708..ca20b91b4373 100644
> --- a/arch/powerpc/kernel/vdso/Makefile
> +++ b/arch/powerpc/kernel/vdso/Makefile
> @@ -81,9 +81,9 @@ targets += vdso64.lds
>   CPPFLAGS_vdso64.lds += -P -C
>   
>   # link rule for the .so file, .lds has to be first
> -$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
> +$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o $(vdsocheck) FORCE
>   	$(call if_changed,vdso32ld_and_check)
> -$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o FORCE
> +$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o $(vdsocheck) FORCE
>   	$(call if_changed,vdso64ld_and_check)
>   
>   # assembly rules for the .S files
> diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> index e45a1fbc6829..429bdcd65818 100644
> --- a/lib/vdso/check/vdsocheck.rs
> +++ b/lib/vdso/check/vdsocheck.rs
> @@ -69,6 +69,33 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
>               ..Default::default()
>           }
>           .into(),
> +        bindings::EM_PPC => AllowedRelocations {
> +            in_object_file: &[
> +                bindings::R_PPC_REL24,
> +                bindings::R_PPC_REL14,
> +                bindings::R_PPC_REL32,
> +                bindings::R_PPC_REL16,
> +                bindings::R_PPC_REL16_LO,
> +                bindings::R_PPC_REL16_HI,
> +                bindings::R_PPC_REL16_HA,
> +            ],
> +            ..Default::default()
> +        }
> +        .into(),
> +        bindings::EM_PPC64 => AllowedRelocations {
> +            in_object_file: &[
> +                bindings::R_PPC64_REL24,
> +                bindings::R_PPC64_REL14,
> +                bindings::R_PPC64_REL32,
> +                bindings::R_PPC64_REL64,
> +                bindings::R_PPC64_REL16,
> +                bindings::R_PPC64_REL16_LO,
> +                bindings::R_PPC64_REL16_HI,
> +                bindings::R_PPC64_REL16_HA,
> +            ],
> +            ..Default::default()
> +        }
> +        .into(),
>           _ => None,
>       }
>   }
>
-- 
Thanks and Regards
R.Nageswara Sastry

