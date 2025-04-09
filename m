Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646325B66B
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193627; cv=none; b=jS1pYSlZdgf2mBFYsZ6ZGCLsimS76H2D6z7xhbmFWrCwCnm3T4n4i9xYfXewiXoetCzcAzbcomWVv+rXXzgeic4iYxGWLSjMWz5qVtLJaDOc27emPb6oy0Lf+oknTTKpcoL+bIw5/cdWMd3dxNTyATWbGq9pprPfUNRrDD5IREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193627; c=relaxed/simple;
	bh=pJZJl6lYmCy8AeRGvXuuCIdZuRvKeI6cSYEePEFyZNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etJY689Ztvd4CNxZTfSr4LR8tuMb5naTLZ9CedN7QKJ1150MuCpBAotOXVO71iJeyi7w3wnHzqLCkcTyoEjXagcLQ/DCEQQ5PBB3sWsXtxSLtiXNdhqU5xlecc5U1FQoZFS8AS9Sr4H/fOhxBCIfnEuJQFLVyt3wO2U37QBNboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NZTPanW4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NZTPanW4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399L5XO027009;
	Wed, 9 Apr 2025 10:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Mzh7z
	402UV5DfbKsPriwhww52oV2qhJDADPBdO/WhE=; b=NZTPanW46EKpw3BCQtejXF
	sYXr3MwusdJW3YAE63z+JbQyG4MsMg+veICiPLaNLoIrDs2wfiPKqt5isJvm/gwg
	Oou/J4j/Yxes1UWCRcYcuqQLLe7lBfeKkzLIK/Xil2HjT5jdnISCX23zXgspwOob
	WYigmmiSZHsU601+Or0Iz3wkYN07AcJ9ARO+ZW3J04bgDpsU5wugHSoZZqBXmu0c
	kgoNs/Eqw49wKap1P8Z0b1LtO149lXA/xTYGMsI7cwDOgKLCXcqAeD51raVMejqR
	J0B+P8YFKW12an9FKBa+6sLu7CMtjLYfNjMI3lTMJRAZskYmB19nissYXpLfXp6Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wb10jvh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 10:13:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5399RlfO013823;
	Wed, 9 Apr 2025 10:13:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunq5d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 10:13:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539ADbeF34931364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 10:13:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC57C2004D;
	Wed,  9 Apr 2025 10:13:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C98520040;
	Wed,  9 Apr 2025 10:13:37 +0000 (GMT)
Received: from [9.171.58.154] (unknown [9.171.58.154])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 10:13:37 +0000 (GMT)
Message-ID: <ff600a27-b255-4d3b-ab2d-a6e9023ca8c8@linux.ibm.com>
Date: Wed, 9 Apr 2025 12:13:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/21] s390/zcrypt: Introduce pre-allocated device
 status array for cca misc
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250327143941.45507-1-freude@linux.ibm.com>
 <20250327143941.45507-9-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250327143941.45507-9-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EzJc4gevSiYR2p4uTHUZuNr0Z0cBbFHK
X-Proofpoint-GUID: EzJc4gevSiYR2p4uTHUZuNr0Z0cBbFHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=912 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090054

On 27/03/2025 15:39, Harald Freudenberger wrote:
> Introduce a pre-allocated device status array memory together with
> a mutex controlling the occupation to be used by the findcard2()
> function. Limit the device status array to max 128 cards and max
> 128 domains to reduce the size of this pre-allocated memory to 64 KB.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

