Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69A1E506;
	Mon,  4 Mar 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555726; cv=none; b=WvW6E2rK/xckT/zLG9/wNeCNdp4JycptVGlM0K8y0N+fIefTCIUeLoaBdZXEljPbKH+0z4mF+RbqHnc2Spu+Qt7TY5XQ2TuxtdO0cqBFqQUBxv+xOiexirDQg239BmG4sM+FJsPtHZQyZp1CoDpJm9/zgLxrNAKcazo+yR2bGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555726; c=relaxed/simple;
	bh=UAf6tcMaNPs1eGCxWZJOpp9hXkM/lsyYYu4bBVNMG4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i+kmR0kFD/l1yd6+CZCSqHLxUtokdxQQTjWVvAfj77uQXC/rNJc2pnKLLQPo/D4IaTtyFxafyN0WycygCKwU5LfVajpLeYbSohZAiyb1fb75JbhUFXOO8BYVQp9rpJJJ8Ta2fQZP/+yWonhQUUQCp9jwV49CenECbBWLwKl+2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jExxalFZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jExxalFZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424C7Snk019373;
	Mon, 4 Mar 2024 12:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JZJ6t3ssrTX3U2wVUw5YeB7doUKBXWHMDzWh4yzrbOE=;
 b=jExxalFZXU+HrUr3lvLQhwKDMylXjbB+mDvd822K3P7Vw9+HCcIgXqq9BQtFq/ONwQ1E
 TTEV6Au8hmQ9OGMiuacy16VdbOwiO+vTHf1Vd+CFrXds5TYpI+F22btdAXrGnXfS0pR7
 6M6UW9lTm8LJOvpKKGUlZmvHsI7cA069tt9HB21s51X8MYourk3N3kZgxyOyCwOeiTDB
 oVKE0/PsBStO6PQSLaTCJENmz4nrGpGTV0qUWFuoqZK9Ntv7ShUrp1L0ml5kBXbjgOgl
 f/x6ss9IqnP0dZsmqH1iE2+50Jxwf5G2yfzSgNGmgOvKy4orRKWONsmoFy+3jsIylQvx xA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wne18rndr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 12:35:14 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 424C7dY4019762;
	Mon, 4 Mar 2024 12:35:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wne18rncg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 12:35:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 424ADDmd026296;
	Mon, 4 Mar 2024 12:35:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfengh9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 12:35:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 424CZAeN20840972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Mar 2024 12:35:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2516D58061;
	Mon,  4 Mar 2024 12:35:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2D315807A;
	Mon,  4 Mar 2024 12:35:08 +0000 (GMT)
Received: from [9.171.31.119] (unknown [9.171.31.119])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Mar 2024 12:35:08 +0000 (GMT)
Message-ID: <4058292e-aa1f-465b-9bf3-9b674cbb0654@linux.ibm.com>
Date: Mon, 4 Mar 2024 13:35:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Reaching official SMC maintainers
Content-Language: en-GB
To: Dmitry Antipov <dmantipov@yandex.ru>, Jakub Kicinski <kuba@kernel.org>
Cc: Jan Karcher <jaka@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, lvc-project@linuxtesting.org
References: <dacadaef-4fec-4d5e-8b91-1a292ab43b37@yandex.ru>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <dacadaef-4fec-4d5e-8b91-1a292ab43b37@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CVCUAcfjFb-JWvsmF6waEJ5XxAw0FiyY
X-Proofpoint-ORIG-GUID: kOldf0cWXDaWs0NrPuR6BTfgm-ea2G4d
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_08,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040094



On 04.03.24 11:31, Dmitry Antipov wrote:
> Jakub,
> 
> could you please check whether an official maintainers of net/smc are
> actually active? I'm interesting just because there was no feedback on
> [1]. After all, it's still a kernel memory leak, and IMO should not be
> silently ignored by the maintainers (if any).
> 
> Thanks,
> Dmitry
> 
> [1] 
> https://lore.kernel.org/netdev/20240221051608.43241-1-dmantipov@yandex.ru/
> 

Hi Dmitry,

I'm on the way to answering you. I understand your worry and appreciate 
your sugguestion on the improvement. Since I'm not the original author, 
either, I also need to undestand what was the original intention. i.e. 
Why should the fasync_list of the smc socket be handed over to the clc 
socket? Is there a way to deal with the list prior to the fallback?

AIU, the syzbot's reports on whichever the original fixed or your last 
patch fixed are about the same issue. And both of the fixes seem not to 
solve the problem.  Instead of patches on patches, I'd prefer to find 
the root problem and solve it.

Thus, to the proposed patches from you guys (and back to the question at 
the beginning), if the fasyn_list should be handed over, I like the Wen 
Gu's patch more. Otherwise, I'd like yours more, but as you already 
underlied, it should be done in some other way

Thanks,
Wenjia
