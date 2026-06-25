Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC97374E45;
	Thu, 25 Jun 2026 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386230; cv=none; b=ZaKKisIOADaUDQWkBfllyDoS6y9+SqYqZ2Ro7f1iwKnRuphCUO2PO5zBQ6OTkeDADbE/m8wfcmmqLFNxDA9y6OU0aFwRj6CSRlj4YPZwrH752HwNjrevAJQJdS/Ck/WFcqGy9WQxGcDDfnYQjB993DTciDCxCtq7PXvu3hVzuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386230; c=relaxed/simple;
	bh=idtMv2Eq1C72KO6kRFAlCQ6+RFlUyE+Jk9yJYlDc8nE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxoFN63DQ+aMCFVyE4A1Ne66LIPSRo/ILGdNB/xUJYCo7XZasOmNMpqdRn0Kpqwh/S2oTbOk0ClfNX7QOmRuRTohErN1fU9UI0CVePh0LxoparlQBt+zs4b0eqdESzBT+2+YXM722VAZFVPr1iYaPpj2mfHs745bWPDnEI/sTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b/D7kVsB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b/D7kVsB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mdZ32927895;
	Thu, 25 Jun 2026 11:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vbRN7s
	krigppb++watalKcUrgs+8azDym0kBgJgAsTo=; b=b/D7kVsBuxSk8T0xOO1a39
	Dk+2BkatuqrGZRwFSksQC4lk92AzlI0JKFWECuGAyBBIei7iWc2dH3vrk20nU1Gr
	QJoneMHsPa9yBgF6y7lqftSMPHlEK3mE634zzkiGkhu6lKj7+yraYvUft25kFta/
	ddC5qkGPF40gxwchahkK46wZM0W9LX5JRQ2kH74VkDpEJn0pj8yw9yHOvvy+Yy/0
	l6PSqLaG9xsIzdDWFa9aVQJlBZ4EsdrbG7MOKq786pP9JTeP7tpIB9ZmP7J7/xto
	wwrkw3S6rxWfwa3q81OWEh+PebAz//jxjaycDYQgArbjjWP5TYZ18mPqB0FTDI3w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gs5e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 11:17:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PB4fr3014622;
	Thu, 25 Jun 2026 11:17:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwnxxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 11:17:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PBGwod37355994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 11:16:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 338FF20049;
	Thu, 25 Jun 2026 11:16:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0870E20040;
	Thu, 25 Jun 2026 11:16:58 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 25 Jun 2026 11:16:57 +0000 (GMT)
Date: Thu, 25 Jun 2026 13:16:56 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [GIT PULL v1 00/12] KVM: s390: Fix S390_USER_OPEREXEC and more
 gmap fixes
Message-ID: <20260625131656.664389a5@p-imbrenda>
In-Reply-To: <1fad4b9d-ca9b-4766-bbe0-46fd5a3d91ae@redhat.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
	<1fad4b9d-ca9b-4766-bbe0-46fd5a3d91ae@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xYSSxbw4Scl-yqQFAtIsS0Nzd448p__R
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA5MiBTYWx0ZWRfX/V3PI7q0/oQH
 YVQiWTPA9FbOphmgK6qmMuZHiHxcUykpuzHCSRHg21JI3XqPzw7qN9+0IIdgt0mbSnaVoWiOHLe
 nKmOzVoeQuK2vnu7BhaBHUmSOVCMVic=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3d0e31 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=95AKu5hJyJmswmW4WEsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA5MiBTYWx0ZWRfX9fXte/j8jMNw
 3ey4pQCJP/h8EiElBiZBGupLmK8trTxqnbjGKq6iZNBQlUJob9UUNDLk5BJp6zSnTbXqdpFtlgO
 IwbkYmv608/6L0kSCJKGQLSjdnmzsaMXn5TdVJGwvYi+EdL+9ZX872twA1lTm9hNjKNmUaVHcvm
 EQ907VWt7dvupEbxg61UskYDxxS/r3115I7v8gmeVkY0xT4K4GgwKFCBsEuXggSXymDKGnssNzQ
 er+Vj3/8r5d+ghDTKqWDSPIrkRULhV0WZCkPCL7/zqRVPXsp9nCrwDXXhD95HT9D/+TRvJqQ+3N
 WBkNLZNW8+PpKrnZnydXPRcFodhgILZok3duDRatcqPVMpoMQkpKZPKx9ag0JFRD1oQQc62H+x+
 OGy+S1f+0Q1TRxTF84USMtQuQwQ3SrnildtaEvcYVQeYCV/66edQmZavaVhOhmP12M6fUOvczWG
 xmAL2fgbomVboCPVvRw==
