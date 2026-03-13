Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4E31987D;
	Fri, 13 Mar 2026 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408752; cv=none; b=UTYuqERdbXZSBWBW5faMdIMCVcqbbuEiyWuOj3OKbrDixehE9OGpUsAtSffDX1qXl3W51Q+8PL+VMoKO6SREyiXKoWrTXr1MEU8g6FMuzfQLss9dJNfKn1tJU6VrIhwRwKXO2Y6znAwHj5LmzZ1CIGUtexokkIvPt20boUZp3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408752; c=relaxed/simple;
	bh=7ILJNIKoclyo/TnN31WhuPp/9WK1OvpJ43GNXbGEw+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7Kg20spe20k8FDEOnw6TqlDmyh/AIm/bUitR8at0AoaIvdQJJnL6V32zlFbR5gI7ZFC3McvebYjLvdZbap9zcuolXLIhAe00Nw/WA4euh88zj0ZcU7gAiU8ELnl/2MyKo3OlrzLfyDFWTPJ8cziU/RN5BtUKcwy+0m1dNJGKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CvgTnbtD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CvgTnbtD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5Iv5A2581579;
	Fri, 13 Mar 2026 13:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=knBAe5Mz9iL/gkqQCgS//1NzZK4swdv8s0rEPfyiN3I=; b=CvgTnbtDA3dO
	BGv423Uq05e5Dekjz36Nb+pRNY9XqoBsCfT+PCAxbkMMOsxWXgzaVqUsNuNJer65
	xjFj5QkPq2ReWxj8X6LErfKO3V727aI0mXj567dC0UNflbB5RQN/kr3pMtaHtBwZ
	R7Iexp9+ebqOJaOsau0bJb3uyi6iwABIwfUNYUMV7QVnamrHbubcxQooTNdAVb/+
	M3dOE/qbjJflobgpApM12BoAnNeJF43nWgbNw37MY3yUXyE3putryiFpfy6vp4VP
	ujpxHlz1AJC7172BFpS64EmBwRbiTerMI+u/E9LCe6+teT/6jAvz56m5SDrR4fLE
	B+LOXwxV6g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh9501wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:32:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAOBwr020823;
	Fri, 13 Mar 2026 13:32:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9pt6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:32:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DDWPJU51052880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 13:32:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C3A620043;
	Fri, 13 Mar 2026 13:32:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0893E20040;
	Fri, 13 Mar 2026 13:32:25 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 13:32:24 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w12cq-0000000EvrQ-382Z;
	Fri, 13 Mar 2026 14:32:24 +0100
Date: Fri, 13 Mar 2026 14:32:24 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
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
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] PCI: Move declaration of pci_rescan_remove_lock
 into public pci.h
Message-ID: <20260313133224.GD2161595@p1gen4-pw042f0m>
References: <cover.1773235561.git.bblock@linux.ibm.com>
 <e9f46b25e5b47ec1d8fdca33b10346bc6de23445.1773235561.git.bblock@linux.ibm.com>
 <0536daedd01b7ad6f88719c9dc799a9de8a3bead.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0536daedd01b7ad6f88719c9dc799a9de8a3bead.camel@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b411ee cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=oaMjjLmQ_YMjUI20znAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwNyBTYWx0ZWRfX2CLOJmc3poNo
 CKHAwepoW61+Z/zSE0kCJvr005y2bUCcN2jrIwmNDv+kmm+v+Z+0tauSP0VUuyCjpbQv/8Ru+8d
 9StOT8Sl4HsMan9YDm0CABPFRrE+EQsr6h/NvV6AQiO94EuNfoiBn16Mrn155UJT5ILiUzcy/md
 VbxfQYPeGMBcvV4u6GNYCQipv+h7BggOC9aR+u3czfRRf45IlYBvdraDF4GczmmoMk4hMcHFchF
 rJsEEv3tbiLVoE8CSw2Jkjco1MpHairmG1gZ6nJrbtfXZi8yjl/ZUEv+2Bz3kmEQVzf5UlpcZyu
 O1phxoC2BqoJ+dsAmdjmjfWOBq/3Vg7pH9kbcIvn++fgEryKe6NdYYxuzgVi5xAzXAHmsydgW+W
 vVX7S3G5ujKkS2bhqaV4V9B7vcufD/lzrjT9IIOErR14dlfEWY/EWuGeSYuuQNWc0GrN83wSipb
 +fln71xrwEs7xgfc24g==
X-Proofpoint-ORIG-GUID: TAuMCTvdsBcT0d2dx5oAWshO8xhFDVMR
X-Proofpoint-GUID: Uw__DgqH15Dz6RgQ9SGvWMVEgZcJhcNn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130107

On Thu, Mar 12, 2026 at 08:41:26PM +0100, Niklas Schnelle wrote:
> On Wed, 2026-03-11 at 14:27 +0100, Benjamin Block wrote:
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index bccc7a4bdd79..e5b12878e972 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -3509,6 +3509,7 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
> >   * routines should always be executed under this mutex.
> >   */
> >  DEFINE_MUTEX(pci_rescan_remove_lock);
> > +EXPORT_SYMBOL_GPL(pci_rescan_remove_lock);
> 
> This has a (rather trivial) merge conflict with Ionut's patch which at
> the same time is a prerequisite for this series. Sadly since that isn't
> in linux-next yet I'm not sure how to best handle this. Maybe it would
> make sense to just include it in this series? @Ionut would that be ok
> for you?

Well, I don't mind either way tbf. I can also resend a new version, once other
other patch gets into next/master. That's shouldn't be an issue.

> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 1c270f1d5123..fd7a962a64ef 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -39,6 +39,7 @@
> >  #include <linux/io.h>
> >  #include <linux/resource_ext.h>
> >  #include <linux/msi_api.h>
> > +#include <linux/mutex.h>
> >  #include <uapi/linux/pci.h>
> >  
> >  #include <linux/pci_ids.h>
> > @@ -1533,6 +1534,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
> >  
> >  /* Functions for PCI Hotplug drivers to use */
> >  unsigned int pci_rescan_bus(struct pci_bus *bus);
> > +extern struct mutex pci_rescan_remove_lock;
> >  void pci_lock_rescan_remove(void);
> >  void pci_unlock_rescan_remove(void);
> >  
> 
> I do see Keith's argument that proliferation of the rescan/remove lock
> is to be minimized. That said, since user's of this header can already
> lock/unlock I don't think this patch makes matters worse. In fact we
> want this patch to be able to add better lockdep asserts so it will
> help against misuse.
> 
> With that feel free to add:
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
