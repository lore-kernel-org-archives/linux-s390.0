Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895FD1B6D1A;
	Fri, 21 Aug 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317197; cv=none; b=ei/TkEopJgb72o7nDCbeB3ILqpExIgEeV+caORDOAivg1sDl7iC4rMcLTY36g6S9pVw96t+JHDr8r52wl+kdMQaVQPFRh+WxyPF4vxfqj46+QhMM1sy/5osaXSvuDh3Scfy5EsvKghrObgIvEyxgNvhyYZUzxwSK9hjbozXzQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317197; c=relaxed/simple;
	bh=3NVEKwsY2QAR/Nzq1XUkbpaRh1ntb4fEa/xQlzyyx30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A89ortnhk2B9TSkJRReUsgzobPllseazb6DPh+E64vLQNPBObJbGC7Z2o1jN3toeOCMdMCw8MUtMkjcDHWUBTSPjLL0hoTtONsZ5lfxuJyX1CLh8jVKj+CUYW3uKZauvYTwbkVA+jbHEkT1mayzjdjL8l7JGeqKODFDWJz0l0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GhqERY9W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GhqERY9W"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LC1e211332210;
	Fri, 21 Aug 2026 12:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=qcm2V1qVE1fxMu7fkrv5PpBRtRlHHZVruJwXk0t0WUY=; b=GhqERY9WUxUX
	tvyOzHpf+iPcOo/B/rjnU+VsXJHUF1NyHDO3z53wWXMXCr6b5zlNsoUTLAKRW/Pb
	JcSDg0zlmCKrx5q+K6REEifn/1zGfMsxPBHdQiJ5z9lJZTbDX2PDslNksVxfRG7l
	0+kyqzBo4Usmo6aG9lNbxoGeyqWw2B6Tg7aeHkqhZHb+5n2ApHABMcWPUC4TNODe
	cbPjaW1bXvQIbMWCPpHyo8JiDrP4096igRFv01mv9fcAfgh2FAt8JSV7CAdcu0Ab
	OQzeXlR8vrtEqzz7rv0zNrZs5vrthTEOgG8uWemk/cAlsm5jiq5gFbhw1pXVZpHD
	n+GXc/vKQQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4hed5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:59:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LCusHW026191;
	Fri, 21 Aug 2026 12:59:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngvgx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:59:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LCxjjb47776200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 12:59:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438F720040;
	Fri, 21 Aug 2026 12:59:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 302052004B;
	Fri, 21 Aug 2026 12:59:45 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Aug 2026 12:59:45 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wxOqW-00000000nx4-3wHU;
	Fri, 21 Aug 2026 14:59:44 +0200
Date: Fri, 21 Aug 2026 14:59:44 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
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
Message-ID: <20260821125944.GB171473@p14sgen6-pf6akexs.ehn-de.ibm.com>
References: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
 <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
 <2d699043-d415-4ba5-907f-393ba481ba20@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d699043-d415-4ba5-907f-393ba481ba20@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX1aL4FxgVVMTe
 pJvy3oVMlE2fCIyWjNLlGZkXhIlumQ66uXPz5z68J/vZO4QlB8gcabxNdjNw+XpKP2pKMAwusmE
 yqCLW1mhKWXT/fxSlpJsXz+0dpTfj2Q=
X-Proofpoint-GUID: 9NAynZE4maIVV6WFmCJfQ_QElqrJ2__U
X-Proofpoint-ORIG-GUID: 9NAynZE4maIVV6WFmCJfQ_QElqrJ2__U
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a884bc8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=9VGsImAwx4z-A5JEZScA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX1gHhtk9PTiG/
 kHik70oo/Nf96HlJ7xY4Bq46Lr+TGL+0zQeNp4lvdlRt1Ss3PdW9cF6k+ouDTEwylaZHF/GxUpi
 o/SOAbT5M9LSmQQgzUwp7gjof82LKZsgjNbdqy5DVjOj8IVTcgEdBuLIj+lxbOELsrIPdcFq1s+
 Y6g/aBF9FWlwULoENoLypWC9++RQEtIqfRuZveLrOKG/nZ/bB7X62bgItXYTbwzsab1Z0R5cZYX
 VpBfYL858Yl889kvueZnUh877NjrT3O+GIHbUTq0kMNjDuzPZfCAtf/yNXATvw54CLTxuyS+aXp
 ra20Q4HwgYilkiGgjJVlqJUUeHGws/4W+64xMMj9UNSTXKVKbx2zFYinUyXyHcsDOPThE4Gs7+y
 rSU8SxUJnL2Cd/s3IEsu5caThbkN6nzQHuL5B1xLwhNltl78S3XYHNOEQT2za73bSMS8pq2khpD
 iv+Wre5SWVSCpOJNwdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096

On Wed, Aug 19, 2026 at 02:30:18PM -0700, Farhan Ali wrote:
> 
> On 8/19/2026 2:58 AM, Niklas Schnelle wrote:
> > As zpci_report_status() accesses the device's driver the device lock
> > needs to be held. Extend the critical section to cover the
> > zpci_report_status() call.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   arch/s390/pci/pci_event.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> > index 839bd91c056e..48c150d6ba81 100644
> > --- a/arch/s390/pci/pci_event.c
> > +++ b/arch/s390/pci/pci_event.c
> > @@ -256,8 +256,8 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
> >   		driver->err_handler->resume(pdev);
> >   	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
> >   out_unlock:
> > -	device_unlock(&pdev->dev);
> >   	zpci_report_status(zdev, "recovery", status_str);
> > +	device_unlock(&pdev->dev);
> >   
> >   	return ers_res;
> >   }
> 
> AFAICT this change is correct, but should we also add a lockdep_assert 

Andy maybe the context one `__must_hold()` or something as function attribute.

> in zpci_report_status()? Since this is the only placed its called, it 
> maybe fine as is. I just fear that we could miss on getting the lock if 
> we were to re-use zpci_report_status().

Yeah, I agree. It's not obvious.

I guess the critical point here why we need the lock is this line:

		driver = to_pci_driver(pdev->dev.driver);

right? Because we assume the relation between driver and device stays intact
after we get that assignment.

Because otherwise I don't see why we must get the lock, if we get a valid
reference in zpci_report_status().

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
