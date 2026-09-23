Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245046D57D;
	Wed, 23 Sep 2026 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155804; cv=none; b=fFd1tEl6RAPJbChWo8l85EpWTDzuOoFn4Rv5YSnjZKQL0aUSLTD9Keklvk4ygCG+NdHO6O2IcWhiIGRn5XqjeqglavOt1jqu4BVIKpVzlgtMs8f3R/+ucHgTMDC3Lao7lOYjYtfAV1rDNCtlLcwyzyb6CUDmTNNpjhSGc1cH7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155804; c=relaxed/simple;
	bh=7KGdJJGq5RqXz7A2MxGYRbng6M71fIW94sYcH+joxh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF+bHXnoDh5IwSHdjzkxgZgmQT2HuHXx0p0fepAxH8NWe9f1bWmpvko0VwkV+Od5Ltaa7g6lnx98ek3Sd7+MuuptsfkL9do6ktkzR8GpCENpaFF9GN0tkiuXOIbYP8Z/GM542QDqZuEE+D5rWTjw89z0dfThlvIeguRIJU4V1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OSd8Ss8v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OSd8Ss8v"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8Zjq72940886;
	Wed, 23 Sep 2026 09:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=sh8m9alv7sqlRqmf4Xyo08q7LYjFNOUSFtLnHGnDzKo=; b=OSd8Ss8vxRRH
	Mm8dnGVPyTJMZAIQrRi8sr7vCwjcoEex4syO9m3fn2p5E5MGLbuk8yHKfJP/T2k6
	y68/YX2bTkB4BJJ+2n93DE6K4ULG/46uGyrV/llsWLEQRE8l4UCIDVytoojtoCGR
	nzBxOYqEHKu34DPI31yAjsFLUFSFGfn2B55ltw/Dxk4pTvDNnZpzfAvhNryky06y
	yxtC2UX0hHmI0AalxkN1WWeTp8PAP5naU7R4IF/hIb90yRqMROzYDXLSvcC5UZ0P
	x0u+SiKYAhK1bqUPIROZ1oeStJ/upaCuGQxTgFWSyGgpykWQeXBx6G16wFecLjcd
	ZEmuuy3pJw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv9vp4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 09:29:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8bcnm008014;
	Wed, 23 Sep 2026 09:29:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1r5gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 09:29:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N9Th8p50987324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 09:29:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60D3C2004D;
	Wed, 23 Sep 2026 09:29:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B2E120043;
	Wed, 23 Sep 2026 09:29:43 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 09:29:43 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x9JIN-00000001F2X-02DR;
	Wed, 23 Sep 2026 11:29:43 +0200
Date: Wed, 23 Sep 2026 11:29:42 +0200
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
Message-ID: <20260923092942.GA30627@p14sgen6-pf6akexs>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
 <20260918083702.GE241998@p14sgen6-pf6akexs>
 <8d95a91f089186b4b09a60c24363642173263d42.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d95a91f089186b4b09a60c24363642173263d42.camel@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vr8Y_3TAxFvjcmJwdg-9w9oJ0rK-AQx5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfXwd08/VdlJYQO
 CpJZuJEl0ypXJCEbYI/CpTCg2ekbj9uVMyh+e64K9qq7gwW12U4qN0SWQh1WQw5htIgxvQbydsq
 WF89n8nuNwoVHfHKoe6Z7oXn5Ke0hj8=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab39c0c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=47u9jTYrQl9R5fVhXXkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: vr8Y_3TAxFvjcmJwdg-9w9oJ0rK-AQx5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX55wQHXjZl+NP
 Wdu2PCFIN0wDRGqV4e6DeiVe+Ic4BeM0Nr8I8VsooR6z0TapFHkMz0AIyaKFeRy4oeOrK9jBny8
 tZMEvQZAadVfH4inwwxltGqtKoqO7h3kjiXycFWQASK6C0C/yYb934SJs2+PG0lzGqWCrAUL/bi
 O/eDZpMHSPJ3zsWIfeuaP4gCMecc6kNjMAfePPo9Z70RSo3njrT9dI1bzRCZxBgxMbzWlC/9Y65
 SdesVvuP7jC6cfWdEx/+Km73XvyH4AfvvBamNEc7QHV7LdYqL+7kHMFDLgiinn2xPzHR0lAKum6
 e8IhmloCBCeu85l7Wk3hU0Gx7vN+LyEt7koAa4yFLcYdTVWCAXT+RU7uJ65RJ2GupXZjgH/rPl8
 YpWytah92II8w0M06ObB/nGaNQ1DJplTsV1o28xNcCJXQFvMYIGqWqy6txf/puBiAgeFDswvios
 hIKSzdGhuSN180B5fgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230035

On Mon, Sep 21, 2026 at 01:54:03PM +0200, Niklas Schnelle wrote:
> On Fri, 2026-09-18 at 10:37 +0200, Benjamin Block wrote:
> > On Wed, Sep 16, 2026 at 05:14:10PM +0200, Niklas Schnelle wrote:
> > > diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
> > > index 7030f7052926..867419779219 100644
> > > --- a/arch/s390/pci/pci_report.c
> > > +++ b/arch/s390/pci/pci_report.c
> > > @@ -89,7 +89,8 @@ static struct debug_view debug_log_view = {
> > >  
> > >  /**
> > >   * zpci_report_status - Report the status of operations on a PCI device
> > > - * @zdev:	The PCI device for which to report status
> > > + * @zdev:	The zPCI device for which to report status
> > > + * @pdev:	The PCI device associated with the zdev if any, NULL otherwise
> > >   * @operation:	A string representing the operation reported
> > >   * @status:	A string representing the status of the operation
> > >   *
> > > @@ -103,15 +104,15 @@ static struct debug_view debug_log_view = {
> > >   *
> > >   * Return: 0 on success an error code < 0 otherwise.
> > >   */
> > > -int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char *status)
> > > +int zpci_report_status(struct zpci_dev *zdev, struct pci_dev *pdev,
> > > +		       const char *operation, const char *status)
> > 
> > One small thing that is in no way critical: I wonder whether we could make the
> > `pdev` const. We don't do anything with it apart from reading some attributes
> > and such.
> 
> Just checked. This conflicts with device_lock_assert() taking a non-
> const struct device *. So we would have to adjust that as well.

Ok, fair enough.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
