Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674D332916;
	Fri, 10 Jul 2026 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680722; cv=none; b=MfVsKNcDIiGBYOSqjIWHvUi6WlVXjwEFYfSljMeATTJkWhqMm3YSD9EIRieuO38cERk3GCi/mo2E58wrn0yvbHJoMrbV0SSXjpx4cZG/U/9iFqpe73/xQpJXvzGG7cGAURGXIB+uQI9rLilG6msgf0Hj2v6jr9uv1a2x/+BBUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680722; c=relaxed/simple;
	bh=BOZ5ry/n+ZfBztT+fRHNB26u/OqM4NCUia4lwGUW3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbBFrNC0M3Em/W7xDPeEwht1yyWoPvZznvpCSSzI4izx3ax+GVJbVU9QEzIc8sVqm5oTDymTNs2aqeptQcIPBHCni3DiL6VQT2u+H2AYXhztBrx+o1EB/ClNeaXqvneKtAV5/gGtW+lfkj7Cwmibw15aig08lXmOnEBlEkdWuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VGgz5mhB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VGgz5mhB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAmijR1390824;
	Fri, 10 Jul 2026 10:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GOt9UTfd15E1bmXXOo8yVb8JvjAgMS
	QeHBt96w88/lg=; b=VGgz5mhB7pvtkSg86KDe+v1YOa3KoxHi3E/EGNpgCrOWnv
	J78KChO+feSW4mi7bI1gzXyww3UyP7xmvvnXuEgqMT/2BZfWuQowdtqFrZ9rFNq9
	GgmbrROYOIBGs/DxNWAh38gJph/GSawOJRqVprobnf+Vg04sPvs8eSwJ5bAXHnNf
	S/ybdW090VTMFsQZuXwgCdpKRgMM/qVVH7oC11aBrm7Zz6++ktN+RP9EW1YmwZtq
	jvAugQTosYYTMwwVWveA1KnlYX7CwN/7a/6qaZJlyP7tG+RpwQaNunVZvCnu99KA
	KXYJqMFaeSDYvFw5ispNdfTVpsir20v6brQ3Uyew==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur60nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 10:51:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AAo3xj021453;
	Fri, 10 Jul 2026 10:51:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yh8vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 10:51:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AApZCs42860824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 10:51:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F31D2004D;
	Fri, 10 Jul 2026 10:51:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A65D320043;
	Fri, 10 Jul 2026 10:51:34 +0000 (GMT)
Received: from osiris (unknown [9.87.147.219])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 10:51:34 +0000 (GMT)
Date: Fri, 10 Jul 2026 12:51:33 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 13/27] KVM: s390: Prepare KVM/s390 for a second KVM
 module
Message-ID: <20260710105133.984749-G-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-14-seiden@linux.ibm.com>
 <857debcd-3e44-4844-8abc-b26b892d3d7c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857debcd-3e44-4844-8abc-b26b892d3d7c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEwNyBTYWx0ZWRfX4zdIBNagPqa0
 gow44HyeI+ZE8COEI5Df/iYOXHuCJZHcb65sFe2LS1k9gKhL162cEPMJaDdCVChbjTNslF2mUq6
 1NmQG6QREOoqR4oJD+e9jaLSpJgxkKQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEwNyBTYWx0ZWRfX/p7pRWT1fj/s
 ClwVNWbmThtrMJBs0xfC/3ZFJuLnVNHceKRH3C1gkMY7TiGhfi2I/QF4NcAaC7wLTpyDClyoH9N
 qtUkqRRpjrsUZZMlojOR5abFGV0XPs+GLXgw7Aso/biq2WVee6IevLjacQ0EDIEG+MUXMR6t434
 JbJbPHViwnhLYH5VLjsXR+XmwCRYB16J0Fmly4+kvMuPBNaDP2/IHggRKSiRfAZuH9U7xOrVY3I
 dilbbccVv7VU3lx2FjJV/EWStypteNLmI4/kjlR0v348gIoyxSYh/U0Hqyq2gXsNe/fyBCS5IzD
 v5wqoql9nZTVu0lD3u6pjwflNCfMgN2lwLvTFpeGvZAELe0scRyGKdcNYWB+jEWE95jTB3iQiiF
 DuD7Sc09/A9B7nl7jKHFfwv9U619+ci94kxyLi4LWllHr44zEQBvIlIZ50AHSsFOE9SF4dcUQsX
 6KBTc5p/RjvU85QinUg==
X-Proofpoint-GUID: vSk_p_zZRro3pgiNR5436sG61bZennMI
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a50cebf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=YB9r6mRHUy78XhmW5L8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: vSk_p_zZRro3pgiNR5436sG61bZennMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100107

On Fri, Jul 10, 2026 at 11:22:29AM +0200, Christian Borntraeger wrote:
> 
> 
> Am 06.07.26 um 10:52 schrieb Steffen Eiden:
> > Lay the groundwork for a second KVM module. Guard KVM/s390 behind the
> > KVM_S390 config and turn CONFIG_KVM on if selected. Move all the
> > kvm_host definitions to _s390 postfixed headers. Prepare local header
> > include guards for a new location. Move gamp related tracing into a
> > separate file. While at it, rename the main KVM/s390 files from
> > s390-kvm.{c,h} to just s390.{c,h} to match the naming scheme of other
> > architectures.
> > 
> > No functional change.
> 
> [...]
> >   arch/s390/include/asm/kvm_host.h              | 774 +-----------------
> >   .../asm/{kvm_host.h => kvm_host_s390.h}       |   6 +-
> >   arch/s390/include/asm/kvm_host_types.h        | 347 +-------
> [...]
> >   copy arch/s390/include/asm/{kvm_host.h => kvm_host_s390.h} (99%)
> >   copy arch/s390/include/asm/{kvm_host_types.h => kvm_host_s390_types.h} (98%)
> This is just an "almost" rename only in the end. Maybe we can convince git to show a better diffstat to reflect that?
> 

The rename only part worked quite well (6 lined diff). I used
--find-copies / --break-rewrites with format-patch when creating this
patchfile to reduce the diff. Otherwhise we get a diff like: 

...
 arch/s390/include/asm/kvm_host.h            | 774 +------------------
 arch/s390/include/asm/kvm_host_s390.h       | 778 ++++++++++++++++++++
 arch/s390/include/asm/kvm_host_s390_types.h | 347 +++++++++
 arch/s390/include/asm/kvm_host_types.h      | 347 +--------
...

Which I think is more confusing and bloats the diff unessecary.

But I cannot find an option to convince git that kvm_host.h should be
treated as a new file. This problem seems to be out of scope for gits
heuristics.

The only way to get this smaller is to split up the patch but then the
first of the two patches will not compile.

> In any case, I guess we can handle patch 13 and patch 14 pretty soon upfront so that the patch series gets smaller and is easier to review.

yes +1.
I would argue that the gmap refactorings (PATCH 15-17) can get handled upfront as
well. They also have no functional changes as well.

FYI: I made some smaller cleanups on those refactrrings since monday.

	Steffen
