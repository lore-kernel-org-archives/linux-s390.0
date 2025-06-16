Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB216A956;
	Mon, 16 Jun 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082953; cv=none; b=LPsww8fsugVe1PHS93U24tbs1QVtdgdoWtFVmOF8Rm10zw2xUQ3AA5j1ICfh4YmLoxHb9+gWN1FCI8oKFUqFG98ZMTaGj2IXpzdovj785sC9xtuX8R0w8FxjUDeOFEhHsTJjwaPbtKmGxf8DaitzU/X0pQick6qWes6vf2m6whg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082953; c=relaxed/simple;
	bh=JGlrsGxMAVB61k3IHK4i5f7dJXbRm0MHTP1SGNIDHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8GiQ2F/NOa84PR+Akz+4X6ChbRVxcMDOR4jk2ni8N/9IfwTtJIhJ3VB4Ak8/yCaASid5f7d8iDO83d04jyEJUX2cTgbTV3KxBh9uaopjcBmGdvVP+s6aBm/cTQe+9I4W4FBf+yh+CfjWG8tdqRGif5lbRWl+A1Lx3cLMz1elvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MGvjBL1n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MGvjBL1n"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GAb3cC002457;
	Mon, 16 Jun 2025 14:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cUCDOQp6K7ZdwBwnzZfkPQY+UbCZKp
	6tcV0BZg7HRvc=; b=MGvjBL1nV5Pl8q/QdnPZYagwO2si4Onj9N91io1HMHR34S
	zuzFGa6SB8tedgv4fv4qveqK6/Ol60LuR8D3uH/ziT6zMbhn0QTAA/+0i543dQH2
	o3u2Ia2d9bG5oG67Y8n3bH8vu5oxSeXbVTTrzXct5z5OK7vYX8ODais5sVAxOO4H
	OnVfQK6H+M/1SrGsoAMVwyItKk3zEwKDetjVDwOrzyso1emK7oZC4f86EQ6AxK1c
	zaa3FAaA0zNhar31MMx2vlS03qEKqM38mAsd1/I77ca0POzHEj7CPgvN5Wb/lNze
	GiJpNTvWgL+73MBMZU2E9McxAPs2FvQWK4jVIMxg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r1sxw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 14:09:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GC97rB027466;
	Mon, 16 Jun 2025 14:09:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479ksyphx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 14:09:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GE907235848946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 14:09:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F380D20043;
	Mon, 16 Jun 2025 14:08:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D19720040;
	Mon, 16 Jun 2025 14:08:59 +0000 (GMT)
Received: from osiris (unknown [9.111.21.197])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Jun 2025 14:08:59 +0000 (GMT)
Date: Mon, 16 Jun 2025 16:08:58 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: next-20250616: S390 gcc-8 allnoconfig mm mempool.c In function
 remove_element
Message-ID: <20250616140858.9423D47-hca@linux.ibm.com>
References: <CA+G9fYuDOnN6TrcVYcMZT5UPNc34mOHQZsfyFvpq+Ndhz8p48w@mail.gmail.com>
 <CA+G9fYuu5r34=bndUYWNxe_yLgBaPGXmK9WP3WTtoXMs_2LX-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuu5r34=bndUYWNxe_yLgBaPGXmK9WP3WTtoXMs_2LX-Q@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vgt6nU4y0AEk9MX8uSkJwrQqWUmdS313
X-Proofpoint-ORIG-GUID: vgt6nU4y0AEk9MX8uSkJwrQqWUmdS313
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=68502580 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=7zJU5eA7aM_5DAGN9CsA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4NyBTYWx0ZWRfX6cbi7BPfbX0L 6LwkanaVTogzD5mJ1YVM4XeTgHmSQSli5YLUcp95mY3K0kwQdzvIAfutKxLLLzQyIal2gQEqtKJ 6RbjBLNL/E1buUQRgahki9fZ64/DXwBeOqp9k16FRHWBQfG54OssCVD2rCEd0z08m8aUdCeQGOW
 jDNDfw270DRcwFTdl+C+9mOtP6rbKOn3+wayL+uxy8h8OhqovYHYMaPb3beA0dxd0m6EPGX8wef Jng6Pe4JoJqQuMWwbL2jKhxmJQd29T5QqDuqkdtz1ixhcjwezLEBmUzVq3K8I7D+vGztqT9N/0+ nF5CHm/X0vjnuSZ46T9kLMhelIzF/RDsz05A5ILK/3vZrTgsXyneKDdq2QEQBNB7V/8RUY5dxVx
 RkjvHEU1JV8HqHB+V8ajiM+/Uti7hOWbva7aK2dAqFvz+ux3ivs2I+BoWSd4zkwXk40jJs3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=457 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160087

On Mon, Jun 16, 2025 at 07:06:10PM +0530, Naresh Kamboju wrote:
> On Mon, 16 Jun 2025 at 17:36, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > Regression while building S390 with the Linux next-20250616
> > with gcc-8 the following kernel warnings found.
> >
> > Regressions found on S390
> >  -  build/gcc-8-lkftconfig-allnoconfig
> >  -  build/gcc-8-lkftconfig-hardening
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducibility? Yes
> >
> > First seen on the next-20250616
> > Good: next-20250613
> > Bad:  next-20250616
> >
> > Build regression: S390 gcc-8 allnoconfig mm mempool.c In function remove_element
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Build errors
> > mm/mempool.c: In function 'remove_element':
> > include/linux/compiler_types.h:497:20: warning: asm operand 0 probably
> > doesn't match constraints
> >  #define asm_inline asm __inline
> >                     ^~~
> > arch/s390/include/asm/bug.h:12:2: note: in expansion of macro 'asm_inline'
> >   asm_inline volatile(     \
> >   ^~~~~~~~~~
> > arch/s390/include/asm/bug.h:43:2: note: in expansion of macro '__EMIT_BUG'
> >   __EMIT_BUG("", 0);    \
> >   ^~~~~~~~~~
> > include/asm-generic/bug.h:77:57: note: in expansion of macro 'BUG'
> >  #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
> >                                                          ^~~
> > mm/mempool.c:149:2: note: in expansion of macro 'BUG_ON'
> >   BUG_ON(pool->curr_nr < 0);
> >   ^~~~~~
> > include/linux/compiler_types.h:497:20: error: impossible constraint in 'asm'
> >  #define asm_inline asm __inline
> >                     ^~~
> 
> Anders bisect this build regressions and found,
> 
>  # first bad commit:
>     [45c79ca947c936085c94b716be92eaf9a1bdc8bb]
>     bugs/s390: Use 'cond_str' in __EMIT_BUG()

I'll take a look at this tomorrow. I guess the easiest "fix" is to
change the s390 bug code similar to arm64, so that those problems with
inline asm constraints cannot happen anymore.

At least I hope that will work. We'll see.
