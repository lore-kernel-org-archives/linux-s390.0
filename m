Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716472E7F39;
	Thu, 30 Jul 2026 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407750; cv=none; b=riIt2dLBJmys3vWEUUh6BOaZsTHu5P8LQ0GxXlRdf2TkpWjMhM9MssIPf0aW5FvkHSIHijpdJWraUNAAhZDt26IAbiLFW0Wg9VFvkXeJS0NAPBzb4Wj4LujiaIjEAguSeWGaVBgXfFx/8DhTFPtczZsxyDthdt16vu6ucBbtWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407750; c=relaxed/simple;
	bh=uu5hHRXLB1y9ztZ8x1oL+ni/wYOObvoKLqDoA60e3rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNIS+yVBLW/b+SDtw7YpR24jbiozU8rOqtRJFaL9daY13TrCJQij9t4zprP1BhjH/RiKygGLSrRhOv5oSKj6GrD8PXzQoFyghGtlKiygwuy0WvugX8ICfjmKeuEpw7Im3zfB6EuNJNLrr/lwZATjrHD6sR5WH4CW3IvYgPwqms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DWtIj036; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DWtIj036"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAJ7xn2763076;
	Thu, 30 Jul 2026 10:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j7UTss
	p/Ja2Wn2ov2DKwUJOZW4fVMdeahFzBmEhqAsQ=; b=DWtIj036sZ8P3WR6fFP/91
	mZ04PCrgxittJq2G66zQ56/HhKjh2T4uAiApkIwyp/OgM3UVwtbrxjo2nm9euzM3
	Qw2ivhU91aS30/OkBJfhORBbkV8uQMRyGX1kabqsR7kgLsFFhtYcRFOfswHfm+Xk
	V87gXokAQp0HMwHn32ihWG9Y9WstY1sDMf9mXL3u34jtViyKZi8+W/2ZXvAoRCPl
	0IlYKs8eUBDCq6FDy8RaJPS1X9L6xMOjiScnncpDLa6tTH4HAXDD129FqC2cY/Qz
	1uOdbiY5nNYy6DKXsmd+2mgIrcFLKQg6GE8WBtbS/vChwtuH0xCOWXDC2BSR6Dsw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd6cxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:35:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UAQJOu000415;
	Thu, 30 Jul 2026 10:35:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhjt26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:35:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UAZfTP27984246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 10:35:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C562420043;
	Thu, 30 Jul 2026 10:35:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C8B420040;
	Thu, 30 Jul 2026 10:35:41 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 10:35:41 +0000 (GMT)
Message-ID: <777b4913-b98d-46c9-939a-bb79d5c89840@linux.ibm.com>
Date: Thu, 30 Jul 2026 12:35:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 0/7] KVM: s390: Fixes for 7.2
To: Paolo Bonzini <pbonzini@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260727095720.9150-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PZWdWDYA0e6TVeIKbBos_KYot24paEmj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA3NyBTYWx0ZWRfXyPuCFw7Uv4B7
 BFqFFhU31ldoTDfksI8ukNyLwbJ4CN6S/hcm6o0S1cfboF+ieFzGkZi1RkoR6PF/lM+Hn6+KKR7
 JFoa5aar1OoJGJRjaLXfzG64UC85nkw=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b2902 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=X5Yi34Xx1fHshafFgPMA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA3NyBTYWx0ZWRfX7q9XkCjBlXrd
 pQ6XsunUMN+biJprhkNH6hzlCpkUIVnwTH5H1AMuLL5ovX2L1Rm2W9050G9smtvVdE1qhGtMUIZ
 uUmqx5+48+T8ULUu1WCe+SLU76LGh4jeWm1HmEYXAk5U87brVHqTggmC5Zs3/G4diLP3ip0VzxE
 ohVkW9w0d/BaN/cC8J6hsxr8Y6cM7fiXl4LIisVCAvHwVNVUnwHwyky0s1xTWifCt6LDS0vbN+W
 4uC1bcIDmjuMnHGfKNQ4hLIhub2gb9RrCdhwQyYGQXyiBHVOdhK7bnU51cX4C5QwKtvCmT8xa63
 +kMN5loNM39fQtCWCZ/+Ocvzu8BBEOLqgEhjPxmcLw3iX1PwEt8BVOYu8a0XyI5LSythdfN3u7y
 h8/KEmFr03zE72hzzesu6k2N3bA1UmklBr/Js44DfczHFaW7uk0lVp4u9Hudjr9IIs+VPxiHrE+
 yj5B9BAWWg/vLG5xJpg==
X-Proofpoint-GUID: PZWdWDYA0e6TVeIKbBos_KYot24paEmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300077

Paolo,

I have now more patches in virtio-ccw
Same as pci, mostly triggered by AR review.
sashiko feedback is here
https://sashiko.dev/#/patchset/20260728033022.2658232-1-farman%40linux.ibm.com

Shall I simply send a
tags/kvm-s390-master-7.2-3
tag with those as well?
This would be https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/

The existing patches from 7.2-2 have been reviewed by sashiko here
https://sashiko.dev/#/patchset/20260723221409.5874-1-alifm%40linux.ibm.com
and
https://sashiko.dev/#/patchset/20260724133943.1664961-1-jhkim%40linux.ibm.com
just fine,
but my pull request itself did not work well with sashiko as it failed to partially
apply my patches and then complained about things that have been fixed in those.


We might even have some more fixes from Claudio this time around, we should probably
then do another pull request early next week. Or do you prefer to wait for those?

Christian



Am 27.07.26 um 11:57 schrieb Christian Borntraeger:
> Paolo,
> 
> some more fixes triggered by AI bug reports or testing.
> Mostly for PCI support.
> This also has a regression fix that we introduced in 7.2-rc1
> 
> The following changes since commit 3e3aa6da87d30a0064a17b836685cd43c90a3572:
> 
>    KVM: s390: pci: Fix handling of AIF enable without AISB (2026-07-09 16:23:10 +0200)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-7.2-2
> 
> for you to fetch changes up to 9972befc3e34ff8b6847198c84f11bfc312dde40:
> 
>    KVM: s390: Fall back to short-term pinning in MAP ioctl (2026-07-27 09:23:53 +0200)
> 
> 
> All fixes had no new sashiko findings, just pre-existing issues or
> finding that are being fixed by other patches of the series.
> 
> We have some more fixes pending for gmap and vfio-ccw that still need
> testing or sashiko fixups, but we should process these fixes now.
> 
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes for 7.2
> 
> - several fixes for PCI passthru in s390 kvm
> - fix a 7.2-rc regression in the adapter interrupt mapping code
> 
> ----------------------------------------------------------------
> Farhan Ali (6):
>        KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
>        KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
>        KVM: s390: pci: Fix missing error codes and memory unaccounting
>        KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
>        KVM: s390: pci: Fix resource leak on IRQ registration failure
>        KVM: s390: pci: Validate AIBV and AISB before pinning guest pages
> 
> Jaehoon Kim (1):
>        KVM: s390: Fall back to short-term pinning in MAP ioctl
> 
>   Documentation/virt/kvm/devices/s390_flic.rst |  15 +++-
>   arch/s390/include/asm/kvm_host.h             |   5 ++
>   arch/s390/kvm/interrupt.c                    |  56 ++++++++++----
>   arch/s390/kvm/pci.c                          | 107 +++++++++++++++++++++------
>   arch/s390/kvm/pci.h                          |   2 +
>   5 files changed, 148 insertions(+), 37 deletions(-)
> 

