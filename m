Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F686329;
	Fri, 10 Apr 2026 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812524; cv=none; b=eQrn1AHt9QMgOERYDD8mCWbV9MYJo9LwG+/BvISHKdMQRUaCawPOaN2042lGvb/WAe+voZ3LhXk71l5euU49iNNL//glXCEc2enje8nExX5Lsokc2rRWA5WiZpjYb7jUnyjRbDFPiss6YHMI1oHfM24m8c90+9aSIV0R8btKukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812524; c=relaxed/simple;
	bh=7t2J5UpGUsQhlqU9fPuo73wamMrDzEy92IiHZKwl698=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=tHbDSCMhXqfooeO8F8xogNcsgjvETYWigoDi+09lyPatuscKSLmnpWwnIZrCD9sQzI8Of1McqMlQwro6UBla1ESqn5GkQJMcStxO7jjgmYKVsLFiqYtfnQJMWLpRlJB1HLWOaP+4040YDmghZ12I+TfI8W0ZY5BsSgfxPKHB6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TUAKZere; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TUAKZere"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A958NM773967;
	Fri, 10 Apr 2026 09:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yaou28
	q7dHtKt66hCI/u4IYqtGkGgPeHTbzr2DtcfXo=; b=TUAKZerewkyy36EFgzMWlc
	jOJhQoID31vy7l99TKFlUo2/Gmv+SNd7NJa29Y/cdJK+U7RJR3zHobCAqrobTVXV
	pUN14j6FNd5QvJXV2wl/X58zKmT43JbpBT8b5BG+KC6dbdI9SJhYvT+BNZ9gAM+U
	USVt8RqoujbWMCUGDxw/SR11k2vKd7JphhEj03Nm81E5g1fEXQCZiJbZXEPCPnMs
	yXxOB6nWnbw7P+tD1QfSsPqjMdgctQif0gYsGQvG7QPx+tc6tN13XT96MFmvIZ7l
	Es2YoEHp9wSv5IqQ/ZXpKJIfWHVzqwS7rJ/86IxxcAoKrnXb/ndR8F7Ix+kDFg5Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hr2p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 09:15:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A8i6Gp026655;
	Fri, 10 Apr 2026 09:15:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg878u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 09:15:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A9FFsH55968220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 09:15:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 974A820043;
	Fri, 10 Apr 2026 09:15:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F8F020040;
	Fri, 10 Apr 2026 09:15:15 +0000 (GMT)
Received: from darkmoore (unknown [9.111.44.245])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 09:15:15 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 11:15:04 +0200
Message-Id: <DHPCZUIKL3VY.2TSR0QVXXUYCN@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <nrb@linux.ibm.com>,
        <seiden@linux.ibm.com>, <schlameuss@linux.ibm.com>,
        <gra@linux.ibm.com>, <david@kernel.org>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] KVM: s390: Add alignment checks for hugepages
X-Mailer: aerc 0.21.0
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-3-imbrenda@linux.ibm.com>
In-Reply-To: <20260402150135.196943-3-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfX4mR7qbe5SKbc
 s8r+19+IaHad76tSmadhRdeR4RYbKQ3DaSp496bmwDE87qqtZ5Tfoqoyk2hmLMH4OIjkg7YmNdP
 sy83ADwFO1pZi4RydgxM0QPN7igiahlBCcvZn/IA1Xm1cNmjrmXPFTJuzif4OyCM6iN6tqD124E
 QgbLuXxEzZ3FMQopyvBhFe3Xp9Af4ZATy0fB+jRJGLF4PuuvT+vBVWBI/1IVivgZBSe2fuWiVyu
 CpT8di8ETpChMR8SllJhgeLDF4D4kaou8z/BzNze/bzmAaSpYoGjlTLKmDHNilcxGy3GYwrd/8z
 l289PZ6k44RkjXtq9KyBxVT9yJnGUK0ARfnFqQYpS9C55AXrN+3fcaNDRNU8XoOMcI1C1naq3J8
 iyXh3F/yURNkpWZTjw/2yw9h5LumVhkQoW7eFJp1M0+3fQt+zVucQGyw4KW/mBfX0FTh+EN5kqc
 4svxdvKEovW2a6jCy1g==
X-Proofpoint-GUID: ksS_2FQ0LXp2HbOnICLj-kvSnbByvBqE
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d8bfa8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=bwOT_0aHw2EZLAc2GVcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ksS_2FQ0LXp2HbOnICLj-kvSnbByvBqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100081

On Thu Apr 2, 2026 at 5:01 PM CEST, Claudio Imbrenda wrote:
> When backing a guest page with a large page, check that the alignment
> of the guest page matches the alignment of the host physical page
> backing it within the large page.
>
> Also check that the memslot is large enough to fit the large page.
>
> Those checks are currently not needed, because memslots are guaranteed
> to be 1m-aligned, but this will change.
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/faultin.c |  2 +-
>  arch/s390/kvm/gmap.c    | 32 ++++++++++++++++++++++++++------
>  arch/s390/kvm/gmap.h    |  3 ++-
>  3 files changed, 29 insertions(+), 8 deletions(-)
