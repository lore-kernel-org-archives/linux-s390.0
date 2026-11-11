Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417717;
	b=I8V3j+yxaR50hLWi2IM06iBbpVeBned66QNrUKuCZLkJO6AK0PtjsYfUvHsJiGKH+/8Q
	 nx2CzgeL6PLVKvWYJPsprj6vsb1aCl5hKWUdhZY0HUw/qCiGJo6JfmE1k+4C6CvnmdXWJ
	 xfGZBQM2bdNa0oddsLE5d5IvhDWvqkNstamzZRQAKu9UIg3HSyrou8vDekqtg2+yMcqzF
	 KkPAAaw21ExUXCpTgGJhn8IcOQMuGUQFvQnC6TJ5W1SKb4OdI25NwgtKKUHGvIVNgzDWF
	 kX+MyrYntLkSAlnG1GUPUR/wq9RCr8t444T2JM0JyElQkBxXCAOQSieFlR/ohzahzQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417717;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+ZmkFHq3qH2bEwiVuEABm5RhuZqNolNniXB9pDHYK4k=;
	b=ujKSjygjNNDFi//kiymTjp4hVtD3V+g5JSaAGyokncoO4JUvZ3EgHTrmuXycuE02GGki
	 nRxoSTG+vsvheAO+MJVujf1RO4f9j1ByLg/L9Z3OqGj9YEvCDxD4u9eLuwI7USuwiJero
	 KEpECmfp4Ma3vsDGAD0UiXfrM8ieTP5DH5ycYzM95Hd/RPQiTKq24VM8y5sBeyQ+qoIJa
	 0HjUhBTYLc4p0T6+xgBH07iQvIYmkzRyQUrTMaF08y4BM7dZ3gVWA4d0zsbjV+8hBZeB4
	 ZenyljrjOVPsGMqTfKRvwnYRyygsz+ENI+hl1zncHADnD+ggJ2sWhT0lxGMWb4nSIqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l0M0r7Jc;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC454606A331
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC454606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l0M0r7Jc
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFECeE4004976
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+ZmkFH
	q3qH2bEwiVuEABm5RhuZqNolNniXB9pDHYK4k=; b=l0M0r7JchiyuTGfCMmHPLj
	G6C321E7w+G1bAUZeXD3NhAJmuUNRdvXjVSJkDHzPDS5EXoFFLMR8ZH9gPBsrIy1
	ji3f8YJbG/M93JcZzRo/Wtbip1Lzw9Fgozz03MKD6I/JawgBe5GESJR3LM31KwEi
	/tslZYjAB8a2LuiTN6zHGwnhQZn6fSdjqzB/rCspcZMTQR5OOXp+MNBDq7XXl68J
	JNnAujb/PaEw2aSryuhrkH/6OJa9adl/ahYibnRcnKm8yWYz/sw1ZQe3oTKp+zXT
	P07OGN/HZlZnQt0btc/AhJiHnqjCXVM+8BOdGtXZvc6EC1cUJ00WlK18cZO/hUVw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntbmbd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:21:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF54jc2382072
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:21:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51u2g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:21:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABHLp6737749044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 17:21:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BAA22004B;
	Wed, 11 Nov 2026 17:21:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 383D220040;
	Wed, 11 Nov 2026 17:21:51 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.111.87.86])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 11 Nov 2026 17:21:51 +0000 (GMT)
Date: Wed, 11 Nov 2026 18:21:49 +0100
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens
 <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] s390/mm: Allow hugepage migration for s390
Message-ID: <20261111182149.7ffa706b@thinkpad-T15>
In-Reply-To: <acdfe7cd-1f50-4a10-b9cf-5a4318fd582e-agordeev@linux.ibm.com>
References: <20261106170844.4079771-1-gerald.schaefer@linux.ibm.com>
	<acdfe7cd-1f50-4a10-b9cf-5a4318fd582e-agordeev@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfXzC1DuUBnz7lJ
 muSy9JkNi7IptWSxruZfwrJn1GkVvPtC7jovU1gnTO8IF1893afh+J503xNOkaMkSJAI9ZsUsRd
 LYWdWzVP9ptA/3xkSJugVKRmO8Yev0Fta218kNh9nFandrtNnLmarDX8adOadPNjc+ua9Zhg06R
 ya83jrxBn/QS4oS4kjxN7lb3Qy2v/ObkerThLitsISpCWOJ4qA6Ttzju5KmRAmD0ImwHY7sT0aA
 oj/KE2nrEfSAZIujtrXc9Qu7PuSk5HSdQ367WK9Ux1fd+RZe4M9X24pwrOl4B2zuT3k8LUOde2h
 Qw8mBUBYzyUdKZUVmilYvFUO8OTp19u3LqbjXCjGQbYkGbYd8h4oHnkeIimvxas+Qkb+hzti8oW
 c7yTSy/62ZvJI0zU8Yhq17nvyICNHFgxgsX4V1tA+TnbxFmwrb/H62/dGJZHyDYvhr6PaX5yIeF
 Ok6fn/3UmG4rCOnacDQ==
X-Proofpoint-ORIG-GUID: utup6fjxMjpvtdqOjhnwzXrQGZee4pOh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX74qz7Rxav44D
 ztV41jWj085GpbeUhUVDRnN6xLH3a/LX/59a78Xkb8rkAk4lKHKN1eGKvz5T+9/QKuEJ5KLgATe
 v/0VPX/Dznoa43Nsno+0sb+Sc2S4aso=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af4a434 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Pybl42v3iLmzYJVr1bQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: utup6fjxMjpvtdqOjhnwzXrQGZee4pOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110068

On Wed, 11 Nov 2026 17:09:45 +0100
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

[...]
> > @@ -241,3 +241,15 @@ unsigned int __init arch_hugetlb_cma_order(void)
> >  
> >  	return 0;
> >  }
> > +
> > +bool __init arch_hugetlb_valid_size(unsigned long size)
> > +{
> > +	return __hugetlb_valid_size(size);
> > +}
> > +
> > +#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> 
> Could you please use IS_ENABLED() instead?

Does the benefit mentioned in Documentation/process/coding-style.rst
for usage "within code" also apply in such a case, i.e. not within
code?

Or are there other benefits or coding style requirements? Just wondering,
because I never saw that in such a case where a whole function is behind
such an #ifdef.

> 
> > +bool arch_hugetlb_migration_supported(struct hstate *h)
> > +{
> > +	return __hugetlb_valid_size(huge_page_size(h));
> > +}
> > +#endif
> 
> Otherwise, LGTM.
> 
> Thanks!

