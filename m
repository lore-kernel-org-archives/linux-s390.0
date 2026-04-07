Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F113AF67C;
	Tue,  7 Apr 2026 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565208; cv=none; b=lPBJSNR6pYzsdBGHWvSZZtKIhnbpP/qT5jyL2C+n2i0uyk/qQRo4EuBrOfnC7qW2aYankG5W9rctkGmzt0GWZ0WFHluAIJWs178QVJnaeBOKWvWy3ElyJMHG1W29BaWkTogXJB/xslhw+Z6WPfRqzJ2FUAbcITyUZWx4yuW1PcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565208; c=relaxed/simple;
	bh=8+jRyO/upQoHbAYSQ7RqRtZtJOgaXFMUklJ8wiX1xew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjF2LxWqTPAKQy+mFUSDQQ6GIkMF2hBI7DyMQgkU3YCiEZO/ovNM/gOcfoWIlGatvVeb7BBPaZua6FjDuaZ/wHPexTqzf6DLyyWQ5lKJ3rD8S2j0WqUqp/snty/qkIPaRD3ASQHV43QBjxBh1t1gmWYP2cAtvSOTD0Wada4pxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o9ev6qm8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o9ev6qm8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmCUa2326198;
	Tue, 7 Apr 2026 12:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4qRjhP19SknR98BpGsnHIiIbsE3tGx
	3CRT6J375itDU=; b=o9ev6qm8zVmA8HclMx8eTey9FZ05KJdJFN15sEIJv3QiJl
	MMAC/R/3GTEdgdgNvQPl0LjGuyyex2yJ+0S8/t9gnr3nEUFETDP5jvTcLR2GR23e
	fxmPUQmYTkjjaY6T6LDMJqzwyCbyMylA3u8WScuaIYTgp2VWGWuxPwkHhxC5+zOz
	H2xePhNfRmdA6VzIxOc9s5UmK2iCVRCcm2FtuOz+98VALv6j5JPQTzU71EQzpEal
	l04/0IYOnFZR1s2M/bxVYea9i0Wj3+l51OgtrYwOPTEZIWndXWUp1UTbnlJstt9e
	X12mbzdVcwoZBAUPWSSNOWICzfszUQs3W66pf+AQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kamrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:33:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BNSeS026655;
	Tue, 7 Apr 2026 12:33:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7u2y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:33:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637CXIIL55771626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:33:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5276A2004D;
	Tue,  7 Apr 2026 12:33:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BAC32004B;
	Tue,  7 Apr 2026 12:33:18 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 12:33:18 +0000 (GMT)
Date: Tue, 7 Apr 2026 14:33:16 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 3/6] KVM: s390: Allow 4k granularity for memslots
Message-ID: <20260407123316.296205-C-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-4-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402150135.196943-4-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExNSBTYWx0ZWRfX0TU0v5iuOnce
 GQFg1wnRq5Gy2IdRL+JBnjrwkWFh4WB9hkDM75V6WOgA0fvKXMy30YM2U6QYqqgTJmX+eUJ9Bmc
 Vea/WaUvJVX5ghPn8b6u1eNF5Rn0dFzjGH5RLaKARRHsbHhlPp606GCfNDmmVCM6QxPD7OwiFWe
 kxtDm4DpPXltRG0DrN4DLZYzwrw55SbKRTI/N+ZqssHwPxZHogbCNbUgkfpKC871zTg1JzCPxZi
 wE6w6MMgsCQmMZXRXsvbG+w4ovu5K8oLNl6zh566Nx9YvDxXuAghvEPzSVW4NJX4oWcpmIyI683
 3gPpgbihRYfY4FHg9oDBSA2p7DgKiE4jJHQ0lgfayQlm0ExUZM2sri4q7odfpBt9We9u4krOZ8g
 dOgQDPRwbaUfiZ0N8f3lL/YH2LI0ulZA+ruyz75XyAROsilOWeYotTYY+Gb4jFV+3rqzCjweBiA
 u1zaOLuIQzVxeVf3KgQ==
X-Proofpoint-ORIG-GUID: hZgU798jWR3OISQNgoWeQP8gYpvhB-YF
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d4f993 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=qCOx4D0ofwUGgT_s5KUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: hZgU798jWR3OISQNgoWeQP8gYpvhB-YF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070115

On Thu, Apr 02, 2026 at 05:01:32PM +0200, Claudio Imbrenda wrote:
> Until now memslots on s390 needed to have 1M granularity and be 1M
> aligned. Since the new gmap code can handle memslots with 4k
> granularity and alignment, remove the restrictions.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

