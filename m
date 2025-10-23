Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35730DD17;
	Thu, 23 Oct 2025 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218342; cv=none; b=vCzOm/yLllCwe7bD0ZhvNG6pei9amFWXMjaVrU1ILkNVp83ob/TAriz1Pbxv1dMWqqhDL+30ufeFVUxfuv/rUNHUh7G+ENPUIzWCbKEL6AD6WvJotgPfU164p4+2vLawpsRCd6fBUkJofbKizb3VU9hevS1p9eN7wtjgCJ0QRcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218342; c=relaxed/simple;
	bh=mqmmRoH7FITAijeJxSsnMZTJhAWPbccQroHX6Vusc2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+z6G2x6cOlBNWPXx9vaHMm5H/XPgjhPotu2jfalnqHzgJ9sy4F7TaC8bKBv+jz4/pvMyR+85racrnCRJ1IOTnv2RCzKqBBVkBGThscROxrf1Kt6gVQxRKVZaPZC84z15MtqC0p2qhNHj0TgevnYMv70T13Jpos/J/eJt7MHQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iYc604gq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iYc604gq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N2YUTM007314;
	Thu, 23 Oct 2025 11:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NwOVVK
	jecxB0kPvTmRSrjB66SPVexfOW1GqplpBuWZk=; b=iYc604gqeNZlkyvhcdJT6C
	r/cYmg/+5+VQMLOO1iW+Au4tPFOYLLnCIKLpQK97YTwm1dwo2VfhRrWJ4bJgX0i4
	2HvsbiIq7PXAtVKmznqt6dBYfR0zKzc2Oc3W6LvQBHBJHSo0OL4IJRr8vUhX00nP
	YpdbNBz8p8Ct5SeDAfHvVzhyihYtBwoVujEfWb97CI2KfXhZH0DfIaoVighoqVaE
	oG7pqtyVINmkdJMJTSldiVqPo8YKOb9Dpjuwc684GRv+aT4YeK9O1HK5AwnIiBeA
	QIALTRcUiu3Ap5o5xK699HQsexhDfpFQl8F4xZTSSjmPNaGmBMa1HUAUzW+oUnwg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fhu99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 11:18:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBAW71002367;
	Thu, 23 Oct 2025 11:18:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejn7b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 11:18:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NBIvbT51577092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 11:18:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3136158059;
	Thu, 23 Oct 2025 11:18:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A299558058;
	Thu, 23 Oct 2025 11:18:55 +0000 (GMT)
Received: from [9.111.75.188] (unknown [9.111.75.188])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 11:18:55 +0000 (GMT)
Message-ID: <d611c17f342acc0d00b9921686474007a7d29213.camel@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/pci: Restore IRQ unconditionally for the
 zPCI device
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        mjrosato@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Date: Thu, 23 Oct 2025 13:18:54 +0200
In-Reply-To: <20251023074028.9536A84-hca@linux.ibm.com>
References: <20251022164727.882-1-alifm@linux.ibm.com>
	 <20251023074028.9536A84-hca@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa0f23 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=2UMdAixpWwqS9JbEpxgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Pm42vjeufBB_-sfYUvcyJTn3c4vJk5pl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyAW2bk/ctP8Z
 98hSg0eOSpqfftB+CnEZUNp4UXYkxtwPOGhfSvGBupZ3ZqsWUOAr7B9lgL8lUVYaiW+m3Y6Z2Md
 xHIbudXcmMEq1gitiIbZdt7ZhGdtUoWLlykiZEedGLPUeBw4Sm3lOTmEnw5UjYbKaGMAlFljHHn
 oLxT2YYRDVWTwb0h/1EKSE/+dc8hI7irmhtvDgwqG7qSGVk2cUKEQkNFCNNG54T7Baa3gaVlgJN
 1mnIxN/QFFmG8tWNlj1+Fkpt/9Y/zcUIeMYa9+gIOF13Rxc8L6ePTkvNnw94rCEklbpQxiiRaDg
 V9ke2YavFYfkimWBovC1VIgnaG0yXQ/nC1NPNuDkT+Sf6erAs7sMbovnCA+N+1QqRGCLwMEu+2J
 yOV6DWRnEyvcvD4NZ+T+ACY52E0PwQ==
X-Proofpoint-ORIG-GUID: Pm42vjeufBB_-sfYUvcyJTn3c4vJk5pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Thu, 2025-10-23 at 09:40 +0200, Heiko Carstens wrote:
> On Wed, Oct 22, 2025 at 09:47:26AM -0700, Farhan Ali wrote:
> > Commit c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()"),
> > introduced the zpci_set_irq() and zpci_clear_irq(), to be used while
> > resetting a zPCI device.
> >=20
> > Commit da995d538d3a ("s390/pci: implement reset_slot for hotplug slot")=
,
> > mentions zpci_clear_irq() being called in the path for zpci_hot_reset_d=
evice().
> > But that is not the case anymore and these functions are not called
> > outside of this file. Instead zpci_hot_reset_device() relies on
> > zpci_disable_device() also clearing the IRQs, but misses to reset the
> > zdev->irqs_registered flag.
> >=20
> > However after a CLP disable/enable reset, the device's IRQ are
> > unregistered, but the flag zdev->irq_registered does not get cleared. I=
t
> > creates an inconsistent state and so arch_restore_msi_irqs() doesn't
> > correctly restore the device's IRQ. This becomes a problem when a PCI
> > driver tries to restore the state of the device through
> > pci_restore_state(). Restore IRQ unconditionally for the device and rem=
ove
> > the irq_registered flag as its redundant.
> >=20
> > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/pci.h | 1 -
> >  arch/s390/pci/pci_irq.c     | 9 +--------
> >  2 files changed, 1 insertion(+), 9 deletions(-)
>=20
> The above sounds like this fixes a regression. Is there a reason why
> there are no Fixes and stable tags?

It doesn't have a fixes tag because at the moment the problem is
theoretical because no driver uses plain pci_restore_state() in
recovery. Farhan is working on patches where this would be used in
vfio-pci / PCI pass-through scenarios though.

The existing drivers re-use their shutdown and initialization routines
to restore state and end up calling arch_teardown_msi_irqs() and
arch_setup_msi_irqs() so it works out ok there.=C2=A0

That said, I agree this could and probably should carry a fixes tag
since the logic is kind of broken even if it doesn't break anything at
the moment.

Thanks,
Niklas
