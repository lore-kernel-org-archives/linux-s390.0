Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937E282F1E;
	Fri, 21 Aug 2026 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316513; cv=none; b=mlgU3y7rebJ4k47OU8/r4lhsgDXAXJ3ELAc4N2F+P4pOyNIGzU6kZCmIAxVCgMpN/EZjYgAQqypYNuVgXqMbxcFGvC8xhIUrsQHJtoEzli+epigkUx4r2TkU3QewIiz0uwgCst71QMJ0IIkjRnTAVfMjf0EjM6McB3iGqBWLY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316513; c=relaxed/simple;
	bh=1uDKaTnuxYPtcmbOcvt6cYUHRCd9EEkivuRL2OSNsU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGQCiq3K3xgdLC9fh56v2DkdZgQihANmFaeMZ9ZD3iIGOmLn7K+sUzxGhmn9+Ry+bx/6jqN2MWaig+3Jb5y4PH7JWMHuBV04bdgYKcz6qgWTYE2o1jt7LEsyipaUCrhUZqEZea1CEbgvi3tTlroGmAST1CcWnv94ckEqr2+3e9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EB1/vjdx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EB1/vjdx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LC1Zsb3766793;
	Fri, 21 Aug 2026 12:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=eFIpIgd+5JH7+SXPjG5Gwk9/PhTOWb8v+ZYqk8x5q08=; b=EB1/vjdxwE1K
	oSrGUfEJ6GfnQYbRnf/MRni/5gVd1Cy+2OE+ZlDsl94fGoNBGumy6SC/qsU628kb
	sLktl8YtbbV3gHIp3dm7TBlqYLOYdTTXt+h9w6DmhKLmT7WoBdwaKansJa07Wh1U
	dA6inmqLqnfnnXz6HllhZc+boPlfuVyeTzi9UGWLEV3Xjm3KQBvGJSAygunda2/Q
	IS31Ad/wrSeHXFK4dL/aYJwRxPstoupFTqNl5rl7Xz6QVun6dMT1gCbJyhc/ZKi0
	L82hbAPjNf9HKbOvR1oL5ymYnNbPDyM3r75R9rw3TPqHNnti3wPIEfS0jF+EVRX5
	sixDuWiMvQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0hg8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:48:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LCkvZ2030004;
	Fri, 21 Aug 2026 12:48:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekmp39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:48:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LCmPxZ38207794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 12:48:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B270320043;
	Fri, 21 Aug 2026 12:48:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F80E20040;
	Fri, 21 Aug 2026 12:48:25 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Aug 2026 12:48:25 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wxOfZ-00000000l1J-1gDS;
	Fri, 21 Aug 2026 14:48:25 +0200
Date: Fri, 21 Aug 2026 14:48:25 +0200
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
Subject: Re: [PATCH v2 1/2] s390/pci: Fix missing pci_dev_put() in
 zpci_report_status()
Message-ID: <20260821124825.GA171473@p14sgen6-pf6akexs.ehn-de.ibm.com>
References: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
 <20260819-fix_zpci_report_status_pdev_leak-v2-1-da0c4aa7c0ca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819-fix_zpci_report_status_pdev_leak-v2-1-da0c4aa7c0ca@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BbOsn02ixosOnGjUVk7XfepMjhGsf3tW
X-Proofpoint-GUID: BbOsn02ixosOnGjUVk7XfepMjhGsf3tW
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88491f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Qdv-rEsNH8jH4IiURJ4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX2pgTXyVHqEP9
 hUaVJuAQ7NiDRfxGpqdf5Jt8tNDfijQkzq6fzYjCTdZr6WeftNSgkQ4HuMVcRds0sJrED/exXW6
 1zG+YqiwgUsW9+8ce/Mg/cB5QIYDcz0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX0lmQ0z0sOtmg
 UCrWtu5GjKREtY1HUd3eUMZhRYU5P6zQt+D8QJH6zCUhmQu1CK8clfDUKbgt+mJfk3VhIEM9v7J
 eUzMDvRSBa6T51j1/lW7oi/wC9DtDsA/XOOIYxE4WW+/ynhXVytOumjTL1OtuM2IvqilMz3gtBW
 o5Vu2ESHFe5fxgM7PpIriFWdM3NLLkE94k+3h7XbF3qRIwMZBH4z5hgTlctPzEUzorxWCvqzlby
 CNQjLfRHuu+iB0dkWIdg0DiZiSgibL7ETqt2sfDVQQv1ARv6EYCY22HZf8kz1DAfbAUH6NSuBEh
 owNecJOV6Z6pjBBgZSBlrPIxLSYEDVfeKTLKIlr5DJhiURbuyG1f+iI24+s7F0O1blKZhtzgxVs
 Blg19RLeX0Wp7kJW/iQRl35wbcpBs1a07KldcgeS6rkj+qJntJAReQFGoEuCE/WdhiSA0MI/cdo
 amZy2zKVGIO0EQSa5Zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096

On Wed, Aug 19, 2026 at 11:58:30AM +0200, Niklas Schnelle wrote:
> In zpci_report_status() a reference to the struct pci_dev associated
> with the struct zpci_dev being reported about is acquired using
> pci_get_slot(). This reference needs to be dropped with pci_dev_put()
> but this call is missing thus leaking the reference. On subsequent hot
> unplug this will cause the struct pci_dev to not be released leaking
> memory and potentially prevent reattach.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci_report.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
> index 7030f7052926..76b8afc146fe 100644
> --- a/arch/s390/pci/pci_report.c
> +++ b/arch/s390/pci/pci_report.c
> @@ -151,6 +151,7 @@ int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char
>  	else
>  		pr_info("Reported PCI device status\n");
>  
> +	pci_dev_put(pdev);
>  	free_page((unsigned long)report);
>  
>  	return ret;

Looks good to me!


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
