Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCA1CC16C;
	Thu, 10 Oct 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572295; cv=none; b=oAHJBvDad/mWxlGQNg+p7CVdhWyGRX0IhuQ1CjsPYtrTi8RkeA6fAXqQYegzCKlo61vQlZ66zxyoZLx/1964VZ6rfWoh6x1opmNU25Y/YW/Ajz51V1fhbmVbfCCnR558ytxcnRayiALXxwONnjYTturFm/V9RU1Qj2tRouOt350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572295; c=relaxed/simple;
	bh=n+tvVWdrFK7gePCkgxZqwI6xO/tlnEyH8Qeff791GW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW4M4705RfB1Vb0k2z6gNOJoNtj2JAbHEpd2/8DSD5Is5IzdiJ4lNrgf2OzGVC52wLwcUrfsqeryY9hk6LHkEQL5ChBSSrdIo1Ua88y3J4NOKHoFwJRTK9wLdI/HwjiksBd3RwudJXI/B0AEqd5zYuBn7c/6uOhcIpeeYON6ICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWFl7mNg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWFl7mNg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AEQOwV014382;
	Thu, 10 Oct 2024 14:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=QW2tF2kXvcRNC5K/stzgSLxAH3R
	1Cp+7z0fBZIbq+ow=; b=fWFl7mNgVCG++LSIkGbhgERfD3F2Km1gavRam0mQhMw
	lz3rR/KNlPq45Q7qMAxNPwsfVJcCh/TzQ9znyUwAkv6ySlZxAm83J6BsG13BQL2E
	WBObVa89N4o1LaJ1HuVBahnVbidyJ6/ky7TjeR5NowLBk5+ZOD5XFUtP/6H3PEex
	jmUi0qWf30I+3O5ghQdUIY3Uet5fyCwlFYbbO+5iStoefpibm2yPdYNGOPZ/Mn3M
	NV/uTjTl7Z421cPYO05XQejx5dlRfLWq6GhgyRpeqpWgJQob3jsjNS0cTVMlWkHe
	E/a2Amq/p8kuYU2O/rs9FR3JGU51ZDWCup46GocgQjw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426gpf061v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:58:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABllF2013857;
	Thu, 10 Oct 2024 14:58:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fssghkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:58:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49AEw6nk53215722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 14:58:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6946120049;
	Thu, 10 Oct 2024 14:58:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2675620040;
	Thu, 10 Oct 2024 14:58:06 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Oct 2024 14:58:06 +0000 (GMT)
Date: Thu, 10 Oct 2024 16:58:04 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] s390: Align prototypes of zpci IO memcpy functions
Message-ID: <20241010145804.15346-D-hca@linux.ibm.com>
References: <20241010130100.710005-1-jvetter@kalrayinc.com>
 <20241010130100.710005-2-jvetter@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010130100.710005-2-jvetter@kalrayinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WeNH7jYhB8IpKJtIqecsmZXJrxMqgbMr
X-Proofpoint-ORIG-GUID: WeNH7jYhB8IpKJtIqecsmZXJrxMqgbMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=359
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100097

On Thu, Oct 10, 2024 at 03:01:00PM +0200, Julian Vetter wrote:
> The generic memcpy_{from,to}io and memset_io functions have a different
> prototype than the zpci_memcpy_{from,to}io and zpci_memset_io functions.
> But in driver code zpci functions are used as IO memcpy directly. So,
> align their prototypes.
> 
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
>  arch/s390/include/asm/pci_io.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks!
