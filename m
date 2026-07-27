Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6B3F58F5;
	Mon, 27 Jul 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146168; cv=none; b=sKwr5QzGgturonbTFi6pZjlc0Bv2srxJ5JiqM0ZMb9msjeJLNaOq805Vkkh4o2/sHb6mAtuELrEMyg9rPcMYXezITsS2EMqYIyunO+mEfaXblaJtbjnZi+M5KY7cGDGACjq3wqL7H5PwU8ayt4cLLH+9MALgT39BscMWoDue2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146168; c=relaxed/simple;
	bh=Ed80Oa9c9lr7MDu6x66E+yLsV1kSrZQJpdM21p0dAlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT0lqJa09XoGq8FpMJywaLSSGd7LdIdQMbjNMkofc0OsQ3BplP81xS42fTAMRX4tbX5aPRKDCSvaYKqTX+3RjzeQOCQP7wOpOX7TaPcAZgncMMaCWlXR225gdVeIiffe4KJlyJlKDQ4OYjerQLzGzvCUsFE9lVWuT4Fqu8wDhsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RkJ/MrT/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RkJ/MrT/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9UhJn1821352;
	Mon, 27 Jul 2026 09:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QhZAv+
	ejDdzPI6W80x2sWVSwfVxwfS54r53xVxKl9Io=; b=RkJ/MrT/l3muaNi3wbHs39
	Yv56Ht8naIhgPrRXe1W8dwDFmyYYs2oCjn4u9AGfuwfOBfvacm9N5EgrqmOcowEW
	0xOHLYkciu/SHUVseAcQQcpi9KMXPG6/uFDaJwtjhcPkocxfIIiz2bmTs0OkxsE1
	4duT0e1TB6fLpisgh05B3/fpYLVGFIUkyhrggzSbI9OvkqK3GGmsltbNF3oWme30
	DKQJtb40FN8nx2URNmaLetyIugrRT+XRlQOCt470KHJKk8ZOyajzvG/fQe0NMpXf
	c+ucC3pYb4t1W6MDh3+KaBiZYwyaGefFjUMYbCteABR72POfzvfZlpQnpUktv7sQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw77byj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:55:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9fKuI016823;
	Mon, 27 Jul 2026 09:55:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjvug7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:55:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9ts0B47513960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:55:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36D99200C9;
	Mon, 27 Jul 2026 09:55:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D833D200AE;
	Mon, 27 Jul 2026 09:55:36 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:55:36 +0000 (GMT)
Message-ID: <968e5507-5900-41d9-b893-715551d561c7@de.ibm.com>
Date: Mon, 27 Jul 2026 11:55:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 0/5] KVM: s390: Fixes for 7.2
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260727095359.107671-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UTgBrAKJdA86Z7LrRMg8qK-abXJRR8vK
X-Proofpoint-ORIG-GUID: UTgBrAKJdA86Z7LrRMg8qK-abXJRR8vK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfXwjxrb0OoYQxQ
 Nb6xECKapUvoA4kKGVOkZ0WAywJCXVdaRWp33mVA6gOVxL3b0FcwHnTckI+JZMuVjcveVGI5A9b
 NHb6amQceJOGEIZuZqqZuVqYscFHwLMpMKmslgm1djZoIBgkdKKN2KgWx+h9R8qRpi/CaaLsui9
 mOzfKRnHqi+BNqEBJJtpJeksP0eRwRzsW/9IUufVcz0AzXzrhmMfcg7A4DMefrF/vMWKk6zcvn1
 bfbPqCS8zTLt7T0TpOuYwg4hHdv7rFZCA5DeOe5EVVIs36CSz+/rZ74A7A+EeHuAz0fqcLtY/Hc
 3qrhYjKrw4mkhA0FmoVkknA2i09jD+x8F6ejLThllsfIOGFnfGjUcKcJ6HLuwMPUj8BXfV4V6d0
 pqW5LRBf1Xk3ppCZyKfdqTGM4P9ICmXtGDq94Hx7qMec3Yc/zRmyEKyGDFxDpkkot7PzBxfzQ48
 YtTSbVV6AX7Qo+yEpbA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a672b2f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=XSr5kD3-IMuWHpFdje4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfXwJN8X33cNx6l
 FQ28CAcwX4VEKIL5iS7DUQ94U35ydMKBBzuJMsGqZvapsinzjYBXxdHgO0cMPxeeupiO3o9TLBh
 ZCeKtqJiA7Tx1IN+KP3MCFUMzYkUdcc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270096

Am 27.07.26 um 11:53 schrieb Christian Borntraeger:
> From: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> Paolo,
> 
> please pull the following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:
> 
>    Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)
> 
> from the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-7.2-1
> 
> for you to fetch changes up to 3e3aa6da87d30a0064a17b836685cd43c90a3572:
> 
>    KVM: s390: pci: Fix handling of AIF enable without AISB (2026-07-09 16:23:10 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes for 7.2
> 
> - more gmap KVM memory management fixes
> - PCI passthru fixes

Please ignore this, I was running my commands in an old folder.......
will send properly in a minute.
