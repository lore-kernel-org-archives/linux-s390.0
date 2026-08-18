Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6367F34AB1D;
	Tue, 18 Aug 2026 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054503; cv=none; b=IOY7KnPVo6IogwqwhKCGGGZY8i+LZSvlzb+zWrA1ORC06SIGhsbgeLlFcZic8jok+6FpPkIz7PbfXdDPMum2ah+oY0WnIIPPUqh+R5J+L5sCdMANGFLGTr2ow7XYe1dI0bU4idrbZptfcFLwI9lRWfd02EcF/nqzxSOSZEi2hSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054503; c=relaxed/simple;
	bh=gMpZiFaTm6fvnnan5q0yTEk7dZB6XSYa6m79k4RoqYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m651lAnWAxpOy0fefkoN2hubg6hRaVrnh53tHVHXjD+GyrhVR9PXQH84MYRIkJR9fvbu3YUrI2epIXdsLwR+sjTk3ofV/OQ5X6kbxstGjv76IuffZqanH0XnV1sEvGIu5B+qCRxnxmP9o1wB1BjZRCk+Swexogmz0GEmzzl5qgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QEO8N4dO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QEO8N4dO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAVoFf4121620;
	Tue, 18 Aug 2026 12:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HSxxRZGefKh0In0u0GvJexPyMujQYJ
	1MaPf9PybNez8=; b=QEO8N4dOFZJyWOraWG3QpYsTqgbPy15DVnacHTwS7Nmua7
	hPMyqfFwKr1GrtH3HM81G9SK4ff8IlUvMALTADrh6Jy3D5KmN2T/7zW8MozCMWGN
	dbUb2idIyVSFBFW/Xf5lQCH7Q6PcjWDD3UKf8dtZ+a8ND+S6Q4mD6ysDD8/V9jyR
	KXL1re+TBmbRn6PHSdlDQv7i9f4CRW8OalXnVkaAszxi/MOTaQMWMOZREfU9UV2D
	4eYK7miLz9SNE1bODuF1CC/iepg1oqdiVKputnkG+AIVzzxASlPRVMHbXB0aPSUN
	JtPOkn0lwpMJa7x+7/stTVAKbiiikq9WfmCb69CA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkytvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:01:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IBuIli023448;
	Tue, 18 Aug 2026 12:01:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq36y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:01:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IC1Wpl51184008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 12:01:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 074FD2004D;
	Tue, 18 Aug 2026 12:01:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D491920040;
	Tue, 18 Aug 2026 12:01:31 +0000 (GMT)
Received: from tuxmaker (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Aug 2026 12:01:31 +0000 (GMT)
Date: Tue, 18 Aug 2026 14:01:30 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 3/4] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Message-ID: <20260818120130.1411942A70-agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <52c9be0cf71a8896a5d76c148c38fb24a2005dd9.1786956464.git.agordeev@linux.ibm.com>
 <CA+fCnZfMkPDVyy0t9W-3d55M2ba9wXoRyzj2EWWYLEW=QO3zWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZfMkPDVyy0t9W-3d55M2ba9wXoRyzj2EWWYLEW=QO3zWg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX/HzJ7nnyCHrh
 +HaoG7Id6qPNfsSLkUn8mpVhPXOsqePWVGHOcVMdnZc71woPoeBm51360tzgkp6pAXAUkmsKfdw
 uySTXd818WHVCgQiDXvFNCL+sQKyINLqnpzF4En1gWktv+YUG8hOvwg3+qyuSpoEiPdUSfUjHy5
 sVUMA5g6I0ktA4IXxQ/SJockakps4NfT2kGZkqekhp4rQS327gew3p3GltYmDT9HAYP3WccN4nf
 lW3+kHKC9OLej7j4SUzXSLWhHYHTAj6DI85bAimADWgotsdmfZdmdT1ad6tbRNh/5OTcKIQ4I53
 4iC8dCbroiEFZaaY5vwu/7/n5x2FUnKJokVbBJnWPeZ2I5NKoxmfysQyNzsbJz/7yyGpIiFvLEF
 5nRR0QluSHGgCq4jk5daT3oX9pRssJggUFa3GgQIOIF7nLtiqgIcmD2WFwdXSQAMonkNZvPBddA
 AfBuyIgIdoEp0+LpXfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfXxMSVUzPPppRN
 ief7nN+40tBCowkFDgNL4o/GB7pq7c2SdXf+jIMTMvFH7PEyZ0wkjsP0P9uBY0fYWrHJJmR51WA
 qSzR0/DJz/X8lToW9bcfQV0/KPJssgM=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a8449a1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=8Uvy48UusG5hzorP5EsA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: N5GgORfBdGiu4Lb-ApmOs7EFDv6zGCAn
X-Proofpoint-GUID: VKmHdYY6rFcIke9BaqPbB--R8GbSD7J7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180088

On Tue, Aug 18, 2026 at 12:11:34AM +0200, Andrey Konovalov wrote:
...
> Hi Alexander,
> 
> Should all this be limited to only s390?

The idea is to allow any architecture to opt-in. Once [1] is accepted
this may look redundant, but I still see the benefit in having it.

I only did not manage to circumvent the ugly __no_sanitize_address
for ptep_get_lockless() to make it avoid "bogus" kasan complains when
gup_fast walks a page table that entered the lazy mmu mode.

1. https://lore.kernel.org/linux-mm/20260806083926.1807279-1-usama.anjum@arm.com/

> Thanks!
