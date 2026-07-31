Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F643C4562;
	Fri, 31 Jul 2026 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497753; cv=none; b=TCdEQUJ8twpoi6Sj4ZDhv4HGZi3mzjNSSKVJhIkBp+AWFHGXhbv3vb3JRDhVg2Xq1uEYYO7mpfQsF59ZiKGiObXZXthA89Svw6wL9VlNOtPh/MzO/AtuzQmWRVpbni7sloewK430L51TldGDTVMjhU3W/6mJdj+eOqc+N5yd/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497753; c=relaxed/simple;
	bh=ZEnn4WmQmKAI8sHaa1voIHm3tmdCq7iMx5mxhYf2aok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8UVLUPaBGu6b4NU60FHWsv7ewn+Qx4b0oIHhYuV/Jt8UAJediHUZ/oT6TyTvs5OySlBYirSY3jUXBxqp5x/x4EACEa2VeXWKXPxJbImCHCRKezNJxp5aKm7fC7Gcz22txJS2g8V5rmu9GuPwX/G/4XcnycX51c8Ll+5WJBo8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n/Oxvwcl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n/Oxvwcl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8I7743630951;
	Fri, 31 Jul 2026 11:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UczLz+y9JDcwKHO6WRrGOu37PzSf4Z
	qpbe7gTtmLZFM=; b=n/Oxvwcl7gk8rkJmIN3/HQYVHALbcY/zjlaCXe1xnFtmtV
	8vuNJqd9aHCnc+nDpTq211483QR6Nnd8umg0rwZ+VCaxyHuxV2kMqB/kDwU0Xu+W
	Y/DgkDzHKDJL2fT9YVgWszsLlCXxiox3TwQmCjohTq9sIUZwb+yPvkwD1tdJTOkG
	17KrUuOSC+vpMh7vsRFWyvciUC+HtdN9/ZByaWHiJ2ABCi+W9OUiXe1pTG/mfz21
	bETz8CqPGxzrGr67iA3u7urohdfUC32+dGWyttcxzPHdkDTf+3zZUgFNvp/wnWuY
	N1MLSmRIBwkXW+cEYKNF/ofnLTTuwSEc87cAH+1g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycvpgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:35:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VBQj50022323;
	Fri, 31 Jul 2026 11:35:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqgx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:35:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VBZT3L29098492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 11:35:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A5F820043;
	Fri, 31 Jul 2026 11:35:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DADF20040;
	Fri, 31 Jul 2026 11:35:28 +0000 (GMT)
Received: from osiris (unknown [9.111.91.157])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 31 Jul 2026 11:35:28 +0000 (GMT)
Date: Fri, 31 Jul 2026 13:35:27 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, llvm@lists.linux.dev,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] s390: Add kCFI support
Message-ID: <20260731113527.8638Ade-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <20260730231317.GA2423962@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730231317.GA2423962@ax162>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: O-s-9cx409rLfs3zvVfFHrgQoilUdFuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA4NSBTYWx0ZWRfXx2XNXH7cGIMs
 lYv97SCQCafug3lbM2l7FugJlkLcx0E2CyHzB5YKWTy2G3AsL0szo3haKiu/A50b/6HsdfyEghx
 Ra1B+LZ0SbH2r6wudzWhL8oey83xFGIBl78PHV/9NystPfhb8zIscJkxFBs/XzXWXqicdh0N3WE
 8oWGJzJLetqZTXlK3jW9miuCpOCdVh/pdG4Y+qQ0WTplyCFmxccVEx5+7jw/UxL1f5LSaL6uhag
 GQu8ed2kjB/TsJB437upF1H5tCI3jYB+OyHPMHGoNhy6xd2m4jTR/dNPfJfcwNIbkGWuW2CNNeE
 /XGZC5PMSxhOgYs1LCgss2+HAPOW/5a9VZtVi0oRB/8scKOiNeVAs3H90KuZ5QMgKvHxvuPT5/g
 3HFw1px2bpPzB/pkrd9w5pJZeCVnmKvPDM+SqxJpFgDVt4Xk2szfct92WCVNnzT/+Kl4+Cx4LH/
 zcB781EjmLnT1OqHpqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA4NSBTYWx0ZWRfX2M6yMXeAl32K
 cSudhB0GRyt4k20xftFbdj+f+kPwTUfIOQu0KKgmoZMjTgE53wx6w5eTmpZMwZ6hLYfZVaJG9Wu
 6Ur8hhAguoTQzrZAETbHnOKBxlICyKY=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c8886 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=-nT90WUhznJSjK878QMA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: xm3HIybxnMdWNVlq31DFn1JvRXPHtsa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310085

On Thu, Jul 30, 2026 at 04:13:17PM -0700, Nathan Chancellor wrote:
> On Mon, Jul 27, 2026 at 04:05:07PM +0200, Heiko Carstens wrote:
> > Add s390 kCFI support using the generic support provided by clang.
> 
> Yes, getting coverage over s390 specific code and drivers is worthwhile,
> even if there is no architecture specific expansion available yet, since
> most problems should be visible with either implementation. Getting that
> sooner rather than later would be nice to avoid the panic when a CFI
> check fails and make debugging easier but we will take what we can get.
> 
> I tested clang-18 and clang-23 with defconfig + CFI, which both properly
> fails the CFI_FORWARD_PROTO LKDTM test. I built allmodconfig (which now
> includes CFI=y) with both compilers, which showed no issues.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks a lot!
