Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791026;
	b=dLSr64u+MJbMKPezEsDHLtZR5ix8Hm+d/B+qLMGJLk+6aHlMlORIu1qOTO5nBh7ONEzI
	 AIIEANZ3qY1QILloZftJQm7IQU7DSDxOGrTI9+NZePMURJRg8XAR2j3RWyFgCfYDQ4E91
	 7oeUps1ikGjMoEKCSgDln7Urzul+QdmNS+cJWOIRxEO622UriIQqnHHD4+Z/cLY/Ft8xB
	 jRZUjUSP3pKeDUoxQeM4m3Y6tv9mICtnn9gUuuJeKHvxgtWyOU5X/Br3UJUq/cAAo6/Qu
	 mhNRGWb8u15hVkWBryzycI9jg5w4s6EfMQSJ410b8v7kfYJ26AOHnbuDk340z6h2X+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791026;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:Sender:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OVOpJr0dL8mJZ1/H3mpBV6FUXiVc6QB7jM41gMLtcZI=;
	b=JHPqSqQNW9aiTak/hwC33yRdBSwPiuOTACRbGc4Ki1yNgdrmv8NLq90PbIQOqmBH7hhO
	 l9RO/fGKCOSjMiVmuNIj5rsQ2QkRZ7s6C+mgJmCkmHpvxaIORd6JW/PCSlJF+lTMUCT1U
	 rL0YXT5O5w05dQuAa4dIQrkUhCC2qarvKKT2MRRdKXaIyM4USp/oZQmB3wppC+ufSw4ZP
	 eY39lC31GxrAICWigXEoVeV2GLMiUtyUMCKHJ5et0WjBCVsqDcSjNJtkSKUFRcLUNdR7a
	 G+2iKGPzYkPfgKi/0SXHNNln8hY2k8t/YAeuMMcJSldRcsYIwd09R55lNUeU2eXvUvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MY8as7eW;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE07606A32E;
	Wed,  4 Nov 2026 11:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEE07606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MY8as7eW
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BEKQG3420286;
	Wed, 4 Nov 2026 11:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=OVOpJr0dL8mJZ1/H3mpBV6FUXiVc6QB7jM41gMLtcZI=; b=MY8as7eWgLDI
	Uf8USja3axElcb3P4cmU/SDEmbTOK8gMZ02CrtJDEpvvx4LRCQ1J7tpdPEBZM9sG
	c2S/lfT+0cOjCUC/tiM4OvI92OUo1oZaz7rFOqXAJ3J+9wp41UxMsMMVYEIoyudP
	bxSC7NDyfu1Mu+Dq2S1Bcyy/N0ogT6mpyALi6ossYqtVOrblE+rqpDb13QUbRuT6
	tuyZHq3sSbzv62HQ1qEw0SGE8YgLBMT9ONR6iSu1gzG+FAwp2B7wQrTZksl6AM87
	CTocyWBLRSZH2VBTRsFjhYlHEo5165n6/PhGVv3gHY89a/0+LYHEl5DNyWQ47JPb
	BmQfREgOpg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdb4n8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 11:16:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4B5TTt4026998;
	Wed, 4 Nov 2026 11:16:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqke1ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 11:16:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4BGVvn41877868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 11:16:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD23720049;
	Wed,  4 Nov 2026 11:16:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C17E920040;
	Wed,  4 Nov 2026 11:16:31 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.68.30.141])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Nov 2026 11:16:31 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.100.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1xOYyl-00000009Jfc-2G9e;
	Wed, 04 Nov 2026 12:16:31 +0100
Date: Wed, 4 Nov 2026 12:16:31 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-intel-xe <intel-xe@lists.freedesktop.org>,
        piotr.piorkowski@intel.com, Farhan Ali <alifm@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>, Guenter Roeck <linux@roeck-us.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ionut Nechita <sunlightlinux@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>, Benjamin Block <bebl@ategam.org>
Subject: Re: [PATCH v15 0/5] PCI/IOV: Fix SR-IOV locking races and AB-BA
 deadlocks
