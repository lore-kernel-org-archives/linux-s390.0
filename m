Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274E3EE1F2
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094614; cv=none; b=RLZknO6mwpr8pWpBF7fCXl8rnTz6g78UKdQ/XwYYJJSuwSsT8Ey47pxKqZ21B2JvzWvtodVLtSwB4bm5LTGZIS003FKNw/2A0qfaWDPrH5041gqltEjeVx4x7qhO9vjumXSDpmmnAMq2ImA5m58brOg3ZAPNeNDOjxrSXCqBmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094614; c=relaxed/simple;
	bh=tKkDyWhZZ4TWhRLmfMcm6WzmXMLSIBdMLQuPksLSucw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bfcX5jJQ0xbOn/J2dkuwQbUoxJk6A1FqYEBSOjCuAWqY4QEk4o9o9xRsfuqCGHdQg/ebmmXl/LKrvoaNuJsqXybH1J0TE81ecnvn8+yR1LipVp+vlNrCzREC0amPGVFWyIsCppryhVxU5F49Xc5eeloUAsngOt6Ws15rRnUneBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lfrB6VHS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lfrB6VHS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HuhG2276296
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 09:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3rS13pPL2Dhn82mOQSmtNuVOk9ORHK
	1Vse1hNGXhmSg=; b=lfrB6VHSfquT3YH5erhNRf8qIMuPqaPg+ecbXbbQbG/8sk
	z1GTsfTc3gWDjZOSG/yR1tSL8hZBpJPGkEDB5EYcSMYaxTHIVU8iWvZm+yCWGSJs
	DOgZWRwsfhFCRqlPVrl7pARDn30sw86chYl/w/1habEkUZqu7iw2YGZPyi1uqSbp
	2cvVmVp4iw7hlmJnec9YIFMPp9NU7NTKFg2OvSIJFoPhhu6+Qv2NnOf8NWi0pRYB
	TRjbnpMTIUiW1SllQeqslbHJZi8pvupaELMjv32BU65rM3ELIsX6/PuqSeJIvjB4
	hbLkjzRHm0UYER3BbzROb6gK6Zv2pZ+i+LN7hqLg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01k69h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 09:23:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779BHo9008735
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 09:23:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwf6cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 09:23:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779NQ5p34013688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:23:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEE4220043;
	Fri,  7 Aug 2026 09:23:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A13FD20040;
	Fri,  7 Aug 2026 09:23:26 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 09:23:26 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/con3215: Add __must_hold() attribute to
 raw3215_make_room()
In-Reply-To: <20260806155303.2675932-2-hca@linux.ibm.com>
References: <20260806155303.2675932-1-hca@linux.ibm.com>
	<20260806155303.2675932-2-hca@linux.ibm.com>
Date: Fri, 07 Aug 2026 11:23:26 +0200
Message-ID: <yt9dh5l6s2r5.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4JQskVgYkFQYn9WX3Gf7C1nPaJ23VySo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2OSBTYWx0ZWRfX9H4fBqBrstQ9
 cR0dNgme3iUEQDvPNMBN2qmQHSTi6Ry8Jv4L7A4wzqQ1G8F8I0w+OCkZVUSiXJw5HTa8HVz0bYt
 h9SldchgP6zVBzwGfBLrkqIM78ELaj4=
X-Proofpoint-ORIG-GUID: 4JQskVgYkFQYn9WX3Gf7C1nPaJ23VySo
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a75a414 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=7z-1ECfcVaTJoo9D_iAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2OSBTYWx0ZWRfXwz/5+lG0VUJf
 li5GI1IDXJmALcVOt59v7QmCITa21KMEOADpX3F8BHa8thdORSnLNF4gm4uy88S04zAHAfBlArq
 4L5hnStvzqDt74X/FNcLv+a4fjhNPT6A4e9K+CtnV+GMMndUw0hNAIu9RkGRxg+YTrzTvvq9DVN
 IM2fHXv27JzdtI4znfwg/VRbhRtXa3TtH9sY61Wj/nrmFXay8CVVq34nPsisTev5c5i5WrkeDiW
 yEwR2Y+nsxkfNsC39EA74F8DIpFxwkEbf0RGPSiCoHbR8RjDC/no/BV2mqkflVqLBLbJSDv4Iji
 mX2Dk0QCgpoMbrLhCXMa/f4j+yjj3FMJhWoLyD/mp7jeGJ01c+D/7y0Ljhe387Yj6OoUUt++0E3
 gQiAR945MHO3GAJ9bdHPnaD5j1P7lC89vWLlNNgzHudncjLUGYGoFEu2qH5tdpyEe45zmAUFa/M
 3LC8cViS2nF8baMM6IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070069

Heiko Carstens <hca@linux.ibm.com> writes:

> Add __must_hold() attribute to raw3215_make_room() in order to let
> clang's context analysis know that "get_ccwdev_lock(raw->cdev)" must be
> held on function entry. This can also be easily verified when inspecting
> the function.
>
> Without this annotation this leads to a valid warning when context
> analysis is enabled:
>
> drivers/s390/char/con3215.c:485:9: warning:
>   expecting spinlock 'raw->cdev->ccwlock' to be held at start of each loop [-Wthread-safety-analysis]
>   485 |         while (RAW3215_BUFFER_SIZE - raw->count < length) {
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  drivers/s390/char/con3215.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 46265f4fbfd8..57fefa8986d6 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -481,6 +481,7 @@ static unsigned int raw3215_drop(struct raw3215_info *raw)
>   */
>  static unsigned int raw3215_make_room(struct raw3215_info *raw,
>  				      unsigned int length, bool drop)
> +	__must_hold(get_ccwdev_lock(raw->cdev))
>  {
>  	while (RAW3215_BUFFER_SIZE - raw->count < length) {
>  		if (drop)

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
