Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073938655C;
	Mon,  8 Jun 2026 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946813; cv=none; b=dQiscATA74rSoEf4E2jTGaqio/V03XLbfmCh4FaJF6CjtLSaKk9AdgY9R+22vXSaVzKqPvjdrI8xV3YCEnVYbb//+Ys95KlD7bJvz/EASVTnzrMg334jo8o5+VpFUMMY/8dUtzJIbhKGmXnpeRhLdfc7tHCiAOfljuOftcJgUcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946813; c=relaxed/simple;
	bh=YKnKBkI7LsGAJjyacsviA147Ol8MDkqmHxkqgAq1WzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZyKdWAn6IQQmZispMWy2zQIGEdcXpMRARie9hn9k8heXM6RGSRVDIEZCBRwo+aSUh00/MAh8KS7gXajHQ2BTanj1FcLMP00+xkNqaZvI55uw3PbFXjU3o36vDOXdcTYNsBHawadwiNMt6PjvMO7J3mD6HDcO6tDV6lTtQ5Mvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QKlugsoU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QKlugsoU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DFRdV4008241;
	Mon, 8 Jun 2026 19:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KcaM0t
	vQJx8AoDy1DFFH7SPyXD4dEeN/NNhFAvlDVUc=; b=QKlugsoUY7PpsRkSHTH9Ec
	fEokivKF8WhYrP0te+bFg34U405kRrTn0/km4TVC/l+Qq6jGqsxuMOLpUvfakzyj
	7CvOwGnUV1Y0FfLARU7d9i5y8+kWyrK63qxUdsvM4Dw9TUo70bsH5FQ6W+3miiZ9
	ncLdEwkCQ76DQ3TFie9IkiYgiGtXpGi8EuKvU3o4ftRgr2kOn2UuRa1JBU8pUhJf
	i0lhKkM75VC1UVGISaItWHRsrH0HV5LGzAh9Xl5gTxZYR91+jCnXtz5aJR3VVDUG
	79FhcRjjpvqN1o9yzeNMzCkSmfyYPnNIo6TwQsdhUWAjFm7wJnfQxd9pAQcJxABg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhs1u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 19:26:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658JJciR017033;
	Mon, 8 Jun 2026 19:26:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy6hyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 19:26:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658JQcBR28246698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 19:26:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D46558050;
	Mon,  8 Jun 2026 19:26:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 215F758045;
	Mon,  8 Jun 2026 19:26:37 +0000 (GMT)
Received: from [9.61.254.254] (unknown [9.61.254.254])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 19:26:37 +0000 (GMT)
Message-ID: <96c749ba-1b42-425f-8767-a3fce4a4d30b@linux.ibm.com>
Date: Mon, 8 Jun 2026 12:26:36 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci
 driver
To: Alex Williamson <alex@shazbot.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        helgaas@kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>,
        Chengwen Feng <fengchengwen@huawei.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
 <20260603182415.2324-4-alifm@linux.ibm.com> <aiE3I0bL0TX1nOec@kbusch-mbp>
 <d9ca420b-a1e6-4d12-bd42-3993e401d58b@linux.ibm.com>
 <20260604135717.5dc69583@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260604135717.5dc69583@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3NyBTYWx0ZWRfX57T9cjappVj3
 06zgM4swvYo0n6dsR/VlQduf247ndhkyYlp4T9TVoMWmwKz69znhx4L9qDkUThpuqBvnX3ckmWM
 4q4KUX+B/t6ptLmqW9zoV1Blk14BO+cenHqIgbp97Id4cOwmKqTleE06Cyd0OMUhMwK5uQPYN7T
 4599uoRpLa/0nsLutkGKqm1Pw1kPPiYFh5tQ/63mhBAsYgX+4yglOq5xQIQ/gl19jlYYZ1tQIvb
 B8xEAOurPMWOHrgZjZ7m8oiV8Ot6dH/zle3rtv7kaJ9T4wA4l4Vk/wQG6lN5VICBjYF4arsrMZ1
 ZJ82Hhd2i6Qxz8W/O7O1MpMOMKscXjQASsJXbxfVuDEAYwlcZU2DfYcvWPP0qZ68CRONjelIVN4
 vtwCrYRiGSDiC2BpzmMByPbFT+c7RaN6bw1WLzhiGYi15OGeB4l5NXxkY3P1c6Rp2AILhwm16By
 CDCQfAfmYsS82DO14rw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a271770 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=f6RAqg8oNnK9RgWYnkIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: 7XZ-i2pRu5MGQs1_JlS0awG03ZAp4cnO
X-Proofpoint-GUID: 7XZ-i2pRu5MGQs1_JlS0awG03ZAp4cnO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080177


