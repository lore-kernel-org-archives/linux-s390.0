Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3639B944;
	Fri, 13 Mar 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408784; cv=none; b=nfYXmvY36J4GbhnkglcR00VNQ6Cx8UiCZVORTwCHws7t7DjDFYJ5k9eXUsUVOIZTZTIA6L4vf8f+uTzhigqkS/FPJprj7lfbxsqZDy3kcV6sz1CT+sd347nbdtdVYoNcoi6W8NTwJWY2gSzIF5U8/+euqgm2yGtiQpqeJdooEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408784; c=relaxed/simple;
	bh=Cmf9C8jdnRxFhIrga8eXUUi/3ceTPrN8yeNIZHWtqWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdUkR6EHkM/BbqMw7TcIrFxUpofwyIOzjTlFqPsTWmb3ZfB+1h9jpPNiNS96AwbC0o0aOMsCRJ/zGsZtV7EbqXTo+nY8je0uK9gHckyg5HBVkrD5o5wVL2aZsOEirJh+WRyx4wz+060lYaJmNLro5nSURiCSmL29rXYSrg4UkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G12VWOuS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G12VWOuS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D53RBH2303246;
	Fri, 13 Mar 2026 13:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=H65/PNt2NpvbM4MMf/pw+mH+fy3auvgJ8ZwANvpEhqU=; b=G12VWOuS1Xce
	hLjfcbDGmgwVsXzm9E9KwswDX7PeMXj54fOFYJHTksUfw8g2pINAwaonBaRDrxBD
	Cz58JZtSh2y7wTEpbT7PeUNPlzUGePSmhd2LPZMryT0oBPXenWG503ST0ApiZbmc
	grruj4KJ72X+x0ovfXi5a4XlNQmNkAYq1oaE7JXIVyd5DNmWL4a/OBPgWj7pZDrI
	NzgcoDd5oDrFhl4va33TbmkqeYWEBk0ZgdmDhCX1UaY+IbjTuL6asqU1ZxM0qLUR
	V27gho7M692Qgd+/M0CIV9vevVHov2nSHUcmq+KUcpu8/zzYY24eWJb7NUpYLcf3
	TAaEN4R1MA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95ypwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:33:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAOBx0020823;
	Fri, 13 Mar 2026 13:32:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9pt81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:32:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DDWtdm53412306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 13:32:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F3CB2004B;
	Fri, 13 Mar 2026 13:32:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B55720043;
	Fri, 13 Mar 2026 13:32:55 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 13:32:55 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w12dL-0000000Ew0T-0hWb;
	Fri, 13 Mar 2026 14:32:55 +0100
Date: Fri, 13 Mar 2026 14:32:55 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Julian Ruess <julianr@linux.ibm.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] PCI: Provide lock guard for pci_rescan_remove_lock
Message-ID: <20260313133255.GE2161595@p1gen4-pw042f0m>
References: <cover.1773235561.git.bblock@linux.ibm.com>
 <c55e954604dcf728dfc93ed0adff102f2a2469e9.1773235561.git.bblock@linux.ibm.com>
 <51276081d5a14795e040af21d151eca8eb32ab81.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51276081d5a14795e040af21d151eca8eb32ab81.camel@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwNyBTYWx0ZWRfXx0j8gk5qkcHS
 OZZTliZqNW9tbR0vEUe7W9VoZ5Sjo3AqvEjRd3J4dnlCdn/wvql2ab32cdjRDj7SKZErJ/bqFaQ
 Mq+kiOcieK7NDeucOZIBj7ll3FFdE4m313AJE1xxLj5WV2R0c7LQxcTmqjsTh4EAv6WhIzKZZgb
 484Q7C0AWzq/ENZmPdlleJozbB/6OfwP8qtxWUeCSg58LNbWxLhY5cTYmb3Etrgj6iFGZo6Lzfk
 yB7e5nt+k6uCu9gEQ8zIAez23Z70WbSS7agjsdV0Z83T4WFEoQ/BLLGjV2nqG9VbJTiSQDNaQqJ
 5wuu1ucaVyiRt7lIs/p9pBZw8xZc690ifVyR0CA9aZkRQDFivNRSY3OMo6Vxhl7U8RdlAdv2b1e
 1Qhga42ql/ALwYZZX3N0wJoOGe0tPrKn9Z5EFdDi6EVLH+9UWq2TDDAqvvQAZtnjbkrM9KjSkv3
 0PK6PcCnxAjssnKLylQ==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b4120c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=68vO-LSvPmclk7FFOsIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: X6x8JjMJ__6SFKxbssLLIpguZH1z3slG
X-Proofpoint-ORIG-GUID: hBa2JCWwsBH35omAVkM6p8KaVgZW_0io
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130107

On Thu, Mar 12, 2026 at 08:44:02PM +0100, Niklas Schnelle wrote:
> On Wed, 2026-03-11 at 14:27 +0100, Benjamin Block wrote:
> > Make it possible to use guard() or scoped_guard() to lock, and
> > automatically unlock `pci_rescan_remove_lock`.
> > 
> > Since the actual mutex `pci_rescan_remove_lock` is always supposed to be
> > taken and released using the functions pci_lock_rescan_remove() and
> > pci_unlock_rescan_remove() it is not possible to simply use the already
> > existing guards for `struct mutex`. Instead define a new guard
> > `pci_rescan_remove` that will also call the functions in question, but
> > is usable via guard() or scoped_guard().
> > 
> > Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
> > ---
> >  include/linux/pci.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
--8<--
> 
> Looks good to me. Thank you.
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
