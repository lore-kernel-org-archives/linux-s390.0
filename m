Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211D199EBB;
	Wed,  9 Oct 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485910; cv=none; b=EWe6hwMq26Zp71uX4iJZffj+qe7D8dTqUzk8Esf4APS6Xz3aPN/kKLwRF2WrNdqyORmHxHXuVQ8Ekehy2CI0d63nhUAurGALjTI5EH6UY+iOuWkTpnNRJXeQ7ZLN9ET4GcinfCh0nGEuJL4fJL+lV567EFM8K98HQQKVHBsJplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485910; c=relaxed/simple;
	bh=OV32K35d8RvpVIJxAJa46zA4HVN0mb1PBXvzp9+rAOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDzo2FRHOMDQeh26smjBgiW0OezwnzWmvQWRv3+TcHG4VCgUphgyXxT2wlByLAJG2Toev1zbhM+uDnxdKRC7KHS6dUI0lsV1nG8rtSJSR5D8XVzEQzTBT+7IAJrhcyPZ4LHfZvm2QiXieG6oozMw610Eg2uLFsb15mRjsNh3ICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jppxMLMs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jppxMLMs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499EnGiI021336;
	Wed, 9 Oct 2024 14:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=F
	SE4vFzVYiMPUHEUKQOrO489/5NR9PGPMJ27xStbNgI=; b=jppxMLMsXn9EmodLA
	Dm6nHlxc3leotF9zm4hrq+dzdcgFx0ek4enMCQr7lCmoQf5dEHAUXhsX3bx9S/J4
	Vj0sda3y40jlRqzrQdxBzrZgoOdqTH9Imi6RfmRz74xvg9K+ZjwY/t5AUTvli2nX
	Fe7Kf+4e/PV7yyZWLXGcygy+CRcI3vPoXTaaXBP++Nd/kdSwAknhdKuBSYr3DuAr
	qaZ6hMPEHE1V+91/qAeQO9Rf0cENF+sxGGkrvXtkMI23uZg0hr05E1dvJD1OizOx
	ABArG7LKY4Z6kgLRbBXlnGltTvNCw5f5Gxo4BtbhUXmEfdI5UYakPHhLcdPib9xU
	W2XYQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 425uxa01ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 14:58:18 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 499EtBiW003852;
	Wed, 9 Oct 2024 14:58:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 425uxa018y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 14:58:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 499C245e011524;
	Wed, 9 Oct 2024 14:58:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xtakq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 14:58:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 499Evx3A44040694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Oct 2024 14:57:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7617D58059;
	Wed,  9 Oct 2024 14:57:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 535C05805B;
	Wed,  9 Oct 2024 14:57:57 +0000 (GMT)
Received: from [9.179.10.188] (unknown [9.179.10.188])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Oct 2024 14:57:57 +0000 (GMT)
Message-ID: <95e11684-9aa6-4999-98cc-cac874d37a8f@linux.ibm.com>
Date: Wed, 9 Oct 2024 16:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: Address spelling errors
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ezQjHbu0GvavekIkxk3Ck4tr5cGks2fz
X-Proofpoint-ORIG-GUID: 5GzgBpspE-jm09xylcVg8Gva1Nb8jho3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 mlxlogscore=759
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410090093



On 09.10.24 12:05, Simon Horman wrote:
> Address spelling errors flagged by codespell.
> 
> This patch is intended to cover all files under drivers/smc
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia
