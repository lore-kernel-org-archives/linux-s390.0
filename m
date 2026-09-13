Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002AB331EA8;
	Sun, 13 Sep 2026 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789315987; cv=none; b=buG/2s/rm+JxRcGh+DBKZgclWTGOEaL4K8wUSbtm8c0R0Syd6YCPd4Tc1lH4vjUo5hFJhnNhSJMSSfb4bS8zvgx75EFrgNQc8jKiwmxrhW1VLA2lEHeRhWsskqr7XTgblg6IzYfln6+GpwPj73Y46TB0dCsWfDUbnvWxAEc3QTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789315987; c=relaxed/simple;
	bh=y20wvdB/hCrDKMEVppmgQxqr1c8y+UCBmfERPsoqDLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJDOzaZOT2yZpXXj5lEwJdHLxb/s2q5F5orh1lHvD9VE9gcvGy5EkECfjQJib8EcpZIdTx4bYqYcgOexYOm6hUSaFEKVnjhOyGspKmed68XJoLi0SWQKgQeLkysUXxbzB82/UM6lVk6mteDBUe+nE5qBbeOxnzIElLEnEJhqDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rQG/AxuL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rQG/AxuL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DE2I503532209;
	Sun, 13 Sep 2026 16:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y6m2rq
	q5Dc3KZmgRi4tHGJhmnNcKcJqfHvJoxzOAcyU=; b=rQG/AxuLjz+RuQz2Jzx3Id
	lwpCTm2DxeB2Nwx3OCpbajEVKpQnZ6VsCmuC6ya1V73bVMyFLjs+iiTB+HRPDegd
	gj7e7fhefL6IZ4ApWkuAAfbTD4vSIfa/bWi+0NpJjd3WMI94F9+PlUFEQbEuqALv
	Rket+JDs2Y9IwfAo6AqYptBzULGa2ozgRmk1QCekJ7f7qtfw9KaCy4/enVleQ1mQ
	SKx1sNDA4sx2UvfO3sdP5X5FNsGA9YGQtoujSIL5kvXj7PgV2+kyB8qmMnx5Ez2U
	rUpxLBQyrAPTWvP/tIHAOSmPzQDJ8S/Q2iwwz+7N6yklsgsUl8tZQW13QSofcmqQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4n319-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2026 16:13:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68DE51ve796391;
	Sun, 13 Sep 2026 16:13:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnk9j1s2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2026 16:13:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68DGCveZ31916504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Sep 2026 16:12:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC6A82004B;
	Sun, 13 Sep 2026 16:12:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78A7520043;
	Sun, 13 Sep 2026 16:12:55 +0000 (GMT)
Received: from [9.111.48.119] (unknown [9.111.48.119])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 13 Sep 2026 16:12:55 +0000 (GMT)
Message-ID: <001596bb-0e76-460e-8d62-be4cf0645b07@linux.ibm.com>
Date: Sun, 13 Sep 2026 18:12:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: Add lock nesting annotation in
 iucv_sock_close()
To: Simon Horman <horms@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260910162919.2100124-1-wintera@linux.ibm.com>
 <20260911162945.B92321F000FF@smtp.kernel.org>
 <20260913134209.GH48209@horms.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260913134209.GH48209@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NHl932T2tOEeQyZVPDxbpNHpMEyT8yvg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIyNyBTYWx0ZWRfX0afjv4q6EcYN
 b1aWPzXvcXftYeVWwaulPXiaCELvAjzaSiRWDwHWU7+BcO8PliW9EE/QzuHHpDjH1XfzWuP2IE2
 Iij0XwvNB/yNpC/055rR0+Dx4Oro4Gs=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa6cb8e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=RiEY9gyW2IlFH4kpdRIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NHl932T2tOEeQyZVPDxbpNHpMEyT8yvg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIyNyBTYWx0ZWRfX7vZ66NY04TAI
 THxGgTE4tu21aw3swu+kRHkFJPJ1NtDsfHgAO4qXBNPJebbd8bdqz630PxH64levVzQBzKBFyD+
 z1Lc2Mib76PtLs5k4youEitn6LNlMP2+ZKS+Td5o0SSUVH8xI/z5LIAuJBjPZ8hyTi3vIpZnTq8
 5XJJe74Rkb9824qw88g6rJ2/N9QkaoEWwDIL3iPxQ/M0/WodmMtmzyVFGM8FhLyi9uv0v3XJg2Y
 s68Z50W/Ocs1LyNjZY1lSPIqd0YprTRAkl+4spqfbEbp6oI0vspF6cZgcO9WwlokAgTAW1qfsMT
 9XOCqXrN641rtVhCB2/iZ+T9g5uyaVn68usxLRiRvTEnBFTObP+iIn7pBCzRC89W2rtXDDBgWmU
 /SOFNSJMLNpBGynr77/nJLgJbZrmpUBzxG6BPVOez0WA085FZyOe7hBecsIZK1fu2sMNcrXqHeS
 hiHomEyoxxmcrf/Rg7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130227



On 13.09.26 15:42, Simon Horman wrote:
> On Fri, Sep 11, 2026 at 04:29:45PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [Critical] Lockless traversal of accept_q causes list corruption and use-after-free due to concurrent modifications from softirq context.
>> - [High] Newly allocated sockets are permanently leaked on error paths because iucv_sock_kill() returns early if SOCK_ZAPPED is not set.
>> - [High] Child socket leak in iucv_sock_cleanup_listen due to late state update leaving a race window.
>> - [High] Unprotected state modifications in iucv_callback_connack cause state desynchronization.
> 
> My opinion is that the issues above are all orthogonal to this patch
> and should not block progress of it.
> 
> ...

I agree. I think all of them were reported already by Bryam Vargas [1]
I need to get this one out of the way, so I can reproduce the real issues.


Linkk: https://lore.kernel.org/netdev/20260724222917.134769-1-hexlabsecurity@proton.me/ [1]
