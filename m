Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795518127;
	b=mBX46aQQjMRpoqTpRM96idUQWnmdR3B1mV11BAwqR2RsNGb88P+zDrxOWWikUe2af2Jw
	 FlAOECIFGNeQ6iFyuKHSUtaRipXuxDdybVQoMM3RLiijSXMrPLilc9TOxvXWCiEnp8iav
	 rBJrAtJrgUHrNPFKhTilkNNq7bmtg6G/x5GlvZ5jeQOlXrXyjcOe5gxhCtJhLlCDt9GBS
	 0Jgewz9tjNK/kY7q0DdbIiO6H8Ln7Cp32AAfQnBFSrGg6NiGuRxpU/wwOq1QvTd0bcq07
	 5AOojUtMY+80T3G1cD+4RmcEJMku7mPf0QYJIS/pHXIv4sE8aQNcMRnzFiZGft9SpCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518127;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3ftNlEVqvZWGVx20k+ZMzr1PN5Nc7kI54sOOrnbpJQw=;
	b=yJE26hRSsmvQ5b30b4PnReTaWXGaVoHDWZNwEd7AcBGepSrI2yeDZ0/eUw58xZS7mNMy
	 SeCQb7AnBQOF7EdEuA6lbyo01E6Uh+XsLUC90phpqPimrNTAoL6n9DLPbbI/LcRMmfKIy
	 YR0VAvTLYGch6lB9xR6UpfCifGsy57yKZIO6AwzjNSKMX6d4iQJz1s4cOsPdudjsuwgbB
	 ZRw8xNJapon5oRvZWS1KqKPff8iRoPa0b7SZ2UDrlqNW4VQJZcEogJyBj8uoE9Xb/MHPA
	 3jpK8uhgUV+f4ZwKK8Q1Hcb15kIguV63xsULlOhX0/GF2zhg7tNCXVMaD+B4IJo4FaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W1crwuEw;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC3606A31E;
	Tue, 24 Nov 2026 11:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41AC3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W1crwuEw
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO34haC001811;
	Tue, 24 Nov 2026 11:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3ftNlEVqvZWGVx20k+ZMzr1PN5Nc7k
	I54sOOrnbpJQw=; b=W1crwuEwyJOICbIHwyUi1zY5Ia/gBXD4sm8f0ERp/CQMcX
	PWpIA9eZSN2N8dB2/VV94VoeWRO/xjIVoFH71BHwrukMmCy4dBL9tVmNIPl9frqe
	kdsni8SgZOfNpdXreIJo1DfdN618qZxWJxaR11VxwDV8kAMokWjTS52SO6MGCTyb
	m2t/UxhelFfrSv7rSBo8bzBB+oeSGdBbrf2yDUDUjewboSjd/XZVhORia0EfwbSe
	svTrcC/E+KRokkYN2j1cB0uSzH56WpXGc74KrnbHgv/2CjQqkoLcqZ+rbLdBEiqL
	j0p1C2hlh1xEJTFGsYmxg9tw6+TvSxhFkWhN1M9g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4et3r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 11:02:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO90O73021873;
	Tue, 24 Nov 2026 11:02:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmk2a71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 11:02:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOB1vEX47972686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 11:01:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20DF52004F;
	Tue, 24 Nov 2026 11:01:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB93520040;
	Tue, 24 Nov 2026 11:01:56 +0000 (GMT)
