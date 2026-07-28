Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A9841D10F;
	Tue, 28 Jul 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230966; cv=none; b=jZTiiRKsYYZIA2bZ9S7Tr6BFhTXShV8PlgwUymmzpjjg+mp+/klkyKbtx8lHpPmhgnEP4ceFQmCCntX3p0wENqzqFuKWNrFIwYILOPc1zecHD+aq/Op5Sa0IdbYT/xaU+YyoLmeooQTGkqced5Dgd49+PUQRqH8qy/1qG8HIj9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230966; c=relaxed/simple;
	bh=8LOThpIGz0t/6PH+V9cSJlRrMjdoMeFmXzzP3LN9cFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDIOaNRjDiCBzbxb2aiEDttgYOQLoH+vvNRGm8iDtn4RKyrgcqrzFdBUQDuMkTmflVAXjBp4YneKhRVU6sTpkFAS5cEgAik4KK6eSsIv+pl7026azw2IiQ0nnAidWESDWjjsTJWWCFi7GLHg251zvqfkz8wDlIebIcZYYhPyLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BMDWzB83; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BMDWzB83"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S8Hvui521165;
	Tue, 28 Jul 2026 09:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6tnem6
	3xH0J7QPg4PbEDpgwzLHoqrRotF7hoceGHBx0=; b=BMDWzB83yU4W7U9pGBmU8V
	Ape9B5bgUmnZ6odz0R0oCCmQ69g5ZNTDVspGQy5KHP5S2UMuSsjrhKd7Jx3VneAk
	opDXIz/P0DEY4bvWMuaeKKHFovHnN3llJQ+b0+8ZbB9+BuG182ELLUzDN6pf8nn5
	sGztYnTUzC5w4AR965rG8nH51ZErxiO5vZjMo6liWrKmNgzgYv9DE4e8uZdxBTQT
	+VfjygnIh6XlK+nGojWVWfMELpPxLuGyyBPFtOAql8HKPWNjfoLvS+2KrMIi+iTB
	Ma2wcTKk2jAyZKOcHL/V4DBDAzMuZE2fAAB7+6j90kA9ZCr20zfkbxab8krPIVfA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcuw6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 09:29:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S9BEMq020628;
	Tue, 28 Jul 2026 09:29:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg8xpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 09:29:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S9TDcH15925996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 09:29:13 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FF7E5805E;
	Tue, 28 Jul 2026 09:29:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70E3C58058;
	Tue, 28 Jul 2026 09:29:10 +0000 (GMT)
Received: from [9.224.81.112] (unknown [9.224.81.112])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 09:29:10 +0000 (GMT)
Message-ID: <d6001f44-0fef-4181-8924-45541ce53d97@linux.ibm.com>
Date: Tue, 28 Jul 2026 11:28:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] s390/cio: Remove cond_resched() calls
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-5-hca@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260727162430.1599396-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RZRyVYBZiqJRf3NIt0B6c0IN5RNHnf3I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MCBTYWx0ZWRfX4o8i0MZQY7Ai
 MuchS39/NtJU8kLZu2taSZ43i+2fv2Q+e+opELZrvi+Dt6EfVxyD6DPoOZ++TK0p2WtKhRJgtah
 g15OES0yftWYcvc5Mxek+aX6B/GQfjI=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a68766b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=yxu4S9OlT7h8PgVkVWIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MCBTYWx0ZWRfX/JA2IL0EFIrZ
 Jj5eB0SkUiRHZesDkeLquemo/TN9Fo8RfjO9z0hnBtncpbIVZZs+6oEJzrau15Xap8PpuDwJ1ta
 3NsRkliLK55j+h1BFCQ5CQmEahULof9dqZ4d2MnByfMJk7Zx0jF0JpACrbQsQ+OLlUGfCPPgptO
 QuhJpiIGoq6SFLfId1RijfirDy70TKCXatRRMZCLN5fmVLyx8Pj80ziWxU4Z4rS9UjrzyhXCCgL
 rY2CarvJ1KcP3kfABUvznu9DXNESOTNjFd9aWtq6Ot/IpPYjC6u5Xm+UUzWrbXrm4u+SDCSsCog
 3hGACXnR9+093O18k5VW0KeuiS2grsjOwr0mLFLalXJfRKQJ2bM+Rkm+7Mgs/gg6OoGe9u6C2Iq
 cWkY2ngHAwh5Nz2E92laee0/ZBjnpSGXjcmx4ZUezibWhjIqkL+FIPo+Y8sEXcmZviupUEsQ6PV
 2Tdf6cWfwxsVJBqzUOQ==
X-Proofpoint-GUID: RZRyVYBZiqJRf3NIt0B6c0IN5RNHnf3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280080

On 27.07.2026 18:24, Heiko Carstens wrote:
> Since [1] cond_resched() is a no-op on s390. Remove all calls.
> 
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Makes sense, also given that this use of cond_resched() was added
specifically for the non-preempt case:

To quote b207f5a8f9a6 ("s390/cio: Relax subchannel scan loop"):
    ...
    This processing can take a significant amount of time during which
    no other task can run on the same CPU (unless CONFIG_PREEMPT has
    been enabled).
    ...

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
