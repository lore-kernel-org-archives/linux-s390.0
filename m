Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFB4BCADC;
	Tue,  8 Sep 2026 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876210; cv=none; b=nyAEkpm006PiOlU9UnaU8GxrtcD6oamtTKZadKha2grFQB3LCkVg/Dno+f1gDEmE8u/jBlgHRMeo8a77xLiaEDhi3Kio4COwNwhGXD0KqzYdvIucaV99pvRxFqP8CVOR0BLrWlb7WvqEVXmCqhwk0OjvQfGPJxYHfaj+XllaT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876210; c=relaxed/simple;
	bh=FtTl5w8d1+YgnJfgQPWUTdHWyV3qRphQn/hXwdONM3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omVDxtVxGdFgrL0kJFkawg352ko4tsFNAxabqYEOZiwq45D1ryizo+Bmguik0mVwt247zVjCiok742WYo9xFRR+6Ta0JFYXoqGDUi6UEndLW7cQqNaongo/e+RPoXyz4dlIWrXMxI+epY/6rzDyuRnOgDGXBIfcDgT3IwLQ0Dg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gYrLU5Ef; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gYrLU5Ef"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688D1g3C1003779;
	Tue, 8 Sep 2026 14:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2whIbC
	FAU8+7G8xGjZchg7r9WDxCBwgXb64pwaDKpq0=; b=gYrLU5EfZw8GU2kmpkwLVB
	+yFbfSv/Ac9sMTMai7f9DUwlI3mTvVYn/g7v/aI1qkp+unoQ9AAlSX7e5rtP6wul
	VBLU6/X5sC/lxZyhOKCiwVyJ6GN7NgWfvkn17D0e4GNK0R1gelWEk6uaQa3hCNOd
	F4y0E8L3/hV/oLiponSzyzqxNuwJIiJ2/5qx5K2DSIw2BDGTy2qXtFe0exjx5DOe
	vKTKNAFZgqrvL7p95r/chEEB0yeMp5rcGBlpENPiX8rx+TYFJ5R6tP+wZOrUUkf9
	QhRisYGihhrqo9RX9gTIGzyx5FWTA4gM6b6wWt+Ktd0wWhYa7lqTH9/LNYYQUmpA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhey47s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 14:01:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688DuGaC013471;
	Tue, 8 Sep 2026 14:01:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwh43xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 14:01:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688E1qYM46465360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 14:01:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D719220040;
	Tue,  8 Sep 2026 14:01:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E31D520043;
	Tue,  8 Sep 2026 14:01:26 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 14:01:26 +0000 (GMT)
Message-ID: <adfa12f0-b10e-4ddd-b869-5b89472bbfbc@linux.ibm.com>
Date: Tue, 8 Sep 2026 19:31:22 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/24] powerpc/elf: Move relocation constants to UAPI
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
 <20260908-vdso-absolute-reloc-v5-5-3a93791af1cf@linutronix.de>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-5-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Dz6bXYpVsJYl67ajhfIQyLGdmvAGtUCI
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa01556 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Cwp57q3QIedEjLD5lMMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE1MSBTYWx0ZWRfXysvBzka1o/50
 4kveyTKejicNd4VJelhAvj9HEis1s5Wa2+2ZqewkCdeVX/nEJPY8ZgWu2HsSwrHup5CP/4MdPUP
 rjkYh05RijGRI1vng3OWh24sdcJ2b1k=
X-Proofpoint-ORIG-GUID: RUOFMcpvHu-hiEQKa1wedlEgPK_cLfrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE1MSBTYWx0ZWRfX5fpGXX2j02v6
 4ytvt1er+ipzSFrhNEKDL42vx91DOabCzR7M25V+L8JfU0Muf/TjcCqfabHJw6SwL8FaFAo/aWV
 N7aki7nHBru2kwK1FN63VVoRS6qWZuYKYjxZxLcnLtIiuMpmCtkHUGs9ztmS0HedvC17i/gAyxw
 PX5I5qNVhYYSds+qlLcUDquJmZuXFInEx/x2LPN+0kO3Z2Lx81jHsmUrC2zq3yhnV/7GQR1b+tC
 4deowVpR8Qnj6FJRvbtq9tcrt6CW13jr7dzPR/Qo2jtoIeE9jZqOL0TRjVnqwVvHlQB7grQlVAv
 CchXbBh7S0WFGTmwi2zkqFhDgX1AF36i0c1FCLjpJI4PhIn38ng3Wl8p7MfkYGTrmbBFzE5Lk77
 CpEprMYZ1BdRJxv0aHdShqsgNJEc9StH67jbl7y++ym1bnzCqfrg2WQBeWcJbPnGVtqvTN9EAE/
 OUSI+OAMiprLow5Z24Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080151


