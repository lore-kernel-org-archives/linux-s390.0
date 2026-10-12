Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A0433E81;
	Mon, 12 Oct 2026 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804710; cv=none; b=Vo2L455wNyY/K2z2qgqmAQHprNbwQQFDpdhrt25gUaEKtJx+YIAlohkNeSGy4bZmPZFJnPhbT4Dya5jOERucXnj3Ghr8gBBYhc8JDxJAGkk6jYhd8niqcEYfE0TJw2wy/U5/azFGqYIo+U/uC8jbeKfdd8gv6GIIIdsVtkH+l0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804710; c=relaxed/simple;
	bh=2HTu1DA46A3Rq+CoBYT+WU9sGWrgQuqKtymiHb8CRvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDyWGcKWBM5/noTfioM1Q+7613VIlynJzvMG6tH3PPvGG0P8KNN0cOfQ8WXqR50v2CjIbZhbQHl7YQcxXTHpbNASayMLqwAs9IcQmJbvWZXHdR/qeUmQH0/zKKq62JWXy9j0oHmcbH0dvk3QPM+fJHwD82Wq0so5kCxFXdTtBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hWtVZrIZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hWtVZrIZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iQtG3968445;
	Mon, 12 Oct 2026 11:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AfWX+R
	yH6ssoI/3jJQ61Qx5FQqOU5Ea3xDwaNZPkj/Q=; b=hWtVZrIZ41juBEMJb/P/zi
	+r8dPrgiqDuaTp2iCzdKT+JAXI2hYIp3rDh0mCP/PvTgFhINdbZZg9iGzngUanA9
	Qi3G78oyo5wHNfd5uXso72uEhFxa2mXp2RpFUUpl3BVDIfsiBzROvh0kT0ppHJUd
	awOi3/L0fzQ36POCpTpRDDj0LPF+D7X5hc/jzluGltlIimkyTbHGvJKZ8DtmUDxN
	sC1+QMHie5hp9NwNkZVURO/afXsyBrjdhTlLHgxQiI9Tw/byet/MHuASi9aUjWpa
	/832peOQCOVmi1EqUSLcPrgn3MFKucl78ThAnKld3xImMjmr2/93IXTC48qjcJLg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w09cm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:31:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K15h1013466;
	Mon, 12 Oct 2026 11:31:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cycnu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:31:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CBVgDb17367402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 11:31:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B92B22004B;
	Mon, 12 Oct 2026 11:31:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3718920040;
	Mon, 12 Oct 2026 11:31:42 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 11:31:42 +0000 (GMT)
Message-ID: <4838f7e9-fce0-46f8-a0b7-67f816836c9d@linux.ibm.com>
Date: Mon, 12 Oct 2026 13:31:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/32] s390/kprobes: Prevent kprobes on instructions with
 exception table entry
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-2-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX+RYX2GzxiVIz
 fA6U2nCPe9JIaRoC9De8OiYihumQMUX5PcWFmimoL9K9Q4xHi+5DEAqdeQ9PKed4q0MGpW+RARt
 sHEMHHXUgLi56D4zU4qOfr/KOQiE0ow=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXyrP7TUtrzLuQ
 jJA4FPK3P1HObUahAudG3vdqQ10Vo0igRjK/+zGfLelRcxuGgfs/LLVXKppYfmPkOOQlKyj6HYy
 x3QgJbqZaaUfeZYTOWKOJXYdzkddaK7YprP/tXr+wHe6UGWwPnL2TgUmc1rOhGCT5SUg2bIMyW9
 lCmNWuOsAzLxaFDGFQwxoz+5X8SnFQb9pZWMTvY5Gi2XhHLaKvYL3Ewyr7MmEBhNrZyNCBfim7U
 xsJiSEWCSWyWB/VhvmfzEK6gLN9RXYvTof4n3seStEe/z6BJ9kzU9lqkzRgm8WjBLKgoOXWvhRv
 03Cnp64kdwYKggmGxrV/pG6qeniHBuPlQXWjhvon+6SSvFFYTIhyvlSozTLjr6n0VT4hC/BdEz3
 XYqFXKkkdYoI9BoKLmZu3R3S9qU/ZtALTL0T9mfss9+KHaoIBEt2oDUJK9XuBlKLLxckv7tGD3p
 of/HeCrFsgoFbV/Glow==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accc523 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=a_u-TuGqFIQ8ZqSRPssA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3fucFtz2lUs8nknSIQ6sAvHbfdYz0iHF
X-Proofpoint-GUID: 3fucFtz2lUs8nknSIQ6sAvHbfdYz0iHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120044



On 10/1/26 12:32, Heiko Carstens wrote:
> The mvcos exception handler ex_handler_ua_mvcos() decodes the faulting
> instruction, assuming it is an mvcos instruction. In case the instruction
> is kprobed the decoded instruction is a breakpoint instruction instead,
> which leads to incorrect instruction decoding and potential register
> corruption.
> 
> Fix this by simply preventing to set a kprobe on such instructions,
> similar like arm64 is doing it.
> 
> Fixes: c488f5187a24 ("s390/uaccess: Shorten raw_copy_from_user() / raw_copy_to_user() inline assemblies")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/kprobes.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


