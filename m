Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFD199237;
	Mon,  6 Oct 2025 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772875; cv=none; b=q02mh5Ly0A9w8qQRsSf6nmVqqb/NJuG2zaiz/ZrXFbZ1ErXOXen5pqMW10RoxH4XGPLVQQJDoO7uZ3DaH4m/t6ttKZGuk5Bmz2tJr4u9AqCa+7uaRaNff2ZxIEkDfB3UV4Rzn8Af14E3CDuw+5rXJFLAjiywiYCNddSCmED6rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772875; c=relaxed/simple;
	bh=fs9hUfEVexxAfYpjTyITTLJDNYflHPxV0GaTNmPv45g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWyiGMQFACCVhnFoFQjfHXFkagJWeZ/cNEj2aaWdBQ52kqbndLa4e5MOc3fLL4sq/6icOq5Fo+umzhmlfrxl7vbnkQG5g5klPIo+XfsQWrH8LmGMEU6TAYP3V7oOlZSaMjEcLdFnTbvj7h1vjHuOXZ+eZ9m1NJhUEv79psRtO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s5nPKJxX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s5nPKJxX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596GOgPg017742;
	Mon, 6 Oct 2025 17:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=y650WnoV6UlxEDnN3qJMdVFPuu8AtV
	zw/0GeglG768Q=; b=s5nPKJxXUPu6ahyAFV79OwrYQYaYZQsz6m3mw6BlZnSUaS
	RVT2sncbFNrLLYTbiJx9vuzVKrCTV0pEGTkXSYqph6+/ih1uAv0GUNzjQOCI0Wur
	S1i+IMfup4tQVwIY7VH2ht40Z/duRXQaXrEMLP/vidziLwTjmCsprGjDqgArYvkF
	P9tgY1av72W7mTVbvUzV6ebM3qQwH7phBp+3Qh8UGiyWruEsSI4vLY5eL/34ChqG
	GAxODZiPTco/o3jccz16c9sdIMm9KUuoH+qd3i71kLDNpt3X1WPdWM/4iiGvzbuY
	kJ1xQ2KYEbgTAnGJld0KBPmoTlbaKFMjmlL3x9jw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju93as0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 17:47:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596ESFIe021174;
	Mon, 6 Oct 2025 17:47:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kgm171mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 17:47:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 596HlgLN48890170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Oct 2025 17:47:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2AB020040;
	Mon,  6 Oct 2025 17:47:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26E5A20043;
	Mon,  6 Oct 2025 17:47:42 +0000 (GMT)
Received: from osiris (unknown [9.87.137.121])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Oct 2025 17:47:42 +0000 (GMT)
Date: Mon, 6 Oct 2025 19:47:40 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Alexey Gladkov <legion@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ben Copeland <benjamin.copeland@linaro.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: next-20251002: S390: gcc-8-defconfig: symbol `.modinfo' required
 but not present - no symbols
Message-ID: <20251006174740.13659A33-hca@linux.ibm.com>
References: <CA+G9fYvVktRhFtZXdNgVOL8j+ArsJDpvMLgCitaQvQmCx=hwOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvVktRhFtZXdNgVOL8j+ArsJDpvMLgCitaQvQmCx=hwOQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4Vcvnt5Z0hm-q6z5TxGQIzN7HBiCKIvx
X-Proofpoint-ORIG-GUID: 4Vcvnt5Z0hm-q6z5TxGQIzN7HBiCKIvx
X-Authority-Analysis: v=2.4 cv=Fec6BZ+6 c=1 sm=1 tr=0 ts=68e400c3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=Oh2cFVv5AAAA:8 a=21D8NHQQAAAA:8
 a=KKAkSRfTAAAA:8 a=5jmsZD25J3Aw2ox8uuIA:9 a=CjuIK1q_8ugA:10
 a=7KeoIwV6GZqOttXkcoxL:22 a=aE7_2WBlPvBBVsBbSUWX:22 a=cvBusfyB2V15izCimMoJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX3QPbcpTlPtbx
 mH2t5fQ3iCfOvxGb+ZQinKFkHn71EHnt/vpXxmJISi/YUAOXZRdQ7p2KK2Tv9sDW4LTbu7/LIBK
 j91pxdcPkcEoRCqYr2Avxg4/OmRdIYDLdLTGu6Bti/2tYVwwAlhDLVf+19ux3vGNP1bocGsx5nU
 mq6MvaTYSlajnYl9TXT4eI+beOxmJh377jCDv8ete4k16mv53BaQbjj9FIoC6qmvIlhZDQmjrMd
 ef27oJ9O5uyNM9kEFAv2XI4g/XBUBpsLBM/DhrKOHT58vSyxkMR1RdrTl2b4kmRzIrz1I2hKsnW
 oVIEIAgGeBDGtOhFZZ0PEkFKW0N5XTDyjOxgZ63MCh5sKHO+OutK4pqI3wnq/AdRMxLrSz2m89g
 eENH/iXCrs3mEVnJ8rRt/l1YxcEjPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

[full quote below, adding Alexey and Nathan]

On Mon, Oct 06, 2025 at 04:55:56PM +0530, Naresh Kamboju wrote:
> The S390 defconfig builds failed on the Linux next-20251002 tag build due
> to following build warnings / errors with gcc-8 toolchain.
> 
> * S390, build
>   - gcc-8-defconfig
> 
> First seen on next-20251002
> Good: next-20250929
> Bad: next-20251002..next-20251003
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> Test regression: next-20251002: S390: gcc-8-defconfig: symbol
> `.modinfo' required but not present - no symbols
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ### Build error log
> s390x-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section
> `.got.plt' not in segment
> s390x-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section
> `.got.plt' not in segment
> s390x-linux-gnu-ld: vmlinux.unstripped: warning: allocated section
> `.got.plt' not in segment
> s390x-linux-gnu-objcopy: vmlinux: warning: allocated section
> `.got.plt' not in segment
> s390x-linux-gnu-objcopy: stM7JmYX: warning: allocated section
> `.got.plt' not in segment
> s390x-linux-gnu-objcopy: stM7JmYX: symbol `.modinfo' required but not present
> s390x-linux-gnu-objcopy:stM7JmYX: no symbols
> make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error 1
> 
> 
> ## Source
> * Kernel version: 6.17.0
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
> * Architectures: S390
> * Toolchains: gcc-8
> * Kconfigs: defconfig
> 
> ## Build
> * Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/build.log
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20251003/build/gcc-8-defconfig/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/config
> 
> 
> ## Steps to reproduce
>   tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
> --kconfig defconfig --kconfig-add CONFIG_DEBUG_INFO_BTF=n

Isn't the above exactly what is supposed to be addressed with commit
8d18ef04f940 ("s390: vmlinux.lds.S: Reorder sections")? Or did something
change with the commit? Didn't check, and might look into this tomorrow,
but adding Alexey and Nathan already now :)
