Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCBF3C37A3
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785568; cv=none; b=ZlQwjUbtadZS3ibzL0DR+6gub/kpMdCYOz+EcJqV2whKpRQRpNXnUYBFL5k/RJcljnsIz/kwV9qBDyAGkZp6ALzvIzpATdg0cP9+TAY0egbWQxioK9S3y3Tp+GUnwYjCnn3se/ttnWuMffkaa/HqfU69pEw6a66Wu+dKeGKbowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785568; c=relaxed/simple;
	bh=yRnk/j3x4TnQbtGKyGwDhN1FxOdns8rVhGVYJ9USwf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6EGoWy5KHGS98VFsllrc0NTL23QJC9lemmF9LJpNsZPM5NLSpZ+wuRDG/1//WSgZ98oqakn5gcgeSj/5wBLXMXoeJUEohmvHXTL/C9zG2u6d8kS59zCJmvjmqqxQ6y5D4uCgPWXVNeBU2peUzxCnvtCDVYCsWmLorbDyPI+rv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=na8yicYg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="na8yicYg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QL1Y1S3280470
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wy1A+s/KzG2LK++7J9JA6uDx8UXd1w
	1oxcNtWWF+9Ao=; b=na8yicYgy00Ilucn7Y8bOap/39+vn2r6J/+9yGnpEFAR7G
	3Dznc1XudmItB5/KH8aZh3UBavLTgL8YxEzsPvbfqy45KSyy73DcfFWiaVRYF9cg
	5Op/ZZnZyXLdfmoYGF7hgt72Db3m5LiilMs5c0gqPz/4x3stSWpfcV8RAY4YI9WA
	cK2yHSj4W9oWcB3oB7yio8zABk3d9eYDu+xPzI4rq2hkurix2jMoCGQS9mQjvVwi
	fJHQ4QX+Szy43N/irqsOlkfzPD6N6AUWz3HKat7KUU50jp6N1ptvahTMydkTw+xU
	/aD1qo01CqHXEdFpUIDYYU20JhHz13gOKTwi0U5A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er1mf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QMuKx1020075
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qcv8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QN61pC41681352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 23:06:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 743692004B;
	Wed, 26 Aug 2026 23:06:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 231AE20040;
	Wed, 26 Aug 2026 23:06:01 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 23:06:01 +0000 (GMT)
Date: Thu, 27 Aug 2026 01:05:59 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v1 0/1] zcrypt crt and me fixes
Message-ID: <ttkeg5z@ub.hpns>
References: <20260825160154.106501-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825160154.106501-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 28bCRxeDJAvn6qFfzs9WsFczF8QNs6Lb
X-Proofpoint-ORIG-GUID: 28bCRxeDJAvn6qFfzs9WsFczF8QNs6Lb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfXxxdXOi3a17e0
 qyBZGSiWHFW562Vc4ex9SbiS4ddcsqdkIbon5p9q31a2Ywbi8Vu1y33/FfuUjW2ieCt8qBwe1Ng
 0D1qbT6O7G7cgBsT4QeOcTW5wCYZWxberqYlQZuEwRPUDkZoXCVLRGd9jRvaZ8xta/rrRLzJoyv
 JTpTLyU/xYdj8EnwwVs74vLRKfh/y87PpkuHDPOUgZQ1mYci+u6rgt8Y3FuCH95DsS7FSw2eA7n
 VfYBcdRgYVjdsRbB7zoCgvRDapi36QM7nOFOhUG2Z4mfogLVHCvwYiriA5C7UyBEHabOQkbWrAA
 LROF1yVDkdgA4gBVrKkeKjtFqGMulBBmRKEQwpqwZm0UubG9WNJOeuVnoE2mQgff8T/7GXNgdy+
 9OqFaiuoLIL6mV/QDjBsZACAyeScY26ikc5aTE1qoCyhOJYTr6seip0Mqbxb11Ry+Q5oo0NsD9u
 fyf8VjZIvF32o7Yp09Q==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f715e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=X8ArHMiIHYs-VAeYbBgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfXx3w+NGwWln4q
 pEcb/1NSxg4piywT9gtcRzaIK4/EC/C9XHT0NJv8WNaC4y3LYERLUcfs8jBm3b/6tV9fsQg0mI6
 f1uWmXY1gfSgQK/Bcd+wtwLC/jV73aI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260194

On Tue, Aug 25, 2026 at 06:01:53PM +0200, Harald Freudenberger wrote:
> Fixes related to type50 and type6 with RSA CRT and ME.
> 
> Changelog:
> v0: Just one patch fixes an AI finding with padding when a CRT
>     CPRB for CCA cards is constructed. Details see patch header.
> 
> Harald Freudenberger (1):
>   s390/zcrypt: Fix uninitialized padding in CRT key structure
> 
>  drivers/s390/crypto/zcrypt_cca_key.h | 1 +
>  1 file changed, 1 insertion(+)

Applied, thank you!
