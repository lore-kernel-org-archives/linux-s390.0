Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B033BBD9;
	Mon, 15 Jun 2026 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514284; cv=none; b=DqGoPMY7UaFRGBPBhfY7qU8z2+mC4atSOIswJq73lx/YDWDw9gGR5vzKOuJRk5X0m9KaDggn0OvKo7Ys/H7Rv6/wA+tyN3UXL6DiiahMbeV5N/1+xRvWO01XyFAhzbPXb/Fuh4RmTgYLUHuja4sLaknJ9rK96nzfXpNpuoSRnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514284; c=relaxed/simple;
	bh=f2RVNCpFF/HL0peoGLYSHIPZQiBntS349FqT4+uZDe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjJwF9XU3JqHFLiBhrNf0iS7O0Oj1Z+LC62b6bdLhtE0BJpsYhrWIqRST27JhiZlOgZw/RnIxu8vBQuad9xZZX0DXoFLQEqo6hjHUqUUeHUFQ+Uc5hmDn5WdWt8zcdFjFXaa8BfFEQ8vM5sJTMd/ejIaeY5OPccC95Am51ZSRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bdv/tpcD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bdv/tpcD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6IVFN1555437;
	Mon, 15 Jun 2026 09:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qraA7u
	XqXqpLp5+9gZeensX6WiJejtZ6XEFHKTklheM=; b=bdv/tpcD/ls0Jz2InQPW45
	oIm+0aAOkhoO75Z/vy9jttZ/7ZZK/DGb3hhrdI6QPkFw0N7QJY1xObUGmeTenQMa
	WUWo/cyvvARo7dsd8j5KJzvmp9Yc7yzp0SMRU2REr3BvLMzSAHQXqDltbkbkgKgN
	ch9wy2Z/LuAsPqNujMtcvcmeOYChf0Q6ZTEbfUZ8+QfbUe8F5VEZMV4UrftRjYjK
	Vqi3h8CzGIysFhTh5vL3xFzHAdd0hFhY21HHncFWe2Fqf9Cx7a02/7Cd1OAPKeRK
	TpymlCmA5kszGN5sWwRPxfx6NWKVxN7P5MCN/q9L5fMUISt82r45GRVPaggymR4w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nfpat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:04:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F94cRe012642;
	Mon, 15 Jun 2026 09:04:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvwx2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:04:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F94a5R48169316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 09:04:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE19120040;
	Mon, 15 Jun 2026 09:04:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13E4F2004B;
	Mon, 15 Jun 2026 09:04:35 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.31.49])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 15 Jun 2026 09:04:34 +0000 (GMT)
Date: Mon, 15 Jun 2026 11:04:32 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Douglas Freimuth <freimuth@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v10 0/3] KVM: s390: Introducing
 kvm_arch_set_irq_inatomic Fast Inject
Message-ID: <20260615110432.0ca16a11@p-imbrenda>
In-Reply-To: <20260604192755.203143-1-freimuth@linux.ibm.com>
References: <20260604192755.203143-1-freimuth@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2fc028 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=nuq1gdfsaJWFMegv1WEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX0SraL7kdzAvv
 Ao0oemaefqqRCQ0yPGBtpFVjBXR93QTMcHb8FUdoYyCleJpmeKWYxQac3J7GrGAwaahnlWdt5z4
 40KA9g/qkbP36HmqBSmvivL51x8rRPc35jRAuvVyVqz0WDV2uJfUR70CPxXEBVSGptx/KMQBUGF
 o2CbGqsXYGKY0D2iKChTYBj5Ze3gQLHteOtUzpgMvF4HqRndgOtXN0Nmcuth3Wp1N7mtTxxxm8o
 6wn4S12DiVwHrpy5tMf9ug3nlyNKfaTfGFfWDRnMwIDOe5wHXKGPB76MseX3U3f5YgnCdcMwEkA
 x3DZjMXuTKiGt3crPTrSqGqThwT8mfV/4udPbWvNxeHpSrlKU+kuF4u7m8D1Z3pG2LLpxKucAxE
 DvbTAC9eMTU5xpVI1metcklca+7kuLSnyKxCK3zbnb9lUpmtc8WjkHMmvjtP4M0MiMso3qNBQNU
 8cGBb9CNMt0m1JDFN3w==
X-Proofpoint-GUID: LXxutkVT7s4SV0UdG0INGF8XrUHPzPqf
X-Proofpoint-ORIG-GUID: LXxutkVT7s4SV0UdG0INGF8XrUHPzPqf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX0Qs/DgWZzaQg
 Xdt9ezeL2ux+bNxb5qxfcSZYt7m6LLOKO2tG3Oif7GnkJTwUGzO9tA/s8+tvQX8/Kabcf7JwKpv
 LkgqoDhn6OhdLQaOHmzxsmvUoySrNUc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150092

On Thu,  4 Jun 2026 21:27:52 +0200
Douglas Freimuth <freimuth@linux.ibm.com> wrote:

> s390 needs this series of three patches in order to enable a non-blocking
> path for irqfd injection on s390 via kvm_arch_set_irq_inatomic(). Before
> these changes, kvm_arch_set_irq_inatomic() would just return -EWOULDBLOCK
> and place all interrupts on the global work queue, which must subsequently
> be processed by a different thread. This series of patches implements an
> s390 version of inatomic and is relevant to virtio-blk and virtio-net and
> was tested against virtio-pci and virtio-ccw.
> 
> The inatomic fast path cannot lose control since it is running with
> interrupts disabled. This meant making the following changes that exist on
> the slow path today. First, the adapter_indicators page needs to be mapped
> since it is accessed with interrupts disabled, so we added map/unmap
> functions. Second, access to shared resources between the fast and slow
> paths needed to be changed from mutex and semaphores to spin_lock's.
> Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
> but we had to implement the fast path with GFP_ATOMIC allocation. Each of
> these enhancements were required to prevent blocking on the fast inject
> path.
> 
> s390 doesn't support a PREEMPT_RT kernel and this patch doesn't either.
> Given this fact, we are not using raw_spin_lock instead we are using
> regular spin_lock.
> 
> Statistical counters have been added to enable analysis of irq injection on
> the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
> io_set_adapter_int and io_390_inatomic_no_inject. And
> counters have been added to analyze map/unmap of the adapter_indicator
> pages in non-Secure Execution environments and to track fencing of Fast
> Inject in Secure Execution environments. In order to take advantage of this
> kernel series with virtio-pci, a QEMU that includes the
> 's390x/pci: set kvm_msi_via_irqfd_allowed' fix is needed.  Additionally,
> the guest xml needs a thread pool and threads explicitly assigned per disk
> device using the common way of defining threads for disks.
> 
> Patch 1 enables map/unmap of adapter indicator pages but for Secure
> Execution environments it avoids the long term mapping.
> 

Whole series:
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


> v9->v10: Streamline logic in register_io_adapter()
> 
> Douglas Freimuth (3):
>   KVM: s390: Add map/unmap ioctl and clean mappings post-guest
>   KVM: s390: Enable adapter_indicators_set to use mapped pages
>   KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject
> 
>  arch/s390/include/asm/kvm_host.h |  11 +-
>  arch/s390/kvm/intercept.c        |   5 +-
>  arch/s390/kvm/interrupt.c        | 559 ++++++++++++++++++++++++-------
>  arch/s390/kvm/kvm-s390.c         |  30 +-
>  arch/s390/kvm/kvm-s390.h         |   5 +-
>  5 files changed, 488 insertions(+), 122 deletions(-)
> 

