Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2833AE706;
	Fri,  9 Oct 2026 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534139; cv=none; b=jikEMwQZMQRfjOLRzGr1CgyzFpAbsKjxOPe1UKJWNB3ClLSr7D9mKsMuilrZ8+exXYYZJw343WFxck7qC070NDInMmqge+LEtV51ixwz7TQ2yFqXTHCm94UAuMSYNIBrSLA7Qpau9dRoSVx3Y5taRgH+HxFcAApgS8drrSTWHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534139; c=relaxed/simple;
	bh=ukFQ4/ui1VqVugfxgHKsFxlK4ETWJ4ATSqk+TWaBVkQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=H1El9r1jUTJZ8cpxab4hROnxIE2nJ0oQtgdMo/9b8tQH86GhYU/eAjEzNKIciHhgn7LfXUImlutR81MTwbYzJlxp2fIwfuU9xdPqaqoe6OeUOa9yKb7Mx8ScDj2wqH/cd2GjD1MOIXo1B2oXTZJjVRf0evGf1aFLLp/O/bCAY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHOMbMFq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LHOMbMFq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZkAn3209544;
	Fri, 9 Oct 2026 08:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EuWLKM
	W3bqup8A4VClXUJqRwXNdNmqTMrZ+827ab/No=; b=LHOMbMFqhivXfjaGKHK4l8
	5TG3AxFi0gzKj3Rw6SqA/zeHLshqMRnx1rIjPy9UiBOxV2/vlzf7T45JwgBoZrXK
	TvED4Xaldu8vF/+83AvEFCW6ROh+4gaEyye2M9BnmNUeEI1KFrwGX8nwbILirgYe
	whJaVmT8uFGlc5CeXfKBdtxzsjlS1tQiG6ml1LIgNNDQCWW6yjj8POijRCvnmMLK
	vX7HyR459EoYjdb/8krjUVQHT5iOPMhpzg32C7L9JI1GTledS3uhaug6WLauZbjq
	jeo4sdQgjlEjB8GJkhFlvScsyl3B/UvVW78JfWXt6p1CGCl+QR0krj9J6WnEIwEw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvrr61-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:22:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I3wC621424;
	Fri, 9 Oct 2026 08:22:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnj67t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:22:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6998MCjI46793044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 08:22:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 251562004B;
	Fri,  9 Oct 2026 08:22:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C04C420040;
	Fri,  9 Oct 2026 08:22:11 +0000 (GMT)
Received: from localhost (unknown [9.111.170.212])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 08:22:11 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 10:22:11 +0200
Message-Id: <DM05UI42G3Y8.M70PK5HKUNKQ@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev"
 <agordeev@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 4/8] s390/pci: Fix use-after-free race in zpci
 floating interrupt cleanup
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: <sashiko-reviews@lists.linux.dev>, "Tobias Schumacher"
 <ts@linux.ibm.com>
X-Mailer: aerc HEAD-0d169b7
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-4-ced19028da3c@linux.ibm.com>
 <sashiko-outbox-164948@kernel.org>
In-Reply-To: <sashiko-outbox-164948@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hQdDAD7RQ96NT9ZNk20_0skjkKTxf9G7
X-Proofpoint-ORIG-GUID: hQdDAD7RQ96NT9ZNk20_0skjkKTxf9G7
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac8a438 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ImQPJegGMbh94QW6gX0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXwbo50nDOzbfN
 3ekn2Z8NqP5rY0t+AxalBR2Ui2t5wazRaa9Mcsvyf6jAXarBS5rTVFLtUYsvyhVfE9hZZTbuKfC
 OJq1cpvuBqj738mGQHgXemn5yxdaFBQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX8OdwkDtVLEXA
 xuIjMq6KukTf9QHi7iGn/PDrgZpda/v5ssR+EXnPjjPRDlqxcvjO4n4v19o9XZq7X/ePRA4eniT
 uuLtZ02BXQKdNsXTMzhLb3TiSd5iZxtvWVUkYKda+B/iD0AwsMlZ+94LD3iLWJb9g/zc4AoGYzG
 UkgYw0xioiVf1p1rWC+kvc4zdCJt98MkA3bRvWiwE9q+CUuBgPK0SHuYf2kuAhkLCL4XWA5HAVk
 Sc1HGhI0jddEkg2KHYkWJoHYsnZh5wY/MQHjYIU/Rtcx1XhoqHAsTcNtnA2Jjwe7YGccXpKLQrv
 TMNw2CmHYAjVLF/sOed7CBk4dQFCCb53OFKtDlZOEYaPBk73i0vMzUHzMI7HxgDngr1aKAhKyqG
 mj1xuunzP6SchHUgguhOE3SJAwnjIXlxfra/a1CuHrlJM7/FDV55J1RM3Bs+MHQ/bYIcKe79YtC
 mWdgQuk+GquzK0QCvqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090032

On Fri Oct 9, 2026 at 8:32 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] s390/pci: pending directed MSIs cause spurious interrupts on rea=
llocation
> --
>
> commit 125383b5f8790de7f1cbeff916db7b71f9226ee6
> Author: Tobias Schumacher <ts@linux.ibm.com>
>
> s390/pci: Fix use-after-free race in zpci floating interrupt cleanup
>
> This commit splits directed vectors from floating vectors into a separate
> zpci_dibv array and adds RCU synchronization to zpci_msi_teardown_floatin=
g()
> to prevent use-after-free issues. It also annotates zpci_ibv with __rcu t=
o
> ensure safe access to floating vectors during teardown.
>
>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index d5763c5feb097..c5fabad381395 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
> [ ... ]
>> @@ -342,13 +343,16 @@ static struct airq_struct zpci_airq =3D {
>>
>>  static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
>>  {
>> -	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
>> +	airq_iv_free(zpci_dibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
>
> [Severity: High]
> Does this code leave pending DMA bits on remote CPUs intact?
>
> Only CPU 0's vector is passed to airq_iv_free() here, which clears the
> physical vector bits on CPU 0 but leaves them untouched on remote CPUs.
>
> If a hardware adapter interrupt was pending on a remote CPU in
> zpci_dibv[N]->vector, the bit remains set. Furthermore, there is no
> synchronization (such as synchronize_rcu() or draining) to ensure remote
> CPUs have finished processing the old bit before it is freed.
>
> When a new device allocates the same MSI bit, it will overwrite the ptr a=
nd
> data fields across all CPUs without memory barriers. If a remote CPU then
> processes its delayed interrupt, it will read the newly populated ptr and
> data, resulting in a spurious interrupt delivered to the wrong device or =
a
> potential kernel panic from an inconsistent domain/hwirq pair.

The only change this patch makes to zpci_msi_teardown_directed() is the
rename from zpci_ibv to zpci_dibv. Freeing the directed bits only in
CPU 0's vector goes back to the original commit introducing directed
interrupts. A stale bit on a remote CPU could in theory end up as a
spurious interrupt for a device that later gets the same bit, but until
the bit is reused, the cleared pointer makes the lookup fail harmlessly.

I'll have a look at clearing the bits on all CPUs separately from this
series.

Thanks
Tobias

