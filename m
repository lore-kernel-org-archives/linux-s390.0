Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C843C3F5C;
	Mon, 21 Sep 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995490; cv=none; b=o0xKYO8c7NhYGKInfwd2rcrVxEcs9W9q7irwpMdmmXKrmVdljgBllvA2ZgBDZbSrOCLPLn2XwMz8VE09x9b7AfxxEdzvPAPpCF7itAfPxUwMteYPcj7VNMF/i6VSyor+b25B5U3Vi+iGklFWfpWnttGZBA8cVDCWUFyib6aoSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995490; c=relaxed/simple;
	bh=U+iNA+ewdw9QjWb2pfFqPvb8JBcksCtiqKJ0nhhYPfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmRHg1TbhGFPfOUeX2MqAl5GQI6ApHp7SZJGiFe8j/MpaaFOHXdoeB59HePO8so+D2in9kXQPQi5rOyUPHhhfRpJIfIn+gBUbs8+Xv/PO//gI6NAAAC4+sEQVu4Iusv7887KFTbQKrbnhNFXFPOXbV5nDiGvo9gHKYMjWBqbCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UNmaD0Lh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UNmaD0Lh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5Pkf1316555;
	Mon, 21 Sep 2026 12:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=u8hrIA4ybDMxlv7uVLhjWvVLQ29sbu
	bjiGqz5uBc8Ak=; b=UNmaD0LhtNI12Omldxrav1mcXtrAfWQ2Fncrn9aanCa5DX
	cegthF3ey+HFlm48GR7g0ARzdMTS3MyvbDd6QrP20KWSvynMVyUUs1yVNLJSMTWN
	eWRx1sQcpL9HJM7HHt86x/1uPtEVY/NfTqrz69lFN6qWiTihkAjBZZd8dYnymLWI
	kPN/MZiaU9C5ktBUvARCvv4CLCMS/IeIsvq7MQs69Wvxp0cnMRj1zxh2Puy3C1KO
	II3DGXYc5CeiCxiMZiDtOZ+Za4lwZCnhNIUHTU4ohM+mFnimaLE0nqx06EBiNXUa
	LkB/Qa9g8qZqtnpJG/QpXVmVPcz0NDtiwDVp7oig==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg28kw1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:58:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAld6S1072418;
	Mon, 21 Sep 2026 12:58:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjna3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:58:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LCw3qE35717522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 12:58:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4804020043;
	Mon, 21 Sep 2026 12:58:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B00ED2004E;
	Mon, 21 Sep 2026 12:58:02 +0000 (GMT)
Received: from osiris (unknown [9.111.14.239])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Sep 2026 12:58:02 +0000 (GMT)
Date: Mon, 21 Sep 2026 14:58:01 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] s390/pci: Fix some zpci_report_status() issues
Message-ID: <20260921125801.9433C34-hca@linux.ibm.com>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OoY1AnboP2uPJAXl5peo_dYcIGWRaMz-
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab129e0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=ofj4Y0baRIDAMozNyEQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MyBTYWx0ZWRfX3MiYiNJmVBrY
 LgA0awosdDqaMJ9qTBKG+hw6U3FjrHwRvup62TlbOIBqaXySsEhXpBRHGQOJbugjTG55C0CUpj4
 SPEiP6AcInRutVNBQ+VzxT3WUgjj076We+BH1AUeIVpJS2VPyxe4CTfnf6phDtNayI/kmCOc6bw
 ydMa4SXMDeIh8EbPka9apSxikIxaxdJsBqlKRh6WfGDRU4azQgwCAg2zHEajaZHEk7Wz077zJaK
 FVjZgtrFpGv6lO3sMt44IAPzLFlhck4g4EIA9nY1+9/eO52r6gHGDwHl2MwgWkw/PpEw+dwjQvE
 OjNG/TtVe40leriv+POn3QbPiq/8eoFVsplq5np3v3N8GcYd8el/Q7epWpJdhp1wjzLlU2EQFxT
 pxgLDpaxgOoJ/plvXBiTuEROWyIG44WrRDGj25N9iZWjfrUI6UPKb/SlJkyNoSLxmDD8oCzv1EF
 NQytgrAEgP++OaTROpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MyBTYWx0ZWRfX5S4elwd67xa5
 dQirHd2CaVxRvHOfo3KTwY+FkvurjKO1wwKilGTRDZSN+NYr/mFz5nnc5Q9+d0oIL88/H0Dyrjh
 V8XmISIxqoxF6TABmsSM1JgIf50LArI=
X-Proofpoint-GUID: OoY1AnboP2uPJAXl5peo_dYcIGWRaMz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210183

On Wed, Sep 16, 2026 at 05:14:09PM +0200, Niklas Schnelle wrote:
> Hi All,
> 
> This series fixes four issues found in zpci_report_status().
...
> Niklas Schnelle (4):
>       s390/pci: Fix leak of struct pci_dev reference in zpci_report_status()
>       s390/pci: Fix missing device lock in zpci_report_status()
>       s390/pci: Report SCLP status on error events when no pdev is associated
>       s390/pci: Don't report recovery success on skipped recovery
> 
>  arch/s390/pci/pci_event.c  |  7 +++++--
>  arch/s390/pci/pci_report.c | 32 ++++++++++++++++++++------------
>  arch/s390/pci/pci_report.h |  4 +++-
>  3 files changed, 28 insertions(+), 15 deletions(-)

Series applied, thanks!
