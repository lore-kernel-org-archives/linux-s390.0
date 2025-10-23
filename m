Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4F78F2E;
	Thu, 23 Oct 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205240; cv=none; b=V0j0wKynzcuhkR8ZFxukZCqvI9uO8w1TqZGkqjbTh7A0c7LmVxev84mSk51tDKa843KeSxbeWzytwqfjLLg+iEs/dudMsBfwGXAf+TAmyAEKcxai1lI4Q5GHrS91z6NSTBslr1AAzFtAbaOl9PuTyM2N9Wi9zMzwP5jnlcqTnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205240; c=relaxed/simple;
	bh=C7PiJxPu7LQr+K7tT4hAEolH4SOafOCaoyLMzp2hDT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7atoiUQJz8XMKDSaNT3BbN16IT8zHHZuGHpkUZzwSVmMNXzc8cR9hXBDHCuPxKhdVI52MELhTulqULw3hX62Z+2PQPY10tQIMtWxu0cneJfyFQ4TglGvfyKlfG6nYMOejIaer1CtHURPf6kIRnahigP6kzh9IAE3M9xRQBeluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SGj8xxSp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SGj8xxSp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MNQxOE022111;
	Thu, 23 Oct 2025 07:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ds75PIDQJTSkxMSQnMu9ovYRDQnWNe
	SL5GxQ7vjC9b8=; b=SGj8xxSpMuKM5YKifMezJdGwdKltiymuIM/nbHnhQO9AfR
	Iwe6ZTxVVwsb0uc1e8SkosDMv058lmR0uxmtnL59V/KW30Qx+97eINVX8XIhiZpb
	BiTIzoSU2HXp6f8IdwYWVdsNzyMHSKbqOwt+LKULtEUKA+lKAi3Efg19IDH/GKoy
	qYitx8R+Yafyikk3PTvtyuDMj0SWXuxVRhZe70nx/PnURhLA59qRdn5ZLMoCJtcf
	Sic+6XVM1343rrSgo+rUQ9ERVYctCOPI/3Fk1PK2tx83v48PqHlzhFYKhgH2tZyF
	LbuT5hktIv/RxdwRGnP71WgHqz5Kog9w4LDoSjyA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vyg9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 07:40:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N60E3S032092;
	Thu, 23 Oct 2025 07:40:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n4jee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 07:40:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59N7eV3U54657496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 07:40:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 170E020043;
	Thu, 23 Oct 2025 07:40:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB50020040;
	Thu, 23 Oct 2025 07:40:30 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Oct 2025 07:40:30 +0000 (GMT)
Date: Thu, 23 Oct 2025 09:40:28 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390/pci: Restore IRQ unconditionally for the
 zPCI device
Message-ID: <20251023074028.9536A84-hca@linux.ibm.com>
References: <20251022164727.882-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022164727.882-1-alifm@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EdwIqeBTmua4fZRPTcmmaC-NqUT5DWrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7wKjFxAlzrB4
 mlDNa42OuYWfET5EnxB1UCdLSCrgDZWIKTe6ZNQqcTCw8BwpFWGWyPiNIaw7ns85QQB7mWPlcOJ
 4FhTlvbzVzDsmJnEI8XpmkHvJkIJNYcf9DKOfDqVnBUP1m9rH3ba1yCaTlj3ed8A7CpiDrWIFut
 y99aSMiUgay5OwI15vS/W3cxsgrB0eilIiqiHM86iz6EVJMOkIc2KfnYr/k3vTmBgvKDTAfKB0G
 uYoxuXOJ4TFD6pA3zf9BEYOvzGhV0vQaFHjQBj27xQwcUwZnO1enOPyPBG2wdo8wfn1mNpgqSlB
 3QopIdJ14X0ACGWne/J2vYuRdd3hq6NoZdmNRF5Khmn0jbMl/p8rnaTkA0lfQWepcGSurG4Jd8A
 HMJgy1dF/ac0F5CKHstjdE5wbowl/w==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f9dbf3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=vZQJCZbJYqUF9Gs009UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: EdwIqeBTmua4fZRPTcmmaC-NqUT5DWrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Wed, Oct 22, 2025 at 09:47:26AM -0700, Farhan Ali wrote:
> Commit c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()"),
> introduced the zpci_set_irq() and zpci_clear_irq(), to be used while
> resetting a zPCI device.
> 
> Commit da995d538d3a ("s390/pci: implement reset_slot for hotplug slot"),
> mentions zpci_clear_irq() being called in the path for zpci_hot_reset_device().
> But that is not the case anymore and these functions are not called
> outside of this file. Instead zpci_hot_reset_device() relies on
> zpci_disable_device() also clearing the IRQs, but misses to reset the
> zdev->irqs_registered flag.
> 
> However after a CLP disable/enable reset, the device's IRQ are
> unregistered, but the flag zdev->irq_registered does not get cleared. It
> creates an inconsistent state and so arch_restore_msi_irqs() doesn't
> correctly restore the device's IRQ. This becomes a problem when a PCI
> driver tries to restore the state of the device through
> pci_restore_state(). Restore IRQ unconditionally for the device and remove
> the irq_registered flag as its redundant.
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h | 1 -
>  arch/s390/pci/pci_irq.c     | 9 +--------
>  2 files changed, 1 insertion(+), 9 deletions(-)

The above sounds like this fixes a regression. Is there a reason why
there are no Fixes and stable tags?
