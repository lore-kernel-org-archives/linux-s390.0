Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B8263F44
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838586; cv=none; b=PxpQqgjVIK/7CnFgTztj82scyTaOS2vFXi4qkkMEEA09loc4t0z3l7Qx6SjJbBWCshA6FY26tlVj5Curd1L2gl1GltkpRCTtKKsZzvpIHIrwTo8C6e30A1m4kwtABTwFXhOPFe4jnyd9obHb4JGLtADONtXTjAP3PxgjpayyoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838586; c=relaxed/simple;
	bh=1VUb5D22bnkU4CjpqeomYIM6HUS7rPL6nEj+zF+ssfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoQT40DaAFdDtlBtYFWjRe5RN3HGp7jLz14FFnBtfrHesdLayGclF2uEGS5zfsg2Iwx9frE1e1LQeFVfPnAgtvHD5lvHUbBvzwoQtCy9ONhtxdVciuGlztm3XAzVWVypIetcHbpYIaz1U2hCbWybFIyUQ4lmHC268wd5cpEP704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L/bl+P6t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L/bl+P6t"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVY7e1126149
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WA/vQ4rfRJfeU2bhL4aJZFG653iLvG
	8yqVU7/cvHxfA=; b=L/bl+P6thtExbJocBVVfZosKWG5CwGeliUqRuk6eAejR5H
	FW37zxhAjxGc1zghJEeDheP/e95y99dPE3EZHXIHJhjN3cJbGp1yAA0QaHe83xuo
	J2czQ01omiJrv03QcumL3qC1cmS1abIt3jTptUkycke1A81xdZy0cWpKp6ljHqPx
	EivmCQnmzBKABcBEtqAxmkqIFo3wrh6Eyi/nj2PzmOxFiYgq24yGAisYQ450ux5X
	/Da6doCPvSvZLx/xiQSsnBoHGDW2rB9eBH7HoCMNYNWXTox/jdriueKrWQxA+ebp
	k8/44M+rU0P0CUs6TBw31FP+m+47xca1ZDIuwIQQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er5nmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:49:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDfavh015120
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:49:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyg3j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:49:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RDndLP51249424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 13:49:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AADBC2004B;
	Thu, 27 Aug 2026 13:49:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C47A20043;
	Thu, 27 Aug 2026 13:49:39 +0000 (GMT)
Received: from osiris (unknown [9.111.16.137])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 13:49:39 +0000 (GMT)
Date: Thu, 27 Aug 2026 15:49:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] s390/boot: Bound command line facility ranges
Message-ID: <20260827134938.25110D0b-hca@linux.ibm.com>
References: <c00-03.ttkffvj@ub.hpns>
 <p03-03.gfb54656967a2.ttkffvj@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p03-03.gfb54656967a2.ttkffvj@ub.hpns>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8zyzbLjC1Ylwty1Qm4b23uM5qpYz9kP7
X-Proofpoint-ORIG-GUID: 8zyzbLjC1Ylwty1Qm4b23uM5qpYz9kP7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfXx9vYBbpMpzB9
 CnNXFbuOCc3Pc+rJLTPsTiPbH+NpxL0UsCAN5iH5q89MDUJYbPQoXkOA2+tM/OlDw1sDxeqBv6l
 2nALUfwsa99UYvLMrB2h4saAQ30FBCO7Ye9ABFKx6/ud2H83qkrasqUHmRY1nKl0DGrxYQu+4cB
 ACSk68Sy5vmxxp7/kDq78QoAbLd/MMy4RA7F5mHgNqc+LtmSCIb1WVfBmvAgbx6+MNU3tppyIqi
 r39P5YaS68ExKcMD0W8MkLkVBqPFGy/kp5GzPNHJp0O2FUniMlkP6AxboM1Z+X3vFaMRTsFpZQg
 H95WCRJ/TxNbkmRRJQDwHwsb99Q+Xdm5ZhpHWZKMD8xO3BGIC8kzgu9GJDo0faTlUA/CsUGoSNB
 ZCgJq7gZxpTwfS0q8IbKq4HvxHUP4mIq2gwBphvWA4Jwx6fOSTeB2kB8WxwpnB1Rd4ZOOMgsy37
 X0R/z1BwtO66C2s/hCw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a904078 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=MEMzB6hTcCgFQ1MD5gAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfXwgzIUW3Fv4PP
 cxygulCaAAneQ0AWBaUayZYhtCGT7jRJLds2ctIuyd++m+tVYCt+HnRJX5DoPEdEh07IMBWI+y3
 Lcs28dSa5oS544mdao0N/XcVQyNsAIs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113

On Thu, Aug 27, 2026 at 02:01:31PM +0200, Vasily Gorbik wrote:
> The facilities and debug-alternative command line parsers iterate over
> inclusive numeric ranges. If a range ends at ULONG_MAX, incrementing the
> current value wraps to zero and the loop never terminates. Large finite
> out-of-range values also cause unnecessary early boot iterations even
> though the bitmap helpers ignore them.
> 
> Stop each loop at the size of the bitmap it modifies. This preserves all
> meaningful range values while guaranteeing termination.
> 
> Fixes: b5e804598d59 ("s390: allow overriding facilities via command line")
> Fixes: 15c33a5bc9b8 ("s390/alternatives: Add debug functionality")

This is quite esoteric. Not sure if this justifies Fixes tags.

> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/boot/alternative.c | 5 +++--
>  arch/s390/boot/ipl_parm.c    | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
