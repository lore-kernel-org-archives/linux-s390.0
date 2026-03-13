Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A15264614;
	Fri, 13 Mar 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410349; cv=none; b=e+n2c/no1cAkgPEFLswOtAoW1fFF/Sv7vUC3rRdUNScWMaegBgWX//1NuN2X9WcCQRcjHV1iLPILgHMlSgFR6FkAAaUVYaywoTUHSAPCcpcn2ST6nRt264knk++wbRLnZu0ASW0qWL/Q/VmOQsWHNLZ0fdeEjeO+YV+dz9iXSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410349; c=relaxed/simple;
	bh=M/gYnjy2iyQlUysIv6EM3N9+mno870oBl18oCQdauWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8pHnb3U3ZtGkyGQfLQ13uzwG0+Bm1qg5SDEY5FTrkq+y2TFSHCoGDEZqAxPR/rhS9MMQrDd6PGqfJ9aYPMk24LDplocp3pKLQl2FiPqGkoUsVVvlP9hxipwQbGQjTSh8D9Ghqd2MrYirRUpV6fAOuG2cSxHuKgTPZN5VkYYZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FAHetmwr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FAHetmwr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5S21G2581749;
	Fri, 13 Mar 2026 13:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=8VGBlofSOB4DTOBNrLOd7VEjOho24D5yc5lDbNR98Hw=; b=FAHetmwr0WYV
	4/NITE/ZiUTvB9CLoV4CcChdR2FtbJwkntvn6uod5efrZxMvqBu1yzoN1CI5N+hv
	JaDmkCLYEJmTD+HdAb68wk+SmdpBmidjPHRTiJsI+AjNt3Zik60z3DSPX8peeBTU
	t3udCh0IPHFkvl+nMjV3fgpY5E078j2QBZvWzmbWNYwsrzNea9Fl+k8f5F/BLUrg
	DkK/TMhhITY8MH+xzTv23qxntcf4WTR51OUNvqcHT28wxdaPE2P+/Ov6aTEVguoM
	9iUet0oeMaMQObtfuSkINnL0CPb+C0fQUEcYtDOtDaAWXTIf6Oo+HBumXSfS5jYx
	Y20wYthLKg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95057t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:59:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAJ67U020802;
	Fri, 13 Mar 2026 13:59:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9pvmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:59:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DDx1cp46334264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 13:59:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E142004B;
	Fri, 13 Mar 2026 13:59:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C06E220043;
	Fri, 13 Mar 2026 13:59:01 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 13:59:01 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w132b-0000000F4z6-27ny;
	Fri, 13 Mar 2026 14:59:01 +0100
Date: Fri, 13 Mar 2026 14:59:01 +0100
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
Subject: Re: [PATCH v2 3/3] s390/pci: Fix circular/recursive deadlocks in
 PCI-bus and -device release
Message-ID: <20260313135901.GF2161595@p1gen4-pw042f0m>
References: <cover.1773235561.git.bblock@linux.ibm.com>
 <354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com>
 <df10e28bd86227dfd4830c34da8c68976df5e938.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df10e28bd86227dfd4830c34da8c68976df5e938.camel@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b4182b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=-vHt_pugA9TOX_X6-0IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwNyBTYWx0ZWRfX7SaeKw3Wa7jf
 uCjSrH7U48RFe+uNdZT/71rz8xdZqGw5darUs1WZBa71CnLdKEnLX7y8f4rY4FVxmp4E8czqzTV
 9XQgqr7BvUvUVwk31+ZYCHg38IPMLiYz9zEtHY0/g0q/Q/FNZE6MIb8VxKQq7B2U29QHRq78YDI
 d3QdBddKrjOc39EDI7qquvYwTyo/OEabRCApWAwDNPQRJHTdKXAV1YrKonVNV5jPz/zfSKtsCQZ
 e/0AmmfRNkfxskrpBdETXI5hGmfj6fTqjt9wY1EiZKXEPBRDLD8VMQ6Sia1bEfoTGkIbibRgCjC
 ewofsKtPuewazeZlUDiwNVzBA6GVQarHWkrm39Maj3iV/Dm0/BGpVYXYSeSj9swc5uAU5Osz4MC
 jZO38KjwZrzAXihhLSaMOr2qy0yovPDdUPLhZrYn6o3XE83FXeJRNiP71wn+GHT99xElOxoJpxb
 5HSQacDgbveFDejMjeA==
