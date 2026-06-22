Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F935675B;
	Mon, 22 Jun 2026 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163824; cv=none; b=lJIiK5LQ1A21ktY1W3lVIjLdw3k1TWPkimKmHowEIW+YROsp/qREe+ryfgadY5IFS65Qbi1XbDGQ90lEUCDBK8iFBC/J54KxZJKzRm7VnpTf5Dy6YoUx5i+3WxdjsJdg/yLGbsgQJnLyIgHv4YuravvkA15sXJnhaTtmDfDkiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163824; c=relaxed/simple;
	bh=rY/lCz3dbJTsXY2JYWpNlQ7t/z+ar9fME7tKS+q04yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGjBTwNdd2AF4mUmEJRvd7Ft54BkU9GjaxViSW5ilzkjwavU2AuFPI1vThmKSIC/MUPDbz5H7yXb2CsM7T/rgdLYdJZhOX+JHQCiEvVZeOhGKFLz9HD6fLjO8Uai7lA+/BP15F0QxbdPNomrs75mJvVgGraLshccP0I32b3ASW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A8me9fR9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A8me9fR9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MJmNFQ4133777;
	Mon, 22 Jun 2026 21:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YJ096u
	mEx3MrpmXsinFXH+2SQ0ejLWuKDD45GA2hOVU=; b=A8me9fR9R6KijQnmWO/aod
	C6zFx63CawgQROVU7U1PwlHSCkp7MxazEHvWczpevS1+F+IqGj8CVxse+WAuN2uN
	Ww/6JOD9PvBGAvBnqMT3s2LR9XXRa1gSMTq8v6JNWh9ooRL5z91YV7hLqV9Z+VBI
	IVG66rZ395C+ayCY8Crugo2Zu51KkcqEjHqDm9/tZjdLg+Nv2WfsjLyFPvRWJc5o
	3CGh0g564UxXTzJfz++P6j588UJDpOUaDneL38OCZSuHS9V7DKF/M9JuQngAG0xk
	kZk4k3d6TfBIDmo2Zfo+NFwMJ4lLQCHlzMHrjgs4gJMk3Jc95QlbBtVmvag7Sf6Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqkctt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 21:30:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MLJc2Y012893;
	Mon, 22 Jun 2026 21:30:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q8dkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 21:30:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MLUHOG20054738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 21:30:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 331F45806A;
	Mon, 22 Jun 2026 21:30:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 453875805D;
	Mon, 22 Jun 2026 21:30:16 +0000 (GMT)
Received: from [9.61.253.34] (unknown [9.61.253.34])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Jun 2026 21:30:16 +0000 (GMT)
Message-ID: <6bf8243d-89d6-4a20-ae15-166b028a2257@linux.ibm.com>
Date: Mon, 22 Jun 2026 17:30:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] vfio-pci/zdev: Add VFIO FMB device features
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com
References: <20260612181048.91548-1-oelghoul@linux.ibm.com>
 <20260612181048.91548-4-oelghoul@linux.ibm.com>
 <20260622142215.2446486e@shazbot.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260622142215.2446486e@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a39a96c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aPsx3AmzkLelg1VItP4A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfX2yzd6ktk772Y
 kQueMCHnw3fBvQRTMeImkRWO7RHGcbjpfLwk7sVDeKYuagzDJ19Gx9Nuv/6e5ZYD6f38Ib3LuFt
 rlSYXSCARuLxlTUr4KMyz8TbFZVmeJDKfTlSbryeAiiy02y8vSEQ4BZXnu1Aps8013yxtPpHr7C
 FL5t26I1JiMA5+kNDlE5gW6Vye8ql++kPTHcqLu/SJ+oPn0ETcOoEM4ucdJ2FOpGJnIJhB+96vu
 ZoOz+sx1LD6n4Hvbuybf1b6F7pRSddMoDEYyeQShnn5/F30/xFndRIVb7XX28NB53BqyIVQ5QZQ
 3XFHCQVuFVLjKbipPHXAMEEUewxdl+y2e+yEpJn3EX74tEVTj0o4ixa85Guebqft8EgXGEtpjBD
 fKmsuliViwEq8i7VGxLHOzsZcL/8PoDXFL7+DBDVLK14vdrzdEFQsghHv9tKh0rvzlRSIrxfrK8
 QCZQ91cNXFKvNOfcXQQ==
