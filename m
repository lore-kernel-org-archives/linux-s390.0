Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD864330322;
	Wed, 18 Feb 2026 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451350; cv=none; b=s+O6/NhSa49gSqhLG4eZgdqEoBZErtmTVZZTh6e0zXpQLH0vPFeQZZ1RfYZSBvTbS9AO3n+U6ZrlDuxXw0zIXkp3rsY26ZnGZ15JWeTcfOAjeDnUimrlmjJCRLXRePu/x/5IYFHQndmFt10mJmTBx0JyGlktW3CheNNRi4WE9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451350; c=relaxed/simple;
	bh=LOT2uMNbe+G0E9WMNmNAIOAcfdqlXjepfLJUkmlxMFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhxOjtQdMQGLv1EHMDYnGZWwVhAqzHOvMZPwgu33tSwPZ3V3RhNX0COMIjXIKpLz85c64Iyo7OvCN7Ud0ENaUhiBpNrJBaS9HhHSDD6A27tPoZLO6wvwYiylM28Q2TFLgliI0ZK7tvyx8avOoS3a/fXx26nHijn93LnRBWZmmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZNrcvXlK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZNrcvXlK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ICwVgV3800571;
	Wed, 18 Feb 2026 21:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=siJwqB
	Xn/1P22W5m+XiexAChhUOcCKcNpKUBEhACIYw=; b=ZNrcvXlK+R2ssdcVi2RFGX
	3bbbN7OrDUhNLBJps+PIoNuE+HLgi4jE9XNX+6retKYuDCXoQa50M0ZuGWlfuygg
	DYTUoN4FGoevFMdZN3ZlK3WRmFF9T9MIg99KPBG2LjaiSDK2mTSRkZypcMDO8isg
	sYzRhMGOlxpbQkKsD9TPP0oVS/qJbHVbhuXWvZqn5jZVh8lXEANsU6x1kqzSdLkK
	fR/HyelSoPqHxvslCx06pf3LlcD1GWoFeG1fE5XA9UpsvlGbhGqjv8rllKwTw4gE
	8fNrJzqCGCXKsnrAbNKSSHuk5kmWoSVtg423c8u3qOfjZ83G7fnX5rRi3XlKoPFw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjj7f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 21:49:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IHRoha015846;
	Wed, 18 Feb 2026 21:49:01 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb459nbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 21:49:00 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61ILmxG445547922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 21:48:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7692658045;
	Wed, 18 Feb 2026 21:48:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 240B15805E;
	Wed, 18 Feb 2026 21:48:58 +0000 (GMT)
Received: from [9.61.252.35] (unknown [9.61.252.35])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 21:48:58 +0000 (GMT)
Message-ID: <7259dc94-b8b1-42f6-852d-76519f1eb262@linux.ibm.com>
Date: Wed, 18 Feb 2026 13:48:57 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/9] PCI: Avoid saving config space state in reset path
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
        clg@redhat.com, stable@vger.kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
References: <20260218193503.GA3439585@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260218193503.GA3439585@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: R-zAZZGlyn7ijtJNZX30CLw5PIxQHy8p
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=699633cd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8CvCqfvxvhR63hKVNt4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE4NiBTYWx0ZWRfXykNUAzxw6R8O
 ssKLo31bsSoI2+PF1APPrvtWQtYaYtZrwx3+ktbX797mxSGpK1RMuyGjaRPbRm54O9iSpYe9ncl
 kmgHqKI9AE2Av0KX/ayw7J1LITROdim8WL7hVfXWjIVdnkTK0LBFB2XqEalk9lf7FeKltrZZhQY
 rb0t6oU9Ngg/LBXGkpEZMtfewit5QabtDkCMjguSt3+uTCcQ2GtRNi5sbfxqcn+XN2YePCpCyI3
 RQcv1zvSITh+qPYPW4uKE1h0RG+TbSO3G5T7/Ylq+h7pJgc6/cA1DV+tNuU2DIBgF5YplmyQ637
 IsvQP4PPGcK8NHtt6xS3cfTF1ykgbYEIv8mxvWQZMFD4EhiY3tj1FJ/bYMPf0FktY9BBhU/dijY
 GjzUJld8m6xiDGASu5pnAlMhAcWtB8jf+ZKQ43tLKY9LCCFQNkeTh3xQqZaJr2nSfmFS3XX9GyY
 YpVafnidQP1eKHNI9jg==
X-Proofpoint-GUID: zCdq0--Qjjlk7zGsubnFWkl3nsci3r7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180186


On 2/18/2026 11:35 AM, Bjorn Helgaas wrote:
> On Wed, Feb 18, 2026 at 12:02:01PM -0700, Keith Busch wrote:
>> On Tue, Feb 17, 2026 at 11:55:43AM -0800, Farhan Ali wrote:
>>> Yes I think you are right, with this change the PCI Command
>>> register gets restored to state at enumeration. So we will lose
>>> the updated state after pci_clear_master() and
>>> pci_enable_device(). I think we can update the vfio driver to call
>>> pci_save_state() after pci_enable_device()?
>> Either that, or move the pci_enable_device() call to after the
>> function reset.
> I kind of like the latter idea because it seems a little simpler for
> the rule of thumb to be that a reset done by the PCI core returns the
> device to the same state as when the driver first probed the device.
> Drivers would generally not use pci_save_state() at all, and they
> could share some initialization logic between probe and post-reset
> recovery.

I think the vfio-pci driver was intentionally doing the 
pci_enable_device() before doing the reset. As per commit 9a92c5091a42 
("vfio-pci: Enable device before attempting reset") it was done to 
handle devices using PM reset, that were getting incorrectly identified 
not supporting PM reset due to current state of the device not being D0. 
It looks like pci_pm_reset() still returns -EINVAL if current power 
state is not D0. So I think we can't move pci_enable_device() after 
reset. Unless we want to update pci_pm_reset() to not use cached value 
of current_state and read it directly from register?

Thanks

Farhan


>
> But I would really like to have Lukas's take on this.  Clearly some
> drivers would have to be adapted if we stop saving config space in the
> PCI core reset path.  We can take care of that for upstream drivers,
> but it seems risky for out-of-tree drivers.
>
> Bjorn
