Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05D47668E;
	Fri, 21 Aug 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320736; cv=none; b=WrFjEDbt58LM6341tl2o77ta2VS/86w/wwgIT1WdmxShhxmtCdJpaRcSBwLulcZcREDB7TMQpNLWQ29I7MvjQJGMibYCKsR/ZE/Exej8+rYHQacbZnkuIYFWOSfUaYQAVsaKJ6asHXoBuqxVYTeg0HHHqXgyreksIbOBx2IHY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320736; c=relaxed/simple;
	bh=H1jSPx3ao0gLydztfzs5G78IbwWXtGiw2wPSgv8CNvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1BbXIBS36taCN8kYQ3giFNnL7otGvOF/2fDBtsv3LyO/iOOkyitylEuyn50A3oXkoU+sB5bC+Dab5S1fAxih8aQgW6DvyPDQyLImdyxH1y+YGk1/2jyrkQ0bHcd9LfJBvZhYpvj2qmtIkIjMiikZ/H8MEuwI05dU9TW7ZOYaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U4Mv/4ik; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U4Mv/4ik"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD1ohN1606108;
	Fri, 21 Aug 2026 13:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=6oqjjZ/M3DsayHkVKc57ELo+cqShvfgbpiTTqKvRVeU=; b=U4Mv/4ik7Iis
	nyURbJYVKZze+caKHeR0VMwCABnIOlmYG1sClHQzQ1E2dyjyolbWtZBkflWrC4Jv
	44kg5lf6uccfLJl+4fBmxkUFJKFIUK26BhS+lElq7MFbs7CEDoreDPc+RdoliKVC
	jFSHPnJg9icRDjK0h2iL9mMyxl64muJFePfPe8ykyCajGf+EtKPhkx5hmciYVbHf
	rGrDnydvABzmymMTRb1I7WkBDczivdvqnHiPTDZI0vFkBK7Mm8uyQpZtdRqqxlW4
	w1g1D9GCnniJZJGWxR2Mml5xNWMR+FuuJPumz1LIbu+Dv09q3U2W8ar34bbML9Gm
	361N3HvxFw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4hntw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 13:58:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LDuM9W025389;
	Fri, 21 Aug 2026 13:58:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twn304-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 13:58:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LDwm8M48890198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 13:58:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9794720043;
	Fri, 21 Aug 2026 13:58:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 844BC20040;
	Fri, 21 Aug 2026 13:58:48 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Aug 2026 13:58:48 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wxPlg-00000000yjL-11FC;
	Fri, 21 Aug 2026 15:58:48 +0200
Date: Fri, 21 Aug 2026 15:58:48 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
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
Subject: Re: [PATCH v2 2/2] s390/pci: Extend device lock to cover
 zpci_report_status()
Message-ID: <20260821135848.GD171473@p14sgen6-pf6akexs.ehn-de.ibm.com>
References: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
 <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
 <2d699043-d415-4ba5-907f-393ba481ba20@linux.ibm.com>
 <20260821125944.GB171473@p14sgen6-pf6akexs.ehn-de.ibm.com>
 <6dff883412d6a8fc55b55cec8f58f4e27afc429f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dff883412d6a8fc55b55cec8f58f4e27afc429f.camel@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a88599d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=sjspah7KbaAGFeDV_WgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: bn9hUmeBwQN2rNY0IVjApJFAx1zl2kHd
X-Proofpoint-GUID: bn9hUmeBwQN2rNY0IVjApJFAx1zl2kHd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwNCBTYWx0ZWRfX4/7uD7Ra0IAX
 PPXwZ5JdkUXE+NHn+nfQf8Y8zneVwllKBBJ5UvHIln9GplA7xIwFkXLiRTQaL/PXtZvE94BFcBV
 MpahnDLgXuLGlkkqvzPyaM2YiTnYBR0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwNCBTYWx0ZWRfX/9UiisQTaIoH
 w92l89KSvOao9eQtCMuYqzl37hHda9/QacgRikG/UzbTHnDliVQJmVCze4VBipAY0r1pLYOpM/v
 oMQm8Gd1BpUrYS+5XBSUFlHEMz/8+sKhFz2px2N4F8J4ZLFZLC4fk1F9iDkixatHaGualoMtfGJ
 eQ4bIaxhwSKwYNHC1qTLalBQWQIkUEy3U2aX/6P5H1qZjlgsbL4ntKYdg01fNcU7HEpGHHtXIdU
 Ok0/yIUdPBmoCo6str4u9vRw46ex7QDuzKorH60WgDoxL28ypAiWANfqQ9tJ1qmefui8in95q2M
 Pf8qVlw8yLHBS9OVZWwCOJq5wg++Btbdy0W9El4o+peT/3cAXXb3qUFIpi92y8K1Xz+5KJ0CYT4
 JKmymTyjl1wC7ivXM7YaQLAzWnPywQvhCPT+/82dlRNm1YHdbIUHLBXfAyZg+mfuQnfk8oDoFoh
 szv4STJzTaGQ1sEsdTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210104

On Fri, Aug 21, 2026 at 03:14:32PM +0200, Niklas Schnelle wrote:
> On Fri, 2026-08-21 at 14:59 +0200, Benjamin Block wrote:
> > On Wed, Aug 19, 2026 at 02:30:18PM -0700, Farhan Ali wrote:
> > > 
> > > On 8/19/2026 2:58 AM, Niklas Schnelle wrote:
> > > > As zpci_report_status() accesses the device's driver the device lock
> > > > needs to be held. Extend the critical section to cover the
> > > > zpci_report_status() call.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >   arch/s390/pci/pci_event.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> > > > index 839bd91c056e..48c150d6ba81 100644
> > > > --- a/arch/s390/pci/pci_event.c
> > > > +++ b/arch/s390/pci/pci_event.c
> > > > @@ -256,8 +256,8 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
> > > >   		driver->err_handler->resume(pdev);
> > > >   	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
> > > >   out_unlock:
> > > > -	device_unlock(&pdev->dev);
> > > >   	zpci_report_status(zdev, "recovery", status_str);
> > > > +	device_unlock(&pdev->dev);
> > > >   
> > > >   	return ers_res;
> > > >   }
> > > 
> > > AFAICT this change is correct, but should we also add a lockdep_assert 
> > 
> > Andy maybe the context one `__must_hold()` or something as function attribute.
> > 
> > > in zpci_report_status()? Since this is the only placed its called, it 
> > > maybe fine as is. I just fear that we could miss on getting the lock if 
> > > we were to re-use zpci_report_status().
> > 
> > Yeah, I agree. It's not obvious.
> > 
> > I guess the critical point here why we need the lock is this line:
> > 
> > 		driver = to_pci_driver(pdev->dev.driver);
> > 
> > right? Because we assume the relation between driver and device stays intact
> > after we get that assignment.
> > 
> > Because otherwise I don't see why we must get the lock, if we get a valid
> > reference in zpci_report_status().
> 
> Yes exactly, we need to make sure the driver isn't unbound or worse
> unloaded in the middle of it. It's quite subtle which is why I forgot
> it in the first place I guess.
> 
> Also note that the function may be called, and does handle, both an
> unbound device (driver == NULL) and/or a zdev prior to probing the
> associated pdev (pdev == NULL). This means the device_lock_assert()
> needs to be inside the !pdev block. I'd think this also means we can't
> really use __must_hold(), right?

Hmm, true. Yeah, that makes it awkward. Doesn't seem like we can use
`__must_hold()` here then. Always found that nice since it is right next to
the function name; can hardly miss it when one uses the function.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
