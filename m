Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF8312881C;
	Thu,  7 Mar 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813444; cv=none; b=k3fApS99sgswZggEYKu0eiVOllrlc9UN+yTrD+gxh2HpGBfebUimkJPtxByuJ/exH7oywjgYFho0EWdV8KrmQ3gz+txDdI6bj+WzrutmwH8jGUJM0hXDDwFe36IHxWw1VTc8ebQ8b7sgpYWrJASG+d4Y6dJoyok16u8SsD6+zqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813444; c=relaxed/simple;
	bh=L246+BnyLUSqthQdBY7HdXf1J37eEP4oheJjvWJUDo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4+eWfaiZN5cF6ysj9+zNYyzlFNCmUpLnwlFbMRG9ODIes4O2FU8giOEx19mS1Kb2buvGqpKw8wWag76YgHDCbkYcoZGj5yGperIQ24P1zLo4KxPOrcLolZzTzAe8X5nDaBGKfMaNWbqnTsO8MEguCyVh9nhA9Kr1JsvDNoAeUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NvY1eS6k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NvY1eS6k"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427C5nuG024234;
	Thu, 7 Mar 2024 12:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8d+0gs8i+gAA+3JTtHq5lrw33iiCprZeyKytBgf217g=;
 b=NvY1eS6kGnoyJ6m5S6rznLkPMEKT+gYDrRAbSpu5WsBN/CR3v6XFvH/4h/OqSfCpuJmF
 GJtdDiWNKjNJzVzz59brSDEmBgtuOTqM1RFQ6rZ9V5+TNlbdL4HKXCg1aAOP78h2G5RV
 YP9CYp6Vz82Gt+zKdOZHHmk/OrQFZSCXezSs9Uf8/CZSINsutlFHslUhTsvCdtc2Pu5Z
 5hq7PYstKergxqgvVI51caG8Xf0sfaYhuuxh0C56Iuer/n9GG/RIWpL2rmctugQvJEXm
 wRia9908XoQoNbciEXs2g67cWoTFgkNcUfS+SPeuXxAXr2txQDhW9u0/l+f5dcM/tRp8 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqd9pg45a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 12:10:37 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 427C72Cl028275;
	Thu, 7 Mar 2024 12:10:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqd9pg44j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 12:10:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4279R8vq024172;
	Thu, 7 Mar 2024 12:10:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsgqdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 12:10:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427CAUke41419202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 12:10:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47F252005A;
	Thu,  7 Mar 2024 12:10:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 065B32004B;
	Thu,  7 Mar 2024 12:10:30 +0000 (GMT)
Received: from [9.152.212.241] (unknown [9.152.212.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 12:10:29 +0000 (GMT)
Message-ID: <0ecb1240-2aaf-4c08-8b98-596a524b8ae6@linux.ibm.com>
Date: Thu, 7 Mar 2024 13:09:45 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] s390/qeth: handle deferred cc1
To: Alexandra Winter <wintera@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
References: <20240307093827.2307279-1-wintera@linux.ibm.com>
Content-Language: en-US
From: Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20240307093827.2307279-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QXL9w4689UBu-q4rpqbQGKPGn9wDxjXa
X-Proofpoint-GUID: SeqC21WIYepEhS9IixN-dxF2KZfhiGik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 mlxlogscore=913
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087

On 07.03.2024 10:38, Alexandra Winter wrote:
> The IO subsystem expects a driver to retry a ccw_device_start, when the
> subsequent interrupt response block (irb) contains a deferred
> condition code 1.
> 
> Symptoms before this commit:
> On the read channel we always trigger the next read anyhow, so no
> different behaviour here.
> On the write channel we may experience timeout errors, because the
> expected reply will never be received without the retry.
> Other callers of qeth_send_control_data() may wrongly assume that the ccw
> was successful, which may cause problems later.
> 
> Note that since
> commit 2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")
> and
> commit 5ef1dc40ffa6 ("s390/cio: fix invalid -EBUSY on ccw_device_start")
> deferred CC1s are more likely to occur. See the commit message of the
> latter for more background information.
> 
> Fixes: 2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")
> Reference-ID: LTC205042
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

