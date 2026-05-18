Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648739023B;
	Mon, 18 May 2026 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132761; cv=none; b=AKjjCPxQrQ194oopZWUtHyM4SskAxiIUkPb5YbMVteiDll4XqQc7dbr1OQ2uJEyDOMHKR84vk81HN9eEUcqvolvNAA6Peau3UsQSxRMybu7GJpGnBzsLLGSDm1/HmVLIoU42Wi48R3tveaq75KKZqo5tvCOaLXewtksCEepvr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132761; c=relaxed/simple;
	bh=sVe/4amNFLEZz464MhkUytn+NNnprDuyMbrXiH/shZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piphL/TAcoCDyImuCTboIHvSi+f5t+ID5eyJY4zAVZcjK8Ac4PhL09FQTyOBnJS3G865aXs093zCEchJ7ne6p5ptQmt/t1qgEJ7wYzrBVHW567zOqq4AwU+sXjUpm+0CnAI6gaYLgaROZqHQ+JFUa0uKLPSY39bgo3K/4xQIT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qdqssNIB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qdqssNIB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IGjcnQ130203;
	Mon, 18 May 2026 19:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S2VJQi
	DRaWuZ+kGMB9vSJoosMcpqNSoB8b31Y7vGsR4=; b=qdqssNIBW6aM/k+EBYquJl
	+A0Ff9GGQqp/jC5PUoBviYPy2PchLtK+rqeUQhttRjYOX5Ao0U+ozr2Uz/FLHmk9
	enzX3YDxXvu5x3/3dfvH1xhAyYq7b1iGrk48EaknBQ5rNJVpPp6CU6OPeMh7bd9X
	6PJEOwFzXvVMcDstXgk2McsQQzycqW6RwcIvz1/Ut2vLDnRUYoz9zyUshH3r6J8Q
	wdY1ABmafflSpFUAGKWdUG8Zz2BJiTiyQjbzzD4t6xuwOCgZkt3R67N38WDocFAX
	xZ3bWQOB9BHmjCpE8GJ0C69PzL9y0svBs0ECWaeRTO/Tw44Y2O2A916mSYGZU56w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8895wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 19:32:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IJO4hL005162;
	Mon, 18 May 2026 19:32:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxy400-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 19:32:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IJWCMr61800724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 19:32:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC9120043;
	Mon, 18 May 2026 19:32:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E31E320040;
	Mon, 18 May 2026 19:32:10 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.60.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 May 2026 19:32:10 +0000 (GMT)
Date: Mon, 18 May 2026 21:32:09 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Gary Guo <gary@garyguo.net>, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] s390/jump_label: Implement
 ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
Message-ID: <agtpOfpJOe30mLAS@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260512105920.2426293-1-japo@linux.ibm.com>
 <20260512105920.2426293-3-japo@linux.ibm.com>
 <DIGRK1QK7G8H.1W24QCDZ3V1AC@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DIGRK1QK7G8H.1W24QCDZ3V1AC@garyguo.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ehXvOlZa0gcJykoLlB5EP5eR05GCzWqa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OSBTYWx0ZWRfX8KeOmh44pc+j
 a9Kps70LrkMotudJwO54dxBTgigdINOQmPLt99780MTLffw6bgxTKD4hHRt7Z0lTESGLqsx8b2U
 0yV3ILvVVgMEbjWjD17AeEilCjzzIj0jAnZeh5EDCWMx6ylv4gYWGqYz+pvHZMzj/kI44qjdGjN
 RXFBuvkh7KFImC6ykYX1jGsmfa4YMtKdUMpIostdgtGDGp9bMOltD2Zc71WtlGmvlaX19QzIaSw
 2KYrocpPSvnvkboYv2B0Fvb//LlnIdEG7jRgXiX4log9U+bHAkMBy3AS5VJSiSqXHdMAuO0Ducn
 GUSrKK/EKM7nXZgR6JH7wQtvLJuJNhK0KUVvxUCvocwB32VHFfSdHIB4umVQW7qcClO+XtZz43G
 b9LFDuhXpNTnH/N5MY59PENarTuje8S+t9lzto6eRsGCNtqhsBzBzOLZ2odYiTlpwR3lNAKBJea
 kNoObwWqU6rRyUYNFnw==
