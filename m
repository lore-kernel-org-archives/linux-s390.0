Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853C43D515;
	Thu, 30 Jul 2026 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428834; cv=none; b=CS1jiiI18pED1tWGUV5Yq2u+5zeFpchomIbrcCZvHrH8DPW37tuBW0h21/F30z1NcdfsfigZHFWT7OQPWd/UwFLNTohRzDPit4ybvWx/tS+fATaqe3fnHCAcsX9h1DCaW/SjfGa7wOqbypwbkv0OpQKiWSMVjISHLFFxYYlij3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428834; c=relaxed/simple;
	bh=HupSaWUxAQikdFcuyhWnW1QDOAiZbKbh8EtT5MGjlM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT297pymHUYKCMK50q8/k2q+tiLoYUwdPRokbGVNkb8Lf083jGM2mLoWvtzxA3LPaHo5Kv2nkLnmUYOAYDFpdFh8iu8vwJakRZ8Hh+Oi0WbGVzbO88ZvLEr3C6F/q4E7/hNz7sePeXqUTdbCumGagGhxYrWEmXozFdnyEwQEOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e//4S/+1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e//4S/+1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFmA103354377;
	Thu, 30 Jul 2026 16:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F5u7cT
	slDZBYOB3ONe8QR3v9dJZrRwjMwhbbbnCEyP0=; b=e//4S/+1ol+PUNDuA6gDr2
	N2IBKaCGa/utoQAjxgAnLQbZLYD6qEcC/mTypjV6K0JZrMMjLRhmatp170QTvMMi
	OcV6aZAItq4hJ7cPLWxtPhCwF9NQIqOlcFJNgvsodPfPvkTl1Yb7wx+pJr1CYQ2w
	peO9kQA3L4qi6d7bITmO59DflV7aBDM/LzTXZuprOBtAWa016TRBvbKvnClqCRBT
	YDjDD4Ghoi4CaAjJcJ6ksbESgmTsy0VOF7ig6IUC+0Eiuky5tD21PsXfs9rDs6qx
	eZNE0Vb8z2JiWBpZ6Q/30OGwn01CYk6xVbwBpDiYdGnBL5UM0te6ULjiuEeEOycw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjfvjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQQo1010581;
	Thu, 30 Jul 2026 16:27:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ybv4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGR5RL44368156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7A1658059;
	Thu, 30 Jul 2026 16:27:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB32558058;
	Thu, 30 Jul 2026 16:27:04 +0000 (GMT)
Received: from [9.61.249.143] (unknown [9.61.249.143])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:04 +0000 (GMT)
Message-ID: <01d69d29-e20d-48f7-b4fd-d6a88cd64cc9@linux.ibm.com>
Date: Thu, 30 Jul 2026 09:27:04 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 0/4] [PCI] Error recovery for vfio-pci devices on
 s390x
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260720192505.2957-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260720192505.2957-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX2sXUQx53iIBV
 lhrb2Xh0O5VcFAm8xKIJblLneQgokjUYNOlWxTHfIf9YigGANYKgkXIChbyKPxKKnSyTjBJ5Tb9
 VqM44KYtersnvbiIU/wd303kNL4lz8o=
X-Proofpoint-GUID: GWMsBm_iVsUJLz3aXE7tHUWoPLGy6xQC
X-Proofpoint-ORIG-GUID: GWMsBm_iVsUJLz3aXE7tHUWoPLGy6xQC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX3R7a+jGdBurK
 I0da39FczsG0xF8iXc8PmZjza/Iis43avXaxS2y+cpdSi/28AfechSNb+0Xe0zF5K6qP7Gvhbxc
 wavQY4AOudMcEIGs7qMe9uy5jQfqAHgmA4sc80eQGbLR5oPqU56suP53IgYKBKFdCAMZhHXBcLm
 BrnTpfS5lSuYVsHEUqBRUUmZDLXB/YVRwEG5qhtVfcdlWRVTdCeR1YlAqz/K40XYqNQXDhUNEoz
 Qx4V/Ob8Qb6d4005Tf8L6c8JbbUkf83vcu9ck2keymhc7n25A1ShngH6CbopgsnHr5qaS0KfP4H
 E77X0S/8AX5SKjczXySGjlOgLsqgLD8cAmMXNWiv0hY+qng+f8FNSv67UTdUkKTzOrgUlzsb9qj
 ZKuoLh3lNhqLVMcFbSNMVj+H7JNVTPpOJxwvmg7NgSi5MwiW8XrfKIvmLBaVinFgtdCs/6YVF26
 TW8YZtaXL885N2TwHvA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b7b5c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8 a=2uVeXHBKdPZxKLczT7kA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300123

Hi Bjorn,

Polite ping for these patches. I would like some guidance on how should 
we proceed with this series.

Thanks

Farhan

On 7/20/2026 12:25 PM, Farhan Ali wrote:
> Hi Bjorn,
>
> This patch set includes only the PCI patches of the original series for
> error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
> series into PCI and VFIO only patches to make merging easier based on
> discussion with Alex [2].
>
> Thanks
> Farhan
>
> [1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/
>
> ChangeLog
> ---------
> v21: https://lore.kernel.org/all/20260630164807.643-1-alifm@linux.ibm.com/
> v21 -> v22
>    - Ammend commit message for patch 1.
>    - Rebase on 7.2-rc4
>
> v20 https://lore.kernel.org/all/20260622171840.1618-1-alifm@linux.ibm.com/
> v20 -> v21
>    - Amend commit message to include Fixes tag and cc stable (patch 4).
>    - Rebase on 7.2-rc1.
>
> v19 https://lore.kernel.org/all/20260615183524.2880-1-alifm@linux.ibm.com/
> v19 -> v20
>    - Unconditionally enable Memory bit while restoring MSI-X (patch 4).
>    Fixes an issue found with sashiko.
>
> v18 https://lore.kernel.org/all/20260603181647.2215-1-alifm@linux.ibm.com/
> v18 -> v19
>    - Move config space accessible check to pcie_flr() function (based on
>    discussion of Sashiko review)
>
>    - Fix a gap in MSI-X restoration (patch 4).
>
>    - Rebase on 7.1-rc7
>
> v17 -> v18
>    - Rebase on 7.1-rc6.
>
> Farhan Ali (4):
>    PCI: Allow per function PCI slots to fix slot reset on s390
>    PCI: Avoid saving config space state if inaccessible
>    PCI: Fail FLR when config space is inaccessible
>    PCI/MSI: Enable memory decoding before restoring MSI-X messages
>
>   drivers/pci/hotplug/rpaphp_slot.c |  2 +-
>   drivers/pci/msi/msi.c             | 10 ++++++++++
>   drivers/pci/pci.c                 | 32 ++++++++++++++++++++++++++++--
>   drivers/pci/slot.c                | 33 +++++++++++++++++++++++--------
>   include/linux/pci.h               |  8 ++++++--
>   5 files changed, 72 insertions(+), 13 deletions(-)
>
