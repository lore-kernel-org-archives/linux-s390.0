Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90842E8C3;
	Fri, 31 Jul 2026 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509709; cv=none; b=Ayg4jfljOZVaJkIabQvWkf/CC2NYmyOYpK1OZXf39w9bKuartNVfYQDuVNyuAnOrHNEgStDatqsgF+sDkmqZv++2qjW2BrdbhTL+RW6rC6hhVHo16nILjwOXbpDnoH3kf8zxjxeLn93NRYihLqWqhuEq303lkuS1g/df3WpoBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509709; c=relaxed/simple;
	bh=rIYUEZa+I6JTd3B0DZhBhSlxAf7SRsRWitjZdQ7B1Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqugNWxE3Ejgadh1G5VhgQtTN3Hxa+YiWLd2qpjthbSICC0kY9MbVDst3+nyT+m7Ri242ekBKfbRctdXsrCdh01UJY2KEONmvhA0lCrOP0BwDLuHc0J4aad13mgGJqxrSRw13g4e/1yl4LMHzCknM78iIcxprBTf3XlDURACaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jJsawE+q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jJsawE+q"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBluWX1670964;
	Fri, 31 Jul 2026 14:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wyOLfXapGVCMFCK80B76KNSUZOfJcE
	7IYnSc6LvcL50=; b=jJsawE+qvRTZfRljcoXav7lVBBplcQ2kVqnu2wquX/fAJv
	ErH+1Ayz1US8ie2AsQTC+J+3yL8U2eGWx6Js5FzRT5PRgNUa45aqFdD56sDkYNZ4
	+ozfCjuoBCzYl6U/pM0aXMM/udHacYrW4iLw15UqKRv9LYxqWAvRvMII5PSdZuLg
	VTuRMpEA7dpupU+ThZeQj0ovbST02BsQ2aHXkdDnOEOexmvAm/FBft9i5AQt/9HH
	jHiF63EEvEzpMgmLq/GwUjxraf/cUdndlaQh+8Y6aRlpqMyfo6bR4rVB2kGbnKK1
	651ebOPQ3fYVaCTj87wqldwV0jXfa1jsbCZC1OFA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjmjqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 14:54:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VEfGuj024182;
	Fri, 31 Jul 2026 14:54:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgr5km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 14:54:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VEsc9L30736658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 14:54:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F32A62004D;
	Fri, 31 Jul 2026 14:54:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D27502004F;
	Fri, 31 Jul 2026 14:54:36 +0000 (GMT)
Received: from osiris (unknown [9.111.39.121])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 31 Jul 2026 14:54:36 +0000 (GMT)
Date: Fri, 31 Jul 2026 16:54:35 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
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
Subject: Re: [PATCH v5 01/31] vfio: Use file-based reference counting for KVM
Message-ID: <20260731145435.1016137-B-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-2-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731130902.654679-2-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExMyBTYWx0ZWRfX4hv35tlDuMVM
 F3TXRYLy4XQkf8bKrgeOqkZm8c6XRwqSoYVNvYSvleEg8wS4D5URwBB98Jb7iE9aJkGst/R1dz+
 BW/bYeAx9EjmdIK40TJ57PN0Ihl9Ias=
X-Proofpoint-GUID: jwhUHEZPuOYg88dhNDAhOGsqrR0YX0rG
X-Proofpoint-ORIG-GUID: FDr6UuFMO9qRKFTSC5NpcgYL8jFU-QrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExMyBTYWx0ZWRfXwkD7c0jWNzi6
 bnBgGVovJ7pze0ug+D4hmokKx4LE7ns0bc3TM9Vh6A3YJv0jJ6eOVZh0ZNBRgbYAzqcwlm8ybjw
 TwhpYqm15MqiGWPxV127CFfJlRy/DwdrA2fOV/h2XXFrXyBA7laayrb5AB5qBePnFWuua/h0AUC
 Cj09HAExdd4yNt0narsKYtFcc3bYVujyJi11qGI1vflttyF8nPzPMqk3W3r5oKRnOQfoz6/ZCet
 lTiy4RLKkpfx9JwvrstRQl4U1aMFrH8TIWuTl7XgadrzS6KPOiqha3WSxSbZIqfLtYzAFD74jaA
 d2ix93j3tlByr4I4JEhSxmhURNcr1I/MCsjoB+SQaBsHPFcyUJ36EpntoWdDGjybkqzZsdwbC9U
 qpbPeoYWf8lsvw0xbyymoPfWM4VTlkp3C3b1XrXcgohtmoogjATDUJLUbHBL/Y5t55BPlmimdzD
 J9NcraK8Xf9O2jDZpVA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6cb733 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=1c9xuZXCCkOUJ1rrCtEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310113

On Fri, Jul 31, 2026 at 03:08:29PM +0200, Steffen Eiden wrote:
> Replace manual module reference counting with file-based reference
> counting for KVM integration. Previously, VFIO used symbol_get() to
> obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
> then manually tracked module references through these symbols. This
> approach required storing the put_kvm function pointer in each device
> and carefully managing symbol references.
> 
> Pass struct file pointers instead of struct kvm pointers throughout the
> VFIO-KVM interface. This leverages the kernel's existing file reference
> counting mechanism via get_file_active() and fput(), eliminating the
> need for manual module reference tracking. The file->private_data field
> provides access to the underlying struct kvm when needed.
> 
> This simplifies the code and removes all remaining externally exported
> symbols for KVM, paving the path for a second concurrent KVM module.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/x86/include/asm/kvm_page_track.h |  8 ++---
>  arch/x86/kvm/Makefile                 |  3 --
>  arch/x86/kvm/mmu/page_track.c         | 16 +++++----
>  drivers/s390/crypto/vfio_ap_ops.c     | 24 ++++++++++---
>  drivers/vfio/group.c                  |  2 +-
>  drivers/vfio/pci/vfio_pci_zdev.c      |  7 +++-
>  drivers/vfio/vfio.h                   | 10 +++---
>  drivers/vfio/vfio_main.c              | 49 ++++++---------------------
>  include/linux/kvm_host.h              |  2 ++
>  include/linux/vfio.h                  |  4 +--
>  virt/kvm/kvm_main.c                   | 23 ++++++++++---
>  virt/kvm/vfio.c                       |  8 ++---
>  12 files changed, 81 insertions(+), 75 deletions(-)

@sean: This is based on your draft in https://lore.kernel.org/all/adkFk3ZN4HJtpLA3@google.com/
do you want another/more attribution? If yes which?

	Steffen
