Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585283FD15F;
	Mon,  2 Mar 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466057; cv=none; b=ri441PTY48ZCWaXdlAwONX15y1HMq5O0iJ07F+QfoI70FIhHSUN++h9QEcXmh4VCITnuZxnE3Wxtkpygogdb5AKJZJcLNXmTvp7dpYBZZg2R8lQQAW+J2jlvH2ddoXqu0q74CbQlPWDFIQda6/uHfw9Msfny+C8W5en+m7jgb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466057; c=relaxed/simple;
	bh=ynRF1HovJqpoAa3+j5Js7C5BeNzCwiUbHmxsFTbfDjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6ccl3sbBwnjJgWSv1IyN9Qb+yo4S0/aUpDdrGMqcH6gU8ILBt+DFrrVRAQ6z6E6rEWM69CHZSRNqR+eeyH3vpTwFv0Zytz++uQJqqY3INpt9mHZa17MRq9qSMbdKUkZ5bukWhETTIj56UbH0WV84Z18puPz6yte2J3HqYS3/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jZVCaB5i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jZVCaB5i"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622Ax00t1233029;
	Mon, 2 Mar 2026 15:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VzJMNue8WFv/RW6jPXU2EPM7Xox2/L
	+aWE3PsGluIRc=; b=jZVCaB5irxuPinbtTtNlxPu1o3gyODNZSzpr+CL5Tqimu5
	UhdqoAu86jLJIVc5SMkEOSaI46oPQCFlYYoaBz1QPYzzxgJXjrBirO0aqLOKcnuy
	CDFo6WcudPiYmmSEV4i7oA/f1dcfR8fh1iNeiCk+szzmxhd/WxMd8RNIgPdAVfRq
	JoBNeJbBIJjkGUt3DiKHqkjcOzFlazWwj86HSje7z5MML5CjsFebuf0DQjjdzLuL
	dXWAcfF6MuyA09vMf8FVGaOE7eumcwUd04+9Ct2pIgcgLCqOFLnhj9taWLiXue5z
	5xNco814S6yXaDmPRvSKCDyl94I4+eSuWL1i0I9g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3q40t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 15:40:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622EIcvg027710;
	Mon, 2 Mar 2026 15:40:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwj6fm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 15:40:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622FelEX59638116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 15:40:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD85620043;
	Mon,  2 Mar 2026 15:40:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F31520040;
	Mon,  2 Mar 2026 15:40:47 +0000 (GMT)
Received: from localhost (unknown [9.111.42.248])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 15:40:47 +0000 (GMT)
Date: Mon, 2 Mar 2026 16:40:45 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] s390/stackleak: Fix __stackleak_poison() inline
 assembly constraint
Message-ID: <your-ad-here.call-01772466045-ext-9689@work.hours>
References: <20260302133500.1560531-1-hca@linux.ibm.com>
 <20260302133500.1560531-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302133500.1560531-4-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zse6fxysxo_0ZaexxLTmCtZdcjDiihm-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMSBTYWx0ZWRfX7RxJKQm8VwTK
 IEOaRexFuIAnpW6n11Eok8hijBPy4Eas1VGnZyvhmpkNwbsce4gciCntmIR6wXIE46GK1bGqj5e
 UnYeWtqAsoJjFiatewv04Pxtrx4JAQF8iKj5rX4++pahvxyux9QL9pu/3ZxV89xe8JDd5Rt/rcQ
 ey8Gf4n6Wc/jjpce8VotQfCPEEBokZ/M1a6cJ8atVEEpbrvn4tqdE8y2lfiAfiuuorON9t8xuwz
 3sLkqmrZRehzMRJqxJ+X+HyV/7IuODRTIPAzcgY1/pQ0tEKY9cW6NAyqeRHW9cWSqT/h/LD7DNy
 P6syf07W2fkWDV5Jr1ZdCAyacg8Usu+EO71v71UuN/iw0uKsuRHO2dOuCgTWvKh+vhnUiQW23U9
 F+YO7OpOlvrMlsjf4g5tDUG/ROIYkBQi/nxJExCfAjmPh26zXFPFKRAuVwcPjuQq3UQUev2hmMM
 jp3771Os+0bYfQwu1ug==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a5af84 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2bjmQ6Ql1u0Qu4szMpgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Zse6fxysxo_0ZaexxLTmCtZdcjDiihm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020131

On Mon, Mar 02, 2026 at 02:35:00PM +0100, Heiko Carstens wrote:
> The __stackleak_poison() inline assembly comes with a "count" operand where
> the "d" constraint is used. "count" is used with the exrl instruction and
> "d" means that the compiler may allocate any register from 0 to 15.
> 
> If the compiler would allocate register 0 then the exrl instruction would
> not or the value of "count" into the executed instruction - resulting in a
> stackframe which is only partially poisoned.
> 
> Use the correct "a" constraint, which excludes register 0 from register
> allocation.
> 
> Fixes: 2a405f6bb3a5 ("s390/stackleak: provide fast __stackleak_poison() implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/processor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
