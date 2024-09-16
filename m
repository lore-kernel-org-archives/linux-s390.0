Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FC4962E;
	Mon, 16 Sep 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489043; cv=none; b=K87h7NF7rYwn1yTaeSeobMeNmeQJUqFPf79bSWWeOb3ljY9gvHAfLlKV/ce4b+HUhdGCBMMbYIQlkh77yw9D4swRHhwQWJpvzeZ8+MNxeautPgjva0M91nOhVuyXHwAr64yEcalOezpZW3lisBNkfxKtTyapMPPsa54o4B8ASA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489043; c=relaxed/simple;
	bh=dvlYiOpY5g2NVdxzbAje45G4DZQio7EFYusrXzQAzV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kud6qLWApkdjemi/UL+jzSkFDPmUaNY7OgySyp9L2qQtUErmXN8b19U3Nm0rrfeNr1hW3xjiodVdy0CQCH8aTS5e+4fz6Z9a1CPw/b1BwWK4C7pmbwGt2xJcumlI6k4+5C3Psad23pbMqrV6eC2cqp8JjqLbF1t/cjOa/WtMdOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bBQotW0F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bBQotW0F"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48G1CZVA011227;
	Mon, 16 Sep 2024 12:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=1D6pu5yAl2FG8jgwnGi4Bkydcfa
	djCRMdlp2xLBpljw=; b=bBQotW0FZeXPBH78AtvSm/j3cQzU8irmAhiYZ59R0Wh
	MOiXBFc7K3D4xdBgy0fD76fSVVY3ZnqSgGDB3QRGKgis84v8+4VIfYuOF37c6hlJ
	U9ZDP/eywFBydk4cxXs9W2/05KW0g5Pc+Zqg3y+vmnycdpVC3M08rCArgl6eCTN+
	ZH+Qfd0kkG/dTlgZV0l7mQgvhqaZH9e4xkhnCYU5Im3O3sl/7QgDIlSl5WBoglqs
	Pkyhuwf6GVO8RbNM4w+p7s3UWXhGs7zQVFiOb3ePBVrSfCnOLjxKIbU/JNdmWJnW
	nWbHLKtRn5hwrUci946WuuwXOXqmfbRylBs0G+xZbmw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj1tcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:17:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48GAhS2K001915;
	Mon, 16 Sep 2024 12:17:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nmtufhwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:17:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GCGwHa54329708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 12:16:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DF052004D;
	Mon, 16 Sep 2024 12:16:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6D6920043;
	Mon, 16 Sep 2024 12:16:57 +0000 (GMT)
Received: from osiris (unknown [9.171.58.79])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Sep 2024 12:16:57 +0000 (GMT)
Date: Mon, 16 Sep 2024 14:16:56 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20240916121656.20933-B-hca@linux.ibm.com>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <172615373091.133222.1812791604518973124.stgit@devnote2>
 <20240915051559.435abfcd@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915051559.435abfcd@rorschach.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hn8g-7rXOsw8rZzdW_yoBnCJwpudOsHo
X-Proofpoint-GUID: hn8g-7rXOsw8rZzdW_yoBnCJwpudOsHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_08,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=22 priorityscore=1501
 mlxlogscore=56 adultscore=0 phishscore=0 spamscore=22 lowpriorityscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 mlxscore=22 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160075

On Sun, Sep 15, 2024 at 05:15:59AM -0400, Steven Rostedt wrote:
> 
> Can I get an Acked-by from the S390 maintainers for this patch?

...

> > +static __always_inline unsigned long
> > +ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
> > +{
> > +	unsigned long *sp;
> > +
> > +	sp = (void *)ftrace_regs_get_stack_pointer(fregs);
> > +	return sp[0];	/* return backchain */
> > +}
> > +

...

> > diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
> > index ae4d4fd9afcd..cda798b976de 100644
> > --- a/arch/s390/kernel/mcount.S
> > +++ b/arch/s390/kernel/mcount.S
> > @@ -133,14 +133,15 @@ SYM_CODE_END(ftrace_common)
> >  SYM_FUNC_START(return_to_handler)
> >  	stmg	%r2,%r5,32(%r15)
> >  	lgr	%r1,%r15
> > -	aghi	%r15,-(STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE)
> > +# Allocate ftrace_regs + backchain on the stack
> > +	aghi	%r15,-STACK_FRAME_SIZE_FREGS
> >  	stg	%r1,__SF_BACKCHAIN(%r15)
> >  	la	%r3,STACK_FRAME_OVERHEAD(%r15)
> > -	stg	%r1,__FGRAPH_RET_FP(%r3)
> > -	stg	%r2,__FGRAPH_RET_GPR2(%r3)
> > +	stg	%r2,(__SF_GPRS+2*8)(%r15)
> > +	stg	%r15,(__SF_GPRS+15*8)(%r15)
> >  	lgr	%r2,%r3
> >  	brasl	%r14,ftrace_return_to_handler
> > -	aghi	%r15,STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE
> > +	aghi	%r15,STACK_FRAME_SIZE_FREGS

This does not pass the ftrace selftests. Please merge the patch below
into this patch. With that:

Acked-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 7b80ff4d3386..df5a0f8d3445 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -78,10 +78,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 static __always_inline unsigned long
 ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
 {
-	unsigned long *sp;
-
-	sp = (void *)ftrace_regs_get_stack_pointer(fregs);
-	return sp[0];	/* return backchain */
+	return ftrace_regs_get_stack_pointer(fregs);
 }
 
 static __always_inline unsigned long
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index cda798b976de..10b08e617306 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -133,13 +133,12 @@ SYM_CODE_END(ftrace_common)
 SYM_FUNC_START(return_to_handler)
 	stmg	%r2,%r5,32(%r15)
 	lgr	%r1,%r15
-# Allocate ftrace_regs + backchain on the stack
+	# allocate ftrace_regs and stack frame for ftrace_return_to_handler
 	aghi	%r15,-STACK_FRAME_SIZE_FREGS
 	stg	%r1,__SF_BACKCHAIN(%r15)
-	la	%r3,STACK_FRAME_OVERHEAD(%r15)
-	stg	%r2,(__SF_GPRS+2*8)(%r15)
-	stg	%r15,(__SF_GPRS+15*8)(%r15)
-	lgr	%r2,%r3
+	stg	%r2,(STACK_FREGS_PTREGS_GPRS+2*8)(%r15)
+	stg	%r1,(STACK_FREGS_PTREGS_GPRS+15*8)(%r15)
+	la	%r2,STACK_FRAME_OVERHEAD(%r15)
 	brasl	%r14,ftrace_return_to_handler
 	aghi	%r15,STACK_FRAME_SIZE_FREGS
 	lgr	%r14,%r2
