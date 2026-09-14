Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD22931D5;
	Mon, 14 Sep 2026 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403976; cv=none; b=Ca4k+yUsI0ejAuBca+8Db/ZTQHDRGwCXFpPlPLy6C3mnzNi94nxrLcw60xxzsYMc7m38NKjyykY+pRgKKsn3kqwB5V82OEuPBYlaZ+vUltJf0NDJO5lnjUUraPpIe8wjZH0N6alSVjjacdCCJa9585TGus8mFj4Ok4HVlm7sRnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403976; c=relaxed/simple;
	bh=MDCS+DwBBvZQVCiQHghds8MAclp3nTVy06BtXhXknfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8jt9DpCVSCMOC4Ou5pwWvuLsFBsjTK0yoJQVJbSDxCdImFkBJ2oetiuBgMj8jZJFCGcGeL6388jl9mtNVuKrmhcVnkgNuIVS7tP7axNPuXTdENjO3ZwddjUAeCfhd8npP0pk1KfVtRlsIZtGfKLQi7k3jKsySPsCBNJj63bDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNHOOuJS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNHOOuJS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EFvlXt2515004;
	Mon, 14 Sep 2026 16:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=L+VTZHCk5iXsbveXYvm5i3sWEfZS1u
	NWv4aPjgW8AgA=; b=rNHOOuJS6/DIqWc7xkpt8d16hPGNCdUgVw3uLa+nxLLrzs
	sOLtFqO6XGtTAjajN6jZkutY/XSs+T3+6tt3yuVBfXwSjDy3l0wyZxuARJxNef99
	ZQHmC83ATHAsKKKWVv2DVKHGvrNVxIRx4p8vNKh17s4dgmTvH1UOwLFuxNfgoBi1
	YeIHM5LZps9xuNXMRdjeyBpFVjGOqqdAgXR0QbmwJf7kA7GGoPadV+e1ReJIDdWW
	p19b7Xs//e+LHVFL1277uSAXXEIj7ZDHhgxS/7b0cm8r5+JVX6cpPBtEmwH0gIEe
	9Hq2Ym/pFS5D4Ad2zElW7bDeZTyPt7Rp6B9MB+Jg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcutfgn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 16:39:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68EGZGjR2298651;
	Mon, 14 Sep 2026 16:39:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnj2jy3h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 16:39:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EGdDOo33882380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 16:39:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5BD820043;
	Mon, 14 Sep 2026 16:39:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42CFB20040;
	Mon, 14 Sep 2026 16:39:13 +0000 (GMT)
Received: from osiris (unknown [9.87.150.220])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 16:39:13 +0000 (GMT)
Date: Mon, 14 Sep 2026 18:39:11 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2] docs: s390: pci: Fix the sriov_numvfs attribute name
Message-ID: <20260914163911.14910B28-hca@linux.ibm.com>
References: <20260907055847.27992-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907055847.27992-1-kmehltretter@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzNyBTYWx0ZWRfX9ZomLieitzjI
 XW+uFsnYMjMKJclhzPFSZl+rfLhmCN//jMqhz3j7VvPzWj1yw/1WO57Kv14UnFSAMwMJuPxA0cS
 L672SzzfoO0nrYgdg10aqel8zsQvw08=
X-Proofpoint-ORIG-GUID: bZP-d9hdWjp48CnsjEcRR6HuI4xwWCIV
X-Proofpoint-GUID: xPxHy8ONm7k6w3CDhaTvi02ufuKrck-O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzNyBTYWx0ZWRfX3rE6VVemJEEc
 izkvH80HmvWOlyPygQgRatTyiwREe78jozY/5o4Y3prXK0ucEO4BI5g2UP68yP937KV3CwmOMs8
 90lhsfp01JuqI3pL7DYNjgTHa/zfsDNJelFX5LlGlMbCjDPUpEeXkJFTMVcfcdWv5+dZDJx/fV3
 PkjvRBeNhel3u94hqztzDrTrzBUzHm175fFxUcMtf0Ao6VQBxJArJr0zuCBFsXye+eYBvTKIISI
 6b++3Hfc5uCvUZfAwr78VQC9wuIWktj209umuBa49tkDISISgKQAwhoJ0oCt0Wtu7q5mSQpInMp
 e7wtKy9GEb/nJNuEbutJfVs0qrmbYxMkF+Ymq0NTVMd1GR8Lv+esn3k3YUXXdgBzeUq1gHixZye
 Sz4IxzcG/sEZ50ZhXI9GQOIZt5c6Ypha1eIYwiRFaPA0fFSTI18bCVXXfOKHCg8baJaP2FNIRXg
 mfO0Qd6KrtTF/ldaSYA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa82338 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=E2sr8YU9W3YN-qfbN24A:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140237

On Mon, Sep 07, 2026 at 07:58:47AM +0200, Karl Mehltretter wrote:
> The attribute is sriov_numvfs (drivers/pci/iov.c); the document names it
> sriov_numvf, which does not exist.
> 
> Use sriov_numvfs.
> 
> Fixes: de267a7c71ba ("s390/pci: Documentation for zPCI")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: name the file that defines the attribute, drivers/pci/iov.c (Randy);
>     Reviewed-by collected
> v1: https://lore.kernel.org/r/20260905091627.40946-1-kmehltretter@gmail.com/
> 
>  Documentation/arch/s390/pci.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!