On 08.09.2026 12:03 PM, Thomas Weißschuh wrote:
> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
>
> Move them from the kernel-private architecture-specific header to the UAPI.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   arch/powerpc/include/uapi/asm/elf.h | 201 ------------------------------------
>   include/uapi/linux/elf-r.h          | 201 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 201 insertions(+), 201 deletions(-)
>
> diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
> index a5377f494fa3..aba921b8249a 100644
> --- a/arch/powerpc/include/uapi/asm/elf.h
> +++ b/arch/powerpc/include/uapi/asm/elf.h
> @@ -17,78 +17,6 @@
>   #include <asm/cputable.h>
>   #include <asm/auxvec.h>
>   
> -/* PowerPC relocations defined by the ABIs */
> -#define R_PPC_NONE		0
> -#define R_PPC_ADDR32		1	/* 32bit absolute address */
> -#define R_PPC_ADDR24		2	/* 26bit address, 2 bits ignored.  */
> -#define R_PPC_ADDR16		3	/* 16bit absolute address */
> -#define R_PPC_ADDR16_LO		4	/* lower 16bit of absolute address */
> -#define R_PPC_ADDR16_HI		5	/* high 16bit of absolute address */
> -#define R_PPC_ADDR16_HA		6	/* adjusted high 16bit */
> -#define R_PPC_ADDR14		7	/* 16bit address, 2 bits ignored */
> -#define R_PPC_ADDR14_BRTAKEN	8
> -#define R_PPC_ADDR14_BRNTAKEN	9
> -#define R_PPC_REL24		10	/* PC relative 26 bit */
> -#define R_PPC_REL14		11	/* PC relative 16 bit */
> -#define R_PPC_REL14_BRTAKEN	12
> -#define R_PPC_REL14_BRNTAKEN	13
> -#define R_PPC_GOT16		14
> -#define R_PPC_GOT16_LO		15
> -#define R_PPC_GOT16_HI		16
> -#define R_PPC_GOT16_HA		17
> -#define R_PPC_PLTREL24		18
> -#define R_PPC_COPY		19
> -#define R_PPC_GLOB_DAT		20
> -#define R_PPC_JMP_SLOT		21
> -#define R_PPC_RELATIVE		22
> -#define R_PPC_LOCAL24PC		23
> -#define R_PPC_UADDR32		24
> -#define R_PPC_UADDR16		25
> -#define R_PPC_REL32		26
> -#define R_PPC_PLT32		27
> -#define R_PPC_PLTREL32		28
> -#define R_PPC_PLT16_LO		29
> -#define R_PPC_PLT16_HI		30
> -#define R_PPC_PLT16_HA		31
> -#define R_PPC_SDAREL16		32
> -#define R_PPC_SECTOFF		33
> -#define R_PPC_SECTOFF_LO	34
> -#define R_PPC_SECTOFF_HI	35
> -#define R_PPC_SECTOFF_HA	36
> -
> -/* PowerPC relocations defined for the TLS access ABI.  */
> -#define R_PPC_TLS		67 /* none	(sym+add)@tls */
> -#define R_PPC_DTPMOD32		68 /* word32	(sym+add)@dtpmod */
> -#define R_PPC_TPREL16		69 /* half16*	(sym+add)@tprel */
> -#define R_PPC_TPREL16_LO	70 /* half16	(sym+add)@tprel@l */
> -#define R_PPC_TPREL16_HI	71 /* half16	(sym+add)@tprel@h */
> -#define R_PPC_TPREL16_HA	72 /* half16	(sym+add)@tprel@ha */
> -#define R_PPC_TPREL32		73 /* word32	(sym+add)@tprel */
> -#define R_PPC_DTPREL16		74 /* half16*	(sym+add)@dtprel */
> -#define R_PPC_DTPREL16_LO	75 /* half16	(sym+add)@dtprel@l */
> -#define R_PPC_DTPREL16_HI	76 /* half16	(sym+add)@dtprel@h */
> -#define R_PPC_DTPREL16_HA	77 /* half16	(sym+add)@dtprel@ha */
> -#define R_PPC_DTPREL32		78 /* word32	(sym+add)@dtprel */
> -#define R_PPC_GOT_TLSGD16	79 /* half16*	(sym+add)@got@tlsgd */
> -#define R_PPC_GOT_TLSGD16_LO	80 /* half16	(sym+add)@got@tlsgd@l */
> -#define R_PPC_GOT_TLSGD16_HI	81 /* half16	(sym+add)@got@tlsgd@h */
> -#define R_PPC_GOT_TLSGD16_HA	82 /* half16	(sym+add)@got@tlsgd@ha */
> -#define R_PPC_GOT_TLSLD16	83 /* half16*	(sym+add)@got@tlsld */
> -#define R_PPC_GOT_TLSLD16_LO	84 /* half16	(sym+add)@got@tlsld@l */
> -#define R_PPC_GOT_TLSLD16_HI	85 /* half16	(sym+add)@got@tlsld@h */
> -#define R_PPC_GOT_TLSLD16_HA	86 /* half16	(sym+add)@got@tlsld@ha */
> -#define R_PPC_GOT_TPREL16	87 /* half16*	(sym+add)@got@tprel */
> -#define R_PPC_GOT_TPREL16_LO	88 /* half16	(sym+add)@got@tprel@l */
> -#define R_PPC_GOT_TPREL16_HI	89 /* half16	(sym+add)@got@tprel@h */
> -#define R_PPC_GOT_TPREL16_HA	90 /* half16	(sym+add)@got@tprel@ha */
> -#define R_PPC_GOT_DTPREL16	91 /* half16*	(sym+add)@got@dtprel */
> -#define R_PPC_GOT_DTPREL16_LO	92 /* half16*	(sym+add)@got@dtprel@l */
> -#define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
> -#define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
> -
> -/* keep this the last entry. */
> -#define R_PPC_NUM		95
> -
>   
>   #define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
>   #define ELF_NFPREG	33	/* includes fpscr */
> @@ -166,133 +94,4 @@ typedef elf_vrreg_t elf_vrregset_t32[ELF_NVRREG32];
>   typedef elf_fpreg_t elf_vsrreghalf_t32[ELF_NVSRHALFREG];
>   #endif
>   
> -/* PowerPC64 relocations defined by the ABIs */
> -#define R_PPC64_NONE    R_PPC_NONE
> -#define R_PPC64_ADDR32  R_PPC_ADDR32  /* 32bit absolute address.  */
> -#define R_PPC64_ADDR24  R_PPC_ADDR24  /* 26bit address, word aligned.  */
> -#define R_PPC64_ADDR16  R_PPC_ADDR16  /* 16bit absolute address. */
> -#define R_PPC64_ADDR16_LO R_PPC_ADDR16_LO /* lower 16bits of abs. address.  */
> -#define R_PPC64_ADDR16_HI R_PPC_ADDR16_HI /* high 16bits of abs. address. */
> -#define R_PPC64_ADDR16_HA R_PPC_ADDR16_HA /* adjusted high 16bits.  */
> -#define R_PPC64_ADDR14 R_PPC_ADDR14   /* 16bit address, word aligned.  */
> -#define R_PPC64_ADDR14_BRTAKEN  R_PPC_ADDR14_BRTAKEN
> -#define R_PPC64_ADDR14_BRNTAKEN R_PPC_ADDR14_BRNTAKEN
> -#define R_PPC64_REL24   R_PPC_REL24 /* PC relative 26 bit, word aligned.  */
> -#define R_PPC64_REL14   R_PPC_REL14 /* PC relative 16 bit. */
> -#define R_PPC64_REL14_BRTAKEN   R_PPC_REL14_BRTAKEN
> -#define R_PPC64_REL14_BRNTAKEN  R_PPC_REL14_BRNTAKEN
> -#define R_PPC64_GOT16     R_PPC_GOT16
> -#define R_PPC64_GOT16_LO  R_PPC_GOT16_LO
> -#define R_PPC64_GOT16_HI  R_PPC_GOT16_HI
> -#define R_PPC64_GOT16_HA  R_PPC_GOT16_HA
> -
> -#define R_PPC64_COPY      R_PPC_COPY
> -#define R_PPC64_GLOB_DAT  R_PPC_GLOB_DAT
> -#define R_PPC64_JMP_SLOT  R_PPC_JMP_SLOT
> -#define R_PPC64_RELATIVE  R_PPC_RELATIVE
> -
> -#define R_PPC64_UADDR32   R_PPC_UADDR32
> -#define R_PPC64_UADDR16   R_PPC_UADDR16
> -#define R_PPC64_REL32     R_PPC_REL32
> -#define R_PPC64_PLT32     R_PPC_PLT32
> -#define R_PPC64_PLTREL32  R_PPC_PLTREL32
> -#define R_PPC64_PLT16_LO  R_PPC_PLT16_LO
> -#define R_PPC64_PLT16_HI  R_PPC_PLT16_HI
> -#define R_PPC64_PLT16_HA  R_PPC_PLT16_HA
> -
> -#define R_PPC64_SECTOFF     R_PPC_SECTOFF
> -#define R_PPC64_SECTOFF_LO  R_PPC_SECTOFF_LO
> -#define R_PPC64_SECTOFF_HI  R_PPC_SECTOFF_HI
> -#define R_PPC64_SECTOFF_HA  R_PPC_SECTOFF_HA
> -#define R_PPC64_ADDR30          37  /* word30 (S + A - P) >> 2.  */
> -#define R_PPC64_ADDR64          38  /* doubleword64 S + A.  */
> -#define R_PPC64_ADDR16_HIGHER   39  /* half16 #higher(S + A).  */
> -#define R_PPC64_ADDR16_HIGHERA  40  /* half16 #highera(S + A).  */
> -#define R_PPC64_ADDR16_HIGHEST  41  /* half16 #highest(S + A).  */
> -#define R_PPC64_ADDR16_HIGHESTA 42  /* half16 #highesta(S + A). */
> -#define R_PPC64_UADDR64     43  /* doubleword64 S + A.  */
> -#define R_PPC64_REL64       44  /* doubleword64 S + A - P.  */
> -#define R_PPC64_PLT64       45  /* doubleword64 L + A.  */
> -#define R_PPC64_PLTREL64    46  /* doubleword64 L + A - P.  */
> -#define R_PPC64_TOC16       47  /* half16* S + A - .TOC.  */
> -#define R_PPC64_TOC16_LO    48  /* half16 #lo(S + A - .TOC.).  */
> -#define R_PPC64_TOC16_HI    49  /* half16 #hi(S + A - .TOC.).  */
> -#define R_PPC64_TOC16_HA    50  /* half16 #ha(S + A - .TOC.).  */
> -#define R_PPC64_TOC         51  /* doubleword64 .TOC. */
> -#define R_PPC64_PLTGOT16    52  /* half16* M + A.  */
> -#define R_PPC64_PLTGOT16_LO 53  /* half16 #lo(M + A).  */
> -#define R_PPC64_PLTGOT16_HI 54  /* half16 #hi(M + A).  */
> -#define R_PPC64_PLTGOT16_HA 55  /* half16 #ha(M + A).  */
> -
> -#define R_PPC64_ADDR16_DS      56 /* half16ds* (S + A) >> 2.  */
> -#define R_PPC64_ADDR16_LO_DS   57 /* half16ds  #lo(S + A) >> 2.  */
> -#define R_PPC64_GOT16_DS       58 /* half16ds* (G + A) >> 2.  */
> -#define R_PPC64_GOT16_LO_DS    59 /* half16ds  #lo(G + A) >> 2.  */
> -#define R_PPC64_PLT16_LO_DS    60 /* half16ds  #lo(L + A) >> 2.  */
> -#define R_PPC64_SECTOFF_DS     61 /* half16ds* (R + A) >> 2.  */
> -#define R_PPC64_SECTOFF_LO_DS  62 /* half16ds  #lo(R + A) >> 2.  */
> -#define R_PPC64_TOC16_DS       63 /* half16ds* (S + A - .TOC.) >> 2.  */
> -#define R_PPC64_TOC16_LO_DS    64 /* half16ds  #lo(S + A - .TOC.) >> 2.  */
> -#define R_PPC64_PLTGOT16_DS    65 /* half16ds* (M + A) >> 2.  */
> -#define R_PPC64_PLTGOT16_LO_DS 66 /* half16ds  #lo(M + A) >> 2.  */
> -
> -/* PowerPC64 relocations defined for the TLS access ABI.  */
> -#define R_PPC64_TLS		67 /* none	(sym+add)@tls */
> -#define R_PPC64_DTPMOD64	68 /* doubleword64 (sym+add)@dtpmod */
> -#define R_PPC64_TPREL16		69 /* half16*	(sym+add)@tprel */
> -#define R_PPC64_TPREL16_LO	70 /* half16	(sym+add)@tprel@l */
> -#define R_PPC64_TPREL16_HI	71 /* half16	(sym+add)@tprel@h */
> -#define R_PPC64_TPREL16_HA	72 /* half16	(sym+add)@tprel@ha */
> -#define R_PPC64_TPREL64		73 /* doubleword64 (sym+add)@tprel */
> -#define R_PPC64_DTPREL16	74 /* half16*	(sym+add)@dtprel */
> -#define R_PPC64_DTPREL16_LO	75 /* half16	(sym+add)@dtprel@l */
> -#define R_PPC64_DTPREL16_HI	76 /* half16	(sym+add)@dtprel@h */
> -#define R_PPC64_DTPREL16_HA	77 /* half16	(sym+add)@dtprel@ha */
> -#define R_PPC64_DTPREL64	78 /* doubleword64 (sym+add)@dtprel */
> -#define R_PPC64_GOT_TLSGD16	79 /* half16*	(sym+add)@got@tlsgd */
> -#define R_PPC64_GOT_TLSGD16_LO	80 /* half16	(sym+add)@got@tlsgd@l */
> -#define R_PPC64_GOT_TLSGD16_HI	81 /* half16	(sym+add)@got@tlsgd@h */
> -#define R_PPC64_GOT_TLSGD16_HA	82 /* half16	(sym+add)@got@tlsgd@ha */
> -#define R_PPC64_GOT_TLSLD16	83 /* half16*	(sym+add)@got@tlsld */
> -#define R_PPC64_GOT_TLSLD16_LO	84 /* half16	(sym+add)@got@tlsld@l */
> -#define R_PPC64_GOT_TLSLD16_HI	85 /* half16	(sym+add)@got@tlsld@h */
> -#define R_PPC64_GOT_TLSLD16_HA	86 /* half16	(sym+add)@got@tlsld@ha */
> -#define R_PPC64_GOT_TPREL16_DS	87 /* half16ds*	(sym+add)@got@tprel */
> -#define R_PPC64_GOT_TPREL16_LO_DS 88 /* half16ds (sym+add)@got@tprel@l */
> -#define R_PPC64_GOT_TPREL16_HI	89 /* half16	(sym+add)@got@tprel@h */
> -#define R_PPC64_GOT_TPREL16_HA	90 /* half16	(sym+add)@got@tprel@ha */
> -#define R_PPC64_GOT_DTPREL16_DS	91 /* half16ds*	(sym+add)@got@dtprel */
> -#define R_PPC64_GOT_DTPREL16_LO_DS 92 /* half16ds (sym+add)@got@dtprel@l */
> -#define R_PPC64_GOT_DTPREL16_HI	93 /* half16	(sym+add)@got@dtprel@h */
> -#define R_PPC64_GOT_DTPREL16_HA	94 /* half16	(sym+add)@got@dtprel@ha */
> -#define R_PPC64_TPREL16_DS	95 /* half16ds*	(sym+add)@tprel */
> -#define R_PPC64_TPREL16_LO_DS	96 /* half16ds	(sym+add)@tprel@l */
> -#define R_PPC64_TPREL16_HIGHER	97 /* half16	(sym+add)@tprel@higher */
> -#define R_PPC64_TPREL16_HIGHERA	98 /* half16	(sym+add)@tprel@highera */
> -#define R_PPC64_TPREL16_HIGHEST	99 /* half16	(sym+add)@tprel@highest */
> -#define R_PPC64_TPREL16_HIGHESTA 100 /* half16	(sym+add)@tprel@highesta */
> -#define R_PPC64_DTPREL16_DS	101 /* half16ds* (sym+add)@dtprel */
> -#define R_PPC64_DTPREL16_LO_DS	102 /* half16ds	(sym+add)@dtprel@l */
> -#define R_PPC64_DTPREL16_HIGHER	103 /* half16	(sym+add)@dtprel@higher */
> -#define R_PPC64_DTPREL16_HIGHERA 104 /* half16	(sym+add)@dtprel@highera */
> -#define R_PPC64_DTPREL16_HIGHEST 105 /* half16	(sym+add)@dtprel@highest */
> -#define R_PPC64_DTPREL16_HIGHESTA 106 /* half16	(sym+add)@dtprel@highesta */
> -#define R_PPC64_TLSGD		107
> -#define R_PPC64_TLSLD		108
> -#define R_PPC64_TOCSAVE		109
> -
> -#define R_PPC64_REL24_NOTOC	116
> -#define R_PPC64_ENTRY		118
> -
> -#define R_PPC64_PCREL34		132
> -#define R_PPC64_GOT_PCREL34	133
> -
> -#define R_PPC64_REL16		249
> -#define R_PPC64_REL16_LO	250
> -#define R_PPC64_REL16_HI	251
> -#define R_PPC64_REL16_HA	252
> -
> -/* Keep this the last entry.  */
> -#define R_PPC64_NUM		253
> -
>   #endif /* _UAPI_ASM_POWERPC_ELF_H */
> diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
> index cf931fc05afa..0d0dfaa7c724 100644
> --- a/include/uapi/linux/elf-r.h
> +++ b/include/uapi/linux/elf-r.h
> @@ -113,4 +113,205 @@
>   
>   #define R_AARCH64_RELATIVE		1027
>   
> +/* PowerPC relocations defined by the ABIs */
> +#define R_PPC_NONE		0
> +#define R_PPC_ADDR32		1	/* 32bit absolute address */
> +#define R_PPC_ADDR24		2	/* 26bit address, 2 bits ignored.  */
> +#define R_PPC_ADDR16		3	/* 16bit absolute address */
> +#define R_PPC_ADDR16_LO		4	/* lower 16bit of absolute address */
> +#define R_PPC_ADDR16_HI		5	/* high 16bit of absolute address */
> +#define R_PPC_ADDR16_HA		6	/* adjusted high 16bit */
> +#define R_PPC_ADDR14		7	/* 16bit address, 2 bits ignored */
> +#define R_PPC_ADDR14_BRTAKEN	8
> +#define R_PPC_ADDR14_BRNTAKEN	9
> +#define R_PPC_REL24		10	/* PC relative 26 bit */
> +#define R_PPC_REL14		11	/* PC relative 16 bit */
> +#define R_PPC_REL14_BRTAKEN	12
> +#define R_PPC_REL14_BRNTAKEN	13
> +#define R_PPC_GOT16		14
> +#define R_PPC_GOT16_LO		15
> +#define R_PPC_GOT16_HI		16
> +#define R_PPC_GOT16_HA		17
> +#define R_PPC_PLTREL24		18
> +#define R_PPC_COPY		19
> +#define R_PPC_GLOB_DAT		20
> +#define R_PPC_JMP_SLOT		21
> +#define R_PPC_RELATIVE		22
> +#define R_PPC_LOCAL24PC		23
> +#define R_PPC_UADDR32		24
> +#define R_PPC_UADDR16		25
> +#define R_PPC_REL32		26
> +#define R_PPC_PLT32		27
> +#define R_PPC_PLTREL32		28
> +#define R_PPC_PLT16_LO		29
> +#define R_PPC_PLT16_HI		30
> +#define R_PPC_PLT16_HA		31
> +#define R_PPC_SDAREL16		32
> +#define R_PPC_SECTOFF		33
> +#define R_PPC_SECTOFF_LO	34
> +#define R_PPC_SECTOFF_HI	35
> +#define R_PPC_SECTOFF_HA	36
> +
> +/* PowerPC relocations defined for the TLS access ABI.  */
> +#define R_PPC_TLS		67 /* none	(sym+add)@tls */
> +#define R_PPC_DTPMOD32		68 /* word32	(sym+add)@dtpmod */
> +#define R_PPC_TPREL16		69 /* half16*	(sym+add)@tprel */
> +#define R_PPC_TPREL16_LO	70 /* half16	(sym+add)@tprel@l */
> +#define R_PPC_TPREL16_HI	71 /* half16	(sym+add)@tprel@h */
> +#define R_PPC_TPREL16_HA	72 /* half16	(sym+add)@tprel@ha */
> +#define R_PPC_TPREL32		73 /* word32	(sym+add)@tprel */
> +#define R_PPC_DTPREL16		74 /* half16*	(sym+add)@dtprel */
> +#define R_PPC_DTPREL16_LO	75 /* half16	(sym+add)@dtprel@l */
> +#define R_PPC_DTPREL16_HI	76 /* half16	(sym+add)@dtprel@h */
> +#define R_PPC_DTPREL16_HA	77 /* half16	(sym+add)@dtprel@ha */
> +#define R_PPC_DTPREL32		78 /* word32	(sym+add)@dtprel */
> +#define R_PPC_GOT_TLSGD16	79 /* half16*	(sym+add)@got@tlsgd */
> +#define R_PPC_GOT_TLSGD16_LO	80 /* half16	(sym+add)@got@tlsgd@l */
> +#define R_PPC_GOT_TLSGD16_HI	81 /* half16	(sym+add)@got@tlsgd@h */
> +#define R_PPC_GOT_TLSGD16_HA	82 /* half16	(sym+add)@got@tlsgd@ha */
> +#define R_PPC_GOT_TLSLD16	83 /* half16*	(sym+add)@got@tlsld */
> +#define R_PPC_GOT_TLSLD16_LO	84 /* half16	(sym+add)@got@tlsld@l */
> +#define R_PPC_GOT_TLSLD16_HI	85 /* half16	(sym+add)@got@tlsld@h */
> +#define R_PPC_GOT_TLSLD16_HA	86 /* half16	(sym+add)@got@tlsld@ha */
> +#define R_PPC_GOT_TPREL16	87 /* half16*	(sym+add)@got@tprel */
> +#define R_PPC_GOT_TPREL16_LO	88 /* half16	(sym+add)@got@tprel@l */
> +#define R_PPC_GOT_TPREL16_HI	89 /* half16	(sym+add)@got@tprel@h */
> +#define R_PPC_GOT_TPREL16_HA	90 /* half16	(sym+add)@got@tprel@ha */
> +#define R_PPC_GOT_DTPREL16	91 /* half16*	(sym+add)@got@dtprel */
> +#define R_PPC_GOT_DTPREL16_LO	92 /* half16*	(sym+add)@got@dtprel@l */
> +#define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
> +#define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
> +
> +/* keep this the last entry. */
> +#define R_PPC_NUM		95
> +
> +/* PowerPC64 relocations defined by the ABIs */
> +#define R_PPC64_NONE    R_PPC_NONE
> +#define R_PPC64_ADDR32  R_PPC_ADDR32  /* 32bit absolute address.  */
> +#define R_PPC64_ADDR24  R_PPC_ADDR24  /* 26bit address, word aligned.  */
> +#define R_PPC64_ADDR16  R_PPC_ADDR16  /* 16bit absolute address. */
> +#define R_PPC64_ADDR16_LO R_PPC_ADDR16_LO /* lower 16bits of abs. address.  */
> +#define R_PPC64_ADDR16_HI R_PPC_ADDR16_HI /* high 16bits of abs. address. */
> +#define R_PPC64_ADDR16_HA R_PPC_ADDR16_HA /* adjusted high 16bits.  */
> +#define R_PPC64_ADDR14 R_PPC_ADDR14   /* 16bit address, word aligned.  */
> +#define R_PPC64_ADDR14_BRTAKEN  R_PPC_ADDR14_BRTAKEN
> +#define R_PPC64_ADDR14_BRNTAKEN R_PPC_ADDR14_BRNTAKEN
> +#define R_PPC64_REL24   R_PPC_REL24 /* PC relative 26 bit, word aligned.  */
> +#define R_PPC64_REL14   R_PPC_REL14 /* PC relative 16 bit. */
> +#define R_PPC64_REL14_BRTAKEN   R_PPC_REL14_BRTAKEN
> +#define R_PPC64_REL14_BRNTAKEN  R_PPC_REL14_BRNTAKEN
> +#define R_PPC64_GOT16     R_PPC_GOT16
> +#define R_PPC64_GOT16_LO  R_PPC_GOT16_LO
> +#define R_PPC64_GOT16_HI  R_PPC_GOT16_HI
> +#define R_PPC64_GOT16_HA  R_PPC_GOT16_HA
> +
> +#define R_PPC64_COPY      R_PPC_COPY
> +#define R_PPC64_GLOB_DAT  R_PPC_GLOB_DAT
> +#define R_PPC64_JMP_SLOT  R_PPC_JMP_SLOT
> +#define R_PPC64_RELATIVE  R_PPC_RELATIVE
> +
> +#define R_PPC64_UADDR32   R_PPC_UADDR32
> +#define R_PPC64_UADDR16   R_PPC_UADDR16
> +#define R_PPC64_REL32     R_PPC_REL32
> +#define R_PPC64_PLT32     R_PPC_PLT32
> +#define R_PPC64_PLTREL32  R_PPC_PLTREL32
> +#define R_PPC64_PLT16_LO  R_PPC_PLT16_LO
> +#define R_PPC64_PLT16_HI  R_PPC_PLT16_HI
> +#define R_PPC64_PLT16_HA  R_PPC_PLT16_HA
> +
> +#define R_PPC64_SECTOFF     R_PPC_SECTOFF
> +#define R_PPC64_SECTOFF_LO  R_PPC_SECTOFF_LO
> +#define R_PPC64_SECTOFF_HI  R_PPC_SECTOFF_HI
> +#define R_PPC64_SECTOFF_HA  R_PPC_SECTOFF_HA
> +#define R_PPC64_ADDR30          37  /* word30 (S + A - P) >> 2.  */
> +#define R_PPC64_ADDR64          38  /* doubleword64 S + A.  */
> +#define R_PPC64_ADDR16_HIGHER   39  /* half16 #higher(S + A).  */
> +#define R_PPC64_ADDR16_HIGHERA  40  /* half16 #highera(S + A).  */
> +#define R_PPC64_ADDR16_HIGHEST  41  /* half16 #highest(S + A).  */
> +#define R_PPC64_ADDR16_HIGHESTA 42  /* half16 #highesta(S + A). */
> +#define R_PPC64_UADDR64     43  /* doubleword64 S + A.  */
> +#define R_PPC64_REL64       44  /* doubleword64 S + A - P.  */
> +#define R_PPC64_PLT64       45  /* doubleword64 L + A.  */
> +#define R_PPC64_PLTREL64    46  /* doubleword64 L + A - P.  */
> +#define R_PPC64_TOC16       47  /* half16* S + A - .TOC.  */
> +#define R_PPC64_TOC16_LO    48  /* half16 #lo(S + A - .TOC.).  */
> +#define R_PPC64_TOC16_HI    49  /* half16 #hi(S + A - .TOC.).  */
> +#define R_PPC64_TOC16_HA    50  /* half16 #ha(S + A - .TOC.).  */
> +#define R_PPC64_TOC         51  /* doubleword64 .TOC. */
> +#define R_PPC64_PLTGOT16    52  /* half16* M + A.  */
> +#define R_PPC64_PLTGOT16_LO 53  /* half16 #lo(M + A).  */
> +#define R_PPC64_PLTGOT16_HI 54  /* half16 #hi(M + A).  */
> +#define R_PPC64_PLTGOT16_HA 55  /* half16 #ha(M + A).  */
> +
> +#define R_PPC64_ADDR16_DS      56 /* half16ds* (S + A) >> 2.  */
> +#define R_PPC64_ADDR16_LO_DS   57 /* half16ds  #lo(S + A) >> 2.  */
> +#define R_PPC64_GOT16_DS       58 /* half16ds* (G + A) >> 2.  */
> +#define R_PPC64_GOT16_LO_DS    59 /* half16ds  #lo(G + A) >> 2.  */
> +#define R_PPC64_PLT16_LO_DS    60 /* half16ds  #lo(L + A) >> 2.  */
> +#define R_PPC64_SECTOFF_DS     61 /* half16ds* (R + A) >> 2.  */
> +#define R_PPC64_SECTOFF_LO_DS  62 /* half16ds  #lo(R + A) >> 2.  */
> +#define R_PPC64_TOC16_DS       63 /* half16ds* (S + A - .TOC.) >> 2.  */
> +#define R_PPC64_TOC16_LO_DS    64 /* half16ds  #lo(S + A - .TOC.) >> 2.  */
> +#define R_PPC64_PLTGOT16_DS    65 /* half16ds* (M + A) >> 2.  */
> +#define R_PPC64_PLTGOT16_LO_DS 66 /* half16ds  #lo(M + A) >> 2.  */
> +
> +/* PowerPC64 relocations defined for the TLS access ABI.  */
> +#define R_PPC64_TLS		67 /* none	(sym+add)@tls */
> +#define R_PPC64_DTPMOD64	68 /* doubleword64 (sym+add)@dtpmod */
> +#define R_PPC64_TPREL16		69 /* half16*	(sym+add)@tprel */
> +#define R_PPC64_TPREL16_LO	70 /* half16	(sym+add)@tprel@l */
> +#define R_PPC64_TPREL16_HI	71 /* half16	(sym+add)@tprel@h */
> +#define R_PPC64_TPREL16_HA	72 /* half16	(sym+add)@tprel@ha */
> +#define R_PPC64_TPREL64		73 /* doubleword64 (sym+add)@tprel */
> +#define R_PPC64_DTPREL16	74 /* half16*	(sym+add)@dtprel */
> +#define R_PPC64_DTPREL16_LO	75 /* half16	(sym+add)@dtprel@l */
> +#define R_PPC64_DTPREL16_HI	76 /* half16	(sym+add)@dtprel@h */
> +#define R_PPC64_DTPREL16_HA	77 /* half16	(sym+add)@dtprel@ha */
> +#define R_PPC64_DTPREL64	78 /* doubleword64 (sym+add)@dtprel */
> +#define R_PPC64_GOT_TLSGD16	79 /* half16*	(sym+add)@got@tlsgd */
> +#define R_PPC64_GOT_TLSGD16_LO	80 /* half16	(sym+add)@got@tlsgd@l */
> +#define R_PPC64_GOT_TLSGD16_HI	81 /* half16	(sym+add)@got@tlsgd@h */
> +#define R_PPC64_GOT_TLSGD16_HA	82 /* half16	(sym+add)@got@tlsgd@ha */
> +#define R_PPC64_GOT_TLSLD16	83 /* half16*	(sym+add)@got@tlsld */
> +#define R_PPC64_GOT_TLSLD16_LO	84 /* half16	(sym+add)@got@tlsld@l */
> +#define R_PPC64_GOT_TLSLD16_HI	85 /* half16	(sym+add)@got@tlsld@h */
> +#define R_PPC64_GOT_TLSLD16_HA	86 /* half16	(sym+add)@got@tlsld@ha */
> +#define R_PPC64_GOT_TPREL16_DS	87 /* half16ds*	(sym+add)@got@tprel */
> +#define R_PPC64_GOT_TPREL16_LO_DS 88 /* half16ds (sym+add)@got@tprel@l */
> +#define R_PPC64_GOT_TPREL16_HI	89 /* half16	(sym+add)@got@tprel@h */
> +#define R_PPC64_GOT_TPREL16_HA	90 /* half16	(sym+add)@got@tprel@ha */
> +#define R_PPC64_GOT_DTPREL16_DS	91 /* half16ds*	(sym+add)@got@dtprel */
> +#define R_PPC64_GOT_DTPREL16_LO_DS 92 /* half16ds (sym+add)@got@dtprel@l */
> +#define R_PPC64_GOT_DTPREL16_HI	93 /* half16	(sym+add)@got@dtprel@h */
> +#define R_PPC64_GOT_DTPREL16_HA	94 /* half16	(sym+add)@got@dtprel@ha */
> +#define R_PPC64_TPREL16_DS	95 /* half16ds*	(sym+add)@tprel */
> +#define R_PPC64_TPREL16_LO_DS	96 /* half16ds	(sym+add)@tprel@l */
> +#define R_PPC64_TPREL16_HIGHER	97 /* half16	(sym+add)@tprel@higher */
> +#define R_PPC64_TPREL16_HIGHERA	98 /* half16	(sym+add)@tprel@highera */
> +#define R_PPC64_TPREL16_HIGHEST	99 /* half16	(sym+add)@tprel@highest */
> +#define R_PPC64_TPREL16_HIGHESTA 100 /* half16	(sym+add)@tprel@highesta */
> +#define R_PPC64_DTPREL16_DS	101 /* half16ds* (sym+add)@dtprel */
> +#define R_PPC64_DTPREL16_LO_DS	102 /* half16ds	(sym+add)@dtprel@l */
> +#define R_PPC64_DTPREL16_HIGHER	103 /* half16	(sym+add)@dtprel@higher */
> +#define R_PPC64_DTPREL16_HIGHERA 104 /* half16	(sym+add)@dtprel@highera */
> +#define R_PPC64_DTPREL16_HIGHEST 105 /* half16	(sym+add)@dtprel@highest */
> +#define R_PPC64_DTPREL16_HIGHESTA 106 /* half16	(sym+add)@dtprel@highesta */
> +#define R_PPC64_TLSGD		107
> +#define R_PPC64_TLSLD		108
> +#define R_PPC64_TOCSAVE		109
> +
> +#define R_PPC64_REL24_NOTOC	116
> +#define R_PPC64_ENTRY		118
> +
> +#define R_PPC64_PCREL34		132
> +#define R_PPC64_GOT_PCREL34	133
> +
> +#define R_PPC64_REL16		249
> +#define R_PPC64_REL16_LO	250
> +#define R_PPC64_REL16_HI	251
> +#define R_PPC64_REL16_HA	252
> +
> +/* Keep this the last entry.  */
> +#define R_PPC64_NUM		253
> +
>   #endif /* _UAPI_LINUX_ELF_R_H */
>
-- 
Thanks and Regards
R.Nageswara Sastry

