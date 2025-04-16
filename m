Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42A233D7B
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794389; cv=none; b=m3DGSvCCVCo0/teg8ejtvck4fudi8F4P2x6D8RfqvrtfY45YwHdvrUBuY2qy1IsM9MTCc74n1mCcc7M9ZDk0QLwiRPh355UlAvLBbPftGb8YIeLf+bQ/+kXxIkIFJtiFIKKR6A0xm+8urrX5Xhh3i99DK/uvDXWNjDASrMfG7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794389; c=relaxed/simple;
	bh=+i2p40QhgiXLaZKastLVZxCGuollhKuGNv7l3HMDpuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/YZRptzlgFZJw7Q1nyXMCdAlOa8NzgXyWJAah64WU+96GIfzhCy+nXA9hBy4wh6MUV5ZSOQeoK5ZsqZdsntbCfj34qA9ycjxujEMVVHL4L6uzpjeXjnBKbWz5JNhKp7SlNFb0W8iEubYkxauQcGDFrTBlPGTp7C0PA3R9xmqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lQeVzBHh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lQeVzBHh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G5ck2g022835;
	Wed, 16 Apr 2025 09:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TzCkHb
	YF/ZUzEQ+99y5vTBddPXVLVVs9GhfYjzJlp7A=; b=lQeVzBHh97aAnoDmHIbF9S
	cWTHTYQzftzYsAgf4w0EKHDNczJKVwqvYiqVr5t3O+D0sVtwgvktIeCexbbj2K66
	zy1Z32iqA3Scj2YcG1LBs0XrlHSIIBum80W1ckKYbiV63FSkoEQ2dzekUz0AYyqG
	zTthi9z5XPqRdd/SMewi89dVKS24hoYFl5a5dnbk+QzhsZ26TmKBXAOt3jtYpHzG
	hwFBoMRWiUtulUhxEWNePjDwj622dkmW4tIiPkztHZ/Ef41fZNT3XZGinVD8kJ21
	l9leESHmfzBx8E6HKagdTWbqMdiqKibnggot+tXdZRcAXpjRV/kBCalE3RMRjuQQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461ncfny8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:06:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G7Oxnk017204;
	Wed, 16 Apr 2025 09:06:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040kybsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:06:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G96KYV30278002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:06:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BE1520040;
	Wed, 16 Apr 2025 09:06:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE81B2004B;
	Wed, 16 Apr 2025 09:06:19 +0000 (GMT)
Received: from [9.171.38.231] (unknown [9.171.38.231])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 09:06:19 +0000 (GMT)
Message-ID: <ed37860c-3a77-42cb-bb06-244b8f44d4c9@linux.ibm.com>
Date: Wed, 16 Apr 2025 11:06:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/25] s390/zcrypt: Introduce cprb mempool for cca misc
 functions
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250415142438.118474-1-freude@linux.ibm.com>
 <20250415142438.118474-7-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250415142438.118474-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3EoXrGlJ21N3oLFGdmO0R5pyIdURNWGy
X-Proofpoint-GUID: 3EoXrGlJ21N3oLFGdmO0R5pyIdURNWGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160073

On 15/04/2025 16:24, Harald Freudenberger wrote:
> Introduce a new module parameter "zcrypt_mempool_threshold"
> for the zcrypt module. This parameter controls the minimal
> amount of mempool items which are pre-allocated for urgent
> requests/replies and will be used with the support for the
> new xflag ZCRYPT_XFLAG_NOMEMALLOC. The default value of 5
> shall provide enough memory items to support up to 5 requests
> (and their associated reply) in parallel. The minimum value
> is 1 and is checked and in zcrypt module init().

typo: remove the second "and"

> 
> If the mempool is depleted upon one cca misc functions is called
> with the named xflag set, the function will fail with -ENOMEM
> and the caller is responsible for taking further actions.
> 
> For CCA each mempool item is 16KB, as a CCA CPRB needs to
> hold the request and the reply. The pool items only support
> requests/replies with a limit of about 8KB.
> So by default the CCA mempool consumes
>   5 * 16KB = 80KB
> 
> This is only part of an rework to support a new xflag
> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

--
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

