Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27532FA30;
	Wed, 12 Aug 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560800; cv=none; b=Yqk7Hn6/ZwRXBpN0H1iero8J/hn0yxHsu3Dfd93qYdCth+k0VKaJu8aBvi40ZYZuaLmOiaef9ChtfdFq86Xj2iVh24p2w2CUvmP1mTrI4jwih2h/wUvwkEWpaJMMQEQycyqH6750Hf8myHHBGJRmMyt+mgIelV+ei5h9KZU8oKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560800; c=relaxed/simple;
	bh=+CQXRZ0fEpu33udvolvOqO5FMhh3EGATo7nk5lKqLwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jt1ufLYz47M1EyOiTxua88xYz/c+vKTLJ2ejJ30q6CsShga9dTMMUPAZepgxu9dz7nu5npAcRcu1a3GjVImkZjm3W2rdNnwthLTzHUJgsAcxoVZQwL7j6dFlCwGChKArUqAO0F84WndyiL0gm03AtCxroX7Hn5R+ehPJNiH4gc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JYHJlBhW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JYHJlBhW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1TLY4087968;
	Wed, 12 Aug 2026 18:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qtp0/g
	4ndl8vv74gruu5LyCZ29Fm/k+4cINN0PDRcfA=; b=JYHJlBhWyGi4vEbqZs0WY4
	2IixDp5b3gR6jtfNplguR+8S8QFltfe0leQsE4/Bj6MCCOBDYBnqF8X93sh7kZdk
	0fmUIsUe89UDQWDVME2KmakbR5HfNLf//lw6NnJ6TQV6DMJ19uAMqPRMVTNF4W4L
	eSCNutwGN/hTFnTVFrLMeealfqI6r3CN0h51wdjbp1KgTf8F9qNY5cJ321X0C116
	2nHFJDZjiWG7tsZU+YAeUC6yOGJ02OQV7o72olks2wfQiXAf6QQwUhYlPMmfwIdW
	FZbZvLFqUw30KHQB5PIBP8qVHTjuMppo7l6YBJZoyXuHd2f0DFCSH05XXMKe4I+A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9v6q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:53:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CIfVSQ022083;
	Wed, 12 Aug 2026 18:53:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w7mbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:53:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CIrBqP1901292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 18:53:12 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D273358053;
	Wed, 12 Aug 2026 18:53:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F68658043;
	Wed, 12 Aug 2026 18:53:11 +0000 (GMT)
Received: from [9.61.247.231] (unknown [9.61.247.231])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 18:53:10 +0000 (GMT)
Message-ID: <f253be6e-35f0-4cc2-be6c-79f6676f0171@linux.ibm.com>
Date: Wed, 12 Aug 2026 11:53:10 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 0/5] [PCI] Error recovery for vfio-pci devices on
 s390x
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260805165518.794-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260805165518.794-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0OSBTYWx0ZWRfX/yiN4HyNWESO
 s9TVlxIcYcAVC/T5EcNzCCVd9sk750h6WgSsFqv0nOpsLhtUTMxfcicU59uqryX0y+tLlhNBB33
 4iQ6tvjF0ZGoaKB3XrPDuB1bh7FDgAT7erXzxg4oxabg9LV2UO6U4067G2jjs3iRdS+FWTQ2pZt
 LSjRoUdsHKNOR5Phqc+X5dfdYVaybTex9b9I/HF+3aMkGnsEyMOIcOu4ZOOHfmXlYmbWV2UHyPr
 gFCiUQZYEAcUQMqzBijzUjcyPKxEPAHeOA8OdkiN+FAJYSxd1VhpKF6VbZJid/vabyZqmpp/LGF
 aaa+hUgX1NdT96TtH3v0ecet68ChewshK9TztzcfsOEkn/EahyxmnnWdhwMZzSF48DBLaSaxuml
 N6s+S7+h/kpD4zwrwg3ZmoUG4OTi4yjAFvOGoszcPjsUxlT8QzhXKg3rdIDTXj5PP4xi7Q0B4yB
 KZfp2SgIKdw1WKsiE9Q==
X-Proofpoint-ORIG-GUID: tj6lJJ_B8AxUO-zVHz0Qj_kRFHX5_Tez
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0OSBTYWx0ZWRfX4rbqHjseqWSx
 7fnx4JOHXULBXwYpBF/cFod9foIpPmfOCZfptshXfZRSKjdfrcsdxktOdnP8+VpH3Wk7CKwWY6u
 q2Qs3AeM9p2OhGHOFNwNQbWlot218lI=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7cc11a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8 a=2uVeXHBKdPZxKLczT7kA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: tj6lJJ_B8AxUO-zVHz0Qj_kRFHX5_Tez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120149

Hi Bjorn,

Polite ping on this version.

Thanks

Farhan

On 8/5/2026 9:55 AM, Farhan Ali wrote:
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
> v22: https://lore.kernel.org/all/20260720192505.2957-1-alifm@linux.ibm.com/
> v22 -> v23:
>    - Split placeholder constant into a separate patch (patch 1).
>    - Rebase on 7.2-rc6
>
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
> Farhan Ali (5):
>    PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder
>      value
>    PCI: Allow per function PCI slots to fix slot reset on s390
>    PCI: Avoid saving config space state if inaccessible
>    PCI: Fail FLR when config space is inaccessible
>    PCI/MSI: Enable memory decoding before restoring MSI-X messages
>
>   drivers/pci/hotplug/pnv_php.c     |  2 +-
>   drivers/pci/hotplug/rpaphp_slot.c |  2 +-
>   drivers/pci/msi/msi.c             | 10 +++++++
>   drivers/pci/pci.c                 | 32 ++++++++++++++++++--
>   drivers/pci/slot.c                | 50 +++++++++++++++++++++----------
>   include/linux/pci.h               |  8 +++--
>   6 files changed, 82 insertions(+), 22 deletions(-)
>
