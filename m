Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C3186A;
	Thu, 23 Jan 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628852; cv=none; b=ZgcXaRAY4Dgfj844F22iLyGVDMrHN7T0KRyiCCOqsrSb4Mi8+tegvZnxIwJlbNlBGMcOrJsbzbuFWtYVlnkJqk5OReYc+2QefwxA+pv+xIJDTYcs2idDcmd8+PiOjeD6pNi8b1H0lC2vt41YKwlGAhUt+FJ9qeCrsZgGcELAPm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628852; c=relaxed/simple;
	bh=zrK5Lsbmf+cSiwB66LeyPvHutSUGEpNi7yG5s/3z69c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sODLsiiDIzp+rb3zaKEkNMui5EwLkQv57NvOqoL+dLROrbNH1P2UdZ6sHm/crjCHGKa08iK5mN1T5Megh6BB4Y1KjFPPehNWsm/zEvhHfHfEehHjmuo+6JKlWNVJB3vB2qwPuBRKpxpwNv55S0EoKcbqxKcOLRlsxzukuQODC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oC0kdp9n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oC0kdp9n"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N5O5le026555;
	Thu, 23 Jan 2025 10:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=I+ZNzz7N8uTr/4N40mx78vosGusiXM
	z5qq+Jk6d1y2k=; b=oC0kdp9nXiZ1VZRyscU4OMOuplYOVPw0dwHPmu1pRj2S3N
	Z9rR7Xr6RUkBXsrjHHkUNtQxjq3Zj0PyQ68sIuoTck8uh0LcP7UtVRewW4EGOJL3
	tdaOax/+rByXqcnmrAt46XzJs5zqJORVEevulSswjZM4BWUkbNrDY3Ir5j7dr9U3
	aKdaFLePKdUPvA096ivRm3403dxCQ2AAhCmy+VW6i4u0aT7pEfsVOi46y1lS/EZ2
	LIssj4Gp5vIxisE6JUanJBEZgh8mNx8FO+LnuL9DDnUjOalFRbgU6Xf9zpAnleTs
	wS1LsjLihAo3W1jXGnbUIe3K3eIAbwU9sjtGbB5w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7sdd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:40:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7mxfe032266;
	Thu, 23 Jan 2025 10:40:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujvrvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:40:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NAehZT52232508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 10:40:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BD5F20040;
	Thu, 23 Jan 2025 10:40:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B441D2004D;
	Thu, 23 Jan 2025 10:40:42 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.77.114])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Jan 2025 10:40:42 +0000 (GMT)
Date: Thu, 23 Jan 2025 11:40:40 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] s390: Add '-std=gnu11' to decompressor and purgatory
 CFLAGS
Message-ID: <Z5IcqJbvLhMGQmUw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EZCw6DzQknm-F8NCiHtCYL1NERxZl_cu
X-Proofpoint-ORIG-GUID: EZCw6DzQknm-F8NCiHtCYL1NERxZl_cu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=692
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230080

On Wed, Jan 22, 2025 at 07:54:27PM -0700, Nathan Chancellor wrote:
> GCC changed the default C standard dialect from gnu17 to gnu23,
> which should not have impacted the kernel because it explicitly requests
> the gnu11 standard in the main Makefile. However, there are certain
> places in the s390 code that use their own CFLAGS without a '-std='
> value, which break with this dialect change because of the kernel's own
> definitions of bool, false, and true conflicting with the C23 reserved
> keywords.
> 
>   include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
>      11 |         false   = 0,
>         |         ^~~~~
>   include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
>   include/linux/types.h:35:33: error: 'bool' cannot be defined via 'typedef'
>      35 | typedef _Bool                   bool;
>         |                                 ^~~~
>   include/linux/types.h:35:33: note: 'bool' is a keyword with '-std=c23' onwards
> 
> Add '-std=gnu11' to the decompressor and purgatory CFLAGS to eliminate
> these errors and make the C standard version of these areas match the
> rest of the kernel.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
...
> ---
>  arch/s390/Makefile           | 2 +-
>  arch/s390/purgatory/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!
