Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDAB8F7D;
	Thu, 11 Sep 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588651; cv=none; b=KXoNd/QXkxS4ZTzwfBZJhCS8Vj5tl931pMbx6zQFA7Px5+ZJdi4xFt71p58DOaPcrYpL1MwiidnTa70XVOcFhzyq6JUvVNgi0SHw7rVmynobMu4gwlRPShO+ye1EaHHIB5azDhsRQauMq5aZHKFeJe49e2LR6D1g73in9tonc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588651; c=relaxed/simple;
	bh=bzN4YjAy2ZdYpmDkBBNtQzTjTuPZtDyYUizCeJ8mkzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC/hCNsYP70uK1PQt2pZhYqDdVhivnMidz80OpqCoxKap9X8AbFRGa45HQUzZ1mVANFHbzi2Tdqa1bRxuU5jV9w+a8hQLaERh4+qkGsmfhT1XlqeuI3O6ctkE2of7IYiE2YwRRetJGCfZQndRWUCj9uhZSywrLMJWRYYWYnPLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qrnudIzP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qrnudIzP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2YrPd003803;
	Thu, 11 Sep 2025 11:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fXeYmW5Dvw+PIBxIygFUA7weo68iES
	zef9W1NXDRAA8=; b=qrnudIzPUonvocXxV1d+VsH2hWvEMJzPVYsQZ/fc8zLe2C
	9VgyouHUZIxkxIRUahUG08xAwtAOCoe3y2q4tImjyGGPBLEQK0wWCA3pIJ+ROelC
	pCeWBpgBiK4L5ao4Fa5NdnTFnwp3Qf6U4CUSUQspNNX9AfyEE4stWXuRilmSHHxk
	fYvn4ZyCvZtVvVpbXoHJppeqzIIEVdcCChfGvgTMWDmqvJRMcfqjGrrUIgOnfd1H
	/pNKXDQ7RsYNdizqmQUfELjVe/sjRhWUUBALKnZnEeaULuUPAokrzq3it2UP+tNy
	P6tmUJtMgcLHQjRkG76unndcWqAMMFM1LwuQwRtg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct3gjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 11:04:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B9aVsu007965;
	Thu, 11 Sep 2025 11:04:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pweca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 11:04:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BB42Tt20382152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 11:04:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDA5C2004B;
	Thu, 11 Sep 2025 11:04:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1E1720043;
	Thu, 11 Sep 2025 11:04:01 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 11:04:01 +0000 (GMT)
Date: Thu, 11 Sep 2025 13:03:59 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/entry: Remove unused TIF flags
Message-ID: <20250911110359.8894Cc6-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX8RVncBP0VxzV
 XsOj2acvLoPp6smnWQh/BLtc9oEGA3DJdTym4hFuP6oCWtE0PyhCScdWlnjnal4CPnCKZe/zLJr
 2ibiBf3C+T0K40B5620dtwQU7ulPcjZSNDE3PC059boX+DaY5W/2ze7wrUKUkcaUalIRej44eG1
 McI4ARmgukx26t+J7X2qSDUbnvb6pD3UZk5ee/JQP8EEBk9vLsGk1ygvqVnNRwqLMPWmyLJlgOC
 au4peHXNa/wHoKgA0PiQtR2QiNwXrjn5FuwSIXtWD32xYr/YPKnA9EIs1lzwiJa/3Y63Wb9NTTA
 09vRSDE8JTt0fMtS3CCEwR4Ii7gmegIzDohNNhW2+TeJRUPIAuM/BzJ52rFadiGz/TM0LUs2XBV
 e8MkJn/F
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c2aca6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=7bT5Vx_4nleFaGaRH0kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: YYv7bz9YwpZUc9hQNppG2XxU2RPnmiK-
X-Proofpoint-ORIG-GUID: YYv7bz9YwpZUc9hQNppG2XxU2RPnmiK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On Thu, Sep 11, 2025 at 11:28:06AM +0200, Sven Schnelle wrote:
> The conversion of s390 to generic entry missed to remove the
> TIF_SYSCALL*/TIF_SECCOMP flags. Remove them as they are unused now.
> 
> Fixes: 56e62a737028 ("s390: convert to generic entry")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  arch/s390/include/asm/thread_info.h | 10 ----------
>  1 file changed, 10 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
