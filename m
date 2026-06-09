Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9FACA6F;
	Tue,  9 Jun 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036055; cv=none; b=MWilCcaIryqFZKMV8iTi0JVOIWflSRNpiyz9ck+3fZVNjrIjVolIc2KXFB6NdRbSWlgjrsy3tOrPdgkTy6T7Ik23Ej0qm2n4qqEYBX+f4fMxdNbxtFxVDpkl2Tgs0dTObsLDt5IW7y6vOuMr6pDxA6ZY46iDyR8inJpOj/T4/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036055; c=relaxed/simple;
	bh=CCw9e4cIJ0DvSnuoe73jNvhqTepQYMQQShzYBmdoYks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bITCuoP1dA1kB8hbuLR+imJsYlUF/yhmX/n8e6Cx600Q2gGLoIvhQJwd3yMG3hpODDGZMvg3/dnH93S7r35zBI8tYwr+lCqo00eZ//CXDuIU8Kol+bvooXwVmw4XnML8OZXfgkYEGY0nbRBPYTyVfwegeVsBqcWvOAjVS1/BXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FOlggB2G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FOlggB2G"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659GwXNC3517755;
	Tue, 9 Jun 2026 20:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b1EuFD
	5/JdRorFhekNhQ3h9FI/JHvuGtQ59Ha7Att2o=; b=FOlggB2G+kU9sTBkDCXp3y
	qnfGRb3MPWyho6uE6bztomnIOQDDagjmLbCaJC967qgv5z4gnDPm7n9YOGJcf17m
	04139kRAbHg5XcP7syjTGlK7JvqWmTYCQ0OU+8dYPq1cKfc5CyoTQPlzRB0feUG5
	ENaOmVAOV2BILrzAcJuzJdKA7EIQ0j8mMF6M+idF1zc2lHDUe6SvKVhA6uZiBvqx
	LAH8xpPYqmv/czPCO4Ih5cjSGhB9t+u57QIb0UNurU1pxmYyXfK39GChBbeVSw3y
	lGzZfXnnAfqUk9HbAKv8YbuH6fApRmslGUMaw73bXc997FmbT3y//3feikTz1/RQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6swrm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 20:14:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659K4bPl024613;
	Tue, 9 Jun 2026 20:14:01 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq3uje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 20:14:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659KE0Eh26083948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 20:14:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 808B05805F;
	Tue,  9 Jun 2026 20:14:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62A6D58054;
	Tue,  9 Jun 2026 20:13:59 +0000 (GMT)
Received: from [9.61.252.141] (unknown [9.61.252.141])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 20:13:59 +0000 (GMT)
Message-ID: <58f005fe-e142-435e-83a2-5e4a97773406@linux.ibm.com>
Date: Tue, 9 Jun 2026 13:13:58 -0700
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
 <96c749ba-1b42-425f-8767-a3fce4a4d30b@linux.ibm.com>
 <20260609131604.227218e8@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260609131604.227218e8@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ahlGqtTE4HNqzNXdfITA5PRnwwE2fO9K
X-Proofpoint-GUID: ahlGqtTE4HNqzNXdfITA5PRnwwE2fO9K
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a28740a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=_UdKb_X6YVE3caxwgHkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE4OCBTYWx0ZWRfX4ni6VVXONf4L
 7DQjYsVRpFxumXK3FS3rq4jU9Quo47MlV5QTyzYcvF6r2PJDQX9im1xsOm3e9oxB1iRoTHqxqy4
 f9moqpMANIeyF1NRMm/P9LZwx3x/Qj8cIe8X4eXfdrQ4iVp+W5jMTP4xfVql+ZMFOv0irVF7/fI
 /2uJKsCjZuZhWMEcjP7qCILKwB5y1lkSs2ey+upGxNYzQKJvKV4TGiKbaICL1QiJEhZOxAGlD6U
 owAG+oJlIVTvTs8F1ZL7qyFSy4493PgDu4+bhttS1L5DS0NMDYoLakuUedajlu2t/NB03ZOAwkO
 GdGLycqrZ1QtWloH/CPjhfYezJYsFVGQqbUcozlNNK19qLIz6M/6iaUIB2AIbj6M6tWB0FIWMS2
 1CxwCF8AtJoyLt0/YOU//Pk7ECm4sbEeI9IxfNRlI+zY3+QYB57X2JzAFZ9F7zLF5pezfqfhNa+
 5G0e1n1xMkoNcGJ+jdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090188


On 6/9/2026 12:16 PM, Alex Williamson wrote:
> On Mon, 8 Jun 2026 12:26:36 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>> On 6/4/2026 12:57 PM, Alex Williamson wrote:
>>> For things like MSI/X, SR-IOV, RE-BAR, etc. we're actually restoring
>>> from the kernel internal state rather than the save buffer state, so
>>> this is a no-op.  However, one thing in that list stands out, TPH.
>>>
>>> We don't yet support enabling TPH, but there are series on the list
>>> that propose to add this.  The TPH buffer space in the saved state is
>>> allocated just by the capability being present.  On open TPH is
>>> disabled and the saved state is untouched, zeros.  If TPH is then
>>> enabled and the device reset, the pre-reset save state populates the
>>> TPH save buffer and we restore that state post-reset.  With the change
>>> here, reset_done would then push the open saved state.  The live TPH
>>> state is enabled, therefore the restore pushes the original open state,
>>> zeros.
>>>
>>> This would result in a visible user change and maybe more importantly
>>> shows that we're relying on ad-hoc behavior, without really any specific
>>> policy to have this work reliably.  It actually seems like only in the
>>> close function, where we've disabled anything the user might have
>>> enabled, is it really valid to restore the original state.  Thanks,
>>>
>>> Alex
>> I was trying to see if we can remove the callback and still restore the
>> device. The original reason why we wanted the callback, was to restore
>> the device state into something sane[1]. Since commit a2f1e22390ac
>> ("PCI/ERR: Ensure error recoverability at all times"), which removed the
>> saved_state check from pci_restore_state(), we will always restore from
>> the last saved state. However, the last saved state in vfio can have the
>> Command register Memory bit disabled (for example could be done through
>> vfio_pci_pre_reset() in QEMU). This becomes problematic when we try to
>> restore MSI-X from in kernel data and when MSI-X is enabled. AFAICT the
>> msix restore path doesn't check if the Memory bit is enabled before
>> writing the MSI-X message, which could cause an Unsupported Request
>> error from the device. From my experiments, enabling Memory bit before
>> restoring MSI-X state was sufficient to get the device in a sane state
>> without this patch.
>>
>> So we could remove this patch. But maybe there is a gap in MSI-X
>> restoration path?
> I'd say yes, that's a gap in __pci_restore_msix_state() that it's
> writing to device MMIO space under the assumption that the device
> entered save/reset/restore with memory enabled.  It should really force
> memory enable to be set around the access and restored after.  Thanks,
>
> Alex

Yeah, that makes sense. I can add a fix for it (in the PCI patch 
series), and will remove this patch.

Thanks

Farhan


