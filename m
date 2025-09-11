Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1239322A12;
	Thu, 11 Sep 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593790; cv=none; b=Ge3XbXxYfIBYTUa7DIsv+T/AUdYowljh/m23YibAl1LpJY8UzajhYn6WHg0xmLWl1kPUtbmrH2YTSEbsgqpnxmQijlaZy1l8Qvljq5eHoWZ7WBS2Ke9UwU+lB41ai1rrmkC73tUka0R+DSD9k5C8qRt5NOlQDcQVqCUXPu5actM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593790; c=relaxed/simple;
	bh=bMY1bs36S725JkY5Ad2lFMQullWTZrB15maO1x+zUJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO7JKQofcgzeljMKMWIN7Gp2tOBQ5OdlWhQnXdgXtKHqDBaYJOD0+zbjypN9Y66Iro+2WbQp0dhdxZ0m2l0BXsdHakaJM2va4kmTsCN0uZ0Hu1garWhBxnH+CTe2qzvFaJwUm32NYFSU1UIr3aa69lNuAuobO9L2WqO2I8/1skY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kw1o1+SN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kw1o1+SN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B5kb0C002811;
	Thu, 11 Sep 2025 12:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=g0nh1iVW9k8YXmlZJWzlpqf9x4JVVP
	Ycrf6eMNmvpGM=; b=Kw1o1+SNwii2gi14r7208lhGXWtMF3MVA9lSmvMy+fLgnO
	rK3QHrqdLovsbJXMnvD3WEBJABkZlr+aA1CFT/ZfSSUxezCuDbcFfPskdkdrob5D
	qB6he68rUuPLZIyxEkvBIWjMoWbjMoRgpOlUzlZn4PB08P1psA9F0XZsFdaVC3Gr
	CAb0LDPWoOR/KuJ+69V6N0h896D2KODx5BsbiZW5DaonZHhEAZNLoBisL5ZBI4qs
	59yvJzbyE4oparMZtcdRz7Bh29FtM7UfgS5HeZu0Kpv/JO7WjqNwRdpasos1Dklt
	XRVe1slVF1sCGABW/PInULqtqFzc4MBmWDguzfLA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffmmnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 12:29:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B9qwsP010604;
	Thu, 11 Sep 2025 12:29:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910sn5q4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 12:29:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BCTdwG19333422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 12:29:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B77CF2004D;
	Thu, 11 Sep 2025 12:29:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 826AD20043;
	Thu, 11 Sep 2025 12:29:39 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 12:29:39 +0000 (GMT)
Date: Thu, 11 Sep 2025 14:29:38 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/entry: Remove unused TIF flags
Message-ID: <27e149cc-ff11-4007-a0fe-5f7b0e8263c5-agordeev@linux.ibm.com>
References: <20250911092806.3262481-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911092806.3262481-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AnF3CFdlL5KqIKsUw1BS7A3UbQvoVeAE
X-Proofpoint-GUID: AnF3CFdlL5KqIKsUw1BS7A3UbQvoVeAE
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c2c0b9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=7bT5Vx_4nleFaGaRH0kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX1QYHAFJHub8a
 bCOkCRZ/lo6PHwDK04/biTR48Y8bZTp9gtJEHEqtdSHnPVaBrLAn9sORA5E1Qxc/qFE/KEAUG9t
 jnRBnI78jeBTIP74gdKk8GyuLVLLSu+kZKkCliV3vwozUmhTn0nxREuOGNN0irJoF0D3rgFoqQd
 TQPhes0myzjQQ5pjntv+7a8Y8vnW+YHjRuC2zPsS54vjeeS8aDTOhoxkKBPdKpyG6PyhBF4sB+O
 zxXdUFGwnhkh7ACVOSzevRv6Zxr0WYs6YcIUNu2IBkUjjfQbozd3fWsVF+I+tYQ51EQtSRnixpB
 oYvLXEjjCsQFMM/l4hRhYrM5MIl5RCdH0srI3vMdH0PBLux9AiBEeQxo/Cl+0mdOJZyPLZvp6ZP
 +PFHTuKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Thu, Sep 11, 2025 at 11:28:06AM +0200, Sven Schnelle wrote:

Hi Sven,

> The conversion of s390 to generic entry missed to remove the
> TIF_SYSCALL*/TIF_SECCOMP flags. Remove them as they are unused now.
> 
> Fixes: 56e62a737028 ("s390: convert to generic entry")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  arch/s390/include/asm/thread_info.h | 10 ----------
>  1 file changed, 10 deletions(-)

Which branch this patch is against?
(It does not apply neither to devel nor to master).

Thanks!
