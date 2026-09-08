Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F89558218;
	Tue,  8 Sep 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876235; cv=none; b=Ia2DOLWxWy1skoEBzSjrzK0NSaNSNrFyLRH2n/lMXTigFMk8QArE5xLa5DxpJZgAJTi5Bve3wyldLhfHNryrP0NHzEJX/SZL3I2rjESmXfjsK4Ra1ptIV4NTC+LPrag4pmrmNvzFMlGi7y1JKpQrsbNvE/ckXsdK2y52+R+sB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876235; c=relaxed/simple;
	bh=UAIRpdegCEXbOBZbPZKvF/Wg7Wd5IKKlFGBTsa1kTHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5LsBKopSyy0gVkYMiReYYevoL03K74MEM6DGMRkFf1xjbPUoPOU29VWAj9h/f7q6awzgYvvNwinW90WaHgeNPZCb6oIruHx0pr1Q1NRAuQZ7WgBwK+MDoU+YKiFPe18pj95xjetb7n+xt4SWT8+UTPt+3Q5WaIV+2qSA0F5fFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DkRaNUBq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DkRaNUBq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688D1SK33279394;
	Tue, 8 Sep 2026 14:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UqX3MG
	f8NpzxTcQ9X6cYrr7J0OROlL+yYETamRYF6h8=; b=DkRaNUBq5Po3ZiYXLpdZHj
	7P6w4FnM8dpQH99hSATTYsO4+R3x6LS7Q/BLTa58V7jASmR9DDF4HPXfnmYkwnYO
	35j4owUo8+KVUM2AWF/slKJXWdMAZvgg4sFsfz0BkNd25LusvynIYb7WDyLr8Ph2
	KcWRNuQ7cAgZWkkOqWoK20XbS4hCrrT88/KT6I6/B4AjL3LNx2KpqFwQ0jixWALR
	wJ+ho21ylGC7S4S/kN1AC1g4PDijNOy1z+AD5APaHhaSMI0Yqv5Qz+34YPlHZRai
	ZJE3AJnbRa6KbIfmhw55zgTFzJumsWcXitDXmb6LQTfMgzT+mrJROXxb9jPpAFkQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjyasp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 14:02:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688DuHYU002298;
	Tue, 8 Sep 2026 14:02:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqcbec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 14:02:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688E2OPw52887812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 14:02:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E4242004D;
	Tue,  8 Sep 2026 14:02:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9540620043;
	Tue,  8 Sep 2026 14:01:58 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 14:01:58 +0000 (GMT)
Message-ID: <ea5fe025-4d7c-4d57-b277-85a922f09f84@linux.ibm.com>
Date: Tue, 8 Sep 2026 19:31:57 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/24] powerpc/elf: Add 32-bit REL16 relocation
 definitions
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
 <20260908-vdso-absolute-reloc-v5-16-3a93791af1cf@linutronix.de>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-16-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: aYV4ngoIThgEBPmBdnotS3o7i2N5Uzjf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE1MSBTYWx0ZWRfX3bZ8SdHju1u6
 WnAXanC7whchdXDQlbM1bnHHavM3A0XM+U9uNoCZL4isixam/MSBLOyuzMVMdu6l7VHgIEoOycZ
 dlEr5Z5cJkZxXmkrMQ+NOqNOTMk1aXk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE1MSBTYWx0ZWRfX1zaPWFuX+rUC
 riLtFhVLvRWmnm+PCm4A0algSS42oJsAX7QmPC5kzQVWr6sJJZJ7wVpRqR+HpAOpd51fNAQNH37
 vcxn0gYqvf7f/c2pQ3QqZgVmDTdIfS/RCrgwXn+BM9J5Judf5wM9QvQdcwDgBfZJ80Ds6Vvk05p
 z3D5rC5fVpd2v5hVSFzR2x+2nIEy9S4M1fR6OpKmPCb96lJDyBnRDmLeX+GH5PRpxAeInDJhqNm
 bRREiI/ol2jxBUm4xnRLGc3/i5RISKIhAsIqSVCGoz2W0oXpmKoE1P8pJPqeAAl+16UXH8833ES
 1jQ42swBeeopjBnghrZOTHsjCuUFrk2z63ztUpveDTH+D7GQOM82m1IVezimT4QZ+Xv/j9LIsx4
 Qaow1RBjTKepe3FWLG7b9WypE1rQNpqeWLcHksl6ecvx616BKCLrxNEXC6q9hbHxaCmg1KIn/nz
 xdLTLzZaTJe5DzZ9Tkg==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa01576 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=kTRc27yyOv6OL1rmJE4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nj6Cv9HygVweTXNR7EWl_2v5ROwGQX2g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080151


On 08.09.2026 12:03 PM, Thomas Weißschuh wrote:
> These are used by userspace and are necessary for the vdsocheck tool.
> They share the numbers with their 64-bit variants.
>
> Also update the copy in tools/ so they can be used by vdsocheck.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   include/uapi/linux/elf-r.h       | 7 ++++++-
>   tools/include/uapi/linux/elf-r.h | 7 ++++++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
> index 72fc9045a5d4..170888422400 100644
> --- a/include/uapi/linux/elf-r.h
> +++ b/include/uapi/linux/elf-r.h
> @@ -182,8 +182,13 @@
>   #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
>   #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
>   
> +#define R_PPC_REL16		249
> +#define R_PPC_REL16_LO		250
> +#define R_PPC_REL16_HI		251
> +#define R_PPC_REL16_HA		252
> +
>   /* keep this the last entry. */
> -#define R_PPC_NUM		95
> +#define R_PPC_NUM		253
>   
>   /* PowerPC64 relocations defined by the ABIs */
>   #define R_PPC64_NONE    R_PPC_NONE
> diff --git a/tools/include/uapi/linux/elf-r.h b/tools/include/uapi/linux/elf-r.h
> index 72fc9045a5d4..170888422400 100644
> --- a/tools/include/uapi/linux/elf-r.h
> +++ b/tools/include/uapi/linux/elf-r.h
> @@ -182,8 +182,13 @@
>   #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
>   #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
>   
> +#define R_PPC_REL16		249
> +#define R_PPC_REL16_LO		250
> +#define R_PPC_REL16_HI		251
> +#define R_PPC_REL16_HA		252
> +
>   /* keep this the last entry. */
> -#define R_PPC_NUM		95
> +#define R_PPC_NUM		253
>   
>   /* PowerPC64 relocations defined by the ABIs */
>   #define R_PPC64_NONE    R_PPC_NONE
>
-- 
Thanks and Regards
R.Nageswara Sastry

