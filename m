Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26724345751;
	Fri, 21 Nov 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733807; cv=none; b=Wb9Dk/ADuD3x/nRs/NSCuaTSmmj9We1p+3CHSKA/BB6rPNZS1SJmE871tGwDlXZ1triiTY0pY1vt00cCKFfh7QK1PC9EGWLGdS29bW0M902cwELnoUEA0jNRLyn9aITNbRvzaXFnKkNXuzWmoLJBgA8Zg0lXcWJGaCkwhB+tMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733807; c=relaxed/simple;
	bh=rrxHGAOXykXKN79sG/Y0NI5ZnQYl6idA8KsPDeYb04Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQFtyzyu1ej8tQcsNyrcSeX9zdwOXRKzZ1fTDlNICH6ncBAb8V1O5OeDTsTcMdMdmct2XBWX74VfkvcDbazodQFcQC+kB3oL+IPszPED2yh4wKu8Nh16gdf3EQcMCwxscXrgP+pguh5wsKFLooQMv9r+5KiMgfKvlK9qu1ygeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kbwR8Dxs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kbwR8Dxs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALBb0sQ003872;
	Fri, 21 Nov 2025 14:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/Uc3WfpIw6xriopGcFq/H4Mu8TTlW/
	KcS1NjU5wKp6U=; b=kbwR8DxsPsB3YrmIFmR+S5/1EXrVxeiXQI77GOMnP2TuNN
	3WxPakShjTn2zVFM/+Q7F6fFzdYbR02XFoGvILWZnT/uoyluWGwvjem65KxeJrcW
	EwgvgUA8zI5W5s28fz2GPTo3OQ+iTlTDpN2AzaGpCh1WTDsrWpQN3RkIKRapFACc
	BWIvR1t9nz5wbZYTgGaQmLcunUzVXfZs/pY91ytJ5EBdA/ATxJZqe6eJUlfNQDua
	dtHaY8unAPW7gRD5Fv5a4TxkSd8QMr3t5ENbPXBHk0opxSLdryciLvYKLOeOiR2x
	xx2iF0gTaATDwf7oL4MGbnOKFBj56nYXE24lstNw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjuanfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:03:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALBlj02022434;
	Fri, 21 Nov 2025 14:03:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4unch0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:03:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALE3DmB58327310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 14:03:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C80AD2004D;
	Fri, 21 Nov 2025 14:03:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0218320040;
	Fri, 21 Nov 2025 14:03:13 +0000 (GMT)
Received: from osiris (unknown [9.111.15.252])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Nov 2025 14:03:12 +0000 (GMT)
Date: Fri, 21 Nov 2025 15:03:11 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Tobias Schumacher <ts@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
Message-ID: <20251121140311.27602C99-hca@linux.ibm.com>
References: <20251121-implement-msi-domain-v5-0-d7e717dfd3f7@linux.ibm.com>
 <20251121-implement-msi-domain-v5-2-d7e717dfd3f7@linux.ibm.com>
 <626c1d010ff720c8c2beb7bdd36b0565850a6ab3.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626c1d010ff720c8c2beb7bdd36b0565850a6ab3.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pl-psU0-euDSV2VHMMksaVrrEi3v-8i7
X-Proofpoint-ORIG-GUID: Pl-psU0-euDSV2VHMMksaVrrEi3v-8i7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXw/oQsRvqBub5
 Z7c5v4rPv/h4lG/psp/qNYZc+uBgO7xntKm2+KvyFfI/CtX/knetbsSFVmeJ09II8kzQ5+pbVJD
 QObSxv/3IL3yrpm3ZZL3dGHzALno/dwOyx75XOvW7DWIfjgHxV2Wozn1lyR5chwytLVs818AjpM
 PrV9qbopuz4Za2206UQcobbnzq+OUDe8KRaxvZbsDo9zvPjXRybBffgfxTiIFLFm7xVtT4+IxQQ
 a/kNzTxJWIs8yfgiGu5q4h6/VmB2y1u1AVCKP+6S6Cy+lWjluZEcg7RkceLNEYVtSfSQyrEuemQ
 NplDBBIHPcrIojoe7nC2UXJ/6I/dHwwP8G/u05hBS9Sn0gA0BmhJcii3kshYJcrNPi2DsLPn+Z/
 8ZIxouu5BeRpm21izyaiRDYcrLjgig==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=69207126 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=oKjDcYOE7tBpZiAUUPcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

On Fri, Nov 21, 2025 at 02:27:38PM +0100, Gerd Bayer wrote:
> >  	bus = pci_create_root_bus(NULL, ZPCI_BUS_NR, ops, zbus, &zbus->resources);
> > -	if (!bus) {
> > -		zpci_free_domain(zbus->domain_nr);
> > -		return -EFAULT;
> > -	}
> > +	if (!bus)
> > +		goto out_remove_msi_domain;
> 
> Or do you want to set rc to -EFAULT here, and return the "original" rc
> in the error exits?
> 
> >  
> >  	zbus->bus = bus;
> > +	dev_set_msi_domain(&zbus->bus->dev, zbus->msi_parent_domain);
> >  
> >  	return 0;
> > +
> > +out_remove_msi_domain:
> > +	zpci_remove_parent_msi_domain(zbus);
> > +out_free_domain:
> > +	zpci_free_domain(zbus->domain_nr);
> > +	return -EFAULT;
> >  }

Oh, just realized this oddity with Gerd's reply: -EFAULT should _only_ be used
for page faults. Looks like this return code is not passed to user space, but
please change this to something more appropriate. E.g. -ENOMEM, or whatever
fits here.

Given that Gerd had quite a few more comments, please send a new version with
my comments also addressed :)
