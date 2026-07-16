Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCC380FF0;
	Thu, 16 Jul 2026 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225747; cv=none; b=jZzeyAKCYME5aI9wlr/O7WQf61bP6VsxlNZ0BVDIbBftc9GBwpxIljMgW1y+McIxkhsgdnUHMXztBaw1YbnFEwH5TKg+BNYt7Bz0U7f8coAu6lwKfxWud198dM7fH+RYwrLZV2jIaAWM8y1ResCeaakPrTXCTbCPDqucOBHIKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225747; c=relaxed/simple;
	bh=7DlLjnGAfqXDPXcm3OLtZobRyeMxl4go2FnFM3NtNRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOhF/Tds5Rx14CmEoK0QS7IFqTLhTX0nGtYUoWhMMP15tKl8WifOvEK1FiNErKxhPseoQIoe77evBnnuDp6asWT7Vp6sQkqEIKqOAVORqAKDpJdp1/FSG237uLO7yfNiOtPUhryspuZYof+YdrO4KlokIZJGXdL9L8dIZFQWqwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pc2iyuGz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pc2iyuGz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GGfm4V3764550;
	Thu, 16 Jul 2026 18:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7mGCqc
	rHEAISj9C7X36f74R40lZRj/Ex+1iMjRAaObI=; b=Pc2iyuGzTjssLFiDeBsRVh
	eTP/0U55Ee3a1XPXb/0IpqWobCLYgxdYvcDR7R3pAlV6gBQ2Hi6WThuMr1Du7OsG
	s/1irmDpuWms8GPRjHNMDeASmyZjCxwpVrZ9rTqLaDtbDkp4AkH2BMj63boAnTab
	Em0kASuPNHSkcBX27GpA6U0RiwuDNQqRdIyKcH4x0IXJkczbrYZeIarIk6RZYNjX
	iEqPsg1BjN1wXKXgA6oYLcy9ojLe7/ZLwVYSbUpgFe0sRjPYTen7sC8uwVNVU8fo
	vkk7i+EggPI11BDutu0pki8yXYZ+VDxKSfyJOgv/8F7tW7vsCIJWKHDJigi6LHEA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtje7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 18:15:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GI4bRX015328;
	Thu, 16 Jul 2026 18:15:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qeew8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 18:15:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GIFYoV721634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 18:15:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0C7658051;
	Thu, 16 Jul 2026 18:15:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 547345805C;
	Thu, 16 Jul 2026 18:15:34 +0000 (GMT)
Received: from [9.61.248.47] (unknown [9.61.248.47])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 18:15:34 +0000 (GMT)
Message-ID: <95f6e8f0-19b7-434f-a39c-7c07df67650f@linux.ibm.com>
Date: Thu, 16 Jul 2026 11:15:33 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, stable@vger.kernel.org
References: <20260715233408.GA271741@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260715233408.GA271741@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yAeQ4Bc5EBjE7HGtzxqb8IRw5k-AuxT9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NyBTYWx0ZWRfX9adY18yf4uDa
 BaGCHVcgOGAd55k8TNCMtLJl0vKtwemtIzhNEMQgGpXqZqz2f/7OX/+8lRh42xsgfPyhSEAzpXs
 nK2x15bhz/8y+yC6EVHW9BvWRlXBIew=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NyBTYWx0ZWRfX4VlfwwFJ4ZRT
 7PBhRFwDfTrhQqwA90r+H2nYZBYPJz6cFcv71dIaxV+hzvRNKeEgfHXDVnREy+loyrgKsgwxeFi
 ug8PobMGx8xvT2CZzHP1A9Nt3RWU8w5l63FTWMLrruRsF0XzIFjuY9/i12EHne2YIvecEKXhDhW
 DEVf/jW+0GNTfNGgq+fV9XsH0iISMEayYfnteyMoR3eSzj50GRGjASAgb27ccV2Ps082Qypcv3y
 t0JY+eWbOX9JSpk2qAO3iu/UTYG6fwSO1LQunsy4EANMaq19JIvejHjE8iLNqtwMMkthN0Y4qq8
 Xk4aOjqAB33t3XQY1lf3kMK95tAQhzr3BvR1UvmWStdzR14q9mpm+9rpztgWyDDwbGg6bCWQW2a
 I50HaL5vJwDmB/pSZMKR3Z6D7o1+ENcVpsAza0NXGeetE/aQggZqFY8KfGszE4PNLxxJQjpmUGd
 uJ6ixD1GVH6/ILN77DQ==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a591fc8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=11Pa_eY96Gjh7PQ_0wAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yAeQ4Bc5EBjE7HGtzxqb8IRw5k-AuxT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160187


On 7/15/2026 4:34 PM, Bjorn Helgaas wrote:
>> On s390 systems, which use a machine level hypervisor, PCI devices are
>> always accessed through a form of PCI pass-through which fundamentally
>> operates on a per PCI function granularity. This is also reflected in the
>> s390 PCI hotplug driver which creates hotplug slots for individual PCI
>> functions. Its reset_slot() function, which is a wrapper for
>> zpci_hot_reset_device(), thus also resets individual functions.
>>
>> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
>> to multifunction devices.
> PCI_SLOT() doesn't assign pci_slot objects; I guess they're assigned
> by some code that*uses* PCI_SLOT().  Since this says "currently," I
> assume you're changing that code, so we should mention where it is to
> help readers out.

Thanks for your response! I can re-word the commit message, how about 
something like this:

Currently, the pci_create_slot() assigns the same pci_slot object to 
multifunction devices.


>
> I see some Sashiko comments; those also need to be addressed or
> explained away.

Regarding Sashiko's comments for this patch, it mentions 2 issues:

New issues: - [High] Unconditional enablement of `per_func_slot` on S390 
breaks standard PCI hotplug (e.g., pciehp, shpchp) slot matching and 
resets.

I believe this is not applicable as on s390 we don't support any other 
PCI hotplug drivers given the unique nature of zPCI architecture.

Pre-existing issues:
- [High] Lockless access to `dev->slot` in `pci_dev_reset_slot_function` 
can lead to Use-After-Free if a hotplug driver is concurrently unbound.

Sashiko identified this as a pre-existing issue, so I don't think should 
be addressed with this patch.


Thanks

Farhan


