Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E393F1669;
	Wed,  1 Apr 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060951; cv=none; b=f7UpGjOAnMKGP3igFiaOrLMk+PS4vYAYEeldiKix0FSuAYp4lrRc2FFLM7+T7WcQmd4PO4Jl4fez8fNM+ipAtJvrHn1mDRYA7CBUoObyj0kt+9oiCefq7ak4U5PJK83MSD9XxM1kkG5UsC68OITEoVlWyS9kHZc8357nYGcoIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060951; c=relaxed/simple;
	bh=lpKRatsiKjme51mt1hfc1a4RLa4UswyEdIlbv0MRluU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MASU5BiplAAC4r2ojV9Qe3Ns3K++vHV4NrXFHG1JrzA63avVfoBZJ8wGwRxlo5MmNvthP6p517ScUeaEMfmqsSZ1iLw/zqc6wARJ8ddFpehkLqdMuTyNhkhAdCg5G7QsZuqu8aOkAEFhSCFVgQzGRuFdNBrczauOeUC20SNp824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VYq58tWi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VYq58tWi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6316tLV03728917;
	Wed, 1 Apr 2026 16:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8QC9Fk
	+OLA7N5EuWutkyWpfjvL6o15fl0W8VJ8R99rw=; b=VYq58tWiWVgFmhF0JU2Amg
	XunKj9wOkBfJN6cR2hHSh3kPylzwj88drIvV0y9jdm6KgpQTbFF7iUZ8vV1RuBgS
	YFzk5gIxmicF3mVtpE3wuHTKVgl0uMnSnegOkOVm5fEGLYPiHheOjwSb6eRPTumN
	ufRvel/rGzmarRPGLlBlV6mHhrALus9ZfZjmbcr2dO9J6Anf38c8SCSvkdkBvja1
	lW650OYe+pmIamhEWRReaf4y18pyssf9KNHIjLKnyT92TRA+RoYs1sSjsWf2tFd+
	WlmSxgXQB0rUsdrKID6vMgrN2mUjk5YsfrG1ruJKyPR2auBs/LEnOknZMT/Cqp8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgrh93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 16:29:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631G4Eeb031034;
	Wed, 1 Apr 2026 16:29:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjx91e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 16:29:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631GT0NI33620568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 16:29:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E0C958055;
	Wed,  1 Apr 2026 16:29:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D9265804B;
	Wed,  1 Apr 2026 16:28:58 +0000 (GMT)
Received: from [9.61.244.25] (unknown [9.61.244.25])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 16:28:58 +0000 (GMT)
Message-ID: <d059a16f-4b17-4a10-9006-cf05045e6945@linux.ibm.com>
Date: Wed, 1 Apr 2026 09:28:57 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
To: Julian Ruess <julianr@linux.ibm.com>, schnelle@linux.ibm.com,
        wintera@linux.ibm.com, ts@linux.ibm.com, oberpar@linux.ibm.com,
        gbayer@linux.ibm.com, Alex Williamson <alex@shazbot.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, raspl@linux.ibm.com, hca@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
 <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE1MiBTYWx0ZWRfXwiDqhZdR7r2b
 2NeRzSts7j1FXaM+q1fLgqbT48zd1+k7VdnOq6xA8kmwEkPOLLBFCW+pGCs0iHDJmzvDU39055k
 LXkfSexkVXZyhAq6cj2j0LLh49DYV7Q6pegGgoQ2nwrsrLtYcawtydTxd4brFfhv83WTQkPKsyW
 ifA8IrS+X8WnsShS9kBnKY4fpbpGI+7DdJDKoxpmRk9n0SHXUyMdmGrwN4WxisHttBPRo/WCSE/
 Q0EETLleHswEmgOZgIWrqZJ8QmSfxs1mMap4F94rKazS3pa65uC9WtOOKwFmO4CEqSTX7sVtFgS
 KIQ70MVUnPlHZgXIEOKO76EhZpwP5kr92aR1rPT2JP521uN6g2ardtuWMMe7wLNnLtdpYDngxMr
 4N8/kVtRn4J6ludMUCM/dt74Haaktb57cwKBieYoZGt9uBfM+u8aUkTVg231s+keiphQCJzio98
 DAP/J2od+V1BV6RPawg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cd47ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=akap8JHnbm7pTVdsz3UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bfWW_YluBv6JnohcvqC4Kb3bOE2DEqql
X-Proofpoint-ORIG-GUID: bfWW_YluBv6JnohcvqC4Kb3bOE2DEqql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010152


On 3/25/2026 6:31 AM, Julian Ruess wrote:
> Add a vfio_pci variant driver for the s390-specific Internal Shared
> Memory (ISM) devices used for inter-VM communication.
>
> This enables the development of vfio-pci-based user space drivers for
> ISM devices.
>
> On s390, kernel primitives such as ioread() and iowrite() are switched
> over from function-handle-based PCI load/stores instructions to PCI
> memory-I/O (MIO) loads/stores when these are available and not
> explicitly disabled. Since these instructions cannot be used with ISM
> devices, ensure that classic function-handle-based PCI instructions are
> used instead.
>
> The driver is still required even when MIO instructions are disabled, as
> the ISM device relies on the PCI store block (PCISTB) instruction to
> perform write operations.
>
> Stores are not fragmented, therefore one ioctl corresponds to exactly
> one PCISTB instruction. User space must ensure to not write more than
> 4096 bytes at once to an ISM BAR which is the maximum payload of the
> PCISTB instruction.
>
> Reviewed-by: Alexandra Winter<wintera@linux.ibm.com>
> Reviewed-by: Niklas Schnelle<schnelle@linux.ibm.com>
> Signed-off-by: Julian Ruess<julianr@linux.ibm.com>
> ---

I think we have decided to not support any additional regions with this 
patch. Feel free to add

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>


