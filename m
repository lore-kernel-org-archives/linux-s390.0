Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB52367B5
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380972; cv=none; b=TlWzsYqHFo/abo/3KsmS+MBRBFLDWK+jy01L2C1/F4q9PLk7dHQwk1gMWBs6rbEftSYEffV7+DdNxFxxplbtqtk137ZiSXGiSOIOGYo+btltWdGrATF/x0e/RYzuaz2oFhN8MMwdOTjOwuUQxv4xQt8WAN8iGgKpXcEP4JXyFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380972; c=relaxed/simple;
	bh=RLTSEhlpEL3ScS4rOK+cKjliZ0x0AdPbTcUVTr76vAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKZ9i1N8RI9EKU4F4NQAK76L6riGa7EVFu5vzuA+i2g6xBtRHpycZo1od2z5ISZY99MdYGAsebeYPSrTsJD8j4XBObGrhV/Om5CiKPLZNQiCNmYlQsM0sPli+OYNPKcwASdLWjysH+7SsXomXceeGqQZyhdWEDtnRUb8XDRjs6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ejOZ1Qee; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ejOZ1Qee"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BE0Bg9027405;
	Fri, 11 Apr 2025 14:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZymNBb
	yrMJws/I96LLc3/9rRGdJ8A98NQDnmNkFhRWc=; b=ejOZ1QeeBVo/JrSlcOjoV8
	Ou1IJgSstXaq5EOfNy9IAJ009Jct5+PdPbM+geAf0Xku2K553aBsdE2SWs6su6ML
	8MJPqjzBrqQWG2WPTmoRugycEFG/097+9Ci9vT597RB/Lpgh4wr1UArDOzYZI4Qz
	szaH8+v5+PVBsMuTc4nqDI84uD3OIpbfcWxLUW2wYD225CSmPCNN8mvYAEv/doy+
	S9O/ZglVkhm2vYXBzyCTv6vW9jjiAgckDfFMDUKuR54BeJ+YmkoxoTmCq/v7MCrM
	YCMzRviU1lRulGuxq4rMx+PAjQsJ7d5ZezS+It3jj47IvIzCptQ6N+2dt5nTWGKQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xufaar23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:16:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAl9lj013932;
	Fri, 11 Apr 2025 14:16:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup39ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:16:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BEG2An59703564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 14:16:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E10A520040;
	Fri, 11 Apr 2025 14:16:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 460EB20049;
	Fri, 11 Apr 2025 14:16:02 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 14:16:02 +0000 (GMT)
Message-ID: <dda9a747-2d94-4506-8577-b63d74f4be09@linux.ibm.com>
Date: Fri, 11 Apr 2025 16:16:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/24] s390/zcrypt/pkey: Rework cca findcard()
 implementation and callers
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-14-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-14-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EtbnH1HY2jpPEFeiNWeYSA_uf2T2GerP
X-Proofpoint-ORIG-GUID: EtbnH1HY2jpPEFeiNWeYSA_uf2T2GerP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110089

On 09/04/2025 16:02, Harald Freudenberger wrote:
> Rework the memory usage of the cca findcard() implementation:
> - findcard does not allocate memory for the list of apqns
>   any more.
> - the callers are now responsible to provide an array of
>   apqns to store the matching apqns into.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Just a nit: Please change the component in the first line of the commit message to "s390/zcrypt:", as this is the component, where you change the API. The changes in pkey component is just an adoption of the API use.

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

