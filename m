Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA33C942C;
	Fri, 18 Sep 2026 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720467; cv=none; b=D4/XlbRrq9qiXxVP3u7wlDUXsu4jui2uVzGeNTdEhB4ZfbUxXLfLxz2oRtfRkjr9x+37qOAZvGkv+V1IGwSI87gBiPO3JY33p3+PAuzrQUd/1kQ9R2XimyYJn/bjkoez6Yh8U590+WjjuvdIpkeGsS1Q4pgxtBsylvO0Kn7m15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720467; c=relaxed/simple;
	bh=Xo2xXtNBqXIR9laoiskV4yuBu6CYfP4f+SvGhN4thgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbNjwg7sEgmsoFAL4FGbygzMY1Op6CSa9JFuKBV7Hl0RK2CIUcJfVOBuCxaz6cXtvnsm7LwH4EPQFN3dmqeyBfTzGu5KINFYAFUT2EFvCVR2w12IVV5aneAFZl2aI5mOFniS/Qy+9cfmm9AfVhNjFlIojdi4MddMk+okGpQR1wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ed63ceFH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ed63ceFH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61e6h470785;
	Fri, 18 Sep 2026 08:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=63u8HjLw1Oj3UIs+KhcFKdZtvGHIz+/6XLI+oVYSpBY=; b=Ed63ceFHEH6j
	Gsm80nYntfeOFs+eta7XvqgsL1v/Sj1FwU9Tq/dOlcD4L52Y9Ah6KZUf3bIuBMLH
	ecLFS8nkVV5YIJ/gSEeVBHkPgIFr5pirl0rSr/4o/slLfKFH2SWY008ENPOXlvWM
	xCx19q4KY5PMk/JzhnWLZDulpNTCHJIKChHx1O+BkSsrtwtFuiJoAYEnvmM/AmEm
	oGPEenkXmtvD29OzvxaLgSTkpyetYyiwG+efCuRz1SSTXcn2kbIhKAYYnHr/ticJ
	KMrcTr9ppV3fRX3BW/lUk6Z6/wNUXTQfseBHpt1OaaRGVVi4l0P3ct+n12blUpTg
	Htr1z44j2g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5f383-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:34:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I652Pa1154834;
	Fri, 18 Sep 2026 08:34:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gep355-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:34:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8YLQX45678974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:34:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB1B320049;
	Fri, 18 Sep 2026 08:34:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6BDC20040;
	Fri, 18 Sep 2026 08:34:20 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 08:34:20 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x7U32-000000017PB-2bJc;
	Fri, 18 Sep 2026 10:34:20 +0200
Date: Fri, 18 Sep 2026 10:34:20 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] s390/pci: Don't report recovery success on
 skipped recovery
Message-ID: <20260918083420.GD241998@p14sgen6-pf6akexs>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-4-61a2f980e71d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-4-61a2f980e71d@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6SbXNpmqjzZ6MgCSk0rSz43PdyzkyLVV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXxATk0SRBJ5Ik
 vci+yV/vf3JQDJ5mQBJXTFyNXUtZgC9ca8xD610FGgV5JOpZaeI7EDTyGJIsW1U5ovvFkQujUZ0
 z8m6lGPBtLcQjrxzCGnnfzwUmMnN4f4=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aacf791 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=4Un3bHBAJC8VMyDCUI4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 6SbXNpmqjzZ6MgCSk0rSz43PdyzkyLVV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXxd8/2kCsyd6Q
 s3+LkWTfGD80gspeCe5mvbKtted0v2/0y0yvrhasi3eMbCPnbo76Cegc40yiK5xQBX7VGexL2O7
 9Q/B9k9OrHnKl6lHb09pbcEEzHOFqDtM3xwTMSAtSwZPrFyFfd1HlwAF+pKLTVrXIVKUEB/4DsR
 9dl4vXOk8gDmlnMPatiqNOD7RmAkA8/m5Ep90luIK/Ef+nGgooKqnPtyNQhb+ff1+dtd7Wq33Qc
 Olkjca6ZZ0eDjeZT8MIhD2sJ8ri//uGz50JFVS2ojugicaXEIVoU2lQ2pP8/HUa8u3LFAabWNyw
 JCDmOH/xWkuam86wiL3WFDUMdBpiZ4VlL/v3QLmgAm/rlCegDUwBSZMmPTc+2AwvT+XOEUnnzo9
 AOnlcQ33GIqLeinb4KPtZqtu3H5Udv005qQBPTW6Rwueck4LM+XlpT76GU3ComK2e2IAeK/cBRH
 pAaqpT2gvXLzys1KlTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117

On Wed, Sep 16, 2026 at 05:14:13PM +0200, Niklas Schnelle wrote:
> When a PCI device is already in the permanent failure state, recovery is
> skipped, but the SCLP recovery report still shows success. Fix this by
> changing the status string to explicitly state that recovery was skipped
> due to permanent failure.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci_event.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Looks good to me!

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