X-Proofpoint-ORIG-GUID: xYSSxbw4Scl-yqQFAtIsS0Nzd448p__R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250092

On Wed, 24 Jun 2026 18:56:12 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 6/24/26 13:19, Claudio Imbrenda wrote:
> > Ciao Paolo,
> > 
> > here are some fixes for the second half of the merge window:
> > 
> > * Fix S390_USER_OPEREXEC so it can now be enabled regardless of other
> >    unrelated capabilities
> > * Fix handling of the _PAGE_UNUSED pte bit that could lead to guest
> >    memory corruption in some scenarios
> > * A bunch of misc gmap fixes (locking, behaviour under memory pressure)
> > * Fix CMMA dirty tracking
> > 
> > The following changes since commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6:
> > 
> >    Linux 7.1 (2026-06-14 15:58:38 +0100)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-7.2-2
> > 
> > for you to fetch changes up to babe08404e1993697a523e60bc0f9d096ffe1ef8:
> > 
> >    KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits() (2026-06-24 10:08:57 +0200)  
> 
> Looks like either you onboard kvm-s390 to sashiko, or just send patches 
> to kvm@vger.kernel.org.

yes, we already do that, in fact most of the patches in this pull
request are fixes to "pre-existing issues" sashiko found in previous
series.

Most of the "issues" sashiko raised about the pull request are either:
* small things we didn't notice, that sashiko also did not notice
  previously -- we will fix those
* actual issues... that have already been fixed in previous pull
  requests
* complete nonsense, due to sashiko not understanding how the hardware
  works

> 
> Anyhow I've pulled it, there's time to fix up things.
> 
> Paolo
> 
> > ----------------------------------------------------------------
> > KVM: s390: Fix S390_USER_OPEREXEC and more gmap fixes
> > 
> > ----------------------------------------------------------------
> > Claudio Imbrenda (9):
> >        s390/mm: Fix handling of _PAGE_UNUSED pte bit
> >        KVM: s390: Fix dat_peek_cmma() overflow
> >        KVM: s390: Do not set special large pages dirty
> >        KVM: s390: Fix code typo in gmap_protect_asce_top_level()
> >        KVM: s390: Fix handle_{sske,pfmf} under memory pressure
> >        KVM: s390: Fix locking in kvm_s390_set_mem_control()
> >        KVM: s390: Fix cmma dirty tracking
> >        KVM: s390: selftests: Fix cmma selftest
> >        KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits()
> > 
> > Eric Farman (3):
> >        KVM: s390: Fix S390_USER_OPEREXEC enablement without STFLE 74
> >        KVM: s390: selftests: Extended user_operexec tests
> >        KVM: s390: Fix typo in UCONTROL documentation
> > 
> >   Documentation/virt/kvm/api.rst                     |   2 +-
> >   arch/s390/include/asm/pgtable.h                    |   4 +-
> >   arch/s390/kvm/dat.c                                |   5 +-
> >   arch/s390/kvm/gmap.c                               |  35 +++++--
> >   arch/s390/kvm/gmap.h                               |  12 ++-
> >   arch/s390/kvm/kvm-s390.c                           |  71 ++++++++-----
> >   arch/s390/kvm/priv.c                               |  10 +-
> >   arch/s390/mm/gmap_helpers.c                        |   3 +-
> >   .../testing/selftests/kvm/include/s390/facility.h  |   6 ++
> >   tools/testing/selftests/kvm/s390/cmma_test.c       |   6 ++
> >   tools/testing/selftests/kvm/s390/user_operexec.c   | 110 +++++++++++++++++++++
> >   11 files changed, 226 insertions(+), 38 deletions(-)
> >   
> 

