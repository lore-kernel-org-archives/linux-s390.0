Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298918A6D4;
	Wed, 29 Apr 2026 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449900; cv=none; b=Q1LqGYHLWQ4W9Co99J8S3N38OgSfExsJImS/2DqyRNO6uVKeIf94cmoefYaKRutAkmkcxxi1G5gV+FdLUqZEDQ4grpUCiOpLKNfZUBUKCRZnaJ9pJ5/0Z6MK2vIK5CcGLv4lJNWgakYxLdaYaubGU1c/AQV7FGrx4M6xNaQ7a5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449900; c=relaxed/simple;
	bh=nXO1cC9gtjELLGuxPyqb2dgVjOqts6QjJqJf+Eejveg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9oBTW0GuzFUu6nbIGLMYFe1w4I/XO81QwY+vlqolbWvew5iLCOYKtg3rdr1uTRAJ2BOMcAaL389HE9EXZh3us2sBSjZiqc8ajOqr2+oabIf28WRUQQLzVCQXZ+PCsFLnhbt+zz+4RbSLdLqZWJxzf0PpHdTqqMcuNLURzuAZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IDp8K2iR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IDp8K2iR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2hix41679188;
	Wed, 29 Apr 2026 08:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S7NXX/
	gV9JLML/8MaMF7KkfY+fqdAB+RUfgOHZBHuic=; b=IDp8K2iRjMH/j2pduCHme3
	kusq/o40Xyw5AdKI2e//HxCLzNE2huKM5NBO6DUhw8N++hOS7pKYte2lejapBD7x
	oJ+5yFEnvdvngvpPGQBWtMJD0hNQpElN0fnMGo8kOHQokC3818RK1uPmMsn4F0Ag
	vappg4zs+Zd4rRdKHtQXAaZf1FLzC4yDt+RZfnTOFtIQ8fuqgTqlYsHHm4qqPlek
	8xJGj2nCrhFVlk+3v/nvb0VsBRtTYEjCuAjenK/Jlk0erhmgwSY0oZH27tcLmrCU
	tkwuWiMeoy9B9acv1K8xcv5i9aEp3UdQsJtT+x2XmuF96R1pJVjcrOKd6rAtj+7w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44shef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 08:04:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63T7s2Sh020257;
	Wed, 29 Apr 2026 08:04:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehdbda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 08:04:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63T842qR31851040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 08:04:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09BDA20040;
	Wed, 29 Apr 2026 08:04:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A62BE20043;
	Wed, 29 Apr 2026 08:04:01 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Apr 2026 08:04:01 +0000 (GMT)
Date: Wed, 29 Apr 2026 10:04:00 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 04/28] arm64: Provide arm64 UAPI for other host
 architectures
Message-ID: <20260429080400.536931-A-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
 <20260428155622.1361364-5-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428155622.1361364-5-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 34_Hc6C8hpR1w0YGE4xpg5uWiTi7zAfE
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f1bb77 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=AvxnFSxSGNjASAhgYNEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 34_Hc6C8hpR1w0YGE4xpg5uWiTi7zAfE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA3NyBTYWx0ZWRfX/BR9bvAsu6SP
 rnSPINincBDahvVVTXISjI8c8IQUKYiHkTL2yr1b9ycpxCIn+EWZBPpUSGr8WIlt+w1cvbOB4yN
 4pZtekGCWY4YhUY/45+X0AmbLinomFM+akTnvPiwolQ4YpGqEwi6YNQZar+uTNuuHqp6gw5jOxb
 UUIHWhqKD9TVMoCXOmxYs9NjRXG+C+1CDG0qAfk4UEtT8x/Kv+EUm5Nxhfps15Tlxuqmj9qNVmq
 rrf4q4IMMPo4BK87UD9Vyg/KGu4SWdFSIxDqblcLNSBTJs3A4FnJrqC8oIzoBO1pBNxp022bIEk
 fLvkFXOAWStYXIDPsDa5ec0MV+L5nRdZCBzjZRda1KNZ7iX9xTXZzw1P4gjdxD6D7BhsDbgHfnk
 HPOKuHbL6LMPXS5FmNUoa6Nz8Bf2Nbl3EPhywgyG2AF2zhgDvQpY0nVQa8QHwU75cj1PnGoUbfd
 pMgSY1JkXjk0BtV4qBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290077

On Tue, Apr 28, 2026 at 05:55:56PM +0200, Steffen Eiden wrote:
> Enable the ARM64 userspace API to be used on non-arm64 host
> architectures, with initial support for s390.
> 
> The arm64 KVM UAPI headers are relocated to include/uapi/arch/arm64/,
> allowing non‑arm64 hosts (such as s390) to use the arm64 KVM userspace API.
> 
> To achieve architecture independence, some type aliases are introduced,
> which conditionally resolve to native arm64 types when building on arm64
> or to fallback to ABI compatible inline struct definitions on other
> architectures.
> 
> The build system is updated to install the moved UAPI headers to their
> original location but in and conditionally export arm64 architecture
> headers for s390. This infrastructure enables s390 systems to host arm64
> virtual machines while maintaining full compatibility with the existing
> arm64 KVM-UAPI, requiring only minimal, compatible changes to the arm64
> UAPI-headers itself.

@Will @Marc

I think doing it the other way around for the UPAI here might be the better
approach with less churn (esp for arm)

1) keep arch/arm64/include/uapi/asm/{kvm.h, sve_context.h} where they are
2) mark them as shared in the include guard similar as in the symlink variant
3) for s390 (and any other arch that wants them) install the headers to
   include/uapi/arch/arm64/asm

The only thing I fear with this (and also the symlink) approach is that it is
easy for you to include a header that we do not have on s390. This was the
reason I moved all the headers that are shared to a different location - to
stress that those are shared between multiple arches. Marking them as shared
in the include guard may also do the job well enough.

What do you think about this variant?

	Steffen

<snip>
