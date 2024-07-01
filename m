Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24C139CFE;
	Mon,  1 Jul 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831441; cv=none; b=eD9+gmbQdZvSwCUOPYknRThf7oY9zZw4CFVXX7cKYLI1H8l/M31302vJARMP4holFLRe2KFIIQL+WtGnXpIHR7loSu8Hx1tOiSTshQ2qnnVHWsq8i42Iz4SNpmomEj28WGqHoutmscbSPamAWEoIM0SAi3MFC+o1FYuGumeXDv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831441; c=relaxed/simple;
	bh=JiofziG/xZtlyqRXDAzYHGYGfhs54iVEkwzYJYFNDjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsPMWQLqTc47Tfsu1QNgYBa3m+F0I9QeFafDD+byyg1RmHJBUeri+nwlaBk9cRR9ZEeh9Vz3aMAgrxHxu3mE8RUiKwgt9SUFHscNKUPzPTadmVeL9iJLCZNae2UW2XtMj7xgLPGNJtrW1YBIddw8c3qXaIvyGl45rPsUqiTNH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eeNxvYmV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eeNxvYmV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461AurGk031543;
	Mon, 1 Jul 2024 10:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=J
	iofziG/xZtlyqRXDAzYHGYGfhs54iVEkwzYJYFNDjc=; b=eeNxvYmVyDSH150XC
	f/O+mGpnMsGveiSOxRyoT8SIAtODQYWqaS5FoBg9TEncUR0BTxsdOtZFpss8/WW4
	DSj52UCHu+xpnZE5TKZt2HW/LjRmJ6kHIVZ1Q+e4T9biM1+0Ac4qt5aUXlN8+fAW
	Oro+Ts/RWnsQ/9oWg7k6TfrJwrp31gnFY2gkWjlTJggc8tSTJard4E+TrZusHIFI
	2QwgKiwmnZ7gYpPANR+2B/6THuKmsKpPA4gcZI3TuJtr3yj1WHajhANW7WEYKav8
	LaezD0B3Rd05FToiciRy9VpTqQfm+8zfIzCeAdmR9BMw1tpWSwNCmWYbO6Y7fvbQ
	tQ7IA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403tqv81r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 10:57:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4619USAE024091;
	Mon, 1 Jul 2024 10:57:16 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya36dv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 10:57:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461AvCZD26739442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 10:57:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF8695804B;
	Mon,  1 Jul 2024 10:57:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57F575805B;
	Mon,  1 Jul 2024 10:57:10 +0000 (GMT)
Received: from [9.171.47.124] (unknown [9.171.47.124])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 10:57:10 +0000 (GMT)
Message-ID: <2c2655ad-2a2a-4180-8a31-828a7531af1b@linux.ibm.com>
Date: Mon, 1 Jul 2024 12:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20240615-md-s390-drivers-s390-block-dasd-v1-1-36b200f14344@quicinc.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240615-md-s390-drivers-s390-block-dasd-v1-1-36b200f14344@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D1xLR7T2PHM2C2vUe5sHmreK7F05PUyp
X-Proofpoint-ORIG-GUID: D1xLR7T2PHM2C2vUe5sHmreK7F05PUyp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_09,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=829 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010084

Am 16.06.24 um 04:19 schrieb Jeff Johnson:
> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_diag_mod.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_eckd_mod.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_fba_mod.o
>
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---

Applied, thanks.

