Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32A34F24E;
	Mon, 12 Oct 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815692; cv=none; b=vBVfL8k6WUAU4TRSqMVOOlWmQEVbBCAmHnYuoLmZ/Y0V5Xx/HLXV4HRd/JNCWVbxsz9sfPyRn2dI5qexVhExNyYcSA48SbiJLM/x39/uob6WQP+iNh1CxJlzo0YTQdkm13XoS0s7QcJ0Q0A2E3lD2PkUwyfjRsr9AtgPnAvPGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815692; c=relaxed/simple;
	bh=Ngf2ZIYEdEkMkJ1nsmfyQT69Pf4S5l+FctNxsMqJFHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPRkX65pbM9wN397qqL0IPVuq5DS9mE3ch1XX8kW8ry6O85b9XFuGjHAhMtSNz52yn2qea+hP/TkxrqElFIgR1i2Lb1kkZ5LmntxwNvilvdtnBhrj6MNsocWG5mOvDKjnsxk7nEQGZppiMlJRx4mNFYJyr/DXhGBgmCw28uU3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QYrsXyml; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QYrsXyml"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEAfO182455;
	Mon, 12 Oct 2026 14:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iMm+Xa3DHMgTyQZ+/A+duNSngY9Spd
	t4CLtoxOtZzZ4=; b=QYrsXyml8oeDLPVXD2hMzWbUJBlmK6m76wl3ZkOVijumoP
	UFvU3kYcQA9NRB1DJKIUAtThcNnxCoFLSmnAQPf5MxhcmHPQlqQl9tTNbdZ9X1iU
	exL+GiLKBXm4T2e9jomsLOMpD4eBg1FpUTF1njksqtIS3AaYb8dplBYKrGxKgWDt
	7LHkV6GWaInThPV+u04yLLyGIEAGLtWERFhCCdkU+LywUQBitbJsLQB4hDumPJuZ
	FrsF6LDLgDGhuA0scNJuGjXTrTMMqMAynxCMS48EqCFcR45RRv+QgQl09nKIaoOd
	6Wjqd5BDGQrWVK1ga60K7+QB6MmSGzuiR7pjWBkw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv39cnq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:34:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4s8x1286237;
	Mon, 12 Oct 2026 14:34:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cydahb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:34:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEYkoR38863330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:34:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D51720043;
	Mon, 12 Oct 2026 14:34:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 201FA20040;
	Mon, 12 Oct 2026 14:34:46 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 14:34:46 +0000 (GMT)
Date: Mon, 12 Oct 2026 16:34:44 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] s390/percpu: Drop unused output register from
 arch_this_cpu_add()
Message-ID: <23b62609-3744-4b6b-8a80-3ae1b0edd07c-agordeev@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012114249.2898572-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fjBf4eL24L17dT6IgpmlZFkG6lFSCzY0
X-Proofpoint-ORIG-GUID: fjBf4eL24L17dT6IgpmlZFkG6lFSCzY0
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accf00a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=hrbHa4fqjneYn2M9ZQ8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX+V3gHRmi5Av6
 xrna4MbCWGaoSeMygqinY3WZT74JyTWgQ8f9DeGt6zNnu3X4/elm+2xQ2cMP3j26GfZZMotyzfI
 WSix3uRYbcXpLpqAl+mQIxgewiwRCSM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX65JycP2upIzI
 TdDCa6klsApuj/7tqEBjTTYNXAbucO0VKY1HpVm8pRVidXOxRh2Lp5A9jn+MTcy2+nA1X6ybyAe
 wVm3OsPXt/nvRcKgckcmrtTmSs72oHbCGPUvOZ8kimVm8ukGKGdt8P6sqCzO5t48oleqfKmWh2k
 IKz+3yGE8nw5Wn7cSd07+jzVsukv1HRl5ym8PJk8PuibGNnL0r5FP0v/eb5oGLUhVAFZOMgZBoq
 qPbEhzPgcc/8Ye5w685Ii/9PYdrZzpQihvqE77AffOnf9+thko65K2VwlZ/m0WtMvaocQnYrs/u
 rJWrqX74me2/XAlXM9u/DvZWvUdt2pBWE799LJJSbykEsGaNxnKnr7lNbSfh8pOs9zpfagvgl9E
 HziMIJIUSbRlKARS9jXgfZDsFvWc8qmOFqE+TxAcphI/nx9hTTbPLqpCUqtLC9uoxrcjoOuA2nm
 MfOr3E5VA3raTMdBPeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056

On Mon, Oct 12, 2026 at 01:42:47PM +0200, Heiko Carstens wrote:
> The laa/laag instructions return the old memory content, but
> arch_this_cpu_add() does not need it. Instead of allocating a dedicated
> output register old__ just to discard the returned value, change the
> val__ constraint from "d" to "+&d" so it is used as input/output
> register.
> 
> This reduces register pressure.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
