Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410D1802A3;
	Wed, 26 Jun 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402636; cv=none; b=er736UZQroemEv9xsFzFonInbX5OWzZSgnNl0n6QmAFRya95EjHQVye/RHcE/S/jUB5pomSU4BhMDs+sjuohX3xGngZKenkv10tfM7fkD2GHFD1/HiXahyhLnlfoxN3c0I7/OLwenVtc/2A2NIZu2qgjs9YXBJKBvaVOFFaeuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402636; c=relaxed/simple;
	bh=ofPusKWLOwmUb2AYKGiawB8MhlRCDoTLrGx6m1Ye3H4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=haZTgdNjSrGUe2zwsaO6y/jbpe/0KLkmKKob9WqjJB9YgT5TzjgtyXPm0EZYN9ei4qf12ykRZxTJ3ERBkAsu+hVZrjjUxNqXsblzFR2lpkZE3+l+9YaVcj1DcwaContL546XoOAS51b73CgqsBtlaD/hoRxoC/lotSnTU2YoleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qxGdT6hO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qxGdT6hO"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QBRG1f022697;
	Wed, 26 Jun 2024 11:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	FuYGLcPJmc5EbSHey+hHc0f8H78DH+GPjDEIrdfzUOY=; b=qxGdT6hO51ZS7w22
	g7C9swHVwvULxwGTcj0JLifrzVXt7OzMTJ5EaL5Re5ZAA0wjoKnovU1dNBEn3X25
	rKK30DH16z7fTFXQAUBiMV2/KxaNZ20EBOSeoNvMNqWfQsR52uwndOPaQA3fEMu7
	HXWAW6CSlp95CDQ9xgxoNPg664ynUTMhXS8wOhuc85w23/PKGSHZFd/oRdaAET/3
	WD0iMjlOeF3u55J2CYVIH08KhS0DDBysEuIfygFs2q6zWQ2WCcPjkIenVHwLTs+Y
	kWgiuq8x8cnEyNRwEU2jsxSAcvRk3DFSblY2LczPhKWd6Td7CzUFMHGXYI6U+fZh
	GCpcCQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400hq803cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 11:50:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45QBm5xa019533;
	Wed, 26 Jun 2024 11:50:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xq47tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 11:50:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45QBoNdb42336688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 11:50:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B856C2005A;
	Wed, 26 Jun 2024 11:50:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E5D42004B;
	Wed, 26 Jun 2024 11:50:21 +0000 (GMT)
Received: from [9.152.224.141] (unknown [9.152.224.141])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 11:50:21 +0000 (GMT)
Message-ID: <cd626321-51e1-4e69-b043-a838d1351de7@linux.ibm.com>
Date: Wed, 26 Jun 2024 13:50:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/lcs: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240625-md-s390-drivers-s390-net-v2-1-5a8a2b2f2ae3@quicinc.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240625-md-s390-drivers-s390-net-v2-1-5a8a2b2f2ae3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3QEDTMdxbxghYG-mFRAI7qroOFu9LTMv
X-Proofpoint-GUID: 3QEDTMdxbxghYG-mFRAI7qroOFu9LTMv
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=909 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260086



On 25.06.24 18:35, Jeff Johnson wrote:
> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/net/lcs.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - Modified the description (both in the patch and in the file prolog) per
>   feedback from Alexandra
> - Link to v1: https://lore.kernel.org/r/20240615-md-s390-drivers-s390-net-v1-1-968cb735f70d@quicinc.com
> ---


Acked-by: Alexandra Winter <wintera@linux.ibm.com>
