Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE43DA5A7;
	Wed, 18 Mar 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843241; cv=none; b=kUPBn5fLVuX433UNvzoeUPFHKLrefKpCY1WwZ9cX2cN/j86WiNQhcWbXNFQaAPt0j04EAbgShztJCF23VxtqOJQ/GH4e1cI6I80U0UfKurKLiOFdpowlXqss+3O37vjpBhuqGJBLilJQ1YiiSbZDCOHApkuyARewSZUmu96Furw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843241; c=relaxed/simple;
	bh=6RxeWkECCujD9dMdhImhEJXlb2vzMzEo22JNEPOhJy4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:Cc:
	 References:In-Reply-To; b=kXW0DEm4JOsK6y3XbkU/zZ1CeVXrjuOkTMnKMpDjtcPckMfykkViZRqy+AYb5ttezKtwGBe2j7s3fOHVwd4HMOMzlc4COli5+tJSUW8StDu+fw14EzVwaEcGVCdpNW/PaS0tEflw5CVtmfQeXTZfYk2gxQpGVWBQJyuoI8jVWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S4FYWV73; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S4FYWV73"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IBXlXS578436;
	Wed, 18 Mar 2026 14:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eID5Qr
	zlzlKT4t84DJB9BZmmuQuvHIu2U5GfHE71uE0=; b=S4FYWV73QIu1k5nZMbBuW1
	U7rRDAqqGMz4xXjePFjMea3RrmegZLKULaHdZZsYFDi/zo5gtvEybIyf7lXqgOg+
	Re3rRzzb/Ahx1Au+uJxAZ8gLMohLWC9WeBsgwQh0g/26esbdGVjoxhw57XE2oi2h
	4B4vWKEDZr0nvLieoe45atkKPszUntsYZbP+pmTmro3d3xinYYFI5zT+jd8vVI3X
	fX7HdMj+AFOZ96P8NVnoUPvJr3iuJuYflMgPxY+BX9w3i2asHmGJsjVpqvG0Ad7F
	lobOTfSeCWO4ljQrD0N0sUODESrpaSmsSKFSkn82XMFJrQKZTPhGn6XkEUe3rk8A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3j1v7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:13:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IE3eYk028739;
	Wed, 18 Mar 2026 14:13:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgke9vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:13:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IEDsqj53018928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:13:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 485BF20043;
	Wed, 18 Mar 2026 14:13:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3621F20040;
	Wed, 18 Mar 2026 14:13:54 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 14:13:54 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 15:13:49 +0100
Message-Id: <DH5YY1OWTESZ.1IFOYUF2D630K@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC 05/10] KVM: s390: vsie: Cleanup and fixup of crycb
 handling
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <akrowiak@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-6-frankja@linux.ibm.com>
In-Reply-To: <20260316180310.17765-6-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aFslOwtlHUOdsd1x_IC6TkUjneMFYYpo
X-Proofpoint-ORIG-GUID: aFslOwtlHUOdsd1x_IC6TkUjneMFYYpo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyMSBTYWx0ZWRfX63PYXjCQBwKy
 T/VgfwBfWTLO4PkI4clvL66Ujk31sDKlwwtpCdksL3mLatNxJ/9CJE57kEqZIiAFKDWyTEpWe97
 TbthbCsxT+PRT3iOnRLh6AxzwFwL5UCLAlvN9Bln++HjBt/qEcuwZXWBBCxyMOI3lstBYqOeKdS
 zdqMSoXCSNSbc6SPuwo0TVhEnmRD4XD7jSMkXblSVcsvIKavtE/CC2NQsVNTAWJyzctMqSsyCd4
 BSdi4z88MTVLc+QttW6MXC3GSPsGFQhosH7hHweWtpy7CzI1GZ5k4LB7YowA+O3+vpp94/rYy48
 dMYq+Viy72abb/BDsbmOCe24yrtJp44CBSnju2Y/70DKkMWGmEJ9S2wSjmufwQ7vGgfCfzOiTrn
 ABfKJLwwKhF5OINp5D14T9xaELOD73cjF+DZ1yTbt79BAalyVSBDjNYqSJsc1uHbrYPLuQ+DWpA
 40toWd5JAbB56WDc6Mg==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bab327 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=eATCta_MpC3rdhllPI0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180121

On Mon Mar 16, 2026 at 5:23 PM CET, Janosch Frank wrote:
> The crycbd denotes an absolute address and as such we need to use
> gpa_t and read_guest_abs() instead of read_guest_real().
>
> We don't want to copy the reserved fields into the host, so let's
> define size constants that only include the masks and ignore the
> reserved fields.
>
> While we're at it, remove magic constants with compiler backed
> constants.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/include/asm/kvm_host.h |  6 ++++
>  arch/s390/kvm/vsie.c             | 50 +++++++++++++++-----------------
>  2 files changed, 30 insertions(+), 26 deletions(-)
>
