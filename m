Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470337F734;
	Thu,  2 Apr 2026 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113615; cv=none; b=Gt9idfSULal+2RVt25tOnurL6xfpOJEdBW5Y2Xlthd3DMSkfcjJKzKG936mIZt/byUKb59mqBUMpqbNKd7YRbeGy+kFd40bF/ZshxK5AXnMzOmqy5+Srp4267iE2p3VrhU+bj5q0o8RdDwhR7bLEWGl9EQvCD7ivxx/NaE2ueCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113615; c=relaxed/simple;
	bh=YOfWV0b+1yPsva8LgjO/aKzz5PWMLP1G/zmXa15zYV0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OsRQGH6IeBrsHZYaWcZ+JbiluBJ5S9J2uFTgSCTaCHKW1ovYUYZxFnP9iPMmIemF1UipyDC3qAbwAqbxtoWRBUCgbhvdPuG2jTXp+arFKUE8xSGzrTsI3jgNKJsmRt72sfETarBZUC4p/wrtHfW9v0fMlt12IFpod5vBCu3j7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CGpTdZoF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CGpTdZoF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6321QLLE108580;
	Thu, 2 Apr 2026 07:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KTjfrj
	TpSK0fVT+D/0wqDCWvFcR2XqlkR0GvUIEpVUw=; b=CGpTdZoFMBa/fEnF5reNfY
	dODnCk+uRojGVPZLfxBWWuz6PFqwL8pgdPTjIOnLMJ+7RPB9oRdo1VFHX6FXOS/r
	qkqdbTkIBQ+4+uG/izb9FRAmncrH09Jc3jRpTG9Ly10wb8d8QbsJNmq4DpcEVbtW
	mZbCGST+40gJqyu8BdKYNMRQXXBTNl4IVqreFuMjOestuFRgNfTyWamnhNzoqE5G
	fl6fmu1h5BPq4M3YfMKzOP6H04E2LnFJuMqxfBOMs/W3CzpXB6DzHm9595ZHhYxc
	FC1bonybXZ/8R7Sm7VFdlpPZww/gGQ4ERE7afZP5ts0gkmUGjISrd05KS2/JzBMw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcjuw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 07:06:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63271VQD013897;
	Thu, 2 Apr 2026 07:06:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkryfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 07:06:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63276g0246268730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 07:06:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BDEE20043;
	Thu,  2 Apr 2026 07:06:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 046462004D;
	Thu,  2 Apr 2026 07:06:41 +0000 (GMT)
Received: from localhost (unknown [9.111.23.196])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 07:06:40 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 11:06:28 +0200
Message-Id: <DHIJSWHNRSRC.BDZJHUQF0K80@linux.ibm.com>
Cc: <schnelle@linux.ibm.com>, <wintera@linux.ibm.com>, <ts@linux.ibm.com>,
        <oberpar@linux.ibm.com>, <gbayer@linux.ibm.com>,
        "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Yishai Hadas" <yishaih@nvidia.com>,
        "Shameer Kolothum"
 <skolothumtho@nvidia.com>,
        "Kevin Tian" <kevin.tian@intel.com>, <mjrosato@linux.ibm.com>,
        <alifm@linux.ibm.com>, <raspl@linux.ibm.com>, <hca@linux.ibm.com>,
        <agordeev@linux.ibm.com>, <gor@linux.ibm.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Alex Williamson" <alex@shazbot.org>,
        "Julian Ruess"
 <julianr@linux.ibm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
 <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
 <20260401160441.406fe25a@shazbot.org>
In-Reply-To: <20260401160441.406fe25a@shazbot.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ce1587 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ZDiVSpLLCKoyWu1YpPgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EVxx1ZDovUSM0yfp_nhhPsUDtEZ_Wy6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA1OSBTYWx0ZWRfX3ovWCpFFYroV
 1u2j4sTkKDo8LEOTApw/T0oDUX5BdWaECIRsmc1xWCqEozVjpZc31HooRqiOe38iy52SB1oDLdV
 F7U2y5RRikbE3jfEkcAZqS1kZwS7KryD0Qt0v1WtlIUgam3OmlFcdjb+BCu64Z/TJvo+/8GkhXi
 /x6lXxblxnE9NCJ3NNeefU0Po74S2Y5KZ9OXQF9SG/BAjadxGLGjg93x5r7kTlsL0p+rSGO2svw
 CWM0h6xtpr2h3jbf7Mq+s8rrHktr91XtLderXamWboubb9j165q3IXNud6Q2gaIJZQ8VL9fbd9c
 k5Nk2ElAKHi0V1Sg5vgRmGYkIgdNv7kpWL6MjhYZtqLCTb5qyni8Ohx0p9GJUUyr9S4jKZR2WzS
 tIBFcuiLkqC0lDo1NX59grUX/USYn2Faj89d0SIK5Y8nYFY7PypUIEA0LPnnuwe907+6iYiA8rQ
 z+hM7aVPaJi8N/G5DIA==
X-Proofpoint-ORIG-GUID: EVxx1ZDovUSM0yfp_nhhPsUDtEZ_Wy6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020059

On Thu Apr 2, 2026 at 12:04 AM CEST, Alex Williamson wrote:
> On Wed, 25 Mar 2026 14:31:24 +0100
> Julian Ruess <julianr@linux.ibm.com> wrote:
>> diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..00bc81f7225f806eac1b99c4=
520ab5a68137885e
>> --- /dev/null
>> +++ b/drivers/vfio/pci/ism/main.c
>> @@ -0,0 +1,408 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * vfio-ISM driver for s390
>> + *
>> + * Copyright IBM Corp.
>> + */
>> +
>> +#include "../vfio_pci_priv.h"
>> +#include "linux/slab.h"
>
> Convention says this should be:
>
> +#include <linux/slab.h>
>  #include "../vfio_pci_priv.h"
> -#include "linux/slab.h"
> =20
> Without objection, I'll make the change and push this to next tomorrow.
> Thanks,
>
> Alex

Thank you very much!!=20

Julian
