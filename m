Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608534446F8;
	Thu, 16 Jul 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226011; cv=none; b=lYQ0wtMn3NvJ2WLTQ1J8TT4aF1/PWg2rk/Ipf5IyA16dXP8ujR1lPF/I6IHVh0iFW3VUJ/KjAVV33VT+M+V1kjIK6L6kZVjQdp7brMcIr0ODbJGlJzZCfkwFcyTMD/2jHUHqjYsCOUEHTjUJG6fBiqQR8Iksq3VAAMTHtgC0vlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226011; c=relaxed/simple;
	bh=7DlLjnGAfqXDPXcm3OLtZobRyeMxl4go2FnFM3NtNRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nz1MY/umRnS8VOYD6cq6IzQQY4cQCwhjPLyVNR0IreuWA8h2anwJJJvGuI1Om1WiURX0fZuHyZCeQ+s+znFpUxMo5tuq646CorvFnG5PQNh89dz1PmPXsxuQ5/BvcwFMH3ZxglE3q5sFZLXHu99qjXUcC+JrCPS2sBPT79yYwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y/8Ip34k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y/8Ip34k"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GGg0tO3755250;
	Thu, 16 Jul 2026 18:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7mGCqc
	rHEAISj9C7X36f74R40lZRj/Ex+1iMjRAaObI=; b=Y/8Ip34kz7NWlA8vhZ07ci
	0+aa05U7Wm5x+YGRfNjdHE+FfJPbT+oxOJS0ruhNmajTg7+P51d/XXWHWbcAp+yR
	BldtCsQkePW49ISYT3f6M8IKBgBDeUlwjVau1G6ohHy9vCPHxlA6tdFP5GoeGLZG
	DVqlLraHKOrhAhyJBy2uZqY5UoVd8ck3OVqqX27/RNQFuOX+TJX6jptbH/wj5yEH
	wMBieaIMU3we97rJ1nOOUfa8956onJcrp8kEmRM/KoSwmhGmeu2WzbWCERIfSnul
	bt0+ktfDa92kcbTYHrUMcQnmHEHT2W0KmpdWG34yWLZWcvcRPGGE+r/UEk3by3Pg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxtd9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 18:20:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GIJbBr022735;
	Thu, 16 Jul 2026 18:20:01 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgp2ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 18:20:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GIJlGL20579034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 18:19:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6042758055;
	Thu, 16 Jul 2026 18:19:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5CA758043;
	Thu, 16 Jul 2026 18:19:46 +0000 (GMT)
Received: from [9.61.241.122] (unknown [9.61.241.122])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 18:19:46 +0000 (GMT)
Message-ID: <04d517ac-26a0-4572-8ccd-f1de4c8dd2ea@linux.ibm.com>
Date: Thu, 16 Jul 2026 11:19:46 -0700
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
X-Proofpoint-GUID: r8dbtkvE0V1JuIPXPWML-marVsVwRveH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NyBTYWx0ZWRfX3GHDD0FhSAD7
 xWRE1uzLxvZEJeX8tvIbxTZgRelPBx8CimRcPVS8EX/HjuGMH+VIwKCLiMoYBfveWFAHzeQd8RM
 1pjygmBFSBhSxGswQyWlS35tqCReFVc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NyBTYWx0ZWRfX9BImfSN1Dzfw
 pYp0Kf1D03eAqAjxoHqpLzlBkjPnw2DwYqb50Cdc1C7nbOBxEirryP8cqcuI7n+j+ML/2uVp37A
 fKP4l5PBtgLbnHh4RnuqaXKtFL7eV1uay3LbPF+GaNi71JeQ0/7e22iXi2wIn4qaZPkjjlzvAr2
 hQ8jT88WcGZgvh9pmD3qGnfUBKNQQ9hxxMPf0dAfKOEQk6XKJ1VuJAI+XvMURbg5OBU56NwwKgS
 OJGocI3XMUwF5MPfKfmTMTH/E3KWf7ce4dmUpJQZgsdu8D4CB7XyNIkKRaasAGYCtL+tZs3gRIA
 0xFwfENvq1qjgWyvHvy8boOBN11cifAIygorrCcMNh2Ihgi2hfMKKDGn7OLBW1qNI1OyUt/QW5v
 68HRjl1jWhFX4V2Bhl/keItDXHYVDUervhcEjwT+nPWdrNFGff5zFs3mjXTBLGQ2LKO0RKag1R3
 PUWDA72b2kHunmY9wdw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a5920d2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=11Pa_eY96Gjh7PQ_0wAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r8dbtkvE0V1JuIPXPWML-marVsVwRveH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
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


