Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4373391837;
	Fri,  8 May 2026 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239346; cv=none; b=Q2QqF5CubhMkLqFNKyEN2QB0aq0XnzhKsOMdZXytwFofkdfXYY1YGc7lqIYipbMSNltzRlXc+lX5mqgznfAQZtlNpljv512xrU6KCm9KH0bc2Dfs6gGGvmUsycrdoQJaNAjdPEN9oEoh3PPjl3VeWijvNrsOQryG0c0X2hQeONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239346; c=relaxed/simple;
	bh=UEwLSfCLYr9ekGwQxJfjsoHYHTq/8/nFDqjQdyE/UF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu6aXRKz/UwenLJkfVFETqnU4u34jluaabMJTPEvvZwogj8OZelylqOKDcPYulhKPAft27OwfitWCqGUKNXL3/XHtquNC4b5Tup+1BAWi1x13r93b9uAUyrBSHOPKsMlnLhmdQtCleLMo5shC0FfYum+xlBHJ+wq7/46X4jlkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uog7q9bJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uog7q9bJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647MdOQ92752196;
	Fri, 8 May 2026 11:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hoEvtfnAaFSl/3LfwRcaeH3I0H+9QK
	ew9Xs1qI6QVco=; b=Uog7q9bJp7ZttCjE/Eg4+LzJeDbbuKt0YjsZcul2p0MUg/
	VW0df1IMIn4v/cuoEJJJk3B7tb3A45DA7zfC2QvaubMQ6UYUyNbVr2Ra6j/qN4si
	iVlcbvZFf1cJxszlaAzDCO4JInDgbrfTeD9dAxNEF22WDLUCzzeYoDHSyJvNOCy5
	B3ivKx//cHSCtPBAV7lhQ3E4IcCIjRSBEPrrigd1+TsonzxQdse6/7CE30eknwm0
	qDJPhK2cudqYvWtSFD4YNGt07zfQ/tiI1r7xA7wI+83s6TPkGHSVVyxPYbjE71Pi
	WdOQ91YO0lmmsd7K4tp2XlZtAsu7D+xzaD6G3eZg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x53e5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 11:22:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648B9XqI011688;
	Fri, 8 May 2026 11:22:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hfvhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 11:22:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648BMIWe43581888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 11:22:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFEB42004E;
	Fri,  8 May 2026 11:22:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8AD42004D;
	Fri,  8 May 2026 11:22:17 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 May 2026 11:22:17 +0000 (GMT)
Date: Fri, 8 May 2026 13:22:16 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        meted@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        akpm@linux-foundation.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] s390: fix dead defaults for
 S390_MODULES_SANITY_TEST and S390_UNWIND_SELFTEST
Message-ID: <5bd572e5-78c6-4f6e-ba95-4e79a8ef8341-agordeev@linux.ibm.com>
References: <20260414215651.151228-1-julianbraha@gmail.com>
 <a3adc8e8-ce4c-458c-a0c8-c0e66078589d-agordeev@linux.ibm.com>
 <b3dba59d-22cc-4404-8876-8fd4e22021b5@gmail.com>
 <3ec20142-09d1-436f-a623-21a2440ef7f0-agordeev@linux.ibm.com>
 <cffeec5e-068c-4562-98ef-f65e346dff3c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cffeec5e-068c-4562-98ef-f65e346dff3c@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDExNSBTYWx0ZWRfXw3re0RDHs0yp
 zmRC+Aekj4BjZUnjmZjsBgrp5jbmEoIZWpAYAQma7qzNKh8w0WoaYGfEz5QgC2uHOsTen8J1kCZ
 IQS6rZ6J/67iujG4lUG8zu72tcEJ58qo1KpjF8oI0Ca4m3ke35HcF4bnHG3wsJhCi3eNH5pBUmv
 ZDUXJEIP5EzxHUufdCx3b/xVEI4nziVkJqmAe6z8FQRmeMedmFJ6dctizEhnRVb4cHSDDHcObnW
 XP6pgzmnz1GuccO/XD9XmS9Ar0fUYI1RuLC2NjAVwvQUrdZfwEUKTrsKp1m8PPWB6Pgn+mm9GNx
 N3UtqghRKRv/BcB/bZO1nr3x+qAFH+AsmmG+/dy9ddihHdH3mF0Q/GR8WkR33DVlVJFKW39tlJG
 zUs5CPIBb0LchkIYU5KniI+SehzmBpmUt6h7z3SILPQ7n3mFL3zWxrzTUplg3fJ6IDROLkgKMNV
 +2X3XrbSirUh8puC/yw==
X-Proofpoint-ORIG-GUID: kxyyMlWPTAFeXWNmthmRPNmliyb_zuo6
X-Proofpoint-GUID: 0QoY5FWko63fqpuw7YgicSBSLKoe3i1f
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fdc76f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=Nzc7ulkFhySeO2r29UAA:9 a=CjuIK1q_8ugA:10
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080115

On Wed, May 06, 2026 at 05:51:19PM +0100, Julian Braha wrote:
> On 5/6/26 13:37, Alexander Gordeev wrote:
> > In the end of the day I see no impact on the end result (aka the
> > generated config) - please correct me if I am wrong.
> 
> Yes, there is actually an impact on the end result / the generated
> config:

That is what is currently generated (likely because of "depends on KUNIT"):

CONFIG_S390_UNWIND_SELFTEST=m
CONFIG_S390_MODULES_SANITY_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set

> When a user of the kernel build system (e.g. 'make menuconfig') enables
> the config option KUNIT_ALL_TESTS, the user expects *all of the tests*
> to be enabled. Which is what commit
> 25d36a85c61b ("s390/test_unwind: convert to KUnit")
> was attempting to do with these tests, but it appears they made a
> copy-paste mistake. This is the commit referenced in the Fixes tag.
> 
> The point is, these tests were intended to be included with
> KUNIT_ALL_TESTS, but aren't. This is unintended behavior, and the
> definition of a bug in the kernel configuration spec.

I could not recreate it. Could you please provide the exact steps?

> That being said, I do agree with you that this is pretty low in
> severity, as far as bugs go. It is kunit tests we're talking about,
> after all. I'll check with Greg to see if he thinks this is worthy of
> a Fixes tag. Another, similar patch I sent out includes the Fixes tag,
> and has not received any objections from its 3 reviewers and testers
> so far:
> https://lore.kernel.org/all/20260405161545.161006-1-julianbraha@gmail.com/

Well, this is not about severity, it is about whether an actual problem
did exist and was fixed. The patch itself is fine 

> > I think once the tool is officially included you could refer to it
> > in the commit message,
> 
> I will also check on the best practices for tool-assisted development.
> In the past, I have received encouragement for acknowledging the tool:
> https://lore.kernel.org/all/bfdfdb05-77e2-455d-b68d-9da3fd9d1c0d@lucifer.local/
> and the official kernel docs require an acknowledgement for AI tool
> assistance (although this tool is not AI and doesn't generate code...)

I do appreciate your effort to bring a new tool! But unless it is part of
the toolchain it shold not be referred to in a commit message as far as
I am concerned. IOW, once it is in the tree, it is fine to mention it:

https://lore.kernel.org/all/20260405122749.4990dcb538d457769a3276e0@linux-foundation.org/
officially 

> - Julian Braha

Thanks!
