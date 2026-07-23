Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381F3EDAD9;
	Thu, 23 Jul 2026 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837657; cv=none; b=RI/dGg1V/kSKq7bhPz0+ub4Xt0KXq9+6pqx0SvNUBA2YebOzpfG7O7s/41dHXTOz2cKsKZKlpUA5Yv0IFV2DtWZpLNZwjWwYf43ARaRsth0kARn7nuvNvj2P2UIhxGUCHP0egu7RSZhgPzLuJIbKARy2L52+aIJnRSi6T0ah5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837657; c=relaxed/simple;
	bh=YjD5tcK/AKd042i0S7aTl//08XkTI6Mwe3CJgFU3Bdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pk/rCpx18G/Tc95QIp4zUOjECPyIGTn4Ne5qbdNaoTda6Acb4NMTKKG0jqszEr1lc9vtOE79z2oc3yHW60tg7t910alUDkpWG8ow5yH37zJq5Ys/QRZbHnueeRrHB7H4tBhqIdNIPiQyva3JIO56tYEuYZXO7oQuh+wRXQSrEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R90hZABc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R90hZABc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NJBu3Z3874166;
	Thu, 23 Jul 2026 20:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IDJhTb
	UOBWUD9EcFeaBpX4mgUxAIEg2xyd28Sp2tcXA=; b=R90hZABcA2dQEv8OSiyhY4
	/+8Bk561Ph5k0d+1AjEXv4YN7yedIpZQCNL+COoaTBjRzciCo0I4Ypg3Q4aUy1J8
	cU1T932O2E3bwEYSj3XvAOQdG7bqFsndqprq8yWyqYbhdiMrnqDvZBPAhCEZWVwQ
	AA5pUvnojybEgLMMZx5++oK364O0oFas80mSrxL1x0OplQPZJCrqvEuaBOOgN3/q
	shxQu5uqeGr/tdgr+MOIklg57cxqn5yAgzdvs4bv9DT6SqePcKbDrUG3gvJs23Dh
	kyn/WkCrmBOpkaZ3hsyy93AjJe4yU2ePAZxuRCqngK8wncv3amixDo8SKPa9+5aQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7absg84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 20:14:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NK4eq2017582;
	Thu, 23 Jul 2026 20:14:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqe2fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 20:14:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NKDYmw23134870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 20:13:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E83C758053;
	Thu, 23 Jul 2026 20:14:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D20D058043;
	Thu, 23 Jul 2026 20:14:08 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 20:14:08 +0000 (GMT)
Message-ID: <0dae69e7-8161-46e7-bef2-edabefd93fea@linux.ibm.com>
Date: Thu, 23 Jul 2026 16:14:08 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] KVM: s390: pci: Validate AIBV and AISB before
 pinning guest pages
To: Farhan Ali <alifm@linux.ibm.com>, sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
 <20260723183440.3271-7-alifm@linux.ibm.com>
 <20260723184802.816BE1F000E9@smtp.kernel.org>
 <fea9882a-b41f-42a3-b30b-37d6a40af127@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <fea9882a-b41f-42a3-b30b-37d6a40af127@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5NiBTYWx0ZWRfX/6er4hjRenYA
 lsOWceQqDL6ZWvc/RJ6pYnPy75JcJGnWs/1y/V1OhlFm2/Qtp/dw91JpcvIHYJTv1AJSi1vScVP
 fZT2Ftr8UsJKw+cxF0BSDz8pNS/oUJJ1VFjEd3rAG+xBxyNDhbfibsD7+Erx/g9r6RaOvryHDja
 DLx2evIgNEd7oQJeXeQVWYF3BE0JT2+yKNvYU9zqOj/ASnQzmOjAAnBZigiZ286y2+LQha5gF5J
 APDAeBjgpg0Wqzx3Q1es6Wo1uFzuh05SZtyJMyLgKMf2mQXpvgLGoFuNhYsc/H/iJM6NqbG4DQZ
 CBb9xHW02eaLBeVwCuTd4y1zEsBaDK9tA07DppBjT9UIWItdCZE9i5rE5gTE/u8cmVM+NDRUgbi
 41O0v9IyOnDZWyvL9+VxogZ2tq4G2I4KVuGqcQsowuJP/luTd8xkah2/3V+IhRFuJJBWEEZXquf
 NIhWfQlMajvfKd4qo0g==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a627614 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=s2hAA0MTUvO56OCXh08A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 51X4vgbx5dHs6aMcJZj0Sj_fdjr6YsV4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5NiBTYWx0ZWRfX0qKSzKOJSI2e
 2dSDXBqJijhCst3U2waq/SPvXma3KP458x7J0WmjVCqSMRh8kGwN7aP8Ylh5TjZ4nz+WNVvu55W
 PVrMLEwMn3GsN9XWQqDTR0tQiYkVXp4=
X-Proofpoint-GUID: 51X4vgbx5dHs6aMcJZj0Sj_fdjr6YsV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230196


>> [Severity: Critical]
>> Does this calculation underestimate the true byte footprint of the bit
>> vector
>> when aibvo is non-zero?
>>
>> If a guest provides msi_vecs = 64, aibvo = 63, and an aibv GPA with a
>> page
>> offset of 4081, the calculated size is 15 bytes instead of 16. The npages
>> calculation yields DIV_ROUND_UP(4081 + 15, 4096) = 1, which incorrectly
>> passes the npages > 1 boundary check.
>>
>> This would result in KVM pinning only one page, but the hardware could
>> access
>> the 16th byte, writing to the first byte of the next unpinned host
>> physical
>> page, which could lead to host memory corruption.
> 
> I think Sashiko does have a valid point here (sigh...). The right fix
> would be to correctly round up both msi_vecs and aibvo bits so:
> 
> size = BITS_TO_LONGS(msi_vecs + fib->fmt0.aibvo) * sizeof(unsigned long);
> 
> and remove size += (fib->fmt0.aibvo / 8);
>
Yeah, that sounds right to me.
