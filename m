Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4210367291;
	Fri, 25 Sep 2026 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790313649; cv=none; b=Z4s/9rIMhsfbUI8IpgQwgjv+uszu6T2X1nwICWnZC8nLpvhbZtcAzQBLPsph1LVGrmGdHIJyAAPlMICKizppsGkyEWOoVvuCCnVM5NheIKk2hkYNlsp2FVoUz5w50Ob06rGTG5QEzHV8gnPxrA8Sh4h/OdcXY9NIt4hDeRvUrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790313649; c=relaxed/simple;
	bh=8qxpkMMoaVY836cgrQgnFdFSEX02qHLJ14wkm+LoT70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6cwQ0XuTwXSUXSq66hB5qwqwHlHONUzcWvUUzfYxmR4toquaqHvS4J+Ecj0XXAR0KneTEiRMcehqbb6gJkLxaFkByNYTFxQmJTwixr3Wb2RP8LRf/+Z7utDsHB2p5ApyI4ykVanReExyqdWWtLO8YSkdrW1PZdqPFtVULRpDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LXnn2mW8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LXnn2mW8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aB4c061545;
	Fri, 25 Sep 2026 05:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=Rn3aWsRBSbK7JlEcAr0q9d3vEYD1JDh5vsJpTXheSks=; b=LXnn2mW8RF2l
	TsWYgMIjFBCJAhx2Woy9Ko1Dt3qvkRy3Wzo+5jW4CjwEESJEmzLJCzkEpRJegP0O
	+RD3giE7D8zBBOLKN58te4xn5f4fRwYMHWfr13YnZ/YbDDtZmAebhABT3JihM3ej
	QqjdtGcayhw1+rittm0CaHcWaLSyeO7okh3dUErMYw5FrNINUBHsYCeTRRZYwnk0
	r6VtTcFdkCqbcgPiBnFcJnUte7bERAspysHJephLn7q+8+MwA9Wne9Q1gvE5BVtm
	JH4o+Mesi7SdWq5uEn8n3scy500hYINZYmfdoSkyLoal+a2C6dLoOfPZWSweVqjT
	O5iiaVI8vw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsn82w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 05:20:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lYBa3248902;
	Fri, 25 Sep 2026 05:20:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt3129m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 05:20:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P5KfTo52298020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 05:20:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D5F220065;
	Fri, 25 Sep 2026 05:20:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46ADD2004F;
	Fri, 25 Sep 2026 05:20:41 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.111.75.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Sep 2026 05:20:41 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x9yMS-00000009R7E-3jWZ;
	Fri, 25 Sep 2026 07:20:40 +0200
Date: Fri, 25 Sep 2026 07:20:40 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        intel-xe@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v15 5/5] s390/pci: Fix circular/recursive deadlocks in
 PCI-bus and -device release
Message-ID: <20260925052040.GA2183239@p14sgen6-pf6akexs.fritz.box>
References: <cover.1790267348.git.bblock@linux.ibm.com>
 <845f3fd0e94294765ea10454823c21e464d2f4bd.1790267348.git.bblock@linux.ibm.com>
 <20260924164406.B7A151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924164406.B7A151F000FF@smtp.kernel.org>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab604ae cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=FFIfLM0yJpXRnZ21FiUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: cH8_hwyH5h2DnXUFrYoirBoTEL14nOtH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyMCBTYWx0ZWRfX6uTnNMvbolH3
 svX1sJY6gdmUzbUSQY6alJt16bNodUFAujaO6VXEhbxFHdBqE8BgPc33mMDMt7KKCPACQPQhhQu
 qMMweFpKdXG8tqKi2AfuLs7mJsfWMQWZJp9Ly9bSj8CMISScBOBR8utkru8LJJMBY8EqS8TeZZC
 aZU3EPlWO6BXhwrrIyG5xudPtRlumSG/ntFO47hKXCjN5m/knTYaRoceo4DvisGogSRTsNc0ien
 0yJEglOcP7exNxiX8moajR3+I53lOg39sq0W8S9j5FSqmCuYrZeCKL3S5NHtoczcAK5M3u3JoOm
 l6BTGzL/sJy3aRa75nykkrV8JS9NSuU5jjMhOF10wV+trl5DMGRV5T8Wwnk2Z2qwwCghpOQ/bev
 KnO1binI0uqgcAzGACPzw6NBNWYWIYbdr5AOFe9HmZvbL+/qNI79/0hnKxXwkI9ioZ943GaKkE+
 OwPnm0KoYtOvDAAXH5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyMCBTYWx0ZWRfX+rImqnaeRuTu
 Tt3KM3A9zVxEJgXcLciWeVQ8/RF9f2xt/vKUbl1YQlGjsJ0jj73dMXrvz+v2OUwP0eM3MP7D2nQ
 n9zHfPIaKwjxwiSXJVEqOZC0Ly298Co=
X-Proofpoint-GUID: cH8_hwyH5h2DnXUFrYoirBoTEL14nOtH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250020

On Thu, Sep 24, 2026 at 04:44:06PM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index d64c544b32b0c..4fc3e3dc87ad1 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
> > @@ -1208,7 +1212,8 @@ static int __init pci_base_init(void)
> >  	if (rc)
> >  		goto out_irq;
> >  
> > -	rc = zpci_scan_devices();
> > +	scoped_guard(pci_rescan_remove)
> > +		rc = zpci_scan_devices();
> >  	if (rc)
> >  		goto out_find;
> 
> The pci_base_init() function contains multiple goto statements for error
> handling, and this patch introduces a scoped_guard() into the same routine.
> The cleanup.h guidelines state that usage of goto and cleanup helpers should
> never be mixed in the same function.
--8<--
> > diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> > index f317a1465dad8..268f435677ae3 100644
> > --- a/arch/s390/pci/pci_event.c
> > +++ b/arch/s390/pci/pci_event.c
> > @@ -382,6 +382,7 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
> >  	pci_dev_put(pdev);
> >  no_pdev:
> >  	mutex_unlock(&zdev->state_lock);
> > +	guard(pci_rescan_remove)();
> >  	zpci_zdev_put(zdev);
> >  }
> 
> In __zpci_event_error(), there are goto statements used for error handling,
> and this patch introduces a guard() right at the cleanup label. Mixing goto
> with cleanup.h helpers in the same function goes against the subsystem
> guidelines.

So as far as I know this rule from cleanup.h is motivated by cases where
someone jumps *into* a cleanup-scope and thus skips the initialization, but
executes the cleanup, which then breaks.

This shouldn't be a problem here, but if our s390 maintainers think this
should be changed regardless, I can use ordinary calls in those two cases,
since it's probably not worth converting the whole functions here.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
