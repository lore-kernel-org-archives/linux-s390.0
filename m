Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB134FF41;
	Sun,  9 Aug 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299539; cv=none; b=Ll9mvhMtuKXkXvfaSHGa9MNFl7i4RJJI8K4e0NZzYjcOuB266N1c9ts5GNmveYLE8PJI7UU6Rt5zTBA6gFfsIV8bg8tdSYz3mIOh1MOXRtkh2kn7X3P74aLt/7MvEBmTTV3xZFEHpoNal/dDBvpg/H6IZOGkaf2bzKtVVVDHcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299539; c=relaxed/simple;
	bh=aRwxooj+PfNISk4QFGZHircmiC6jIBbMtMpYqE/PHhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjRI5+nVgms+U6U4aprvtg8N4cwJ/IGO5bJPNFwXhntR3YK5NPG1MasxsivCfo+kj83zEtCqbKzz3qYOH1MY5hlP2wYGfX5me9kY/c3kqOQRz9+a8z8G63JwK8xr8d489GbeXG0Sj58m9kcQLH+Cs8vahRL7E6L2EMko3fORE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U9+ahYrT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U9+ahYrT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679FVWsQ3276858;
	Sun, 9 Aug 2026 18:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=E3XfBvoPrc8i8Pk6qz/sA//CZIqDf8
	NuTmlfpQtcGp8=; b=U9+ahYrT1GuQNMSX36yyQimvLwRJl+7J4Dmab+2+X2HgTc
	Y9eP0OVE//Vw1lYlqE775gROSezGMDL6RdGT0imwmRnGl1ARAUb2idUeuftVFpPf
	PFaxiy4JlLoH+P9Qm4EEWCVDzuKlcWgIhyWd9w/GSP33VzZj9fogvpDH3tvWT/xh
	O3nRzpFAKYU+Fp7f0M5DrijxiMoL/9ACBL001u5cQ3/kp+KBXjo731+BYa7r3nDs
	t1Z9n4UDGAnP8j5IIpAzy2o6O+cTjsTi8M7sefaKKFcJ3jflJ0P6gDeDBqtErIPj
	5F7LFCaMbzLLmBkIZO/XOPXkvhzwU8ypULfDiTzw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq94w32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 18:18:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679IBeWP012673;
	Sun, 9 Aug 2026 18:18:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vt4ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 18:18:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679IIpf817629576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 18:18:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B67120043;
	Sun,  9 Aug 2026 18:18:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E39C720040;
	Sun,  9 Aug 2026 18:18:50 +0000 (GMT)
Received: from osiris (unknown [9.111.66.119])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  9 Aug 2026 18:18:50 +0000 (GMT)
Date: Sun, 9 Aug 2026 20:18:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete
Message-ID: <20260809181849.21067A92-hca@linux.ibm.com>
References: <20260806131131.2073914-1-tmricht@linux.ibm.com>
 <20260806132951.11CE41F000E9@smtp.kernel.org>
 <3c6b0cc3-18db-404b-9419-fdc1d3249bd5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6b0cc3-18db-404b-9419-fdc1d3249bd5@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vd2lgTtACF4ven-qWhPtJ0opT2p37dIO
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a78c490 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mUgjO4Rvzf9p5bn0yWgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE2MyBTYWx0ZWRfXw5xUTDFAYjjs
 zRsufqBiTKNQdZFNi46oGLPOFfHbT4mdqJIFhMYq06FOcZyLydj9owcOtwTcSkrKafqvVtTeUH7
 Rrs9p4zkNteM+/SiG2ka9zwx2kcJklV/idIutPbS0DsC8j6HLmjL2REWk+3rEfZaqpsVbERXRwe
 bQCNvNIkzQDKW1ZYprdh69zY4X3CShAe5Mw9B3CZgaz1Qt3pjzMgWylcZcUWmuHODdMt04eNCjo
 3IB9N8ggaqz5CtpHN7BzErfGVZuBQoydgfrL8l64J2F6KNpjCbuwho/Dix2k5QxyEkTF2ltMtJT
 ORF5bMUNyTw6QsIvpPpbP/QcNUsWpPwx0h839jo5TWo11En4MQYyPq8fS1/JOXt0/TyY81ilcc4
 HNBb7hjO3r5grE5Ak3x2x8MRJ0zEAc4OMVeiM2DTLiLO1zgqhY0eYZoD+cxTLC3sI/8NNSZIAQM
 JpuXxJsbw0cSBs/vRXQ==
X-Proofpoint-ORIG-GUID: Vd2lgTtACF4ven-qWhPtJ0opT2p37dIO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE2MyBTYWx0ZWRfXy+JvwCIsUrNh
 1xE2GPa4Sd2OMhVkH+4PNbtRpEaPmvbbQie0t2iwHM5Xnz0CROZvhh38lBugdvMtsM4+xjinnX4
 IYcu5lSjaJdW+qqHkb4FukFo1/MyE9g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090163

> > [Severity: High]
> > This is a pre-existing issue, but is it possible for an interrupt to
> > dereference this pointer after it is freed?
> > 
> > Since cpum_cf_free_cpu() executes with interrupts enabled, if a CPUMF
> > measurement alert interrupt triggers right after kfree(cpuhw) but before
> > p->cpucf is set to NULL:
> > 
> > cpum_cf_free_cpu()
> >   kfree(cpuhw);
> >   
> >   --- interrupt occurs ---
> >   cpumf_measurement_alert()
> >     this_cpu_cfhw() -> returns p->cpucf
> >     ... accesses freed memory ...
> > 
> > Would it be safer to clear the pointer before calling kfree?
> 
> The interrupt handler is shared an protects against a NULL ptr:
>         /*                                                                    
>          * Measurement alerts are shared and might happen when the PMU        
>          * is not reserved.  Ignore these alerts in this case.                
>          */                                                                   
>         cpuhw = this_cpu_cfhw();                                              
>         if (!cpuhw)                                                           
>                 return;

This is not the problem outlined above. In the described scenario
kfree(cpuhw) is done, then an interrupt happens, and the interrupt
handler sees and potentially uses the already freed memory, since
this_cpu_cfhw() does _not_ return NULL.
Problem is that data is freed before the pointer is set to NULL.
