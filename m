Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766F3ACA7B
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529482; cv=none; b=MHHid2Cu0qOoM50GEqzzMTFqqC2Wjy0cZgNyWJCcQO2gKLOzBX3abcLPzYC4yWmLFjr9PLBANhhH2hXnC2cKmGevoytFJby4CF/YqrjvE+JN9b3odVSP5FWXfAL75tMODb2PhSzm0UjimYfN2uTPWZEFaFNn4b82Y7hhjpLMQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529482; c=relaxed/simple;
	bh=5k3ehR2AD/7V1+GStuZTv20Oa1LzLUtOys8LXCummNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snAU5rSA1avp7aaXf4Y77okv+2V41HyHodRw8hkVkvftj4tudbXjnZ5GnBFu/JsgAs/lv23UIVrrqFnvtXo9hjB5fh1yEKPkutfUpxMcBRjZednTYKVu5IQFnlGY1Uj34H4qB6/VJasjCQ8FGp2zuUMz2A7igpPINrPfiKNIaL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d0aZQKF8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d0aZQKF8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1XnS1306552
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 10:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sNa0f+HVF29Ty/KybEDQ2pwMtTm2Sd
	wwtREA3nkclpA=; b=d0aZQKF8ZNrGtvyaXVAX4uy+CBk/fGYr0Pwiq78C9tBduy
	/PsNs1T8u3fB5ZRoduZwixx2pk2QVuDqh0PJpBhj117gpGjXTSyZCK04LCahqMB8
	UK3B/NqFcU/pmW+LOXqcd2zTlxW3qPXDN83csS5XkL4xWJe037ByWCS0+MTbhaJZ
	Hj17NmdZxpSxWaezc27cUIizFPjVJn0fEki7AKESPFpm5Gd79XdrxxgCkSKqo4W8
	qOfHaTWSQoxMY+mtK44WgW9q2opiGd6otUCSSWn+JQDdXws1zHwn+wxBLfk2aKix
	g6y8wlQ3Q9Ru+qt+y4CJXBiT+02RDBbI6gHJnEvg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk01vcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 10:11:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CABJPa023864
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 10:11:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5f36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 10:11:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CABG2U35586440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:11:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F30F12004B;
	Wed, 12 Aug 2026 10:11:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B85B020040;
	Wed, 12 Aug 2026 10:11:15 +0000 (GMT)
Received: from osiris (unknown [9.87.155.64])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Aug 2026 10:11:15 +0000 (GMT)
Date: Wed, 12 Aug 2026 12:11:14 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] s390/debug: Fix deadlock during unregister
Message-ID: <20260812101114.18999A06-hca@linux.ibm.com>
References: <20260812075319.2007940-1-oberpar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812075319.2007940-1-oberpar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX/Dkecc+vUDHR
 A1lE6+i5MQFXw3fSyNpZZddyG2TEssSONEQsD+EmRKEomH3RtBZmyqXcP0rLR4OIOcQaoWuMUTb
 q8407QB2sq6XJL8lNT4naJoTEBtEhO0ZOHofVziREMRJ4591ryB7nCRPUePyqhsisUqj++vq7tp
 Cxl/ww2SDqUCzxlsjBxjfZ7eTvXThHfikQs6mp+CxGucXs5jup656YOnAcAcHuPr1EH185TKF94
 e1qmFSlk+qLReh5NrXhxQFvjo3rByply/PNBzhOfvxM/xutaPR85CWeVMlp19mYP30ES7MkP88B
 TEXcZSsF7nDrxvEC6riVKDZU8NK0ye3r5MFBfcrJp7MGqferNU7vepUoUYflHizRpLcV6SPqmYr
 l+lT1rUgludBAEHVnzmJRWxKJe77di8dB+OMkJql4UID3PsJU/blgjxXkvNPyTJ0bEU+/hpN/9m
 pkLsQjWBvWuJvd6CN+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX/7QZpKCeFFiP
 HSDqRggxFfgJ1o3gVtlpa0y4OAfZcfeXDCt5RVwtrOQr2fUe4Hm+6qiFuDhVUuXvTMXuwWpkq1q
 Bc+MQuWzgrbf8ctR+QlWfofKhmbMLVQ=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c46c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=3FgUlI-fcN_bYXtwy8IA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: hETVr89k3xcznXyogxeXPvAOS2CfK8d0
X-Proofpoint-ORIG-GUID: hETVr89k3xcznXyogxeXPvAOS2CfK8d0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120080

On Wed, Aug 12, 2026 at 09:53:19AM +0200, Peter Oberparleiter wrote:
> Unregistering an s390dbf debug area while one of the associated debugfs
> files is being written to can cause a deadlock:
> 
> $ echo >.../vmur/level    $ rmmod vmur
> ===================================================
> debugfs write
> debugfs_file_get()
>                           debug_unregister()
>                           mutex_lock(debug_mutex)
>                           debugfs_remove()
>                           wait for debugfs_file_put()
> debug_file_ops.write()
> debug_input()
> mutex_lock(debug_mutex) ==> DEADLOCK
> 
> Fix this by splitting debug_unregister() into an s390dbf and debugfs
> part, and running only the s390dbf part with debug_mutex locked.
> 
> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> ---
>  arch/s390/kernel/debug.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
