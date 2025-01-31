Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F647632;
	Fri, 31 Jan 2025 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310784; cv=none; b=XpnBfDCnfEnYro1Ar1rZQliaBj8QWaj9uZcQ768NIMZW1pGRABjpDscWi2WuL/m3HIcCujaZW7r/n41xVvE80bVqj2QnglJMYsBgjjY4PW1ClIL/0MVS+jbE4v2r4lR2FqsOWknTP78Lm9ja3MMmnQ+G4mk7iu8SDbjTE0ppopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310784; c=relaxed/simple;
	bh=zNS/ceOig7QFM9quFO9l2NdtXouN+TuV7vXhAsNSZnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2DdNtfOq9i6MxHNHj2fv1iZRa9eggEE+tw3V54rSUmlKjuUo1tk/F0/U+aeaw0aVV56NfCBBaDURJfDZmZJq6zX6vuNcxaKN1LZomnbz/Xmm3jYg0i8gwpZ8j5vVOYPY8QECS+zGQfdxI7uI1Or+iGhNVSGIUcrcSKbsXPLnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fB0ygwWn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fB0ygwWn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2OBkm014563;
	Fri, 31 Jan 2025 08:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZiyYLU
	U/d10CTLKMVXtjBPsEO89a9FvWO4ZrdEwXlWY=; b=fB0ygwWn7xDUsB+4uhL8OB
	VDA1cE5yWgiDtnyRZx1Wl7JpgzBFPq/lW7TsIrffV7PEEXlReApHm086+Exp1vHt
	ryDsfzXNR6ApUmF6JzhYbERdOy88/ZgJSRwiKvk2xzUvy3myZbWhR4ebGahkHEJW
	b++ynMVu8m8e6rKTiy8ndnIOTWJ3R61xmhWlZR9bRzpSGUeU0hIxnS3VMbdZ1+Mk
	ALp/mBsAL+sWCxfy/0JqJVJav5Ag9F971hQ6M/Y535KCKKE6giBplWc8eomHpYPH
	q2qWDQaLMUhaAe2U/qui1PdAm50Dalz1b4HAd+dIbH0Lxy+ik+4OEvseG+D9gmCQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gfn4tn0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 08:06:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50V84FgT024501;
	Fri, 31 Jan 2025 08:06:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44gf912m25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 08:06:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50V8635C46662034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 08:06:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41C6A200E6;
	Fri, 31 Jan 2025 08:06:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BB8A200EC;
	Fri, 31 Jan 2025 08:06:02 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.13.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 31 Jan 2025 08:06:02 +0000 (GMT)
Date: Fri, 31 Jan 2025 09:06:00 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Tony
 Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler
 <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, linux-hardening@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: Replace one-element array with flexible
 array member
Message-ID: <20250131090600.04b8f4f7.pasic@linux.ibm.com>
In-Reply-To: <20250130124647.15115-A-hca@linux.ibm.com>
References: <20250116131859.105756-2-thorsten.blum@linux.dev>
	<20250129213826.291cfe12.pasic@linux.ibm.com>
	<85863d7a-2d8b-4c1b-b76a-e2f40834a7a8@embeddedor.com>
	<20250130114615.6f591882.pasic@linux.ibm.com>
	<Z5tkaaMNh83x2t/x@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
	<20250130124647.15115-A-hca@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HX1BOxprH6kjGbEiVqJMffgabFV4aw7b
X-Proofpoint-ORIG-GUID: HX1BOxprH6kjGbEiVqJMffgabFV4aw7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=555 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310060

On Thu, 30 Jan 2025 13:46:47 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> > > Thanks! Alex, what do we do with this then? I think you picked it up
> > > yesterday late. And I think, it might make sense to make this look
> > > less like a fake flex-array...  
> > 
> > Dropped.
> > Thanks for looking into it!  
> 
> Given that we already have 5dd4241964c8 ("vfio/ccw: replace one-element
> array with flexible-array member") applied, we now end up with inconsistent
> code. I'd prefer if we address _both_ code locations in a way that the code
> looks similar, and people won't send similar patches again and again.
> 

Yes, I agree. We should make this not look like a fake flex array.

> Halil, since you started this discussion, can you address this please?

Sure! But I won't get around before late in the evening.

Regards,
Halil
