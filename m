Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C191F4C8B
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382229; cv=none; b=qHkl+VpdA9o9tdAyWZJ0mZ/8cAWElOOpSgac3+dXYzSxPuK8J36H5YxuU/CxijYRBGoygnIwlEDEXV97otwis+dXfqhm/KyrIo8UkqfL9Ni3yYaPlCVBhaoI6DcHtBnUwQL6mIJWBCTGhWqd9PTWvZewR9ssSI4hD0O6qRrZIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382229; c=relaxed/simple;
	bh=nPklMStIW5X9pKi/U0HPzknXDtgKxiz7hAySFCez4WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXaGnSSkEIuseEnMMuU5rwB2FWZIccU85PxNTTgnSbflJLVjBDh2jIv68r69b+OdjZadmmTu1lnNmLyG8p1ZUxvFUrq5GhFdEokuB9gIE1El2qIA139FxD//5HaURKPV/cBrK42imFCUEYQBuG9aMxQ6tBMU7pYsumJBRIuobCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jsKX8NUS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jsKX8NUS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B3k9Wb027441;
	Fri, 11 Apr 2025 14:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lflWBp
	ix65t6nCG8oLrcJYOGzMDolfccST/u3SHpunc=; b=jsKX8NUSXHLRH0TumZiZ3F
	l+PXedCVYcLljnolXTArThjUvgjdeze/jWZutUgAkcopAaIAYFVrFs2EaedKwm3r
	VoaLTljtfClon8ir8MCAksleGijx7Qtomkp+eNPgr9ycnp1MOk2wSEdN49s4VzMn
	xAvC4Cvecr3ZuNIkqIs/WGBpsDpLasN2ND2MH9wqvQ70+xp4jBXBqoeae/oUrkEk
	R+hxkKgV7x8vdu1CwdpUinpCMwqiSqT8mJDDzPYYeusQwfRg0JncW9o97Gv5L6AB
	YZHwYGrzyTY+qt1+BQitpMS3gJ3+Oa6qKYJATI4fEAxYSJi82l3Y7e0Z1H7dSpqA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xufaauvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:37:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BE1aAM011062;
	Fri, 11 Apr 2025 14:37:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf803h74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:37:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BEb0Pj41943356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 14:37:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E16120049;
	Fri, 11 Apr 2025 14:37:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2660220040;
	Fri, 11 Apr 2025 14:36:59 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 14:36:59 +0000 (GMT)
Message-ID: <84302185-8920-44ad-a765-489af7487639@linux.ibm.com>
Date: Fri, 11 Apr 2025 16:36:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/24] s390/zcrypt/pkey: Provide and pass xflags within
 pkey and zcrypt layers
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-24-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-24-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aip2l0L3N_QzdHrzTfVZKcls2qAafZ-a
X-Proofpoint-ORIG-GUID: aip2l0L3N_QzdHrzTfVZKcls2qAafZ-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=955
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110091

On 09/04/2025 16:03, Harald Freudenberger wrote:
> Provide and pass the xflag parameter from pkey ioctls through
> the pkey handler and further down to the implementations
> (CCA, EP11, PCKMO and UV). So all the code is now prepared
> and ready to support the currently only xflag ("execution flag"):
> 
>   * ZCRYPT_XFLAG_NOMEMALLOC - If this flag is set, no memory
>     allocations which may trigger any IO operations are done.
> 
> The in-kernel pkey API still does not provide this xflag param.
> That's intended to come with another patch which more or less
> only enables this functionality.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

Please change the component to "s390/pkey:", as the patch changes its API. The changes in zcrypt are consumer/implementer adoptions to this API change.
With this you can keep my R-b.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