On 6/4/2026 12:57 PM, Alex Williamson wrote:
> On Thu, 4 Jun 2026 10:17:04 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> On 6/4/2026 1:28 AM, Keith Busch wrote:
>>> On Wed, Jun 03, 2026 at 11:24:14AM -0700, Farhan Ali wrote:
>>>> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
>>>> +{
>>>> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
>>>> +
>>>> +	if (!vdev->pci_saved_state)
>>>> +		return;
>>>> +
>>>> +	pci_load_saved_state(pdev, vdev->pci_saved_state);
>>>> +	pci_restore_state(pdev);
>>>> +}
>>> Shouldn't there be a cooresponding user space notification that the
>>> device has been restored? There's an eventfd on the error detected side
>>> so user space can know the device needs recovery, but how does it come
>>> to know that the reset is completed?
>> I think if the VFIO_DEVICE_RESET ioctl completes successfully it should
>> be an indication that the reset has completed? AFAIU the ioctl will
>> drive a reset via pci_try_reset_function(). If reset completes completes
>> successfully the reset_done() callback is called via pci_dev_restore().
>> So I don't think we need an eventfd to notify on reset completion.
>> Otherwise we would have the same problem today, where userspace is
>> unaware that VFIO_DEVICE_RESET did indeed successfully reset the device,
>> no? Or am I missing something?
> I'm starting to feel a little sketchy about this.  I asked claude to
> enumerate the state restores and the source of that restored state.
> Hopefully this ascii table survives:
>
>    ┌──────────────────────────┬────────────────────────┬─────────────────────┐
>    │           Step           │         Source         │ Snapshot-dependent? │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │                          │ EXP cap save buffer    │                     │
>    │ pci_restore_pcie_state   │ (pci_find_saved_cap,   │ YES                 │
>    │                          │ cap.data)              │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │                          │ live                   │                     │
>    │ pci_restore_pasid_state  │ pdev->pasid_enabled +  │ no                  │
>    │                          │ pasid_features         │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_restore_pri_state    │ live pdev->pri_enabled │ no                  │
>    │                          │  + pri_reqs_alloc      │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_restore_ats_state    │ live dev->ats_enabled  │ no                  │
>    │                          │ + ats_stu              │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_restore_vc_state     │ VC ext-cap save buffer │ YES                 │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │                          │ live resource_size()   │                     │
>    │ pci_restore_rebar_state  │ (re-derived, written   │ no                  │
>    │                          │ to hw)                 │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_restore_dpc_state    │ DPC ext-cap save       │ YES                 │
>    │                          │ buffer                 │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_restore_ptm_state    │ PTM ext-cap save       │ YES                 │
>    │                          │ buffer                 │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │                          │ TPH ext-cap save       │                     │
>    │ pci_restore_tph_state    │ buffer, gated on live  │ YES (gated)         │
>    │                          │ tph_enabled            │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_aer_clear_status     │ clears hw status (not  │ n/a                 │
>    │                          │ a restore)             │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_restore_aer_state    │ ERR ext-cap save       │ YES                 │
>    │                          │ buffer                 │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │                          │ saved_config_space[16] │                     │
>    │ pci_restore_config_space │  — type-0 header       │ YES                 │
>    │                          │ (COMMAND, BARs,        │                     │
>    │                          │ cacheline…)            │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_restore_pcix_state   │ PCI-X cap save buffer  │ YES                 │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_restore_msi_state    │ live msi_desc list +   │ no                  │
>    │                          │ msi(x)_enabled         │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_enable_acs           │ re-derived from ACS    │ no                  │
>    │                          │ policy                 │                     │
>    ├──────────────────────────┼────────────────────────┼─────────────────────┤
>    │ pci_restore_iov_state    │ live dev->sriov        │ no                  │
>    │                          │ (num_VFs, ctrl)        │                     │
>    └──────────────────────────┴────────────────────────┴─────────────────────┘
>
> For things like MSI/X, SR-IOV, RE-BAR, etc. we're actually restoring
> from the kernel internal state rather than the save buffer state, so
> this is a no-op.  However, one thing in that list stands out, TPH.
>
> We don't yet support enabling TPH, but there are series on the list
> that propose to add this.  The TPH buffer space in the saved state is
> allocated just by the capability being present.  On open TPH is
> disabled and the saved state is untouched, zeros.  If TPH is then
> enabled and the device reset, the pre-reset save state populates the
> TPH save buffer and we restore that state post-reset.  With the change
> here, reset_done would then push the open saved state.  The live TPH
> state is enabled, therefore the restore pushes the original open state,
> zeros.
>
> This would result in a visible user change and maybe more importantly
> shows that we're relying on ad-hoc behavior, without really any specific
> policy to have this work reliably.  It actually seems like only in the
> close function, where we've disabled anything the user might have
> enabled, is it really valid to restore the original state.  Thanks,
>
> Alex

I was trying to see if we can remove the callback and still restore the 
device. The original reason why we wanted the callback, was to restore 
the device state into something sane[1]. Since commit a2f1e22390ac 
("PCI/ERR: Ensure error recoverability at all times"), which removed the 
saved_state check from pci_restore_state(), we will always restore from 
the last saved state. However, the last saved state in vfio can have the 
Command register Memory bit disabled (for example could be done through 
vfio_pci_pre_reset() in QEMU). This becomes problematic when we try to 
restore MSI-X from in kernel data and when MSI-X is enabled. AFAICT the 
msix restore path doesn't check if the Memory bit is enabled before 
writing the MSI-X message, which could cause an Unsupported Request 
error from the device. From my experiments, enabling Memory bit before 
restoring MSI-X state was sufficient to get the device in a sane state 
without this patch.

So we could remove this patch. But maybe there is a gap in MSI-X 
restoration path?

[1] 
https://lore.kernel.org/all/20250814145743.204ca19a.alex.williamson@redhat.com/

Thanks

Farhan


