Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D998460
	for <linux-s390@vger.kernel.org>; Thu, 17 Apr 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889993; cv=none; b=VgVOiiSG8l7NtpGkasTXhCeYMbOdx5Dqq5SJS/G4HCly9BLuEr2IEuw3rlNWdIwp1CQsm2zPmnMAFcJf2BvUobY95EttrK30lAcueCO8jCX0JNer3KpPAv0ztb73/CNiYjb/mvxrJG3HcuT6QbaphavKkI/sM5Wh0uM4MILP9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889993; c=relaxed/simple;
	bh=vxXCKnz9fyPiGAlzhXmGiA+PzlK1OU4GIoWvXCeNBkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkIGp3I4nrSLqHjgn0W818YlPXZkVocCWO69bw8WVcjBcCCW/jzmdr8X/7YKenZGGPBMdjQXwHF7Ifx37GfpjnHcgV4a5PT7XuHW/fbMEK9W3g3l6c8BMwKu0ennw07i4Jmdm/fe/JxeyQmcu1BRVd2T40NxEkrRMK4tV486ess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N48GCt+Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N48GCt+Z"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H7wds7015008;
	Thu, 17 Apr 2025 11:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vxXCKnz9fyPiGAlzhXmGiA+PzlK1OU
	4GIoWvXCeNBkU=; b=N48GCt+Z+WHEOSRCjmax0Ax9GV30cWdhvVlK5nAnpSLVfS
	bL9JZzWwpObNwD75gC0v62YqdN+A6gCA0BqZ+mEiA+TTySrfVbnt0kGQe3cbeEgy
	kBSEUUbGTjeINAEzPQ3CMt+VAHdYmkL4Op7I1LJvI1hguwYJRJEXQMjjDEL6UssL
	q7OUjgD1Ci7/RS1XLKmPXTLGwhvNigyDpWH0EFwdxhQLpjrNCHlQdXHs0hOMXKIF
	tzoes0puuQ5HdWk9G2O+qx3PEkupVvOG55lyzKeIY1qDel4Fh8Eh8dB3T3WNFobG
	q4ZidC/0exB2vRbEwuH5emi9P/uReBpQfYwSngfw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mn7u8k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:39:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HAmnrS017170;
	Thu, 17 Apr 2025 11:39:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m5as0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:39:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53HBdiFD15663420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 11:39:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C0BC20040;
	Thu, 17 Apr 2025 11:39:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B55A120043;
	Thu, 17 Apr 2025 11:39:43 +0000 (GMT)
Received: from osiris (unknown [9.87.137.75])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Apr 2025 11:39:43 +0000 (GMT)
Date: Thu, 17 Apr 2025 13:39:42 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v6 00/25] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Message-ID: <20250417113942.12521C5d-hca@linux.ibm.com>
References: <20250416135801.133909-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416135801.133909-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ANnAolku c=1 sm=1 tr=0 ts=6800e885 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=u2_EUOgfcXWWuWfTchIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: A4m9Ogs0NmXYQ1xzxUTee7Wcf87iYSqc
X-Proofpoint-ORIG-GUID: A4m9Ogs0NmXYQ1xzxUTee7Wcf87iYSqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=768 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170086

On Wed, Apr 16, 2025 at 03:57:35PM +0200, Harald Freudenberger wrote:
> The patch series starts bottom (AP bus) and goes up the call
> chain (PKEY). At any time in the patch stack it should compile.
> For easier review I tried to have one logic code change by
> each patch and thus keep the patches "small". For the upstream
> version I intend to fold them together into only a few commits.

I guess the statement about folding together into a few commits is not
true anymore?
