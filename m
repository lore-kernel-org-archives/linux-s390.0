Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208919995E;
	Wed,  8 Apr 2026 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650718; cv=none; b=p6hSDTDsHZdWdH+MUnkPHdruijbpVUqAVAPOGA7+vUd5XvvAAVgiZtMFr+eXcEMgs+zD4spJRu50UYH5cyloshf6P5mcW4VH1ARpJhLK6KdDhaZtTKazBhrXj4oLykXjcSGG0LaHsEybEeVjiJ6Mr817sFF4bN135Xa7Jh5RCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650718; c=relaxed/simple;
	bh=NEamxRS6+kDuLVN0NlzLC4mte30BzxM9ZKGmkI/TeYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWZ6bj+6hYYIoMfsj1dt/xOh5CRZ0BF/actbBgW7ZAjXxRJRLpL0b8xCVCbbbN3HgokGkMFunZWRK/BH/FRWVmB9P9wrU0eKVCElmOTJIxM1WIQ0Bhw980UfA78KCnwTfjZKleJaDdFQ5P8wM33mpf7vLRlPtuOWXO57Jyd1bc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HHwqjRWs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HHwqjRWs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386WUO92326341;
	Wed, 8 Apr 2026 12:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GJbLlRtw6wjUVT8JSn1mcrdk/q0v20
	wVGSdIuxw5BVs=; b=HHwqjRWswXO4W1P5/MKMKwItUC8X5CqVA8l3c6eLCqXYvH
	L89IlhIJyLLqGGBmp146I5mG4DCrnw+bUiqu86F1kkIHitd2g4uJ+Gz/F9GQovoH
	4bsObvZKLHkqle3+/TZqwA+hMDGs+yI9FcfHZf8Eo+VRhapai6Lz7OhRKDDKg+EE
	unfULi2eKOHxO++A8rohfLpZxxacfqQihuf+/SbdKJmykYeK86Ne9b/jebttDj82
	Rksqbjh2VUfNr/YvhdIGCyQKumr/4j5p5kv7xaNtxWR4+GeRz19Ezl4+I1WbU25O
	S+fQ3MAK8iETtJ1M7xnF4PAPnyh+v3N5UXz3Hqvw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kf9t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 12:18:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638BBdUw007951;
	Wed, 8 Apr 2026 12:18:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2fac2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 12:18:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 638CILR214680470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 12:18:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F0CD20043;
	Wed,  8 Apr 2026 12:18:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4083220040;
	Wed,  8 Apr 2026 12:18:20 +0000 (GMT)
Received: from localhost (unknown [9.111.74.150])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Apr 2026 12:18:20 +0000 (GMT)
Date: Wed, 8 Apr 2026 14:18:18 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>,
        Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-s390@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 0/2] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
Message-ID: <ttd6cui@ub.hpns>
References: <20260407-uid_slot-v8-0-15ae4409d2ce@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407-uid_slot-v8-0-15ae4409d2ce@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDEwOSBTYWx0ZWRfX1nx7gB4ylQPP
 xaxXrnmWcSUlFb/gtNTzoG8BnrEQHPpnJC8WFvGKMUjB8U/89mi2PBMVTQHaR7GWCRKJ1lbuREf
 NNRUYJQVmWXD35XJIzcEaFuFfVqundIPO39RFz/qbGVgVfS9Qpm2+864BkRzslZpLs9c05zOrAO
 tRmK8jAXTmvWlLvn8dM2hVaPtc2xM8J+e/11Ot3jnkPqTwavv6WNLLTyqeBVo0Ru3/4qumWnNj9
 DJFjrA1dGmdZgj4JBwWTKvobcUs2q7cY4a40qu7qGtOweUQXecBAwtMhWC8PwDYLYORZehew2ux
 8NB14FlUakhcrGICUj4hKxK7w3d/8DjFhQ1cEo9PTcWnc1gmgt4+U6hk/JZspivd8j30PnJ25n1
 7fsWNdNwJ62bRQ0OFHHbIfWJysBh+tXxShA5om2+iWNSLLEFPPfYs130Zq12jynUcpxrvpyUKyl
 emtIwHuEJ3R+owh+yyg==
X-Proofpoint-ORIG-GUID: Z79VdgAyCLMQQb9gx2eIg7V2_VTxlr8X
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d64792 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=7fw9t-owY_ObQSO0K9YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _ezVQgjW-Tp2IxpVFlQ9ZIfKS3TqoZcl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080109

On Tue, Apr 07, 2026 at 03:24:44PM +0200, Niklas Schnelle wrote:
> Add a mechanism for architecture specific attributes on
> PCI slots in order to add the user-defined ID (UID) as an s390 specific
> PCI slot attribute. First though improve some issues with the s390 specific
> documentation of PCI sysfs attributes noticed during development.

> Niklas Schnelle (2):
>       docs: s390/pci: Improve and update PCI documentation
>       PCI: s390: Expose the UID as an arch specific PCI slot attribute
> 
>  Documentation/arch/s390/pci.rst | 151 +++++++++++++++++++++++++++-------------
>  arch/s390/include/asm/pci.h     |   4 ++
>  arch/s390/pci/pci_sysfs.c       |  20 ++++++
>  drivers/pci/slot.c              |  13 +++-
>  4 files changed, 140 insertions(+), 48 deletions(-)

Bjorn, would you like to take this through the PCI tree? I think Niklas
phrased the subject with that in mind.

Otherwise, I can take it through the s390 tree. If so, could you give
me your Acked-by?