Message-ID: <20261104111631.GA19494@p14sgen6-pf6akexs>
References: <cover.1790267348.git.bblock@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1790267348.git.bblock@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: HiiXqWxCk03J2r8_OErv4AU8ZA4Oyzxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0NCBTYWx0ZWRfX9kqUjineH7MI
 CY6gymR5ESNx8eJszAf3CWqNyxFmvImwK+4wV6Yl0uFFG4OdXF3ldDViT68ZB/5gJBw7CVo46Ea
 /zgskMN5k7Uc7QdH2ZZaW8yCjkoK1TmiQgZ7BQrJZIPe0vfC1XHMmQlK+jr4AhN3W6ERVHPm2XQ
 NxQkeEjnkZtetnjd3GRSxo1eOo5922YzaPou5irrICC0kpau4Z01IWvbEXS9QyqEIVskErURZ55
 mo5s6oEnbc8PXcvJjxHQrOM396fFq7gREYKlCCyVqh1yTlkcGjMG5h8KSMhAxFU3jKYsmNSkUJ9
 gfGAaRWYq7JNDvOsvaW1u66EgCN3JWMCb0g8KTh8nA9xJlKEjF4NvNxojobq+SQefKusvHf5a1E
 Ap2LTCtLodUQh3vUybFOjs9XHB/5jQc61zLRPTcnLQ1cVKdPcl0CmozZT/W1Kw90Cel7a1zMaEt
 pXc2zJb/NdWf2NUOaTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0NCBTYWx0ZWRfX/i5944wCxu2Y
 0z/Bx7bY9yiBkhlAZIEjfNh/oyGELno5Sb89/mY3V19Gc+DJFLX2Ax2U8m5hTwiHIOGskqxB+RV
 Rhz+5ublTcSN0Cx62GvppresPPhJHxA=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aeb1414 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8 a=rXKLWbfKo4hYPycT6vUA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ubgSmZJsFHGX3TaztGy5gOhUMzNsy05l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_03,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040044

Hello Bjorn,

On Thu, Sep 24, 2026 at 06:29:26PM +0200, Benjamin Block wrote:
> This is the continuation and combination of two patchsets from earlier
> this year that try to fix races and various deadlocks involving the
> global mutex `pci_rescan_remove_owner`:
> https://lore.kernel.org/linux-pci/cover.1776839248.git.ionut.nechita%40windriver.com/ [v14]
> https://lore.kernel.org/linux-pci/cover.1776868550.git.bblock%40linux.ibm.com/ [v4]
> 
> Since we couldn't make any progress since then I decided to rebase and combine
> them, hoping this would "revitalize" the topic.
> 
> v14 -> v15:
>     * Rebased the patchset on v7.3-rc4
>     * Patch 1/5: changed type of `pci_rescan_remove_depth` to `size_t`
>     * Patch 1/5: changed accesses of `pci_rescan_remove_owner` to use
>       READ_ONCE() and/or WRITE_ONCE() since they might happen outside of
>       the lock, and so might be subject to tearing or some such
>     * Patch 1/5: added comments clarifying that access to
>       `pci_rescan_remove_depth` is always protected by
>       `pci_rescan_remove_lock`
>     * Patch 1/5: since the only Reviewed-by was by myself on the last iteration
>       I removed it
>     * Patch 5/5: fixed a bug with the use of scoped_guard() in `switch`
>       statements -> `break` doesn't work as it seems it should, because
>       `scoped_guard()` is implemented as `for` statement
>     * Patch 5/5: fixed a bug in recover_store() where it wouldn't reverse the
>       call to sysfs_break_active_protection() in case of an early error-return
>     * Patch 5/5: since I had to make these bug-fixes I removed Niklas'
>       Reviewed-by
> 
> Overview:
> 
> Patch 1/5: Fixes a regression introduced by
>            05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
>            that moves the locking of `pci_rescan_remove_lock` to a higher
>            level in the call-chain when enabling/disabling SR-IOV, but by
>            doing so removed it entirely from the driver's .remove() call-back
>            call-chain.
>            To add the lock back into that call-chain and also prevent
>            resulting recursive deadlocks make the lock reentrant via the
>            existing functions
>            pci_lock_rescan_remove()/pci_unlock_rescan_remove().
> Patch 2/5: With the locking back in the .remove() call-back call-chain
>            it is now possible to trigger an AB-BA deadlock between device
>            driver unbinds and concurrent PCI device removes. Fix this by
>            unbinding the device driver before starting PCI device
>            removal (and locking `pci_rescan_remove_lock`).
> Patch 3/5: In order to use annotations like __must_hold() or assertions
>            like lockdep_assert_held() on `pci_rescan_remove_lock` in
>            code outside the PCI core (such as PCI architecture
>            implementations) move its declaration to the global linux/pci.h.
>            This doesn't increase the "surface" from where it is possible
>            to use the lock, since it is already possible today to grab
>            the lock from said code with the functions
>            pci_lock_rescan_remove()/pci_unlock_rescan_remove().
> Patch 4/5: Provide a lock guard for `pci_rescan_remove_lock` so it is
>            possible to be used in the linux/cleanup.h macros.
> Patch 5/5: Fix several AB-BA deadlocks in the s390 PCI implementation
>            involving `pci_rescan_remove_lock` by moving the lock to
>            higher levels in the respective call-chains.

is there any feedback from you for this? How can we make progress with this
problem?

Last I checked Sashiko had no more complaints about this patch-set, and I also
didn't get any other feedback - negative or positive.

Especially the bugs this series fixes in Patch 5 are a serious concern for us
on s390, and it's basically been stalled for over half a year now. I need some
form of feedback whether this approach has any chance of getting accepted, or
whether and why it has not; so that we can look for alternatives if necessary.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