X-Proofpoint-GUID: eS_1NjBWvzhw4lKcdk2SA1kxZWRZG8W9
X-Proofpoint-ORIG-GUID: eS_1NjBWvzhw4lKcdk2SA1kxZWRZG8W9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfXygE9fZxg5orP
 WdA6l1QDU3G9DW7anB+6a6qe5sI3sFSKocsm+0Gtw4UK4MydcZWM939bcy4bHcf7XYNBcoJeFfu
 XIzpZLWM/YniKCcKz7PA1dE9LO+4MBk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220206

On 6/22/26 4:22 PM, Alex Williamson wrote:
> On Fri, 12 Jun 2026 14:10:47 -0400
> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
>> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
>> +				   void __user *arg, size_t argsz)
>> +{
>> +	struct zpci_dev *zdev;
>> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
>> +	int ret;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET, sizeof(fmb_read));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	zdev = to_zpci(vdev->pdev);
>> +	if (!zdev)
>> +		return -ENODEV;
>> +
>> +	guard(mutex)(&zdev->fmb_lock);
>> +
>> +	if (!zdev->fmb)
>> +		return -ENOMSG;
>> +	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
> 
> No need to do this or the test below under mutex.
> 
>> +		return -EFAULT;
>> +	if (!fmb_read.data)
>> +		return -EINVAL;
>> +
>> +	if (copy_to_user((struct zpci_fmb __user *) fmb_read.data, zdev->fmb, zdev->fmb_length))
> 
> The v3 comment noted we could do this, but really keeping the buffer
> and doing the copy_to_user after dropping the mutex is really the
> better option.  Sashiko also notes[1] this as a high severity issue.
> 
> Should also use a u64_to_user_ptr() on the user data pointer.
> 
> [1]https://sashiko.dev/#/message/20260612182854.97E641F000E9%40smtp.kernel.org

Acked.

> 
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..97e0f857fe4f 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1534,6 +1534,35 @@ struct vfio_device_feature_dma_buf {
>>    */
>>   #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>   
> 
> These next feature indexes are in contention, so we need to think about
> how this gets merged; the whole thing through the vfio tree, the s390
> bits through s390 tree with a branch exposed for me to merge to vfio
> before applying this change, or the whole series applied to a clean
> branch and merged into both the s390 and vfio next branches.  The first
> two options give me the most leniency in adjusting feature indexes
> based on what's already been merged at the time.

I'm flexible on the merging. Carrying the assumption that the VFIO patch
depends on the s390 patches (after I make the amendments below), I
believe option 2 would work best, but I'm happy to work with whichever
approach you prefer.

> 
>> +/**
>> + * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
>> + *
>> + * enabled is treated as a bool, so any non-zero value evaluates to true. This
>> + * feature fails on attempt to double enable/disable.
> 
> Same inconsistency noted on patch 2, it seems that it starts out
> enabled.

Acked, will amend it back to allowing the re-enable and appropriately
document the behavior.

> 
>> + *
>> + * Returns: 0 on success, -1 and errno set appropriately on error.
>> + */
>> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE 13
>> +
>> +struct vfio_device_feature_zpci_fmb_enable {
>> +	__u8 enabled;
>> +};
>> +
>> +/**
>> + * Upon VFIO_DEVICE_FEATURE_GET, provide FMB passthrough for VFIO zPCI devices.
>> + *
>> + * The user-provided buffer must be at least fmb_length large, where fmb_length
>> + * is reported in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.
> 
> Is there a spec reference for the opaque data blob provided, or at
> least reference to kernel structure documenting the layout defined by
> some firmware reference?

The structure (struct zpci_fmb) is defined in the kernel under
arch/s390/include/asm/pci.h.

> 
>> + *
>> + * Returns: 0 on success, -1 and errno set appropriately on error. errno==ENOMSG
>> + * when the FMB is not enabled.
> 
> This sounds like a user sequencing error, so should it simply be EINVAL
> or ENXIO?  ENOMSG almost sounds like we're tracking the samples field
> to make sure the user hasn't already read the current sample.  Along

The user should be allowed to read the same sample more than once. I
also think ENOMSG makes sense here because its semantics are reasonable
(i.e., there's no FMB "message" to read because the FMB is disabled.)
That said ENXIO probably makes for a good second choice here, more so
than EINVAL.

> those same lines, should this document some mechanism for dealing with
> torn samples since we might be relaying the sample structure mid-update?

There is an "update-in-progress" bit in the structure, but I don't think
that's within the scope of the uAPI since we're already treating it like
an opaque blob.

Thanks.

> Thanks,
> 
> Alex

