Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9F27FB37;
	Wed,  8 Apr 2026 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689972; cv=none; b=ikd9w3OyX1rRxANCr45O+6XaLrKRuzoiEZ6O0UAqiXa6V9Tyz/vGYfFC8naBFaxJo+RBDFGznhNB4Qy3PSjHHVyb3WWRSP+MJtKAb9eel6qfc0L2V+Ff3YCbW/mcCxI9gzcxs9OfmyqiqBcvxX/ZM8/aawQ89gHiP8+Bc9OxRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689972; c=relaxed/simple;
	bh=4ixOa87Rl+zC5lLX74n74Emn8LZURNkIR0pJN/SLRk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UshZQAI/xEi+Ba3qFYJNkk9/Js6kadq+DnTumTqx1vTktQN72ywP/uBCefbPKia1CfpaqzjTP+377llDYQCI/CyvdH1csCuQYCGKwuZXEjkOZQhMbeh9iNPeY59AJadpEyaD37jPJbBaB8iX92Fo+VYtmSUiqejGiRc40a1G5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RnXSvFBQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RnXSvFBQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638IBOWd2301624;
	Wed, 8 Apr 2026 23:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xQl6MmNdG3YYnHAHUYZMWGICh6uDQs
	SLUxVz+4KVHYQ=; b=RnXSvFBQQNyH5EJIs1e943OMDWq861BdQky3UOGKZ2lFm1
	0+0OKc/GdTsM7ferqZEaIPF6FZfBVhA+c5iYhiiH6CDKOo759m/IKmTm2QX+JlKg
	KgQh+agqStcJjP902dgFarU1TdheWklVDjCx9V8OqQZ/Dh1CrP9v9C0cdlpYeoF9
	lfq1auoBu1eYrxEM6jxQ3+wFuZH7/79nWTF/pCH43IOA/3frVLJsO1M89PU2Bj9r
	nYtueXpe7Fw4KiiMkR0XMF+FLi6JTXPwen2x2keeaAsSWo5m2TXyu2WmdZDN28Z1
	nSIpn2bm6aUbEdSM+aLEr16aDxDrwKA7/NZwHTFA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fjc4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 23:12:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638KGLse026723;
	Wed, 8 Apr 2026 23:12:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg81ag8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 23:12:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 638NCT0f27263420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 23:12:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 429CB20043;
	Wed,  8 Apr 2026 23:12:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0E2D20040;
	Wed,  8 Apr 2026 23:12:27 +0000 (GMT)
Received: from localhost (unknown [9.111.74.150])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Apr 2026 23:12:27 +0000 (GMT)
Date: Thu, 9 Apr 2026 01:12:26 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <ttd774q@ub.hpns>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDIxMSBTYWx0ZWRfX04fSY9lJXWCl
 Hybl/B4eBz5+w1drE2mmzeDWpQ1oB5MNuElxem7elzqStgpPyzcYhgngG3DMZDQPxpjf4nwfcwY
 UlAyKf3iP8Vr060Xp1HVURYjTD08EmZiBAgP2Dts6Smbp30vGVFZuEUMMjLbcO9GQZMFDMRa5Qg
 XLjl8A22tz4rEqkmSK3dBVhk8ipKz5e6Zy5pxxFc5X86dTZADIMsSevBSEHYzoY84pmsxWsuD1B
 qHRPiqbob3kOtJVLRfhiD5Nlyw7yK7jqAe/dpGvRrvqf0SScTDyyFz10vp7f+JTzhEoJjiwicMc
 a6GWLWqF2hY7n7XX7sX2C3iTzKy/+Kqu8H2d2ssxH7hiLK7LqPGslSSHpOWhZ5T2QMgfPdd4BX2
 hom9+dv2JbUl0piZFd4TPVVDEdh2V00G5dHYCfU393DHTA7PnDNymZROmUU499yFmuHgHJxuJpI
 LU5N86TkcocpxUX+dqg==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d6e0e7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=7fw9t-owY_ObQSO0K9YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qpQNmMpZT1FSp0wZBE931XIvoIwTc2va
X-Proofpoint-GUID: 7IdXthYsBHhh8Nb4CRm6PuqhLy-jLcnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_06,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080211

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

Applied to s390 tree, thank you!
