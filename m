Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD823ACEF4;
	Wed, 27 May 2026 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864808; cv=none; b=FZ3BNdaX9SrlvNKxZkTJKm7ObAGCcLmv3Y5CL0X9EUbFmXcclAVcaDZiL+jpT6niBWMivdlL7cXDVeKiSfaI2QQNfFiLvXSRA07AehZstwGfhjEb8jJ1FGwsahVvgxR60TbELWCAmy82CJZ4X5/DWO73q4jupdUFRNBALEswwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864808; c=relaxed/simple;
	bh=d2R1H91fNLkqSza84056w8qfZIvzeQx2hakQ9uJpA0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwS5mCaexYC3aCtCvrarWxpS4fjIViRwtvO9rwjWR1mOTHgo/ePEl8kk4fjgU1AWIUAmugK80bFL891MV/rBpFHHlpLboA2YSav//MQP4pq6Q+VS3pfBmPsJWn7fvcsyYDpJGIe52rVylKzXnDkcYfj1Zqr6unRFpaahPhLoSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o4QLNWaj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o4QLNWaj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4Rfq3850810;
	Wed, 27 May 2026 06:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=p5elBc1Qqt+iimqWQMPDYYjmJowPli
	jbVxwIpfew0VA=; b=o4QLNWaj6Mcqe0Bj5cglMNORn1kk8AfeKZKIXdalZsmpb0
	YhkOX7R2LC8kanRYgkRsCCjm9A+tI0uJ6UBGtsDKKpOawO82X/fgvgTeJs7/k/li
	i5IchHX6qDGSHF/0dqcYo755A88bJiXKc4wRwjsoUZUdmQjDSOlbzbw3SOM3QpKa
	0iWroEm59bMHACpqhmCEIrowEzoHrPdVWmMwAHUbXvZHyULG4Y1N5cN7t4VjYI+A
	l8JkLUQ1qcBQECHkcZxqE9w7Bd0WT5tMVThxQaf6coWhNrDPBuLCh0Z4bCu+fl2K
	c50tDdwwht+wodVPnkHrHu6YvA9GYPO6v4uv+adg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pdevgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:53:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R6dDFP010874;
	Wed, 27 May 2026 06:53:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb1t88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:53:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R6r4CX30999242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 06:53:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ED892004B;
	Wed, 27 May 2026 06:53:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3F4D20040;
	Wed, 27 May 2026 06:53:03 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 06:53:03 +0000 (GMT)
Date: Wed, 27 May 2026 08:53:02 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] s390: Enable Rust support
Message-ID: <20260527065302.9471Af6-hca@linux.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <20260521165622.279953-5-japo@linux.ibm.com>
 <ahaIT7BV-gMqcVh1@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahaIT7BV-gMqcVh1@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a1694d5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=n3c56lirc9divvENpjsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: LKrfGc19bWnG7Gcf7zc_awDQIMqxXQLp
X-Proofpoint-ORIG-GUID: 173q5OFg9V13gkDF_9Q4_MbDxrtghJTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA2MiBTYWx0ZWRfX3aLww1h0ZiLY
 ItUxJOUjjO+BjXsFLAn5YXtem8JVoYLvcywyJz1/D8NQzarnDo5wIEHPVfz9cwRGFMQcPavMJTk
 /5j93Jl5kl9xRXIRj97LWeHKuXG0OTLSudPeTlfUWrCIe14aZOtWZK3Yfg93T9QUDO5uR/Fmor5
 6BbBWh7mlY2JHElioxxpQaQ2UiQqVCjnWtNmBxAVW2XsMkjY4viaXoqsJxwDuRHUmpGPuQlMarP
 6ZJkxrLDj5I5MU5Z8YQDP55B3RLrG2pVhhymRzFwv+znNhvCNc5MVPw3RS3Kdea1uzgydR5kCzZ
 FV3P0aDc208dh6BsKBBgjItRxdevcTofsUZaBq4p2GVyOXXi4DnD9W66EksACm9OO57Ev34q8CR
 ZsWjsjtA4gwmK11Fg1qRG89us6ZgKyv2ZBlorH9HFzLs2ACFcBWEfZNf1OGpeUJlgl8sLIyuLHI
 7dd/JxtGXT3EF6Ms2bQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270062

On Wed, May 27, 2026 at 05:59:43AM +0000, Alice Ryhl wrote:
> On Thu, May 21, 2026 at 06:56:22PM +0200, Jan Polensky wrote:
> > Enable building Rust code on s390 by wiring the architecture into the
> > kernel Rust infrastructure.
> > 
> > Add s390 to the Rust arch support documentation, provide the s390 Rust
> > target and required compiler flags, and set the bindgen target for
> > arch/s390. Adjust the Rust target generation and minimum rustc version
> > gating so the s390 setup is handled explicitly.
> > 
> > The Rust toolchain uses the "s390x" triple naming for the 64 bit target.
> > 
> > Rust support is currently incompatible with CONFIG_EXPOLINE, which
> > relies on compiler support for the -mindirect-branch= and
> > -mfunction_return= options. Therefore, select HAVE_RUST only when
> > EXPOLINE is disabled.
> > 
> > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> 
> > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > index b96ec2d379b6..296acf8f71aa 100755
> > --- a/scripts/min-tool-version.sh
> > +++ b/scripts/min-tool-version.sh
> > @@ -31,7 +31,11 @@ llvm)
> >  	fi
> >  	;;
> >  rustc)
> > -	echo 1.85.0
> > +	if [ "$SRCARCH" = "s390" ]; then
> > +		echo 1.96.0
> > +	else
> > +		echo 1.85.0
> > +	fi
> 
> For other version constraints we have listed them in the Kconfig file to
> guard the select HAVE_RUST or similar annotations instead of here. Is
> this the best place to add this constraint?

This is supposed to be the default location for such constraints.

See also the current limitiations for gcc and llvm in the same file, or the
previous limitations of llvm for x86 and s390, which have been removed with
commit 20c098928356 ("kbuild: Bump minimum version of LLVM for building the
kernel to 15.0.0").
