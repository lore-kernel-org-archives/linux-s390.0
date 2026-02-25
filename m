Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82DC38E13D;
	Wed, 25 Feb 2026 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011173; cv=none; b=WpNNjDLr1cFlJkfm2DZpBu/gZdAeh5z/v7mLYTg3n92Tw/DJ2EkAOiLqHQZK4+VzY0bf8Sy/JMZ4ltknxTU4SoEyYnPcGLGF4RUYXhNBfygbxIvEWW29vVrOvW4m6dLc58BxfaMWL6Miy1NGOjIJb/eE0aLZvd/swn3U8i+qCic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011173; c=relaxed/simple;
	bh=0meuorykT4zFIKJ01w8wv7iLcoHa6OtLoVxSULAqE1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VPfEjARD+4nRf0O8mnSm3Ybk5aDr/R9moKQ74KSiLYNBhN6d/UaV5bVWvYAK4ILxjUdy4NHMasgsGQ8YCqpjBvfwgnMNtoRjDe0q7av6CGmLDxM9QBtLgvOYgg389JuX1YNy1YWO2QXPYFFCQAC6dT4/7N8WGVqO+b1Lqt55J/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s9ehq6KB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s9ehq6KB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OLCJ0o3039381;
	Wed, 25 Feb 2026 09:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tft1VbLqTO1YStaWTqpmRc4gmZ9XBA
	RBCVDYbd3HgKo=; b=s9ehq6KBCLYj+RpB9XiHiD1zQ8Vsyq7BGcdUN4F6FTRpfD
	6UonMK7ked51ljqhNXLaofloy10brUPETtGmoRlmXPCf6V++3cmPDFocqx1thBIj
	Rx7GSClA2dGdo/iIhg4pyABFYEWAuvhG+DJmRenhcvgkPmLlD1ao5VotpQNdenVp
	55S4ELVjxaBfKn7MbWwtZqzZ4OjzrLLbEob3yq4xEJ/mfY3VojfaE+hOseSiNCIL
	dB4sTXyZToOUAn0cVY//yr6EzeJAzkyYEsomiNaVf6QbQXpzE9lqsIsX7zA9hION
	7VeTVHUqTqqYOGv0mV+OPL0jFKxvjhTqKMB55SHA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqyfqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 09:19:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P8nUq5004541;
	Wed, 25 Feb 2026 09:19:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jvfhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 09:19:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61P9JN6Y46989618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 09:19:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 800432004B;
	Wed, 25 Feb 2026 09:19:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 629E320049;
	Wed, 25 Feb 2026 09:19:23 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Feb 2026 09:19:23 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/9] s390/idle/vtime: Minor fixes and cleanups
In-Reply-To: <20260218142012.863464-1-hca@linux.ibm.com> (Heiko Carstens's
	message of "Wed, 18 Feb 2026 15:20:03 +0100")
References: <20260218142012.863464-1-hca@linux.ibm.com>
Date: Wed, 25 Feb 2026 10:19:23 +0100
Message-ID: <yt9d342p18pw.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f8JWUVl4r8QUynhte05SsHUBTD95EkUQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA4OSBTYWx0ZWRfXwNW43bgskPNf
 bZt/VIDxVJwD7KyTTzQLVLu2zXrIRBUL3d89K7ArrzfIJZPoLrQo37wcOX2d1LAjxk/qOUwSvZR
 V1ySlYGhVI9s0EsKVpJ7nNsB87mfwx0SkN4ONERKZE6VeisZoVgdemZHSX5GPmI0MHB78Bjh67S
 Yi3cljkMxdRxUUoHWxEF4W7sFelWvGsIEYqnqTF2tqLrRXiSk5hqepS6zqR+dq7tmyTmGN+9mJV
 RjA3pVQnELnglSslN0e4LNFafbi814s/gh46NczWUBy0cP6BHt3s2tQFoopGngoNU1uiVxbN7us
 z8QyB6p5uDKxGeuheIjA9gsFFwoZdVuNeAgepPYCO6RdDRpUQuXxYF+oM62Iuj3n/Bo8w6ODw17
 rpmFr0GrcpUecjrgIrkzFMK5NRcoLZmMJtZ0GVh19OqkK+jqLa5SPx/ZQPg/fweRhYjrzuSLVZ4
 vZabpmiyLXBTduuHcaw==
X-Proofpoint-GUID: f8JWUVl4r8QUynhte05SsHUBTD95EkUQ
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699ebea0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=JTawB1T5yoWm6DnOLoUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250089

Heiko Carstens <hca@linux.ibm.com> writes:

> Frederic Weisbecker's cputime accounting patch series motivated me to
> finally have a deeper look at the s390 cputime accounting code. The result
> are two bug fixes, which are not at all critical, and a couple of cleanups
> and improvements.
>
> Heiko Carstens (9):
>   s390/idle: Fix cpu idle exit cpu time accounting
>   s390/vtime: Fix virtual timer forwarding
>   s390/idle: Add comment for non obvious code
>   s390/idle: Slightly optimize idle time accounting
>   s390/idle: Inline update_timer_idle()
>   s390/irq/idle: Remove psw bits early
>   s390/vtime: Use __this_cpu_read() / get rid of READ_ONCE()
>   s390/vtime: Use lockdep_assert_irqs_disabled() instead of BUG_ON()
>   s390/idle: Remove psw_idle() prototype
>
>  arch/s390/include/asm/idle.h  |  4 ++--
>  arch/s390/include/asm/vtime.h | 34 ++++++++++++++++++++++++++++
>  arch/s390/kernel/entry.h      |  2 --
>  arch/s390/kernel/idle.c       | 25 +++++----------------
>  arch/s390/kernel/irq.c        | 20 ++++++++++-------
>  arch/s390/kernel/vtime.c      | 42 +++++++++--------------------------
>  6 files changed, 63 insertions(+), 64 deletions(-)
>
>
> base-commit: 9702969978695d9a699a1f34771580cdbb153b33

For the series:

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
