Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFA3C3439;
	Thu,  9 Apr 2026 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735736; cv=none; b=ittsOSadP1Kxdr8cvH4EX87MSSK06Kv9CIsIdzSyRNNpxmxNdL/v6ycwNJzk1zaFvLLYgnTFijH57SbCQVSMpNzeeExNHRINOUWf8bcco9j9DK4ZS5sMt5yOmv6u70R6cUk4QttyEKxucv/GwztG7GyPisweIzm8bsB4StT5GRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735736; c=relaxed/simple;
	bh=fxg976uJfnmF/J6X3F9mJwi1HtIAa4JH+0C1fCMUOCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpuwYtRsf8dc3UyrI1/pMfY7ac8HdgnycpZ3ieRx4xmLcWC0/PjTPpeYUN6sbJozl/6CzWSCxGSbLoCWyNUn34humM9qb0HW4+o5mskObIEVCy87nxFfCPs1aAqqZMjD08vtbBJi+aOY0tdW/pnMfuDYD8uE/uk3EyObPVqXKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SshkWPRn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SshkWPRn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638KLUil2302533;
	Thu, 9 Apr 2026 11:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KHjlDs
	NDT1/j+2pqczxZdN1W0eeN3GHFiLJpCVLjVXE=; b=SshkWPRnndSjg3iCiyV70G
	9pM3LPFWSFOnDCOuReRP9eJJS4Ff4d0/FcyEEUHDjnshSnErEZkHeTGIofs4vVQ2
	EQHVsde33SseWwvxppFlAzPhBwNt5HQIBcnZjxP51ZTOqU2CfAup9uwxEiL960Mb
	Vw2jziYBd6mvTcBZFOrTxr+q24JCSobaYnZMxQGhuTG/a8pQN3tPwZFOxw5TbrYa
	76e9/vLfKrSFo3ZMqCUOlPBApSr4iRhrMtoHYwansJRkC9ON0P1N66IUxmX8s41L
	MUcCpE+GqYSQM5WVvyyfaNfvTQO8beqDmqL/Azz4ghWFbEFLzjMqVY8nYz5gs/nA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fmrv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 11:55:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6397aYXd014356;
	Thu, 9 Apr 2026 11:55:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4ue8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 11:55:29 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 639BtSiB15598328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 11:55:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B049D58059;
	Thu,  9 Apr 2026 11:55:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 252CA58043;
	Thu,  9 Apr 2026 11:55:28 +0000 (GMT)
Received: from [9.61.93.104] (unknown [9.61.93.104])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Apr 2026 11:55:28 +0000 (GMT)
Message-ID: <3b982df9-e470-4cfb-9c4a-3a1b7a1a231a@linux.ibm.com>
Date: Thu, 9 Apr 2026 07:55:27 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] VFIO: remove dead notifier code
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, alex@shazbot.org,
        linux-s390@vger.kernel.org
References: <20260407175934.1602711-1-pbonzini@redhat.com>
 <6569b8b8-7654-4dbe-a4a6-f1e565451672@linux.ibm.com>
 <CABgObfbiNRfNGvhDFO=h-E27KONh80fkB1y1rOGpazTB2Eigzw@mail.gmail.com>
 <CABgObfZg7HTX=N3cjHCeiZ2KuKSxnbr9Q7-5ciy8WgMPwBhU5g@mail.gmail.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <CABgObfZg7HTX=N3cjHCeiZ2KuKSxnbr9Q7-5ciy8WgMPwBhU5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEwNiBTYWx0ZWRfX/lWs16yvAb1H
 qJKPQEca/QWhdsYUitJ/g2c+JEy5b/hiHenzUiYdUE3IJjXM4NDJmZ5I/5NWlIH5ztbQDXiYB4/
 vP8RE3tLjTMAlK6uvoZd6TNyHVhTKIYVJeMrbU0xBIFcprEEI3nYgAJBHCu553k7cYFKQKMLgvh
 zf7/HmW34zSLbq8aK/RcWy8SApYPYT9nCJPDp7LWVsmPoQrquE6u2Ads3HPommycuQOseAWlbra
 /R3+x+hn1psa6USdowDI7jb6L4EM172+acA+0I2+jOqRLaFRc3qIYkOniWkB3ykodylLO7Fasca
 L7smNP0cww6YydjyTaOwGW/H4XuJnbGL0kAH0KRbmMDzS2lcSDUQf7pVjPDfutw1SGzg3OGx0XS
 4mAbjnChJZly7oFiSPpyS07M+kqAjIokZveYCnWYjee0MvvXnGWAiQl4TeXw6Yu/nitHrrjteyI
 86XLMESbAYTV7IQWxfg==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d793b2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=CQqoXkB98VF-c3EF6hIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UjFlKUyRcqAl_prkIgeBQsiVEMv9Yrvy
X-Proofpoint-GUID: UjFlKUyRcqAl_prkIgeBQsiVEMv9Yrvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090106



On 4/8/26 6:00 PM, Paolo Bonzini wrote:
> On Wed, Apr 8, 2026 at 4:36 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On Wed, Apr 8, 2026 at 4:35 PM Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>
>>>>      open_device:
>>>> -    The vfio_ap driver uses this callback to register a
>>>> -    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the matrix mdev
>>>> -    devices. The open_device callback is invoked by userspace to connect the
>>>> -    VFIO iommu group for the matrix mdev device to the MDEV bus. Access to the
>>>> -    KVM structure used to configure the KVM guest is provided via this callback.
>>>> -    The KVM structure, is used to configure the guest's access to the AP matrix
>>>> -    defined via the vfio_ap mediated device's sysfs attribute files.
>>>> +    the open_device callback is invoked by userspace to connect the
>>> Capitalization:
>>> s/the open_device callback/The open device callback/
>>>
>>> Capitalization:
>>> s/this callback/This callback/
>> Heh, I had to pick one or the other (close_device previously used
>> lowercase) and chose the wrong one. :)
> I was going to make the change, but then noticed that lowercase is
> more common in the file:
>
>    create:
>      allocates the ap_matrix_mdev structure used by the vfio_ap driver to:
>
>    remove:
>      deallocates the vfio_ap mediated device's ap_matrix_mdev structure.
>      This will be allowed only if a running guest is not using the mdev.
>
>    ioctl:
>      this callback handles the VFIO_DEVICE_GET_INFO and VFIO_DEVICE_RESET
>      ioctls defined by the vfio framework.
>
> What do you think?

It's not critical. If that's the case, leave it lower case

>
> Paolo
>

