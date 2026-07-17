Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49938E8B7;
	Fri, 17 Jul 2026 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283617; cv=none; b=sy+9hGMwH1l4vUsTypuVlZlmosCgGbiAk0IUrHL0vS8yx60NoHcIsH9oEBKvpdhhT/b8/XSzpSjpFkll//ujh/mSwlKslykJ/0cHhpTqeprJOD+NNSWj1rHSSoN3ltBpye0sQWkb4FTcooIz/W+tHOssGbc39LgHwji6UxL4sjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283617; c=relaxed/simple;
	bh=4jHJbu5xS30U3M8BoRo2FzejAHrKWrbPOs9CtjuJfDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDzFyQAxzZ8hIy+wuu/b94QjE116oBu1qKPZPZt3MCIWFkB4yCkSerFgktNRA0luF2rQKM/NKGl8qdxDHt/tMp3L9IINgms1FUPYRSXtZpiPim93p3ZFusu3Xb+811KcM2w+9lITV851C8Y5NJ3swz/NRzppZ4138PTmyGtzgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nej3+8KQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nej3+8KQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6g4k51293177;
	Fri, 17 Jul 2026 10:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CwZcVkrqIcp8a5kHPE4bSh5sot1ouY
	j24Ca+iwy9sGQ=; b=Nej3+8KQVFvn/mv1VhDDTjqcnDKe0POZW8PxRDEVuhgrnQ
	GcQv26lEgNLeZGliN3woXXVzQD7Y8ceTu/cK+/VowjLhWBCYSx+z/K5mW/qq0mEv
	llUofZD5NuxfI2zhmhX+TX+q/MU0+3CQCcp7N4cFgJNdTpEUyRBW0sVg8Q8uQOdF
	kijGMtxxR6gsL0RbCAkPl4bBrzpHTJ10ofZLD6QonVwT/uHJACJynjMtBKT4conm
	h2SbhkOgJ2RXwyfLoBtwFbKIJlOU/P1UaQTZ+9PQ3VYUImZyLBeyuBogDmMpeeCl
	F4l991VbrJsFax4ur8OCi4uyqAKm5guU+4eDmLEQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxww58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 10:20:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HAJd8i007845;
	Fri, 17 Jul 2026 10:20:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhs4gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 10:20:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HAK6sw35455270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 10:20:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8BB820069;
	Fri, 17 Jul 2026 10:20:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DC2720065;
	Fri, 17 Jul 2026 10:20:06 +0000 (GMT)
Received: from osiris (unknown [9.111.76.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Jul 2026 10:20:06 +0000 (GMT)
Date: Fri, 17 Jul 2026 12:20:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] s390: Add support for DCACHE_WORD_ACCESS (again)
Message-ID: <20260717102005.9583A33-hca@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
 <20260717092415.3039699-5-hca@linux.ibm.com>
 <20260717093632.8E3FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717093632.8E3FF1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7dxmTgN4zT0cKnF1u6NAcoBV21NohAIM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMiBTYWx0ZWRfX/hmd8bvTGnhg
 LJs5a4xU7Ggfvl3hxfHw3QmzYujIWEuHC4ca80zRFIXq66XrZZ3LnH/yOt18VgOPXAIJsq49Uzg
 jW1p4HOYz3oITivjZNTKh0SBeayoGns=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMiBTYWx0ZWRfX2qPAhpjabfm6
 PQim/usaTHftVkFi76QKF7VcuiMLOyi8yFU5y39x+l6hqvAsun+xIZmTUhvGSTlnKMgOAGZ3AZr
 7nfywzeopLgD+up1sQSm36IWv4b8qBhwCsOUyzYpCCQaG5n9TYZ160dYkAunjmvRiA/pPy4fo5r
 9/4pNWzsxDkFosQwSHKEoD8F9rOlCqDzGVvmgKHfwJU6jx9GzBAVnUPSoRydog3AtKGHjzE/KLM
 6xc8IUNr6+hk+a4VnisXAgEKt/Em9L4ANSxKpqAd/bgwyOO3agC2yq4fl8OYIp7ACUidorwnyQA
 yvchufJJlu1qY/cwwDmSP7DopO4zgU1kJXHZSgL0Ycbu3mFdkSNi+fhW9MHNp4kPxJ+Zx4WhqWp
 8xovOjNnOsAHf4Xa3GzOiXhzdR7zHjeYm/wjxtEFhN6GEr0M2SY3miY1y62kMhjHPu6qoGx7xY3
 dK+emIG4rup/wKw+xqQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a5a01dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=_su_6yxrm-6F5Z5OsgwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 7dxmTgN4zT0cKnF1u6NAcoBV21NohAIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170102

On Fri, Jul 17, 2026 at 09:36:32AM +0000, sashiko-bot@kernel.org wrote:
> > +static inline unsigned long load_unaligned_zeropad(const void *addr)
> > +{
> > +	unsigned long data;
> > +
> > +	asm_inline volatile(
> > +		"0:	lg	%[data],0(%[addr])\n"
> > +		"1:	nopr	%%r7\n"
> > +		EX_TABLE_ZEROPAD(0b, 1b, %[data], %[addr])
> > +		EX_TABLE_ZEROPAD(1b, 1b, %[data], %[addr])
> > +		: [data] "=d" (data)
> 
> [Severity: High]
> Could GCC allocate the same register for both the [addr] input and the
> [data] output since there is no earlyclobber modifier here?
> 
> If a page-crosser triggers a terminating secure storage access exception,
> the hardware leaves the result register in an unpredictable state.
> 
> The exception handler ex_handler_zeropad() relies on reading the original
> address from the register specified by [addr] to compute the valid bytes.
> If GCC uses the exact same register for both input and output, the handler
> will read a corrupted address from the clobbered register, dereference it,
> and cause a kernel panic.
> 
> Should this use the earlyclobber constraint "=&d" for the data output to
> ensure the address register is preserved during a terminating exception?

This doesn't make sense to me. Secure storage access exceptions are
nullifying per architecture, not terminating.
