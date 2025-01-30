Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9591ACEB3;
	Thu, 30 Jan 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233997; cv=none; b=rmAnc+5PwquIklBc/g5jWUX3+n/KH08xqB1JZfEr7BAQbqUnqvJCSHL6B8VirP96XpGZMXHE/p+syeJ1ttuivtVNowQ3NTVKVsYclGNrKSVZUCM+ab0CIMGAV7rXs6gFpImMLI2oTMalLpQllgaVJq3ziTKDkbB8vzMcK8DBp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233997; c=relaxed/simple;
	bh=XnLyFFk1L3o2T1GAGQ8JEFb5LfLnzJHt7dvXNVvn8Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgYblXSSsKTlvYXbTNQFr09duOhkX45WuxMDc/NUneaq+A7pGoHQ2rZUFy1cwua9LCkZM2i/PfVx4k1c/OSdPv8RThEj0WrRy6VnvoOYStTvnCb5mbqIB4vH5LH3NwwZv7R9DUXUoNdVpcXLRI5a/I5Hu8dFvGDjFBcQTWPfZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OC85zOnT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OC85zOnT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U1ILwU008475;
	Thu, 30 Jan 2025 10:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rbQ0iV
	5kMkAPr98XhQIgEokS+6oo7ofi+Sa+NyvSgwQ=; b=OC85zOnTl/VQmPikdMYnGa
	prkfC3/uLAdyQE9cr9aE54C+FlBj6LMMXjzN8jZsF81wGmd5yWB3bSmNCbSB4xPF
	anxnB0PeYA8eLYjiSuL139O9fs1ubD+s7ApJkk2J1kjf7KQQBHBU3Iloya1Pxcaz
	lCBPXuIvE/uj4UUbHAE01MSdf//ae6PoNa6xYTPnNV+3c9SehkcuaM4VA85Q5Vzd
	VUmZvJc+cn5X3bQAo1xdUNNSugOdnu+EQ6p/ZS+6juAkUJP9Fe+oa+MUiV31B5jg
	JkOBCWHS+kKGj1rcauHkuOp1j6jwF5Fs8uO4ZN0dRm3nSWu0LEeJNFM8chwJDYcg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fq5tvgsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:46:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50U8DVAn028051;
	Thu, 30 Jan 2025 10:46:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbsknpaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:46:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UAkHNW53871032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 10:46:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9531B20081;
	Thu, 30 Jan 2025 10:46:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69B4120084;
	Thu, 30 Jan 2025 10:46:17 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jan 2025 10:46:17 +0000 (GMT)
Date: Thu, 30 Jan 2025 11:46:15 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
        Tony Krowiak
 <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald
 Freudenberger <freude@linux.ibm.com>,
        Holger Dengler
 <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, linux-hardening@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: Replace one-element array with flexible
 array member
Message-ID: <20250130114615.6f591882.pasic@linux.ibm.com>
In-Reply-To: <85863d7a-2d8b-4c1b-b76a-e2f40834a7a8@embeddedor.com>
References: <20250116131859.105756-2-thorsten.blum@linux.dev>
	<20250129213826.291cfe12.pasic@linux.ibm.com>
	<85863d7a-2d8b-4c1b-b76a-e2f40834a7a8@embeddedor.com>
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
X-Proofpoint-GUID: q9NxGqcZI12C94KXtUoH1A5QT5ao1ZLb
X-Proofpoint-ORIG-GUID: q9NxGqcZI12C94KXtUoH1A5QT5ao1ZLb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=635 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300081

On Thu, 30 Jan 2025 10:30:30 +1030
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 30/01/25 07:08, Halil Pasic wrote:
> > On Thu, 16 Jan 2025 14:18:59 +0100
> > Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >   
> >> Replace the deprecated one-element array with a modern flexible array
> >> member in the struct ap_matrix_dev.
> >>  
> > 
> > I'm not sure I understand the value of this. What we have here is not
> > a flexible array but a one element array. Something that in the generic
> > case could be many but particularly for vfio-ap is always one.  
> 
> You are correct. Only fake flexible arrays should be transformed into
> C99 flex-array members [1].
> 
> Thanks
> -Gustavo
> 
> [1] https://lwn.net/Articles/908817/
> 

Thanks! Alex, what do we do with this then? I think you picked it up
yesterday late. And I think, it might make sense to make this look
less like a fake flex-array...
