Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C68D3290A6;
	Tue, 23 Jun 2026 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195209; cv=none; b=UTJoWu2EBUqMJvlNbknISyhm6kRRwEqii5uDriJFHJ0r5nQZvxOoNwwdJuIcLfm4ofx4z307PRq8bwL/DznW4LSafpj9EiqKGXc7Bnv/FHu3w3DvCC0kRJ7tDw71ekdn+DiShz2k3iwTkyZ+vUaOo6Pv2wo5R3zH5xMYmeyacfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195209; c=relaxed/simple;
	bh=hm17CdDoztPhhS9+7uWhsrGqONsu33qxq7m9Rq2AaSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkpM0Pi9p1eiuFriq+ph6IaTwHn47E4H1XP2Y3LP2sVh99knGDkYY4WB8SSNydqjbF+7qDGVu04eOk6tS9MATUKO3UEe8YGJEZA7YjisQMdek+Iz6mmxrPP3EjL0pUdUlOLD8Ciss4bFxxkgHjcELYd7yjttZh+32sSV2Nhfc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ovJdySfu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ovJdySfu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0mXE4352283;
	Tue, 23 Jun 2026 06:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vp+Cbi
	lTka8QUgJ8jBBtinfc+r4aAndzPjmuhbG4LoU=; b=ovJdySfus5P1wH+xVD34hK
	TjhX2ZsgRKcufeg3cSJYfon1einVZeaNHRPtI2+um2Jen/12vpDtwTZxj09bR53n
	412ap/k+d/ozTzrI0f4efrkX8W7rYicrqimS9Ev4Zw9xlGZfMnt/6k/ElHyUWq/t
	htBsGBLseJmZYMuN+Jivfy17EQ2vFsTwVpljwuE/UZfc76LvlI49NIo3LXGojNJP
	MzWq+/HY/P4o2V142IhBP9FWCReXtvSF28jLo1xen64OqTeGpuBi0RFo4BSfo31a
	FfTwi5Kg30JSDgfRG8gssEkBoJfED0kMldH7Gpi6tAzr2dBPmqTAloaGdVE/2YZw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4cwkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 06:13:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N64rCD003576;
	Tue, 23 Jun 2026 06:13:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qa1qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 06:13:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N6DNk443385164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 06:13:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6D4E2004B;
	Tue, 23 Jun 2026 06:13:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D06C720043;
	Tue, 23 Jun 2026 06:13:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 06:13:22 +0000 (GMT)
Date: Tue, 23 Jun 2026 08:13:21 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH -next v4 3/4] mm/kasan: Introduce helpers for lazy MMU
 mode sanitizer
Message-ID: <20260623061321.269982A64-agordeev@linux.ibm.com>
References: <cover.1781789772.git.agordeev@linux.ibm.com>
 <0d76139923a280617a21839b7e3f3e7735b58fdf.1781789772.git.agordeev@linux.ibm.com>
 <20260618150048.F396A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618150048.F396A1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0NCBTYWx0ZWRfX7FSXNz+X4G9v
 JmPk/OSyGK/NtLCS/IYq3u8Ue/LJe4wv2uic666ZxDKYXw2o3osiyYC7/bNqyV+3nGlI8K9vVIP
 oyT0uuJIPvgtvG/RrJ6eKoopmfBgOdE=
X-Proofpoint-ORIG-GUID: 6KIgL9L5teJxi2xUwyx0wBCH3RcJ_uga
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a2407 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=V0YPiZzyHSctQc0-2CwA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0NCBTYWx0ZWRfX/kfwYAweLXrB
 zbxkto18TPoc2YJH2avElIwFyl1EeT817XN6nYc5/cYmF9eYjrtsJwsK0L8WkM6fRMsWfmImQ5+
 eqJvJlHXhB3BqY8EfoZRw549S/4MKZ7KFeKqYPgzq1F9uTRJ+0/kH+x6apFeHFqf/PpmgkdTRy3
 HOUDhxvoWm3TUJ2c4/k6DZyCFNM02wB0hGcOXB2YBy+hXa/q6Eqgswl9VaHPBANZjtzcz7U703m
 58J7KDJJlfUuOgvqSQZvkTH8HwFtIMrULCuoeI1uoheJFeS3daXrebXQSHUE6AjdhDENsK+ETnt
 9YyXz6BSFuGls6YPicZb8MAbE/iud7X7oBqNtFIktWxLVsAKTi0rH/gcNd1bTgs/k6PF9pe0Kxb
 okGxTxAMUBieKQ7xsJT+Pk5WdYV9+ccVwgMbKy7ZYnnOW3tiO+hHIb+q6Stmm6TpUB2C6cVI6Xm
 XFeXs/MCr4ckqOtPl6g==
X-Proofpoint-GUID: 6KIgL9L5teJxi2xUwyx0wBCH3RcJ_uga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230044

On Thu, Jun 18, 2026 at 03:00:48PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The new KASAN_LAZY_MMU_PTE shadow value is not mapped to a bug type in the KASAN reporting logic, resulting in uninformative "unknown-crash" reports.
> --
> 
> commit 7d8731323b7762279e28d0aef3b1b3c457449b81
> Author: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> mm/kasan: Introduce helpers for lazy MMU mode sanitizer
> 
> This commit provides helpers to allow architectures to poison and unpoison
> PTEs during lazy MMU mode. It introduces a new KASAN shadow tag to track
> and catch direct PTE manipulations that improperly bypass the correct
> accessors.
> 
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index fc9169a547662..8ba0fbabd75b2 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> [ ... ]
> > @@ -144,12 +144,14 @@ static inline bool kasan_requires_meta(void)
> >  #define KASAN_PAGE_REDZONE	0xFE  /* redzone for kmalloc_large allocation */
> >  #define KASAN_SLAB_REDZONE	0xFC  /* redzone for slab object */
> >  #define KASAN_SLAB_FREE		0xFB  /* freed slab object */
> > +#define KASAN_LAZY_MMU_PTE	0xFD
> 
> [Severity: Medium]
> Since this adds a new shadow tag value, does get_shadow_bug_type() in
> mm/kasan/report_generic.c also need to be updated to handle it?
> 
> Currently, if KASAN catches a direct PTE access and reads this shadow
> value, it looks like it will fall through the switch statement in
> get_shadow_bug_type() and default to reporting an "unknown-crash".
> 
> Would adding KASAN_LAZY_MMU_PTE to the switch cases ensure we get a
> more descriptive bug type instead?

This is a valid point and the fixup would be:

diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index f5b8e37b3805c..0100e4354a44a 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -113,6 +113,9 @@ static const char *get_shadow_bug_type(struct kasan_report_info *info)
 	case KASAN_SLAB_FREE_META:
 		bug_type = "slab-use-after-free";
 		break;
+	case KASAN_LAZY_MMU_PTE:
+		bug_type = "direct-pte-access";
+		break;
 	case KASAN_ALLOCA_LEFT:
 	case KASAN_ALLOCA_RIGHT:
 		bug_type = "alloca-out-of-bounds";

> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1781789772.git.agordeev@linux.ibm.com?part=3

Thanks!
