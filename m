Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DFD23BD1D;
	Wed,  8 Jul 2026 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514831; cv=none; b=pae4dpb1XbJ+bPvfnszy2k2X6Kdpm6u2JfMBazQZB+b/6WEsgnklM7SJn/FxNi4j6gNAjJ/ZkojbJO8n9h1Gs6pf27wWKmAnyoXk7aBfyaGFsuaeAlU75Zhp88cH/m5mvaKjwHWcPPLkoVaaFD3FkwiGJ+k5d2kvujZdP+ek4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514831; c=relaxed/simple;
	bh=Il163L430DNSTI7nJBzgFtK7rLxoJBPeA5CQIqod/UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvmtY5MI9FMvmIYqHHA98kmJ8TKcSoJcvfqkklzf391PiZy+uWTiweJ9UBLlscF9Iyeda9ZpksfME+VmhKo5ByJcUoTbuwdTlvg0aNfdSDLq0FLeZ3qddrnT5IgPbCskHq4//Z7vN6RSfjnHrgpwbUfNswTiX4LpiYLqfx/ry4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lxip59Wo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lxip59Wo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CIQCc3243353;
	Wed, 8 Jul 2026 12:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pa8MdNpUtg5klv5oBvoGlluIYVcCPQ
	G5XFnrt23NvI8=; b=Lxip59WoJwY3NwENohKUShEmDroTLOYPxrwDZexnAgGheG
	yW/DAEEZ9yEw6g0SIbM2qk5mXlifyDoznB3IN8UG78+yIw6rC0wU2p4JQX6kyNI3
	2N9ucjwUoSndnfjB1lErn97dOSn0eOIkBSrvTMCxSScrpx1FA8/72dLGV9mMpV7s
	BwQ/hlXAWnBhj0FDUqKiK9HT5I8RQet6aTdQwqOfX8oa/SyCsYiZfsCdhpZd0QWV
	T4MsicfCKMVEImgrlEGjGwOrJQo4bHkQMTZ8DvjGvjdyOx6rIkexF72ahpn2SrRs
	eN2NeHvjR7R/urELp+oLTcd8lXx4WMPFXzXao/jA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3vey6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 12:47:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668CYhiW002602;
	Wed, 8 Jul 2026 12:47:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg7t0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 12:47:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Cl2eH28049864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 12:47:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 819CC2004B;
	Wed,  8 Jul 2026 12:47:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6693F20043;
	Wed,  8 Jul 2026 12:47:02 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2026 12:47:02 +0000 (GMT)
Date: Wed, 8 Jul 2026 14:47:01 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/uapi: Remove obsolete unistd_32.h from Kbuild file
Message-ID: <c8182a6f-6196-4389-936d-23d8f9cd1891-agordeev@linux.ibm.com>
References: <20260701134727.882734-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701134727.882734-1-thuth@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4e46cb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=hYLWXru5GXBysA_Rh0gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfX88T1SAQeZSrH
 xDERXzoCBnnG+YkNJ99GOP2f0Vv7SecmgPwy0H862QGFMcHFxdg3idk8iMr8FVkfVcIp72IjMxp
 5Z3h+RoKVc08hS03+vhmp0bJAusaZ20=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfXx049CGchplPf
 RcEGuGKGDUP64cl9g/3ODLigpm3bqYfdamry0YC1f14qRTGcJu6BcxId/BnvAN9KEeemdF7FVH9
 66wc/L59Wyr72q3OR21MXN2dDrpz/L+pYGPlBkJ3Ussb8PuqZ4unbcOCPcYg8H1+32738+ufjyJ
 V+yz9WpUWhfcPfMf9w/GrQsfGPwoplNumzSa/lp1KFrieQEVrr0cmE9W8jgfUOwXBzbFa4fBAcU
 f9j1AZOsNrxhysDm5a0kqeI8V7dbc3DsuOXDr3QSrsWZzdtoeTG58chAO/GWD7jARZy3hRFp4kq
 mniAuurXgS2152DeSuQvbjPPU7RY5I+RuygEXiq1obxSxB7MyUZojIC2lM6/rYj9D6M+Xbi2XhC
 Szyd92x27+vp5LK4Ei9YelbRiG/rUQXzUTJ6176A4SMI+hGu3ZFGvfS9fNjMycMRyRzDW3hYFSy
 736KhzvQMvmpLfyfkfw==
X-Proofpoint-ORIG-GUID: q2ohNmmsKANnZdIJpmU580apuaSuvxsm
X-Proofpoint-GUID: q2ohNmmsKANnZdIJpmU580apuaSuvxsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080120

On Wed, Jul 01, 2026 at 03:47:27PM +0200, Thomas Huth wrote:

Hi Thomas,

> From: Thomas Huth <thuth@redhat.com>
> 
> unistd_32.h is not build anymore since commit 4ac286c4a8d90
> ("s390/syscalls: Switch to generic system call table generation").
> Thus drop the superfluous line from the Kbuild file now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/include/uapi/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
> index 46c1ff0b842a1..378151cef3cce 100644
> --- a/arch/s390/include/uapi/asm/Kbuild
> +++ b/arch/s390/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -generated-y += unistd_32.h
>  generated-y += unistd_64.h

On repeated builds it results in:

  SYSHDR  arch/s390/include/generated/uapi/asm/unistd_32.h
  REMOVE  arch/s390/include/generated/uapi/asm/unistd_32.h

A complete removal would require changes to arch/s390/kernel/syscalls/Makefile
at least, but we still  might want to have unistd_32.h around.

Thanks!
