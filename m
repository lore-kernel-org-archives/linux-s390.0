Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9C3955CA
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785616; cv=none; b=TZ5Chf0tYKktDP1ZIDnkhMKaqHxVaMLU3hO7arO++gSA+DW687IRscnvQxf7untzn0VgZpNOP7ykWpccp2IT+Co0CyOYQUYcqdRYj3QChg6BudOTIooSjgoR/1UkvvqC9afekyJ0yvMBD7EsvtUBU18LAKd0yjXwhQNBDp8y2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785616; c=relaxed/simple;
	bh=kZ+kx+rD2IEaWLYhDG9nps/u+ZPLIt2W64z5YDgTjHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPpnb8e5oYWnJzvazYlTjtfz5Mu+8ZlYoxVf0hf1h/qv6BVNlCrgLshwJaFYDa+ifXe0sZeF1vdCW1aAANbH6bSgEFGIzjUsLlWAtSvRIbxwULDmzM3GxkEBM4fE6OxSOzNpA7PTQhY9T9lE/ejQImDVixTEapjSAd4dg54jFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p96d0Uka; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p96d0Uka"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QL1bJB940032
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=X9ko0veXWMqoE1SGplPzQG6QxIxwNK
	C49O0q5L51HUw=; b=p96d0UkaHfL701m5/Xm2gl7i6l5W8y+p1Ln4HH08XqUOyZ
	7QXtPgw/k24wzz7ATNDGV3VU/hHuq6yXkQfFMv/otkg6/CvmHQw4o4c0nF2RElso
	SGl3UWAXRtS3BTGNJh+5SX/OUoHt98DGNwSjS5BMKi8+NR4rP+I18AZ8VgtJexrM
	7afmoxPKeoaHVNh96LOIDu4Tvyro8nCPUu4KjvcTbXr6Rym5hYjO+0Fw0Kx19Ww1
	UZ2UhoRQsmZIcB65SE8wRAIn0M+2/UzSivpgSX+pYancEKyt7l9JnS6NervvTQRv
	WpDJ7efCsnUp1pmDmOGd+R/hb2t3QcDKU39e3cYg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73949qm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QMuLGF002435
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyccvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:06:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QN6nqk44892442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 23:06:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F1872004B;
	Wed, 26 Aug 2026 23:06:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E96D20043;
	Wed, 26 Aug 2026 23:06:49 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 23:06:48 +0000 (GMT)
Date: Thu, 27 Aug 2026 01:06:47 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v7 0/1] Improve zcrypt reply message verification checks
Message-ID: <ttkeg7b@ub.hpns>
References: <20260807101918.31482-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807101918.31482-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iOmR4ZKa20JQ7YeSjLtL3Z7v4fAAOxYv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfX2QoqxIP0ATO4
 y4RgiSz+E7x7KZIxw+uSTI8ArqmRnYwzD2ic3oYJ5FQQ4D9oIp8Wtv2zb/4MT64/D9DosyporhY
 yEYisNKTdnjndwbL2iZcswVAFn8giU+WrZCggkMplNov/MPj+wXmQ2MVYzfM7IBvh8Q8ArF0T9M
 RnrEZuNtxemcBnaxdEBPswIDHerOzrg69SzEAHX3CNJebBE7layNX2pR49jqtGRumeYo0CHNiTR
 F4nmpBzQt5HASmrTtuDd1YxZi6R/lgTAb6LXbHCsIBSPrzEffM1Y+hFAyScYFuzY6glfMgrWQjx
 8Gzy2fYVZFCumt4k6vs/+i2ph8mZOb15zP6n4qwS0xOCGBNx2N2x7OCsc0VkQ/XSEUfgNbHplhL
 4Hs/J7fJx3l1iOxzppuWpDSsYP+cz6rDM874zI2SmA2rztwJj5G2/QCUjEnOGC35uUIjDw7zGHZ
 UffiYyvOTnXRGVipdVw==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8f718e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SUdzNtN8fpI3OCFGCDUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfX0mp9BfvDVIj3
 CwwIV9jOIen8WMLEwyTz8DofVKgmnN9oQG7XF1K6vbMyOCU/IT1bjXf5W2EiQBLMAaFVOvc3IQY
 kFWBdzx6EfEmG9yhcEK3XSnF1SoN0/Y=
X-Proofpoint-ORIG-GUID: iOmR4ZKa20JQ7YeSjLtL3Z7v4fAAOxYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260194

On Fri, Aug 07, 2026 at 12:19:17PM +0200, Harald Freudenberger wrote:
> Add or improve checks related to buffer sizes and reply sizes to the
> handling of replies from the crypto cards for CCA, EP11 (AP message
> type 6) and ICA (AP type 50) messages. The verification code related
> to reply field length was not designed well and thus firmware
> deficiencies could lead to unexpected behavior in the zcrypt device
> driver. Thus improve the code to more closely inspect especially
> length fields at message replies.
> 
> Rework zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11() and
> zcrypt_msgtype50_receive() to validate reply lengths more carefully
> before copying data back into the request buffer. Use size_t for
> length calculations, reject inconsistent reply sizes, and add
> defensive handling for short invalid replies. For XCRB replies,
> validate both reply segments and derive the effective message length
> from the covered range instead of trusting only the second segment.
> 
> Changelog:
> v1 - initial patch
> v2 - fixed typo in header check_for_overflow -> check_add_overflow.
> v3 - rephrased and smoothed subject and text of the patch. It is now
>      "s390/zcrypt: Improve zcrypt reply message verification checks"
>      and the text does not talk about malicious cards any more.
>      Updated Reviewed-by tags
> v4 - As sashiko clearly states the addition of two 32 bit values can
>      mathematically never overflow a 64 bit value and thus the
>      check_add_overflow() was total overkill - removed.
> v5 - Sashiko had a by-catch related to the very same fields. Under
>      some circumstances the fields count1 and offset1 of the CPRB
>      where not checked but used for a memcpy to userspace. So again a
>      rework of the check of these x86 header fields in the receiving
>      function before the CPRB is processed to be copied in parts to
>      userspace. Removed all reviewed-by as I want to have another
>      developer look onto this patch again.
> v6 - Again reworked and re-structured the code. As the very same
>      pattern appears with message type 50 also reworked the receive
>      function there.
> v7 - Reworked the debug messages based on feedback from Finn. These
>      messages should be real debug messages (so use pr_debug) as the
>      intended consumer is a developer. Thus the somehow cryptic debug
>      message text. Picked Finn's suggestion to avoid hard coded ERRNO
>      message strings and use %d with the real rc instead.
> 
> Harald Freudenberger (1):
>   s390/zcrypt: Improve zcrypt reply message verification checks
> 
>  drivers/s390/crypto/zcrypt_msgtype50.c |  39 ++++---
>  drivers/s390/crypto/zcrypt_msgtype6.c  | 149 ++++++++++++++++---------
>  2 files changed, 124 insertions(+), 64 deletions(-)

Applied, thank you!
