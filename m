Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474AF3FCB11
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408085; cv=none; b=XkXHNiPkcOwP+75m8QhG9+w3P6RFDAVlsZcQP1bLCo5RmwBZ68QjrlWWy+BEj1ViSOlf8cAzWga0CNtbcDbj8VoGAIKwXS5HU7GqQRRLQsH83Zeu3D7HBm9YVKspCmaXoJXr+fCzQI4rBKg3B/IiFQ7BhgxcAOMJ0qbbW38AW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408085; c=relaxed/simple;
	bh=Zk8CPjs3dNzJpQR3BGPAlBDX5DlPjj1JNXqNRotbJIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL8WjCreEfBM+5pMu4t09HE37R9Wjggx0QW1BV0gVGouqX2GUNpUgE4kBAtLVCMCLf2cRlPs/ocNnLtbwZKNTmc5rzZj5jrpWbjWFmn01j9Xx3Ong4I3tAsLXhFMZvEkiih5n9jkpSfvyFkfEdZGLY9/mgVQzl+bgNkcpdEC4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kHwcxXOz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kHwcxXOz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHnGt2760650
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=c1H9LjC3lkXX0b9flendo1VFHWtjtR
	izagftwihACnQ=; b=kHwcxXOzzEu4GQDq4MAOHsnvKhYFsZwQf88c2IT9ALt3lg
	BRQgMyW0Fl3ivE0UsmC6hqF0hvf1A7hFZsAsSkcExDqnTTXYTEdCV2YjHqQh01Mf
	4VB+FPgAoNvhIA8V1HOSaaAVjB9I/BL3HOm8QO99t7xClibFrnHdd3hQ3ZlyiPuo
	7Civd74CfLdeFiCxlutFpwDyJb7fi63mn0luK79EPFTUqSlVeaJvd8fAVJQSJ5Rz
	ZrDDnthUBBB1110cipgleOCRxZF+4U/NPnwwKeZS2q1x9y8mnt8s4jk5KkBg47eE
	fAiUOpu3YStRerVSWRRTXc3U6oiLT19gZ3UEw9og==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd6dew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:41:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UAfHVr008938
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:41:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkawst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:41:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UAfFYc32899572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 10:41:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D360220049;
	Thu, 30 Jul 2026 10:41:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C10520040;
	Thu, 30 Jul 2026 10:41:15 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 10:41:15 +0000 (GMT)
Date: Thu, 30 Jul 2026 12:41:14 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Fixes related to domain access and verification
Message-ID: <ttizhoq@ub.hpns>
References: <20260723095453.127322-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723095453.127322-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pcnzkQU6kpWhiIbCJ0lbfWJl4Tw0DpqJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA3NyBTYWx0ZWRfX3WHgOTOCloia
 cfM+RETfkCwlFaAMxsIbgR/KS9BhEkn8AyXcWOTfJkBSS/RSy4g2wLbef+q5F7D65m4jmJjff5t
 PoDZjDaqZQrjrs0BsbyBdbzQz93odsE=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b2a50 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=hd4YN8TDbyCp-N1hn6oA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA3NyBTYWx0ZWRfX9sv3xX7wfwLe
 O8/S1GQjRfMGv8M1uFHaK3DRz8NsmMTAa1KtKCutF8ndJQSJ7AIiZV0Bh+T5gjfKNTmfY5ENnPJ
 LoBPhyYW/H9MfvyRGTA4lFIxQ78wgTTTUaZWMHKNuZnE0CadQWPLuyZvLhP0hj81Y9yRuKgz1yd
 QQz3rd3B7ZVIYeyhoz8Z1H4UFxoJyymRHa+XGVKQcz9Qw3A0KgAigE4UF3f0203PmzHJ2OtH+K5
 R9TBAfqsXSoGuEu1mxaWERmRPy9xDLEbctrVn1+HAnywkapCK3qV5ERfWsETh6BOwe56wwdga3+
 AL4WXlJHSV+k2Z5VKaQ+zkPb7zMtinwUsSFpdKCKWPxAJ7o8zyUGqtNm3x82WxB190tTlT4AbwD
 5xEp39dgJMPWdCvwm7RZh1IcX2WcIZLzcdABcE2hvdqP4EHnU63sloSRMERR8i2H/1Kx6NIcrDb
 8mMOxC+LHQhokLGYAvw==
X-Proofpoint-GUID: pcnzkQU6kpWhiIbCJ0lbfWJl4Tw0DpqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300077

On Thu, Jul 23, 2026 at 11:54:51AM +0200, Harald Freudenberger wrote:
> This is now a combination of the two patch series
> "Fix wrong domain value verification with EP11 cards" and
> "Close speculative mem read possibility" as there is some
> code dependency between the patches.
> 
> Changelog for "Fix wrong domain value verification with EP11 cards"
> 
> v1: initial version
> v2: Resend without any code changes, just Finn's reviewed by added.
> 
> Changelog for "Close speculative mem read possibility"
> 
> v1: initial version
> v2: Resend without any code changes, just Finn's reviewed by added.
> 
> Changelog for v3 and further:
> 
> v3: Resent without any changes, just this time as a 2-patches series.
> 
> Harald Freudenberger (2):
>   s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs
>   s390/zcrypt: Close speculative mem read possibility
> 
>  drivers/s390/crypto/zcrypt_api.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thank you!
