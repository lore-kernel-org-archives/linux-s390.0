Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBDA12D1FD;
	Tue, 30 Apr 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479009; cv=none; b=XmRiGrprHKT4+C6vQfjqTeMFpO7vacDXTqqtYBSNfyJRaoefwyxuqQEAdfTD6k1Fmcpb9/9hpjZFYGXSywI5veD7Fl7lYCnqQmN66WrdgUl4A6kwKgISiaCILsPxGLaNWsraOkr0+vJxZfZsJKInLB9jygQFcIG5kHURtuLEUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479009; c=relaxed/simple;
	bh=1UcIyZIvw+nKRBOEaDY/eKddMigSGwNJTENljhqGoms=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NN63wTog1JJls/cLnISsGE8j7sOt9r9ocSLLaGqL8tIBRFSaUMr9ZJGJZ+yuaBr5v8P/pmI2SREgeFgf9SYdygsOi2x3KBL2fCj+MewbzmMaeayCuSgsYXuj7HdJbJA/NKO4ToYQ6gjm/b/WW3iSDS4QGQGm91sK+Fjh2TMiC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fv7V3wlD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fv7V3wlD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UC8GsS002897;
	Tue, 30 Apr 2024 12:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2lmFc4PaATfWpyT/9i9Kuvqnyc2AHwa/tz9Tt5u/VDY=;
 b=fv7V3wlD6g8PrRtZYhICPKzkZxeUmYh8x59npFk8JBA7nAR4f9AFNO/fFAtmrf1oxq9m
 V7NuVPXdXSjF++KMtHVtl48LnNXz5pTb35dPyOMLpp+qT0ZV+LAyd8zEbSKOgfA0e+6M
 jWMyDHIiqPrqPHC2upEeamnYtXhtLA6V0Ve6E4ez+fK7COAJcBIa3+1F5QEFXDigFquZ
 2O0aMckeo4Qyy1gusSWpoAylw6wUtef/p68aVI/NHg5I3NJ4TM+gBeJBbpVWbskmeVNB
 YWGkFUyGv/1mFCvpqkacCjg2Kz+ewRlf+M0ropTruP2wejd2srk2ywm8eG3USeAhsN0K fw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu0cpr02x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 12:09:57 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UC9u6A004379;
	Tue, 30 Apr 2024 12:09:57 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu0cpr02u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 12:09:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43U8eWCJ001440;
	Tue, 30 Apr 2024 12:09:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsbptw4fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 12:09:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43UC9oqY53739978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 12:09:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C685B2004E;
	Tue, 30 Apr 2024 12:09:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12FC32004B;
	Tue, 30 Apr 2024 12:09:50 +0000 (GMT)
Received: from [9.171.73.65] (unknown [9.171.73.65])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Apr 2024 12:09:49 +0000 (GMT)
Message-ID: <0a955558-8fd9-4824-aac3-c16d6330b8fe@linux.ibm.com>
Date: Tue, 30 Apr 2024 14:09:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/qeth: Fix kernel panic after setting hsuid
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
References: <20240430091004.2265683-1-wintera@linux.ibm.com>
In-Reply-To: <20240430091004.2265683-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: myMygxWjoJjskkRw1PzaxeDCnrcC2znU
X-Proofpoint-ORIG-GUID: 4eojujexLEwn2K6t046CNlVvoc042c-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404300086

Sorry, I forgot to CC Wenjia, Chirstian and Sven.
They all saw early versions of the patch. 
But of course my mistake, not to check with scripts/get_maintainer.pl



On 30.04.24 11:10, Alexandra Winter wrote:
> Fix:
> There is no need to free the output queues when a completion queue is
> added or removed.
> card->qdio.state now indicates whether the inbound buffer pool and the
> outbound queues are allocated.
> card->qdio.c_q indicates whether a CQ is allocated.
> 
> Fixes: 1cfef80d4c2b ("s390/qeth: Don't call dev_close/dev_open (DOWN/UP)")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 61 ++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index f0b8b709649f..a3adaec5504e 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -364,30 +364,33 @@ static int qeth_cq_init(struct qeth_card *card)
