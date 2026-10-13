Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D9329E79;
	Tue, 13 Oct 2026 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895859; cv=none; b=GnDWCWeL+6RshVRMOMnFTAsmvWIfO+lvb0gUokFs952gC0bq1IrmC9L/tZKMAFIOCgKsUN3auUj3wSXD6d5/se/aCMWeBTF3qQff+8XHVV4riOjwA++nCp9kMHEkpYGoJRWoifrxGTqT/ca5q1AfizFx2zDpVwx+yHsIkgZc9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895859; c=relaxed/simple;
	bh=xOcT/FyMedNAhkcjL67DxbYERLXgw1nv5WMnE4HCywk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGrpoh1eUxabtEm/bda29vsvBC2Pm4+RimIq90Ot31NQ+5KM2LqdWmMCeMoFUZd9AmDyFC2Q/NNTF2TNo8NvTV7VmVpd556jXb0ZOBlqwrZyxoSt07KMLJU68p2ZKJZ4jECuEUtxbh9qTZDuNoGgJaMFbrADob2nR4iy+yoSBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TuGis1Hs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TuGis1Hs"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EMCh1891191;
	Tue, 13 Oct 2026 12:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=efu/MF
	ZoXgLEsAtJbY10Nse927kme76V+A9AMZVtK/w=; b=TuGis1Hsz7Myx+1qHquFOe
	dc8KTWH8LipbyXErKxyuoRGi4LJ9TdVtrMX+iDc/DRYnoulQciBIVnIpA7iCqT9H
	iOYICPMRBIkPAaN25EVAQMuSy4PCahKhH9oH9jWGSYsYX/z4uJpAzC8lJkjfKXFN
	j8/dBESJmrGOPXt2axUDiYAVPNRXmeliL1nuhiWvAMaYthqhbolDuG6TE8gG4ZiL
	6TzSXrJ2MgVpeA1xyH6TS7p4bFjlHAh/0+UUR4PzxFeaizNWnPjWcG8breFvooaz
	+IyjheskQEeki1RBhL6azyoDxXZONiAKT7wAxz+khmhF5myTg1HTzNLdEaDni8Vg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3e210-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:50:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCV29e2712646;
	Tue, 13 Oct 2026 12:50:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyhjqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:50:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DCotb557606588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 12:50:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F240B58045;
	Tue, 13 Oct 2026 12:50:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ABC558052;
	Tue, 13 Oct 2026 12:50:54 +0000 (GMT)
Received: from [9.61.17.246] (unknown [9.61.17.246])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 12:50:53 +0000 (GMT)
Message-ID: <1c4b6c23-4bb2-4a8d-b057-89066ba2b394@linux.ibm.com>
Date: Tue, 13 Oct 2026 08:50:53 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/15] s390/vfio-ap: Add live guest migration chapter
 to vfio-ap.rst
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-16-akrowiak@linux.ibm.com>
 <sashiko-outbox-165442@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-165442@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W_Gpg_Z1mX1cfdsSH1-u7Ntsz0r-PIzL
X-Proofpoint-ORIG-GUID: W_Gpg_Z1mX1cfdsSH1-u7Ntsz0r-PIzL
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ace2931 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZoAj4-0bwIY6jiflxEQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfX3Az5IYcUf6ko
 qJnMhLJ/p47CO12SBJb7DKMvmGM/4rQ3lJMLCROOuUR8vT0RSFdaGPqmDo2CtoZNTVHtKIyFEpH
 0T7+GUtDpownglUjVn2qq9cjQVqEQaI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfX3YWr4cVhB8XI
 xF8xuyBTOhW+05dncK+7dQLHkFzHxyrLO10KpXVUhfH1k9CwcCnaOlvHhNYbv+aVgNUvbxJ2TU1
 vFzx0UbtkfBI3Az7/pzi1I6lokbqxKLuJrtbKvb38hA2VRdPrpByj7N4mBfhy9rsjQh83nqrqMe
 WaNnG4MfDpbp/EWYLum2eRo+S01iUZTM37sh66lUItmRR+fOL+J4e3IBHbQAoNT1BxBC84SCRIb
 ePvNSIqi4D6pQ4koWO6npw013efP7ugU8yycIbZpAw1wkEbc1NejK/o7uiMjh3f5ydJGUR8MURb
 JDNG9CikwsKJ21iGMDmMW+Yg1cy9OdN2u40dWLZMVAYL2KvGEw/wBSpxDF+M6jF/nphGoT/RlDW
 dJS204Fsf7DK1PtNpnz14i4ZDKcMhbFDHsl+qbH4yeAV7sTghC8lwWkKLxPeHGc7+HbSnrp7t7B
 /XoW/N6iimTYkMesjvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130050



On 10/9/26 7:53 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] doc: vfio-ap: incorrect host reference in destination host configuration section
> --
>
> commit b9b160f01756abd52de1ef4f9e6032ef6704eaea
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
>
> Add a 'Live Guest Migration' chapter to the
> Documentation/arch/s390/vfio-ap.rst document to describe the details for
> initiating live guest migration for a guest to which AP adapters, domains
> and control domains have been passed through.
>
>> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
>> index ac0c07f76ddd7..02d7cbe5e4791 100644
>> --- a/Documentation/arch/s390/vfio-ap.rst
>> +++ b/Documentation/arch/s390/vfio-ap.rst
> [ ... ]
>> +  * Display the AP configuration of the destination host with the following
>> +    two commands:
>> +
>> +    .. code-block:: bash
>> +
>> +       lszcrypt -V
>> +       cat /sys/bus/ap/ap_control_domain_mask
>> +
>> +    .. note::
>> +       The ``lszcrypt -V`` command lists the AP cards (adapters) and queue
>> +       devices on the host system; for example:
>> +
>> +       .. code-block:: bash
>> +
>> +          =========== ===== ============ ==========
>> +          CARD.DOMAIN TYPE  MODE         DRIVER
>> +          =========== ===== ============ ==========
>> +          00          CEX5C CCA-Coproc   cex4card
>> +          00.0033     CEX5C CCA-Coproc   vfio_ap
>> +          00.003a     CEX5C CCA-Coproc   vfio_ap
>> +          =========== ===== ============ ==========
>> +
>> +       Each bit in the ap_control_domain_mask corresponds to
>> +       domain numbers 0-255. If a bit is set to one, then
>> +       the control domain is available on the source host. For
>> +       example:
> [Severity: Low]
> Does this mistakenly refer to the "source host" instead of the "destination
> host"?

It should say destination host.

>
> This section appears to be explaining the ap_control_domain_mask of the
> destination host based on the commands above it, which display the
> configuration for the destination host.
>

