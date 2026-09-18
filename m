Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90E2E22B5;
	Fri, 18 Sep 2026 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720629; cv=none; b=KOhz0S8LBvXv2BWVtrWi5oMvnwdaFRy9DyZv3XcJVqtb96/PGveaN7LwOGawFT48ptkACTiS3WxubsfTIqL110FKB7r8wGhUvRKSCcmk4JTnvBiZcsAN8AuguiOyR+7MLN9LwTyYlk86BDi06rOE1i48p6giSPMTmAlkSQQxq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720629; c=relaxed/simple;
	bh=FhizB5ZExj7AcIvFWdqManMckpweNGlpBoA+12SGfTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW2jPZ0nv3MS8tXFVKy3UjsjLEdLrKUTz+WoXzbpReWz89ZcNITbcEcAYZpAMSJ8g9sFtVgeYfZ8gXHAjAEufXrluE/vnAX5o2dCmTjV3WgI80JQGTbu/8+39Qumt9p5Ld060UN66lW/akRNn6y1RNuBQ5+f7Z3ztL6q3pNKua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eqj7S/Su; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eqj7S/Su"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61Xav457227;
	Fri, 18 Sep 2026 08:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=nqjPpLNBvHL1CALtEp6BKY5ekjkOmUllRfLNvKAyJvE=; b=eqj7S/SuvH96
	XqEkSmvrdyyieFj8BSYW8Bf9burlW2ZUHihpEI49yvaSI3Mv1BLMff89Ed6+Ti96
	RQYGsAPUotnGZpJtYarWCOUHCWPWZWdUoV7RnN5SkokP29W9TM9RadMm+EH5qR5t
	HQ97ySP39/BRBncyHhi4IY+BdSLW/y/SkpwOrElmnW0TnnU6NXaVD41KqcB7FCAl
	Jx9eb0T5PeB3C7VwJRj5DdXvFosX9QkzkWsmBhsEqo37vgxVZC13i3DrE3IhZUux
	hWfjVMD5lTrzHwrlO4sAaN8o6TBR1tDwle1tmgGD3s1F0NCQhIP2IBqgDtcONGdW
	atNF9N2+DA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx8472jr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:37:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I658Hp1154925;
	Fri, 18 Sep 2026 08:37:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gep3cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:37:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8b2u044040480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:37:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5BFA20043;
	Fri, 18 Sep 2026 08:37:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9156D20040;
	Fri, 18 Sep 2026 08:37:02 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 08:37:02 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x7U5e-000000018Hd-1MRy;
	Fri, 18 Sep 2026 10:37:02 +0200
Date: Fri, 18 Sep 2026 10:37:02 +0200
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
Subject: Re: [PATCH v3 1/4] s390/pci: Fix leak of struct pci_dev reference in
 zpci_report_status()
Message-ID: <20260918083702.GE241998@p14sgen6-pf6akexs>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX+DXBWwelMzX5
 slaOD7ihGEx2rMSleD3YDdWsqsBghek94GfjDJvDDj8Gi7yMA5/AYozpHLcaatdpwEOqJ/1vaZt
 dvCpBEIv3WQII6MOozYLbH5zMD2wOnk59iICuZXwIY6drMCo+LyxcclyXA6nRzUVwscix4pwtDk
 SOBKh/SJxSx+vlMmC9XpwI4wcdxkd2yn3kpUHpOVSm2K7UdBcFiwAwk7/DrRfK3Mu4HZCbvyS4Q
 APjbv9tzMr705d4Zg9Y74HdN5VnQekPo3hxvpE0gTi+ACJ/ZpqMzbUxK7Xd0LKYw3hJFlghfVy4
 okje9yo+ufPCmTv9D7wHJ643ipDXUmdJaYQbBcqmwYasi5Z1ByGPccLGw4HwyY+YGFMRIghq0V2
 UqTV/4p14dQ/fJll1y6WXdHYDoy+dJEFEYxku/fcXL35CK8pqAIX29N0Eam5y92RFd4A/9ojcOE
 Fdi8L6fDZWiOVngrLSw==
X-Proofpoint-ORIG-GUID: zONXxVGo0wZKvfjh5X5zi_ok6ALvg-OF
X-Proofpoint-GUID: zONXxVGo0wZKvfjh5X5zi_ok6ALvg-OF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX3xUpY911wqn2
 Xdt/DxVd/nblNvpf07V1B65MNTTrlzUg9LehDfqrM47ZQpOk+Yrf+Vi67wg6ciQ8Ni/xnrZRWuU
 I0mA0kQ9S+cXujqFSRhnpqf07KzYeTU=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aacf833 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=fO76wDjEhIgSLRQtgmkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180117

On Wed, Sep 16, 2026 at 05:14:10PM +0200, Niklas Schnelle wrote:
> diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
> index 7030f7052926..867419779219 100644
> --- a/arch/s390/pci/pci_report.c
> +++ b/arch/s390/pci/pci_report.c
> @@ -89,7 +89,8 @@ static struct debug_view debug_log_view = {
>  
>  /**
>   * zpci_report_status - Report the status of operations on a PCI device
> - * @zdev:	The PCI device for which to report status
> + * @zdev:	The zPCI device for which to report status
> + * @pdev:	The PCI device associated with the zdev if any, NULL otherwise
>   * @operation:	A string representing the operation reported
>   * @status:	A string representing the status of the operation
>   *
> @@ -103,15 +104,15 @@ static struct debug_view debug_log_view = {
>   *
>   * Return: 0 on success an error code < 0 otherwise.
>   */
> -int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char *status)
> +int zpci_report_status(struct zpci_dev *zdev, struct pci_dev *pdev,
> +		       const char *operation, const char *status)

One small thing that is in no way critical: I wonder whether we could make the
`pdev` const. We don't do anything with it apart from reading some attributes
and such.

>  {
>  	struct zpci_report_error *report;
>  	struct pci_driver *driver = NULL;
> -	struct pci_dev *pdev = NULL;

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
