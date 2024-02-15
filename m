Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6C129A80;
	Thu, 15 Feb 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006475; cv=none; b=omM37sBDPQBapZNQIVS31OVQdR9m3f7bSxXV2HwaHJRDfEzx2FVlufKhZVLKGnRwXln+fLFs0oJeCOa6o45hp3zv4hFWnFneOBQbxs0QSIUb/pvbIAKGvIHY/lRbHta83CePa+9tRJ2ikxHyl6iQPGBarz4U2SotPBQCS2T8ONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006475; c=relaxed/simple;
	bh=0KmmJF7es5qjGJptTPHwSdrE9Au+2EbQ8WnCPfcgii8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfWRx7aBJ2OVr3eUvR13S9m2ZF5WwYyBgvbG5qJS6WOUGXXOqJKBlIxx8uOkHfRg1hydKMNwCrLEvwXnW/FdWIHGA3+UvejjBCNZyPFRKvu7fUfZJQqViv2uzyQwexBTbtTE4cgiUiC34WrJipXB7tq2JE3BOCijtFnPlqelbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nDw579tI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nDw579tI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FE2QAJ029709;
	Thu, 15 Feb 2024 14:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Qoh53EwvSI9X7jHwJNqWFg94YPQZpOq8pRhjLES4yGY=;
 b=nDw579tIIkzZyEiBUEZuluO/c26Nfo3dOpWJrOXwQF1bO0OWRg7B4k2Q9875OzadldMw
 xUqDsIZ1rYB4g2N4hBQWMbiXcXObWGKDG4LPcWjF6YaprRucdWLuV8Q7tnMHqmhjQYVq
 GLr0OjVGfYjKGROwq6zQwIozCtvIPs64JURPLDK41Ry6ny//7vS+Dtd5mq4Pz9fsC56g
 b5rfZdeIPPxnW/BCSVZixNG6MqPeHnf7ivmcWIchqGaZoVggufReQF3Z7QwM0ZPfmcUc
 hJZdjjOlYzE1/ICKFWdg5W14VTsMrbjO7c8nHE//QmaQDTV5F6dh7To896Jv747SrZoY 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9m1a0ee8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 14:14:29 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FE2Q3O029699;
	Thu, 15 Feb 2024 14:14:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9m1a0edt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 14:14:28 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FDqM87024878;
	Thu, 15 Feb 2024 14:14:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpn5dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 14:14:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FEEMoP2032266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 14:14:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25AB92004E;
	Thu, 15 Feb 2024 14:14:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF9052004D;
	Thu, 15 Feb 2024 14:14:21 +0000 (GMT)
Received: from [9.152.224.128] (unknown [9.152.224.128])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 14:14:21 +0000 (GMT)
Message-ID: <020edf58-c839-41c1-a302-4a75423a1761@linux.ibm.com>
Date: Thu, 15 Feb 2024 15:14:21 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG
 bit.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, linux-s390@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
References: <20240214195407.3175-1-kuniyu@amazon.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240214195407.3175-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LSSaPSZRfFPi7d3TS2Csxpa551B1sVaV
X-Proofpoint-ORIG-GUID: pv6Dn-rrpeMGpJ4w1C0nxLk8wRNgxCt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_13,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=790 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150114



On 14.02.24 20:54, Kuniyuki Iwashima wrote:
> +	case SO_DEBUG:
> +		/* deprecated, but kept for compatibility */
> +		if (val && !sockopt_capable(CAP_NET_ADMIN))
> +			ret = -EACCES;
> +		return 0;

Setting ret has no effect here. Maybe you mean something like:
> +		if (val && !sockopt_capable(CAP_NET_ADMIN))
> +			return -EACCES;
> +		return 0;

or 

return (val && !sockopt_capable(CAP_NET_ADMIN)) ? -EACCESS : 0;
