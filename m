Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16214D29B;
	Fri, 14 Jun 2024 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364871; cv=none; b=Dqlmv27D/ArUawCTcANHZ3BE5ZK5AGXU7W+uIblGZzcFCY09kNTeo3+YeAxmGwiVe7J+vnwc2Uv/Xydwkyi7/1rj1ujAvXzDdkyC03RtwLnc9clZMUvJk8wySfSsSAK8kpSnTp5VGjKelfO31bt18WCLKOoNeHjdtKtTK0fGG/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364871; c=relaxed/simple;
	bh=89WfJNb+pkIMHLvX5/VVcTSWnnaDls4AtCiZk8mJt/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sK9cFBrhn9e8cZLI8CJqji0lly2YZcGudwYiR9I3Ifx2DqENW2BJiaEI5o9dSc50y8xC7szSv1M4KorVMmFfjH56HnPQsJXlw3va7k58W5yRf2xBxjYVu0IxqLhw2OImhX6PopjFelSl7hJHCFwmBVBzVuqGYrZpCUZXdJRmqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OIbzACZ9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OIbzACZ9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EBLldd009060;
	Fri, 14 Jun 2024 11:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=v
	NRcsEt/ZPXZ5MULuZxrcBN0tHNfhU6zxkgm6+WxjgM=; b=OIbzACZ9FwCbreDik
	aP1/DBd5S3hMzLZK7vGhI7urUxWFDgecqlSS7fWR3y38Jh/s5RJuN2987VZJTlcL
	IsA86oXRW3WL00o1qW6lk7X0WXIXwlY5xEAyn+2zOJDssKGJ1il9uvFC2RX0GP7l
	52nf5yho2k2isPoOlOe9gsiNcZlYsjzyTCTLWprQah8HyM+ZhhiP73hODG+i1XBJ
	CW+rXj7J1nXfmkOXIV7q9eY0c3TRf/YloMezY/A+Nr00jEWv69Pvi5RKMiWEI7YK
	Q74vzH6HWoqcHU6YDSw00G/6K3+qSK4+e1yNR7esbQsGyHVDFa0kCqUa98Ao+MQD
	poXmw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrjts8cpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 11:34:26 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45EBYP6x029598;
	Fri, 14 Jun 2024 11:34:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrjts8cpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 11:34:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45EA0DIk028808;
	Fri, 14 Jun 2024 11:34:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1mv1956-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 11:34:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45EBYJc756688998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 11:34:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F71C2004B;
	Fri, 14 Jun 2024 11:34:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38C4F20040;
	Fri, 14 Jun 2024 11:34:19 +0000 (GMT)
Received: from [9.152.224.222] (unknown [9.152.224.222])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 11:34:19 +0000 (GMT)
Message-ID: <6926ba88-42df-4917-b373-0b36ed80c0d7@linux.ibm.com>
Date: Fri, 14 Jun 2024 13:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Add "S390" to the swiotlb kernel parameter
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20240614081438.553160-1-thuth@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240614081438.553160-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HJcg8mp_cVCX9JlFn9GWb3PJfua-CSMO
X-Proofpoint-GUID: n0LxrR1obvK1-C62vzD3ksl9Pa02v52J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=825
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140074



Am 14.06.24 um 10:14 schrieb Thomas Huth:
> The "swiotlb" kernel parameter is used on s390 for protected virt since
> commit 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
> and thus should be marked in kernel-parameters.txt accordingly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   PS: I wonder whether we could remove IA-64 nowadays...?

probably