Received: from osiris (unknown [9.111.55.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Nov 2026 11:01:56 +0000 (GMT)
Date: Tue, 24 Nov 2026 12:01:55 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        linux-s390@vger.kernel.org, linux-debuggers@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: add CFI directives for call_on_stack
Message-ID: <20261124110155.32552B6a-hca@linux.ibm.com>
References: <20261030231714.1319773-1-stephen.s.brennan@oracle.com>
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
In-Reply-To: <20261030231714.1319773-1-stephen.s.brennan@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX8VEIlEH8RAr+
 rm+X20F6w4STTqiIhbyYWRTpiOZKaD2xdxgjQYIR3Fhh1npXF0XPsdx/bSzrnACvvIOZbuuwHUa
 Xcf0GwON4iwOq1Gb5sWp1DPNVb1ZnWY=
X-Proofpoint-GUID: 2IEv-Udvn0Zklz1cQlPhRZc1S8ynq5y4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX7Eg2MbSpaQY+
 Rsl57X4FYn+ePaTAqvUQJydC7Xp5a0Pk/SsWONTpE9KwnoWGIardnGmfP1umlZasB+PWz+mdhk7
 olrjvVntydoV2T1X1fWSsnRND0tMRjz4q529Lba28s+q3QTaDv25QO+6h1oSCVMGFKRWMxDL7fp
 VsVvpB9feIOdw/7n77M1OWEZFwemSarnT3PpLGV7ARHbDFM8w9K4DhfIHjDOMRjxLzb/CgsJsJJ
 gsETER73eyZe0RoN+myJxo+TmJ7pXRQyqoyBodVOM0JhYKuTEwNUAVD9tSYKWXi7LOUvTTE7QbB
 0kQC7DqFkEQsYdrR8pDPFCh4PjFW8Vj11Q5gzMS5I51rOKgLQZqt0O3U/tTaeAcC797hfeLV8TE
 ImUl0ieHEVveGZN3vObghag3+hkDF45ZodItdZSpTxgBjU1ctuhu2nfnYC91VGcb8/BBWgVcPSY
 z2y9yCKyb1x2UNE8g3A==
X-Proofpoint-ORIG-GUID: 2IEv-Udvn0Zklz1cQlPhRZc1S8ynq5y4
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b056ea9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=17FYL03jAAAA:20
 a=yPCof4ZbAAAA:8 a=4y6ffcx9BbnVZogFFskA:9 a=CjuIK1q_8ugA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240041

Hi Stephen,

again, sorry for taking way too long to look into this!

On Fri, Oct 30, 2026 at 04:17:10PM -0700, Stephen Brennan wrote:
> When debugging s390 on drgn, we experience two issues. First, when a
> panic is triggered on CPU 0, drgn is unable to unwind past a stack
> switching event[1,2]. Second, drgn is unable to unwind through an
> interrupt exception frame.
> 
> It turns out that the reason for both is the generated call_on_stack()
> assembly. It modifies %r15 (the stack pointer) without any CFI
> directives describing this change. Thus, the compiler-generated CFI is
> wrong, and drgn tries to unwind using rules based on the wrong SP value.
> 
> To resolve this, use %r10 (a callee-saved register) to store the CFA in
> a temporary register. Then, emit a CFI directive describing the change.
> So long as DWARF CFI is used to unwind all leaf functions, the value of
> %r10 should be recoverable, and unwinders will be able to use it to
> determine the CFA and continue to the new stack.
> 
> I've tested this only in a QEMU VM using drgn's vmtest framework.
> With the patch, drgn is able to unwind through two stack changes: the
> change to the IRQ stack, and the change to the CPU0 nodat_stack during a
> panic on CPU 0.
> 
> [1]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b5097fcef9f61/vmtest/enter_kdump.py#L69-L74
> [2]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b5097fcef9f61/tests/linux_kernel/vmcore/test_vmcore.py#L19-L25
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  arch/s390/include/asm/stacktrace.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

...

> +	register unsigned long cfa asm("10") =				\
> +		frame + STACK_FRAME_OVERHEAD;				\

...

> @@ -196,15 +208,19 @@ static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
>  									\
>  	CALL_TYPECHECK_##nr(__VA_ARGS__);				\
>  	asm volatile(							\
> +		CALL_ON_STACK_CFI(".cfi_remember_state\n")		\
>  		"	lgr	%[_prev],15\n"				\
> +		CALL_ON_STACK_CFI(".cfi_def_cfa %[_cfa],0\n")	\
>  		"	lg	15,%[_stack]\n"				\
>  		"	stg	%[_frame],%[_bc](15)\n"			\
>  		"	brasl	14,%[_fn]\n"				\
> -		"	lgr	15,%[_prev]"				\
> +		"	lgr	15,%[_prev]\n"				\
> +		CALL_ON_STACK_CFI(".cfi_restore_state\n")		\
>  		: [_prev] "=&d" (prev), CALL_FMT_##nr			\
>  		: [_stack] "R" (__stack),				\
>  		  [_bc] "i" (offsetof(struct stack_frame, back_chain)),	\
>  		  [_frame] "d" (frame),					\
> +		  [_cfa] "d" (cfa),					\
>  		  [_fn] "X" (__fn) : CALL_CLOBBER_##nr);		\

The patch is fine, however this should also work without explicitly specifying
to use register 10. Any other free register should work as well, since the
inline assembly is sort of emulating a function call to a different stack -
and therefore all non-callee saved registers are already clobbered, either
early clobbered, or explicitly clobbered.

The compiler can only chose between r6 to r13; all of them are callee-saved.

Or in other words: I'd prefer this

> +	register unsigned long cfa asm("10") =				\
> +		frame + STACK_FRAME_OVERHEAD;				\

to be changed to

> +	unsigned long cfa = frame + STACK_FRAME_OVERHEAD;		\

..unless I am missing something, but "_prev" also relies on this already.
