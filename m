Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F13F8ECA;
	Mon, 27 Jul 2026 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151464; cv=none; b=SP8zRFmjyTAGUg164fDYLdVRV9ZWvkDLakndjwzXytGlj2eT04qukAD45vwKjcoXMBY3gypMsAl8Fm6Wjvu0eQOEA1spNzA+8HrCEGk9369zfevk0FhNWfyNwa9dWaW92VK7ZLQNLHkGjCYERe4+azYREG/4PNJwhrse3aBlkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151464; c=relaxed/simple;
	bh=4OURNIba8Yjg7BD9H67l+rRpHYyi8jFKXhKmyG9deBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUUZBw+cHxST3rxMidO02c45W435WZJQeMVIBw9KF4IT2HFsLynbms3aEXt5BYPqhkI9UL+P+SfudDRQPYkU+cQCEMc/zG8f8qJUJbmKpqXh54BMied7vi8tSmBBiS/6B0G1+lr+BlUSjkz6iX2KHd4PXbuHzCOMSJ+svUFWN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nBSnmFCp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nBSnmFCp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAIm5Q1844840;
	Mon, 27 Jul 2026 11:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pgUX+B
	U9uxf9IsFVaHXQxADSnUjajZehO2WigF6woqI=; b=nBSnmFCpW7DseAUrWgBF2/
	3B9RzdZTIgTA+fFbvJwDe2r7N5mdPsxYW1UO9GDu3nNij33ydGJGucWevkfsUB9v
	ECkW0+NaZX3bJvpbXTaM2gubAIByx7hgU0ZCQnAF3qh4kMAjSV9WS+4IxV3i8uYg
	Q9t7P/MOJplJCBM/++zCR92GXBbuLNBQ3F+bBCG1L/PpFZsBZocwrS/dRWvhhZ3M
	mpEnTZ9xsX07HpoxPxdT4GIw6waRW74F9N/M1+8ULuY30IrfPzNg5xgj8bZ9PU2g
	eVR64vOiZkTLRuDhAEnYzety/h+wGfMYjwUi/K1GBoY3EfswEL+AMhHPdSKl31WA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhy9hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 11:24:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RBBPgE013685;
	Mon, 27 Jul 2026 11:24:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg4xcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 11:24:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RBOGDG51314994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 11:24:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 287E020091;
	Mon, 27 Jul 2026 11:24:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED37C20090;
	Mon, 27 Jul 2026 11:24:15 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 11:24:15 +0000 (GMT)
Message-ID: <a534a0a4-5223-4e65-acf6-c2af29cfcbcb@linux.ibm.com>
Date: Mon, 27 Jul 2026 13:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 0/7] KVM: s390: Fixes for 7.2
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExMSBTYWx0ZWRfX27xBdIqlO2mP
 2E8ZJAii6sH0SBJRBaBGzOiGYQeatqdDKjgSSHLPLhOoRaC9wi38H6IdT6aQcqE9JX0OaTpHK6w
 FA6nK5HQDv208fy5FlgnQxc7ncAFfRg=
X-Proofpoint-GUID: B_fpLqcdJPxcu0eFC3Ip9IpeIPCX29U-
X-Proofpoint-ORIG-GUID: B_fpLqcdJPxcu0eFC3Ip9IpeIPCX29U-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExMSBTYWx0ZWRfX7yO8h0gVjLSh
 /5dHj4LR0MwxbsecQoe8Zz8ApVUU+yYjo/T3EqPkU8I9S1blnf2Kal0N6AeyH7xWPyhmN5Av0ZH
 TnlsHxF2XqS20aJV7dS0/rar/DB9kFMTYxYDHJ4tDPUYIyeDcLPs1ZowKiggg5jWuQhB6eu+Cyj
 JPhKiKAvqw1HEoCN5g7u6zByPSwKlq/4EeVTxLsON4eb46nU5hEoz4JR3Ro+UO1vVx6TDY2laL+
 oumEC4MMhrnLsl3yAipAWq8bVkwat2O76AamcqKWtBvqqUW6SE8/8mQvixbD3W1drE7Q0xyuNdn
 coNDYMJdB4XQzpKEF16HkSOEHHgHzpNoriLL1ZMq2wQTtWtX+PwD2WgCrhZnscABVZuJZHY6IGZ
 gqJ4OFvQm0gDrr/oz95j7gSwBUf1VGqWxBnsMdCoD7BcJn3h4uAaZ4GMxXQdM3j0TLWJD/Y8gxe
 nsh/vZ/AGvv128AaelQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a673fe4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VLg6qVD3L6MNdXo3GXYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270111

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

Paolo,

Sashiko failed to apply some patches. Dont know why, it applies cleanly to v7.2-rc5
and also kvm/master.

This resulted in several false positives as later fixes have not been considered.