X-Proofpoint-GUID: R9BtKe-azZjVTAkcR_CM2oultz0COuxy
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0b6941 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=DTDdz7ZKQx8zIeH2WcYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180189

On Tue, May 12, 2026 at 03:21:42PM +0100, Gary Guo wrote:
> On Tue May 12, 2026 at 11:59 AM BST, Jan Polensky wrote:
> > Rust static branch support needs the s390 jump label instruction sequence
> > and __jump_table emission in a reusable form. The current implementation
> > embeds the sequence directly in the C asm goto blocks, which cannot be
> > shared with Rust.
> >
> > Introduce ARCH_STATIC_BRANCH_ASM and ARCH_STATIC_BRANCH_JUMP_ASM to
> > describe the brcl sequences for the likely-false and likely-true cases
> > and to emit the same __jump_table entries as before. Switch the existing
> > C helpers to use the new macros to avoid duplication without changing
> > the generated code.
> >
> > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/jump_label.h | 33 +++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
> > index d9cbc18f6b2e..1f0114150786 100644
> > --- a/arch/s390/include/asm/jump_label.h
> > +++ b/arch/s390/include/asm/jump_label.h
> > @@ -23,15 +23,25 @@
> >   * We use a brcl 0,<offset> instruction for jump labels so it
> >   * can be easily distinguished from a hotpatch generated instruction.
> >   */
>
> The comment looks out of place now, you probably want to move
> ARCH_JUMP_TABLE_ENTRY above it.
>
> Best,
> Gary
>
Hi Gary,

good catch, thanks. I’ll move ARCH_JUMP_TABLE_ENTRY above the comment.

Best Regards
Jan
> > +#define ARCH_JUMP_TABLE_ENTRY(key, label, local_label)	\
> > +	".pushsection __jump_table,\"aw\"\n"		\
> > +	".balign	8\n"				\
> > +	".long	" local_label "-.," label "-.\n"	\
> > +	".quad	" key "-.\n"				\
> > +	".popsection\n"
> > +
> > +#define ARCH_STATIC_BRANCH_ASM(key, label)	\
> > +	"0:	brcl 0," label "\n"		\
> > +	ARCH_JUMP_TABLE_ENTRY(key, label, "0b")
> > +
> > +#define ARCH_STATIC_BRANCH_JUMP_ASM(key, label)	\
> > +	"0:	brcl 15," label "\n"		\
> > +	ARCH_JUMP_TABLE_ENTRY(key, label, "0b")
> > +
> >  static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
> >  {
> > -	asm goto("0:	brcl 0,%l[label]\n"
> > -			  ".pushsection __jump_table,\"aw\"\n"
> > -			  ".balign	8\n"
> > -			  ".long	0b-.,%l[label]-.\n"
> > -			  ".quad	%0+%1-.\n"
> > -			  ".popsection\n"
> > -			  : : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
> > +	asm goto(ARCH_STATIC_BRANCH_ASM("%0+%1", "%l[label]")
> > +		: : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
> >  	return false;
> >  label:
> >  	return true;
> > @@ -39,13 +49,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
> >
> >  static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
> >  {
> > -	asm goto("0:	brcl 15,%l[label]\n"
> > -			  ".pushsection __jump_table,\"aw\"\n"
> > -			  ".balign	8\n"
> > -			  ".long	0b-.,%l[label]-.\n"
> > -			  ".quad	%0+%1-.\n"
> > -			  ".popsection\n"
> > -			  : : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
> > +	asm goto(ARCH_STATIC_BRANCH_JUMP_ASM("%0+%1", "%l[label]")
> > +		: : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
> >  	return false;
> >  label:
> >  	return true;
>
