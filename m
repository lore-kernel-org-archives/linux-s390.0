Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D443AEF4F;
	Tue, 28 Jul 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235837; cv=none; b=Zf3qC300dK2in1GRI+c49z4JA3/mpKPKc+qFjv8EHVdekIpxz6DBWAKxMi6YWAtQd1XvMqWRLiNOYrr5pGeld9138ihyKACdEnZpKWys8WsgD/ySz6GF6ZiqENLLLfLGX1jeZJB2Va/ldCdFukXxzMbo7wMW4yEPA8ArVBhERxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235837; c=relaxed/simple;
	bh=pHODENAMAwfnGyLkSo/HZZl7Pu/8FmPJmTJlj4vSCsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QN7r5GaqAL7xg5tp9MBkLkXtLc2slKXgBvtyp4tEQl7PXHUxwQk/86YT4S57SDWgLyO5+SXYT5pjAkhmcXLBej0SD5v5kgL9JbaVMED3VOsNgjmz+tqRRhbhmhtslKtvIcertQfE+BJmLE7FHDi8UhCxj4CDwrOYR3J1Q7qOLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=py5KqViM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="py5KqViM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SAlm47896814;
	Tue, 28 Jul 2026 10:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/zZCOp
	bkYB37Wb7dao3TlYIKTkOEgSemVSQDkHXwdoM=; b=py5KqViM8w/N2HfQS5bTed
	PUslNNQF91+aFMFCQbDqSlJThm2+eMEkVBrKE/UixhCPZC/TeDomGm/JeLzeIDqY
	6U3fOUmfehurCdBqCxq7ExB2OpSM6bskckMwRvhuRngNMkL2d/KUEvnFfFpoCrm3
	bKMJ0JAVCB1F8GaAQOAoCaYupPhYoyt0w1oMbyqmTaN57WkwyasxSMu1S7AZW+Ep
	Qi4IBWsBLlk4L2mMQYXvPfDIhQCZFWYJCmHkH09r60qC4miBwt/soZ2odyDhK6/4
	8txcbJdzSx/awOMecjm/2xYJEkWt6T0sawdJWqS62rmev9av7cP+8Q0jlRzk5kpw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcv6dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:50:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SAfhgp021761;
	Tue, 28 Jul 2026 10:50:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw1jhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:50:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SAoCs127918818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 10:50:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C03842004B;
	Tue, 28 Jul 2026 10:50:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0A6220043;
	Tue, 28 Jul 2026 10:50:07 +0000 (GMT)
Received: from [9.124.208.66] (unknown [9.124.208.66])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 10:50:07 +0000 (GMT)
Message-ID: <366c7f5b-3261-4786-8a10-1323597af43f@linux.ibm.com>
Date: Tue, 28 Jul 2026 16:20:05 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/qeth: Check CAP_NET_ADMIN for private ioctls
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        arnd@arndb.de, stable@vger.kernel.org
References: <20260723140050.762991-1-aswin@linux.ibm.com>
 <20260727180644.0e97582b@kernel.org>
Content-Language: en-US
From: Aswin Karuvally <aswin@linux.ibm.com>
In-Reply-To: <20260727180644.0e97582b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: EmAYogU9qUEZJKZYlswdILgdhV7egqH_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5NSBTYWx0ZWRfX808sFjD/Ao0f
 Ij9jRkwtpua9EnVVpUL+XN3DYfLUCAi4HO80jMjz9vKRrIScN6ixWoEAWslJIUMCOqIVbEZpNp3
 T4EkZmgOpbFMtlXPIgyZ9RR+e/JPmZA=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a68896a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=GhjaPdZqsfwpqAw5TiUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5NSBTYWx0ZWRfXzl+QhZjIGvpX
 s7xDipQCVoJW4ceY8rkNLb7Fk8lLxU8oew1tcKLrKvKubkXx0HJ3ZNpB7jAY4Bh5PDCO29v6HTg
 keDJlRsrnywHcH7ZCREfi41sYUmvG0h8pZNMzpXCVUWhvHeaSQOdOJOfaHJIjYSEbK3Grwgjw/7
 /f1FInn/x/epYgC4AFL3KK7rKUBufITi+8jfe+2j1tlYE/SpwvdktegHVd4EGKDGygcHn9pS5BW
 1pIaJVimUJ+mEyFwzas5fpcBrEixIW0VzLPsedxmI5Oo/V7tBD/wnuNDhEUJuGDji0c783LG6vX
 sffOfYB3G75xiYrU+1Hcf93QTQD56hivIqAbBuVApoLJCuJEuirPDlZQiUvrw2mejX3UK3uERQz
 UXTmjxzrfij5l4okUqHUj/1JrjO75MnHdf/lKjrTo32RFuFOy/nDrXJ85vVrJ7b45S4rcBWFIjA
 f6M/NJV3JDLIa/fQagw==
X-Proofpoint-GUID: ykyNVfwhXSE1VLdz3q0fysdLIgzp5SXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280095

On 28/07/26 06:36, Jakub Kicinski wrote:
> On Thu, 23 Jul 2026 16:00:50 +0200 Aswin Karuvally wrote:
>> Gate the SIOCDEVPRIVATE ioctl commands SIOC_QETH_ADP_SET_SNMP_CONTROL,
>> SIOC_QETH_GET_CARD_TYPE and SIOC_QETH_QUERY_OAT with CAP_NET_ADMIN
>> capable check to ensure unprivileged users cannot invoke them.
> 
> No need to make this netns-aware, I assume?

Hi Jakub,
Thank you for accepting the patch!

It was concluded that the tools that make use of these calls are
strictly meant for IBM OSA cards on an LPAR, which find very limited use
within environments that make use of network namespaces, eg. containers.
Thus stuck with capable().
