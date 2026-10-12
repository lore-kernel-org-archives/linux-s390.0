Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAD48EBF7;
	Mon, 12 Oct 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815728; cv=none; b=beaWCWl979s51OODAlJlf6bJhATtmpyEI2X85YiQkTCtg+5VGJ/iyej/Uc0GxJLMZzZR1eUO/I7nOoT6VEF7CJ293gAmOfbJEwQV7h4wJui9a0cdpoLbJdFl3S4THgkts9vNjsaTcRIl+m6M3hOTov7aHGmiZOkNZRschzNqmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815728; c=relaxed/simple;
	bh=GtO5gQgdv/Yc+pLXKoY+5WyQsxrU3QXnNYhUZ39s/bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPRSvXxNZ4j9Gkvz9os75NxJkEdvESAnIZnYN5PsQq/bVt4FrZLoKw76r7imkr2IfPmZKInLtpWmmA8XnJEtpf3tldBt22WeA+8mdpQaXKyN7bQ7y4JbyXavfUPLtZlbm7rKM+ISTWnwSrwwr7NK0dD41+CcTGiHSid1OAnkES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DlQCxtSs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DlQCxtSs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEI9J231301;
	Mon, 12 Oct 2026 14:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sVr1MCy/r06DIuIkEIpDyeZqSctcdw
	umg7EBUaNlPkA=; b=DlQCxtSsGBAFbvIBzDAJRbdgroSdwUx6oAFbTuqzwfrYT4
	aFOMOxZlO7i/5Pw0q4ILmAViiV1fhRUJStILsXstjT9VyVOvkIKb9eZiaYnc9obm
	GBR6N7nxthCEce+MMaK21K9xR5qkXSIJsQtfFSZUXug8ofOpHA0MvZuFK2JU9qnC
	gb0I2ppKL5trcFp/UOQ79OljtPXmg2MV8hSEDq0ssAcsCXku+FMfcd/bx88TjtGL
	rP4K03iGA2dsKXepaNn+ImjrT6z5Lg/c1q0t0md8Oc+DSgJaKeczq42qtnd62NfL
	mpeo6TdCwgglDgaDA/8dpmVFtZKQmtqfyEn24agw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w121u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:35:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4u8m013446;
	Mon, 12 Oct 2026 14:35:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfwd90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:35:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEZMeS16515460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:35:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 393522004D;
	Mon, 12 Oct 2026 14:35:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17C4D20043;
	Mon, 12 Oct 2026 14:35:22 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 14:35:22 +0000 (GMT)
Date: Mon, 12 Oct 2026 16:35:20 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/4] s390/percpu: Drop unused output register from
 arch_this_cpu_to_op()
Message-ID: <eb95b502-8505-4914-902d-105be51ef21b-agordeev@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012114249.2898572-4-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX3uxqSesrwqom
 rcLEwT7os9fnVQ70VGSS0TFpO/e4gl1+/ecDRsti7ZwF+eF7cUnrB3/n+hEErR9CAyfSyyzyb4S
 tf9+oPqeHh8f2Qpciw95MaHZb4Uun2c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXy37OWHvoQUXP
 jCTj2y8zROuLiMy1A/DlkU0KBb9tVr50NaS3MzNXZPlHhie9A18aJVwqoG2yRnDp8nCrnZ/du7P
 Zy9q54OVe4WefsoNEL8UDdRc1RCxvgP8yFLBzd2hPNafQUL5u7mjC0hwJBJlL2JycClKC2I7qjN
 bb/qkzsYL/XwfdU87DSKErBci9EjP/kWnNx1kJ7rzo8LIKzLgUt0OG996sYFb2ZAss+gyRM4G2f
 eVJtA7wCM82ZzZQ1dAu94XMwKtnGKyISThrxsKVFJb4VMc3/DRErcMN/Zn7/6WitdreNRioPTOx
 Qu0NmNToOTU79SSkMjdH2N3Grzo4uE+lBiVjzIy25M4GsNovVn6Ndy4dYIJwnVEoCW51k2dA5r6
 RgJ2Dns16Pi8qy4c5SQHcukE5uxURrCiiHVAMrmlLcqW0FcVM/xzcn04uGAVN04QKP6C4soXjC+
 EK3stcFXxpnDkPo5vFw==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accf02e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=hrbHa4fqjneYn2M9ZQ8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: at8g2o1B7DEmWVIUFxSW0n4ipxRHRNKW
X-Proofpoint-GUID: at8g2o1B7DEmWVIUFxSW0n4ipxRHRNKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056

On Mon, Oct 12, 2026 at 01:42:48PM +0200, Heiko Carstens wrote:
> The lan/lang/lao/laog instructions return the old memory content, but
> arch_this_cpu_to_op() does not need it. Instead of allocating a dedicated
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
