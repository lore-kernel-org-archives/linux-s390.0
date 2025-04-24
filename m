Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EB1D90AD
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507276; cv=none; b=JNNEif8Svj0aQpM3TL4UZ2gaoBkRs4wppW2KOQv78MrcL7nnB4MZlX8LUqDSgTA3m3+3BFMdeKroElt102KYVHeQMFEQzcM6jVlrNw+qLnDbNc0VL5kEpEbrClnc3VndBztXk66uqK4TZP+/v8pIWV1gOjwEVK6Dh+b1GTbjnm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507276; c=relaxed/simple;
	bh=MXDHG1I5gxoo/Pfu6NklO+cBpyNJIlzPICiv9ZnBYug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyJdc61gWoOYvD0jWedx0W5q0WfJ4sgfcizwSnKbfwkSRbIi8OQr5Jsd4mS0HpMv3yLT7UJUikXCJqQN/sY0fDJp3If6JBZk1CE3HCTjLHybrdAo4qZoKU9tzd18Lkic0mz9F1YZMpKXaLUDmPO8nL4mCQXZ8ejCRgbi7HEPuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fSwCh1TW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fSwCh1TW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OA4A5I001165;
	Thu, 24 Apr 2025 15:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MXDHG1I5gxoo/Pfu6NklO+cBpyNJIl
	zPICiv9ZnBYug=; b=fSwCh1TWPb0cGKd9GlV72kLP2S8ijcECyliR9p0wOHjI1v
	C0h6jDTM9u91SRYnMX4MAAHquNSqRZOdEakud1Uu0Y1WVJCvfdEyetYPCW3ysI1I
	OH7cIwSIh5NYix26yYnOCYT9nx+kry7GDgVm3Wl4TA6kxVwrIZc7z7SF+WTfhOyp
	buMNCi4CKvLy2pPwAyRy9xauNwlQXbmlwR7v+vBkL2+lDzOgpzNP2Z/AaUFdqsR5
	/IZFV8A4m/C+j8iDNhUvgKuQXGx6grxE+FYEOS7eKWakKqCMbw/Sb8qQwevPgf/g
	TRsl2kmBTATf05zDt1ZYY/YgaUtHIP4Hw0uXIGsA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467k7k1gc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 15:07:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBSJJ4022308;
	Thu, 24 Apr 2025 15:07:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxgr2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 15:07:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53OF7lko57934208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 15:07:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 494482004E;
	Thu, 24 Apr 2025 15:07:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F189E2004B;
	Thu, 24 Apr 2025 15:07:46 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Apr 2025 15:07:46 +0000 (GMT)
Date: Thu, 24 Apr 2025 17:07:45 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v8 00/25] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Message-ID: <20250424150745.7083C2a-hca@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lbwMWuat5z3-igBQsE1VhFocL7bgK5ib
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDEwMyBTYWx0ZWRfX7FkmEk8GFed9 qM6c++6WejHIDjxJ8kuqvP6pQODtUK1wK+vjP2d38HsE7ucdRJM7yhJkXPVE4IsHPRmrCSUkeHC UzCKxckQg6jbUWuiZgf5qIhJx9fOpitERlWcxvVwsEGXBqPZWgxKVRQ5ICemi+Aku4nc37hksR4
 J4/BjmyoBd1Vk09FuC0ONAeXpYpCUaVXJ2Ff484ed/VPHc4qVC9/xa3wCF3nrq6jdOZHLUqSz8y RsXIMScQZ7dKC2prTyee0W0eaT9OrtrxydrowJ4cSpTOX5DqdU+XFm1MN/5RsIsOWpmBHqOr0lS Zxr5VNOS4edX+6p6zuNQl7VZjzPrnkNrbtGIwIVzX+1aYEOjXGRZx3EDjZyNdr+JWrr9HihnhNn
 ydRtQc6k7D+2wU4SGy56Q2x0aa1GpBrcezFI8zmbvJkifVAR3NvYzCp11cvhOgGf2jzE3UwR
X-Authority-Analysis: v=2.4 cv=KZjSsRYD c=1 sm=1 tr=0 ts=680a53c7 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=G8WMFep8zj0Sq5EJU30A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: lbwMWuat5z3-igBQsE1VhFocL7bgK5ib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=507 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240103

On Thu, Apr 24, 2025 at 03:35:54PM +0200, Harald Freudenberger wrote:
> This series of patches has the goal to open up a do-not-allocate
> memory path from the callers of the pkey in-kernel api down to
> the crypto cards and back.

Applied, thanks!
