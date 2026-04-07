Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F322395DA0;
	Tue,  7 Apr 2026 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564898; cv=none; b=S5VMJ+diLwIKRStWHub0eZx0JKbs306X/zUZ6XSn++EL832J9tkyGoZ+7B/ZkJjw91BS+KcTRH0fYPasGwbU5nnIHIu4fY/uSm85/UuAxhQqrP1Q4nrLwDSbhdRuDXNeGFpAMm5cHNnXEMP4EwXHxt8uwVG8wT4MNsk0Oq73CRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564898; c=relaxed/simple;
	bh=6FUfk7RT/o3k/XrMyRD8enzUua7pxbhrQLW2/w4NOcA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bv/r8LpMtAyzNzGqwTjo/Fz7Eiz5AmNYBMCpyoJjA5eZ0eF1ux7WxQKoV05XlpFj8HecDmYOFoPLnNvT9vmloHIsDclqLPYYkUJBH7st5HVPsz/qOInIX3l6+Ql5B0Swdf1hlFADgI9cmKeTLEwByi647c0JY4/W227gJ4YPHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LqDvnMly; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LqDvnMly"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LnDE42594684;
	Tue, 7 Apr 2026 12:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VYRpeG
	fSJPcs/ZBissaz4FE+R6c8k6IoRpmKwrxG83c=; b=LqDvnMlyp/SO08OuzBZzbA
	FEaPTTLEmuobas5UfslokXkF3vFARZdlA0mE3Bd+mQFCAzeZKArtQSzc0lUB642a
	WmI3QWoyPN0xu0bSRu5vKdlrAy1vvJAH2Ji240A1mfuKNrvqjnAElsZx5Maf6Jq4
	mkfj5ZQ45JezStr4lhYVOiWYIYcKdC00UvG6einatuauzCi4wU9h7hudjEaxfA2n
	Q64KtngweI3RKrXSRp22Kxjs7NZbSmyyJ7yq8o2aXD+KEGC/4pzAswMUY7axcRhH
	S02xz64f9DgY8r5MC9MZroO359MabOfJpTAyKIaHrBqFT4Cgt96zsP6lDd2EAEbw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e2x9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:28:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BQMMe013902;
	Tue, 7 Apr 2026 12:28:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf432u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:28:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637CS2jC53215620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:28:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A224520043;
	Tue,  7 Apr 2026 12:28:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F292004E;
	Tue,  7 Apr 2026 12:28:02 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 12:28:02 +0000 (GMT)
Message-ID: <61126291e21010eb79bc0a8d02cbf5d30e0c7b8f.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/2] docs: s390/pci: Improve and update PCI
 documentation
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas
	 <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Lukas Wunner
	 <lukas@wunner.de>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc: Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens	 <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato	
 <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-s390@vger.kernel.org, Randy Dunlap	
 <rdunlap@infradead.org>,
        Gerd Bayer <gbayer@linux.ibm.com>
Date: Tue, 07 Apr 2026 14:28:02 +0200
In-Reply-To: <20260407-uid_slot-v7-1-e50f7976124e@linux.ibm.com>
References: <20260407-uid_slot-v7-0-e50f7976124e@linux.ibm.com>
	 <20260407-uid_slot-v7-1-e50f7976124e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2FrKXpPRsQulnMDZ7cCBZYX1SSb9CaJg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExNSBTYWx0ZWRfX6U7wudWaC2vP
 aeCb1yFxSgTz20lMErS145WDtAbPJ1p4DbtUSEgt49uruJWHkQFUfSOOAV66J7iI+vkmGEg0L2G
 v9A1Ndu+L+lt6yynCLh5UdOZZPyrUWLrpDxEc9oqKwVYztHcRKiez4f+FOIqGUxBWg7l8o372EK
 eavRf2lwDrCoZ059SbYBkHlG7RGwMMAP3XWKjGMpfZ2BiZbBihwAZckYeKtUJsu44pUdK9LDZ89
 tioW9HeaFRReLd5hFa7F7gZntr4qCRpsnbPHuSZA5lUCMt8eGA6JtudBP/y5zCkDivo1d9kDD10
 QA23i/oNeCV2y9R+Sut4lgv/krDtgDeTtk8B4xyP03Gq5HTA9fWZpTgICPZ3lbe4MEef98VN1Xw
 ZYRM3LZLOHnmw4fLkXbURqCskuFWf6owB7fDxBmJPIH8hEzxVWL2vr6eM73396q1ulSQkeNXjAE
 vlj4+WHFEDgzsyI3Ksg==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d4f858 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=OSxpM7LHIlj9ssaGjo0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -KEi8FMBa-OPQkuO470t9wEU_YANZg5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070115

On Tue, 2026-04-07 at 12:12 +0200, Niklas Schnelle wrote:


[... snip ...]

> Similarly add documentation for the fidparm attribute added by commit
> 99ad39306a62 ("s390/pci: Expose FIDPARM attribute in sysfs") and
> add a list of pft values and their names.
>=20

[... snip ...]

> ---
>  Documentation/arch/s390/pci.rst | 144 +++++++++++++++++++++++++++-------=
------
>  1 file changed, 97 insertions(+), 47 deletions(-)
>=20
> diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pc=
i.rst
> index d5755484d8e75c7bf67a350e61bbe04f0452a2fa..8cb0a1e784a7cfc5df1e04a41=
54ba02c9ecf46cc 100644
> --- a/Documentation/arch/s390/pci.rst
> +++ b/Documentation/arch/s390/pci.rst
> @@ -6,6 +6,7 @@ S/390 PCI
> =20
>  Authors:
>          - Pierre Morel
> +        - Niklas Schnelle
> =20
>  Copyright, IBM Corp. 2020
> =20
> @@ -27,14 +28,16 @@ Command line parameters
>  debugfs entries
>  ---------------
> =20
> -The S/390 debug feature (s390dbf) generates views to hold various debug =
results in sysfs directories of the form:
> +The S/390 debug feature (s390dbf) generates views to hold various debug =
results
> +in sysfs directories of the form:
> =20
>   * /sys/kernel/debug/s390dbf/pci_*/
> =20
>  For example:
> =20
>    - /sys/kernel/debug/s390dbf/pci_msg/sprintf
> -    Holds messages from the processing of PCI events, like machine check=
 handling
> +
> +    holds messages from the processing of PCI events, like machine check=
 handling
>      and setting of global functionality, like UID checking.
> =20
>    Change the level of logging to be more or less verbose by piping
> @@ -47,87 +50,134 @@ Sysfs entries
> =20

[... snip ...]

> +
> +* /sys/firmware/clp/uid_is_unique:

As much as I had loved the attribute to be named as such, or even
better /sys/firmware/clp/uids_are_unique, I find commit b043a81ce3ee
("s390/pci: Expose firmware provided UID Checking state in sysfs") has
introduced

/sys/firmware/clp/uid_checking.

Sorry, that this did slip me...

Gerd
