Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C13BFE40;
	Tue, 20 Jan 2026 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935301; cv=none; b=qUZ+mM9fFzry7htoZ28N+TLjwysjvAs+hZUDKov758qhaEgoMxkTGIN6yBUi1MZCHPKgeOoyViUOiVXZbGmQ9LRjNMwaKYIpUFUxJ9FaQAQiCP58LOkQhqZPnoqe5TOPGybkTTUinKqann8wfHx7PxAN+up07tPeqIyiZlrMgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935301; c=relaxed/simple;
	bh=LPe4IVofvEEi6JOtHZs6ndTyZoV/LDm7D3g86jCqG4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjUk8rx+JJNQXhd3ju9bM9M0DQqBkbbDGzN6MiMwhAo45O1QBzwUuGhJmquO5Ez4vI03vG0OlWsHw9njbplLDQ9Gb8PZHmN0N1OEl6IrjublXHyB+7oWi2XakUyP4fg48RQgfaE4IZv9m+t8sXyQVpyADArViNwVd5UNVaSuE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mv08uU2E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mv08uU2E"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KEkgWS019492;
	Tue, 20 Jan 2026 18:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IVr5HP
	z9OX/XF7uWVjvNvjqzNm6uMv1qr3ZzjZdu92g=; b=Mv08uU2ErihiJn4dw5Xi9k
	hmJ1CpxGS/9F8v2fFw1qn/Xo2EebovzojpOzYgXnIeY8yP+hTim3bMMVSyV8Oal3
	2aGpsxQvtxavA4FDVZy80fH5gwTe3f/7sa4WgCybPsaXHvo4jMfHW0TorU2wF1Oe
	L6r7Ir7a+cJEHuTdmoTOHmxdgs/47rJVp9pkNT6zm2F6lXs0jlVRcIFEzImXd+ub
	7yKe/KEk8N6bgQvWz/4dHHLqThkyn29oZJocZOLKJHwa4HqesqL6D0Q1Cs3771B/
	FaW6TF8rW94wZUUTH+Ch4p1D2skM2bH51Xbd3VaPbgRaI1bMmM57t/kEYmNywWMg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255ysjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 18:54:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KI0bre016600;
	Tue, 20 Jan 2026 18:54:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xy81h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 18:54:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60KIsoeb12911202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 18:54:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD9865805F;
	Tue, 20 Jan 2026 18:54:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6DB558062;
	Tue, 20 Jan 2026 18:54:48 +0000 (GMT)
Received: from [9.61.246.96] (unknown [9.61.246.96])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Jan 2026 18:54:48 +0000 (GMT)
Message-ID: <af49850b-4c83-4847-a11f-deb864e4c691@linux.ibm.com>
Date: Tue, 20 Jan 2026 10:54:48 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] vfio-pci/zdev: Add a device feature for error
 information
To: Julian Ruess <julianr@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260107183217.1365-1-alifm@linux.ibm.com>
 <20260107183217.1365-8-alifm@linux.ibm.com>
 <DFSPESVR3INE.HYERH8O05PYP@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <DFSPESVR3INE.HYERH8O05PYP@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE1NyBTYWx0ZWRfX7MxToiHp06pV
 et4QYafNzoF+06k+sdt9A4VxuRD7w42u4luFUUPxFHcY33HkhhptI0f1Mtfamu+p1FBUyi/sbdE
 1LWpCivF8MIIIXG8kT9VL7ov1JYtA2AwauTFu+0DIdpQKtwXdtc1pDZUYzFpVhOwCyaaXIvqoE/
 Api+rTxj4k+qchRD1SbhMY3AV4L1pimVU3LsxJvtMmwL09wCl+nlvYNZydpF12pcUeBzKb18Lpg
 CWvS2f2gw6oIuZ8jvEppBL//+VuGxyGLdE7jZcRxBQvx1bUqh9Wh9/+q0QBOj1Mr2C9I1CMa4Fv
 YAJ5q4uPL3djZLzHcECDPAHryvN3s9+QMYWSGhxPU2qa2edBGRMHGhA4tspVpGp8QnVbQvbCOgr
 9+ImmvHiRvCKlj/LPJJjZSJc7cBIC9hchYMuDBmcOoC+CpE62XOVWL4tZa2RVT8DywchXlASSTC
 j4bfNLugkXmYKiBj+KQ==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=696fcf7c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=bY3v0OhBKqGwzd9qTigA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mRl1UHgkE9CUcfKTMjKba30Vbx8fVwh4
X-Proofpoint-ORIG-GUID: mRl1UHgkE9CUcfKTMjKba30Vbx8fVwh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601200157


On 1/19/2026 8:24 AM, Julian Ruess wrote:
>> For zPCI devices, we have platform specific error information. The platform
>> firmware provides this error information to the operating system in an
>> architecture specific mechanism. To enable recovery from userspace for
>> these devices, we want to expose this error information to userspace. Add a
>> new device feature to expose this information.
>>
>> Signed-off-by: Farhan Ali<alifm@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c |  2 ++
>>   drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++++
>>   drivers/vfio/pci/vfio_pci_zdev.c | 34 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h        | 16 +++++++++++++++
>>   4 files changed, 61 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3a11e6f450f7..f677705921e6 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1526,6 +1526,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>   		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>>   	case VFIO_DEVICE_FEATURE_DMA_BUF:
>>   		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
>> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
> Would it make sense to name this more generically, e.g.
> VFIO_DEVICE_FEATURE_ERROR_RECOVERY, in case other architectures also want to
> support something like this in the future?

The error recovery mechanism here and also the uapi structure exposed 
via this device feature is very specific to zPCI devices. Making this a 
generic device feature would mean having different uapi structure for 
zPCI devices vs PCI devices on other architectures. I am not sure that 
would be desirable and might be cleaner to have separate device feature 
and separate uapi constructs for zPCI vs other architectures.

Thanks

Farhan


