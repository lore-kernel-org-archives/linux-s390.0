Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536815099D;
	Tue, 15 Oct 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992280; cv=none; b=EzkZLdvfi2Ex4h7Gt6A2OtESsLiCD/7uJiVdEKgdlbQXOx46nrGcyZ0QhE6Sv81IPeQ5ZPmP4/OkHd7vDHxLPjlUJfm8ZPaIpQ2C5s1QCuuoJ+abLwGwTe+WMWzfLQ7qf17baAAf2LNJgBaso8TEBIjfH2Xq2/WtlX/6siItwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992280; c=relaxed/simple;
	bh=Mp5LBkZiogwKXLFgVrkl2Oob6N5swiOVSnVNN+KFfRA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AbJHol8LuFOLlPAN1H1KpAg3rPzFhJNuRwLbr2kQenMtjbUztVWbm7+2D5fHPJ05o7TTqzEVtprTnEhLFifDhUC6Ln5FVXvX3cMPfrtWZ0bd+dT/PlV6V6w1Ix/EM8yiRFHSyKGLYUIl/DFTqVIPI4KHkG/OSfj2WIdFbEEOyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AzjDaDxD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AzjDaDxD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAO3Ii004314;
	Tue, 15 Oct 2024 11:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Z9AeN
	+PQJnEfhjePDf8Qg5Vc1YctQ2jRFbUOMx6/a4=; b=AzjDaDxDvbRO3+KoXR6+1w
	JavBFdcY8+NNf3+9DRmG1YR44YxH9KNUW1dUqsdNMKWyHCln3S1YYi6Xa/qpQpUS
	yiEZkYaoeaOTm5ja1THSVl+dpiX/F/D2YeZ5fpaL6mL/GlcsrH/d0gS5y9vmqJxi
	WZ8ZCV28ewHJO1F9EkjnfkoddIJgvJVDyKEVxU/VL0a84fli8LEWRTtl0KxbxgON
	780nYwG11c/ZnLREvI8U47tg7ABlm8n5Xg81vDn8PaCnkWnLhguoDTTMKJQbaGQx
	B+3bwQPEmIKIt4P1nnJ5aVVF1sYxFvIvnP1YqqXDwO2C5bCBUBGQqKTnB4z/MEAw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429pkygafj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:37:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAsPfp027432;
	Tue, 15 Oct 2024 11:37:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txkm4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:37:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBbt5v38469926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:37:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD91F58059;
	Tue, 15 Oct 2024 11:37:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ECAC58063;
	Tue, 15 Oct 2024 11:37:54 +0000 (GMT)
Received: from [9.155.199.163] (unknown [9.155.199.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 11:37:53 +0000 (GMT)
Message-ID: <5295d507-a82a-409a-817e-c15847ebe850@linux.ibm.com>
Date: Tue, 15 Oct 2024 13:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] s390/uv: Retrieve Secrets Ultravisor Call support
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20241015112859.3069210-1-seiden@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241015112859.3069210-1-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _cqDxpaI3Hanw61PsA6sgYiVkwwfSrEh
X-Proofpoint-GUID: _cqDxpaI3Hanw61PsA6sgYiVkwwfSrEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=565 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150078

On 10/15/24 1:28 PM, Steffen Eiden wrote:

[..]
> Since v3:
> 	* rename BIT_UVC_CMD_RETR_SECRETS to BIT_UVC_CMD_RETR_SECRET
> 	* Streamline list_secrets()
> 	* Fix documentation styling issues
> 	* Simplify conditional in find_secret()
> 	* Add r-b from Christoph
accidentally added a 'since v3'. These are the changes compared to v2 (yet again)
[..]