X-Proofpoint-ORIG-GUID: tnl45ep9_ONeY9nWbYjLE90VlJItxLYG
X-Proofpoint-GUID: seN2Jn7zg7-V7mGjRqcUjv8i-4y6rllz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130107

On Thu, Mar 12, 2026 at 10:02:59PM +0100, Niklas Schnelle wrote:
> On Wed, 2026-03-11 at 14:27 +0100, Benjamin Block wrote:
> > When removing PCI device or PCI bus objects there are a couple of
> > call-chains where it is possible that the kernel runs into a circular or
> > recursive deadlock involving taking the central `pci_rescan_remove_lock`.
> 
> Now that this depends on Ionut's patch at[0] and exploits the fact that
> the rescan/remove lock can be taken recursively we may want to adjust
> and thereby shorten this description to take this into account dropping
> the recursive locking as deadlock reason.

Yeah, fair, with the dependency, case (B) and (C) don't exit anymore.

> > 
> > For example:
> > 
> > (A) Thread α receives a CRW event notifying the kernel that a PCI
> 
> Nit: Other PCI related code calls these "PCI events" even though
> technically they use the Channel Report Word (CRW) mechanism and thus
> are CRW events.

Eh, sure, I can change that. I guess it heavily depends on where you are
coming from. For someone that mainly dealt with "classic CIO" devices talking
about CRW events that concern PCI devices immediately told me where I have to
look in the architecture and such to figure out what's going on. "PCI event"
not so much.

> > Fixes: 05bc1be6db4b2 ("s390/pci: create zPCI bus")
> > Fixes: ab909509850b2 ("PCI: s390: Fix use-after-free of PCI resources with per-function hotplug")
> > Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
> > ---
> >  arch/s390/pci/pci.c       | 11 ++++++++---
> >  arch/s390/pci/pci_bus.c   | 15 ++++++++-------
> >  arch/s390/pci/pci_event.c | 28 +++++++++++++++++++---------
> >  arch/s390/pci/pci_iov.c   |  3 +--
> >  arch/s390/pci/pci_sysfs.c |  9 +++------
> >  5 files changed, 39 insertions(+), 27 deletions(-)
> > 
> 
> I had not previously looked at your commit message from the point of
> view when it is ordered aferr Ionut's patch[0], which it has to for the
> release case. So I ended up with a few comments now even though I
> previously read it multiple times and was just very happy with the nice
> and readable call chain and locking order explanations.
> 
> Either way the code itself looks good to me and I also did quite a bit
> of testing with this and the previous versions. Trying hot(un)plug and
> SR-IOV with various PCI devices and also just ran this and the previous
> version on several test systems for a few days doing other testing and
> development work. 
> 
> I also put quite a bit of effort into trying to modify this and/or
> other s390 PCI code to not require the reentrant behavior of the
> pci_rescan_remove_lock but failed. The really tricky part to me is how
> e.g. a driver can hold on to a struct pci_dev even after it has been
> removed while we have to keep both the struct zpci_dev and struct
> zpci_bus and associated struct pci_bus exactly until the last
> pci_dev_put(). And then needing to remove the PCI bus via
> zpci_bus_release() we need to have the pci_rescan_remove lock but now
> this can happen, in principle, at any pci_dev_put() and that of course
> sometimes happens when we already have the pci_rescan_remove_lock and
> sometimes without it.
> 
> So feel free to add my:
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks.

I'll hold of at re-rolling an other version since we don't have code changes
so far. Hoping for more input. Once I do, I'll adapt the description of this
patch.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
