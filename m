Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E6168BD;
	Mon, 26 Jan 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449101; cv=none; b=p8aOVWz5qPXUEssh3ukn5LhkuCEF2m6OHNe1+BM+dhmxexV/3B+pNcOSvD8h7bZwpJZwGK0wQMDt7kHqiUL3qdnfcPc82i092sfFcVZe4iwOSlgNEBCzVU2AEYmaiQsf4VCBG4Ex+0PwFXQ9+HROBNPNmkK97C3UG4Q1Nfw71jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449101; c=relaxed/simple;
	bh=7tZOxm/f9TWhthbZfH8e1dR77+9Yhq9V3GEr567lFgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lihwa6A2fCm/rjP4B+6UiztUrYDZuHBRSs9ax8qmEFppUChQY4Y1Fo9Rbsk2LHLE4flyBmVRl5yJmy221R73xGWEducvbiSp8nzM5ika6vu/07E+KoWEexE+MyUHXgcZdEXOhQ20NskO9csNbaHmiUHt981GwKDGa63xgILSOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IbyBwK12; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IbyBwK12"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QFsxO9016363;
	Mon, 26 Jan 2026 17:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tGOfEE
	XHGWGecGMH2ijG4TDmUOUPYZs4bsHOugMcYYw=; b=IbyBwK12jbAJCj92DO64+l
	91yRe/fVGoJCP8fdagOHeLtblG/fmWQz6L3htkIlCDivjvc5LJpMSGpIUFCc/txf
	ogGZtAtmHYtUMgaGRRJbOtoKUP3gNW6x4LaL6x0300U459/KRAhJqd8BYT5IxSBS
	rMeFm1OZ1yNBuT56S/0D3F6YpBpCiKIyGk11i8sP/MoMMzblTHdvvLRjmWLH6SJN
	ulkT9ep7Ki9yLy5FaLR7LWpOMVnLz5NS4hFTMe7IEnlgiG9oSmL5hiS2IOsdVw3y
	oDase11VaLIvdnF66yPrYgFSh4LEg2HrLwewL7F2oFHZ95+1BX2m54vvLrx/jQ9Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7hae7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 17:38:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QFeP14006741;
	Mon, 26 Jan 2026 17:38:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy5m6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 17:38:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60QHcBor30933586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 17:38:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6834758058;
	Mon, 26 Jan 2026 17:38:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EE155805D;
	Mon, 26 Jan 2026 17:38:10 +0000 (GMT)
Received: from [9.61.248.165] (unknown [9.61.248.165])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Jan 2026 17:38:10 +0000 (GMT)
Message-ID: <6acb9f29-28bc-431c-bf72-099d698add29@linux.ibm.com>
Date: Mon, 26 Jan 2026 09:38:10 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] vfio: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
To: Julian Ruess <julianr@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260122194437.1903-1-alifm@linux.ibm.com>
 <20260122194437.1903-10-alifm@linux.ibm.com>
 <DFYMO05UXGKY.2HG19ERN69ZUW@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <DFYMO05UXGKY.2HG19ERN69ZUW@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rPdC2KTTPVsWVVy4G-isNWMhQ7hAatVy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE0OCBTYWx0ZWRfX/fywO6AVPmjc
 ztfRVJ0mCNailQ0dQbAiObue3WIpOXIlzjmAflBsy4EJqE0geWrBv4ccQARnHaRs/iU28Z8kt7y
 Pa6jGJhvxy1fXGfUWbnw6Saw3be32tpidm6L3RQH2baL9CKdmHAyd9sOMTK1DBFPcvQeXWFQuC7
 E7q5t9rCZurvfvLqapy6s4SBWtY4eg61/MZMQXZpe1Q4KRSFzZPB62urZX99M0yqBjTBOnO6vEx
 p/iuD2HoCWeTlT/72wiDzUT7f2Ol7dKFcz163rh9rpz7hMCDG+vlI8JdsA5Z3H591oIUC/vVteo
 yBCZmzXgnP1SUeJ5Fknmm7w3fE88BCvH0gUfZ35lo/VVhnM1ZNvE7iUw+O+Vt5p7FF0aHBpMVLa
 vz746CHYXfYOjD9sPZoviY2g/KQ0ML53lEDgAekB+fkIanr6U2iWYTbs5gE0WOpt3uOn7mao5Cp
 AB95smGsOE5kJ+rX+rg==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6977a686 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=q_SdFccrKIupyLLHt0MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rPdC2KTTPVsWVVy4G-isNWMhQ7hAatVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601260148


On 1/26/2026 7:31 AM, Julian Ruess wrote:
> On Thu Jan 22, 2026 at 8:44 PM CET, Farhan Ali wrote:
>> We are configuring the error signaling on the vast majority of devices and
>> it's extremely rare that it fires anyway. This allows userspace to be
>> notified on errors for legacy PCI devices. The Internal Shared Memory (ISM)
>> device on s390x is one such device. For PCI devices on IBM s390x error
>> recovery involves platform firmware and notification to operating system
>> is done by architecture specific way. So the ISM device can still be
>> recovered when notified of an error.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
>>   drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
>>   2 files changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index c92c6c512b24..9d44df9e21db 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -778,8 +778,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
>>   			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
>>   		}
>>   	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
>> -		if (pci_is_pcie(vdev->pdev))
> I'm wondering why this pci_is_pcie was introduced here in the first place.
>
> Do you have any ideas?
>
We actually don't know why it was originally added. The change was added 
with the commit dad9f89 "VFIO-AER:Vfio-pci driver changes for supporting 
AER".

But after discussion on it with Alex, we decided to remove the check 
(https://lore.kernel.org/all/ffc2fc08-2e95-4b35-840c-be8f5511340f@linux.ibm.com/) 


Thanks

Farhan

> -- snip --
