Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2BE12CDAE;
	Mon, 26 Feb 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966314; cv=none; b=uqazTQlPz0eTlXvup0c3Getsmyj/eW9MJVdJqFG/x9Azl/cqWN6w/W5y2lYpDFuMsVX+9TIpwdySNbQdMtV7kbrehk5orVP0oQovAa1YURjlbfVxGaUmcbWJhpbqPZf9cddkLKJ7UukxBCZYZ+Te298uUXzUUgYjG65xvQ+kIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966314; c=relaxed/simple;
	bh=CsGprVwukL3aGUn60fp8HU9YCvMh+YlgTCGIfU/MUe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l66nX5n+BOIDMN6krtOUh2cH5hJrg3QeBAyCnIqug4fpuiQADJkJ2AGUVd8azQ4lMtqw3WQ3nnN2klq4L2Rvc4H/5xsG2lmfvTQ0ncTlV67QhvzpLkJ+BF5m1G/Q4wk0LmKrGFLajhM8oaHmpdwftdoJDg3KJyvrW4uRy21IarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MCEbvEDM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MCEbvEDM"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QG11mZ018574;
	Mon, 26 Feb 2024 16:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CsGprVwukL3aGUn60fp8HU9YCvMh+YlgTCGIfU/MUe8=;
 b=MCEbvEDMsOXQ1KUKPtEeuff7uyr4Vl8Sv0AuIepAZ9KQUsRtphWaDAD8p3a/RLUHLoK7
 DMomI3BniChTgiD5973UZeVmrt3sXqqjNwk37Zjda9zwYNiHaLrQYrDFMvrEXkIGuNny
 +0ddfV3nSNO8b5FFkXiRZfkK91Xaa78dpLakJaKweu3AnSWD+dvPu9agjU9FpAnxbOlN
 8rO7bAmXI6MB1aP1RRiJ5BYBaGfW0tUTfblMxC/codIfbu1rqyrg5FA0vsIa4NtVOLhb
 a9RIIsA+KijPNeDSRoQyr1QF7OD6pUIH1yH4yFnyakxA78/KoxIjQYcq4MNRski3ee4A Gg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgw0k335v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:51:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QFGmcm008142;
	Mon, 26 Feb 2024 16:51:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9m29pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:51:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QGph7n23921200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 16:51:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDE358065;
	Mon, 26 Feb 2024 16:51:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82CF158057;
	Mon, 26 Feb 2024 16:51:41 +0000 (GMT)
Received: from [9.171.88.168] (unknown [9.171.88.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 16:51:41 +0000 (GMT)
Message-ID: <0f04e963-0484-440b-ab21-69c068900f3a@linux.ibm.com>
Date: Mon, 26 Feb 2024 17:51:41 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dasd: use the atomic queue limits API
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20240221125438.3609762-1-hch@lst.de>
 <20240221125438.3609762-4-hch@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240221125438.3609762-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KhOukunnsZpAj1hc_zSSgsccWMgN51yc
X-Proofpoint-ORIG-GUID: KhOukunnsZpAj1hc_zSSgsccWMgN51yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=893
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260128

Am 21.02.24 um 13:54 schrieb Christoph Hellwig:
> Pass the constant limits directly to blk_mq_alloc_disk, set the nonrot
> flag there as well, and then use the commit API to change the transfer
> size and logical block size dependent values.
>
> This relies on the assumption that no I/O can be pending before the
> devices moves into the ready state and doesn't need extra freezing
> for changes to the queue limits.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>


