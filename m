Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773F353A85;
	Mon, 13 Jul 2026 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966902; cv=none; b=qlBJhvo0fdhjuCCw2SkN2DCYr3B7ERyCoDhtsaT814uiqnqBj47QkTVC26iBOp780OfWaAYMpz2Bkdtga1Xh5Uq89R+4ZrxDvlWnukdvHNZHvpHPnMfV7Pd8A276J+Z3hLurkYOzf8968plFs/lxokgJFk9c2F2/ExElt3ugz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966902; c=relaxed/simple;
	bh=/wtvZXQk8dHl7nx+WqHqBTN6NjaZl9MwBV5LpHyjSbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iV2jUcVMeHlF72PLi+o7fufSAxey9p8Ncjkgg92p0j3QDc7jpsu4rpvNQANH9vSXXy823qU+bGbEvoEXbjzPPUe+WZPN6vhqop7/mnKTsFL6UvLArrGdTyugKIWrkmT0eBzsqj+Uk5jw7JlV0+PWa8dHnRdq//sMOYSrL5WZyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wri4PbOh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wri4PbOh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEZpD2833178;
	Mon, 13 Jul 2026 18:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2KowTR
	FgB52ZiLjBHaKUQY4xVTvQlighuuY235chHCQ=; b=Wri4PbOhVEa3+b8bM4Sn/w
	MAD99CmWHxTsiKdvSt/3KtJxULzzL15ksPhDDTPemeH3kD4ZW7fBoyqp/1V3nyzh
	6HtVzrEoDs4oR7BoxP43EzAl/mBKvMSnemyI6IrSHcAK3u4DAc9FGs22N19sVW1w
	2LYVHxBls/XifhSK2KnPKk2HPMlvzpU524407awggDuAeCfcY+aIMv0Xl1wz+aJM
	pRf+CYgEYtuyYR4z9q/pplnqiAfh21TIoVfo5wJMc2nRdKIGJm8ocwAbWzWLfru1
	eHo9JutYuuB/fmUGylvvEQxgZHO4hERcfeDf/NCeVLNWp9wyAfwBt9NNCyGqdCOw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbhuqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:21:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DIJgYp014367;
	Mon, 13 Jul 2026 18:21:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05py8he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:21:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DILXJn59506982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 18:21:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC7955805A;
	Mon, 13 Jul 2026 18:21:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AC558054;
	Mon, 13 Jul 2026 18:21:33 +0000 (GMT)
Received: from [9.61.249.24] (unknown [9.61.249.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 18:21:32 +0000 (GMT)
Message-ID: <030005d7-d87b-4eed-966c-5bb48ff31997@linux.ibm.com>
Date: Mon, 13 Jul 2026 11:21:32 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 0/4] [PCI] Error recovery for vfio-pci devices on
 s390x
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260630164807.643-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260630164807.643-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a552cb0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8 a=29iEHxvmWTY-H69hz_cA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4OSBTYWx0ZWRfX2TJ2lYc4Y6PI
 KfL+r1cLKOQlfH6ag7OMkp/t4bo3/CtIfQFCWbayYq9Bm4kyGr5pUPMR1SgN20zh27dwxBni2nW
 d0nU3Uc1tGl9on76XA19xPFZkw3LVilSdcTzmJWgN2gRrgW50ZM49lSPwFEKFp7vlS1M91ASaYY
 ywiagG+JrBjjPdl2nWE6iDMImzPLnN2sCwHQNpq44qMbZ+47S3ivWCxCWZrac30QPMIukBQrm0/
 J/uVDHnqgT+9yaarbjt1zDj2+NYeMtF4yBN5K299nhTz/6ndo/cDTKYyKuV9KFyn9AjfVfr2DvT
 0tZpq8vx/Qni089p7e7nQmLKX9ufYWYGXOtUejYAK7W0006XGQz3F5R05JfAfM7MfbaJhHnUEOa
 wJSO/BB4Oa7+lFm/GEfyKQ3dtRGdOTmey+Ny6dtwGkdsds5erHUNK6J+q8unyS4fclsq7bb3+Mm
 lp9KqDYNpIRSLRvWoYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4OSBTYWx0ZWRfX8tiMEbFElmSd
 /9DjGp3o6shVYO7mscmnty8f42s9T+k44QVXTXzBfEpYSGrLb0pi/XtP1JTbxiI0bqNzXLgQvB/
 zGwKV4B9p9/EECbVToCIPzzk9770dGg=
X-Proofpoint-GUID: DJ_XcHPg9W_54-WhCaqfAxr0JK0NrPb3
X-Proofpoint-ORIG-GUID: DJ_XcHPg9W_54-WhCaqfAxr0JK0NrPb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130189

Polite ping for this series.

Thanks

Farhan

On 6/30/2026 9:48 AM, Farhan Ali wrote:
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
