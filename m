Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F362285050;
	Wed,  9 Jul 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062313; cv=none; b=J0KYRh1ExUUKPduqqdLwtzkklsBY36BRbMz5LLW1K/WUTQcd/C5eRd75GDwk0vud6YCiRmyQpPIXzt9XMTjn04H2FDJ1I9xBxMNpuZW17RuVgso7tuzlIbd0nxYdIHJ3KcVgJM4xAS+dJq6axdnF48biVSWTEtFhw2smiQ8fvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062313; c=relaxed/simple;
	bh=deqaLj8n/NAFDUKiP5E2BnlV+hJ0ERmOIt2foB27GF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVS4PDTchZ3GUCIHemzxODWCWJiSvCUaHnvP3a3QQlnlgBA6pi059WQhVIxHED+a2GXV0pDVizE4DycHqDHZCrtui2mhUty6R5a5Je3QxMpDjdqbc8M8NFHp8i/0w5KU2NUE/y+pWzHZujFDaEqs1bxNSiQjO7/mhrqLmFNsqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e0gXmM2N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e0gXmM2N"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5696hFkm011039;
	Wed, 9 Jul 2025 11:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BALjs8cFSvExIVBNi8L8lLdQ3kLyc7
	QtGrofM4HGey8=; b=e0gXmM2Nk1AmYLFB8cXcOefhHByeXJ+hFmw8413DbNL1ZP
	7nqq5Wq/VkXpj0Ed+4UfR+AmRU2/0IlhKBnNElxx2crZfQ+MAlgb1vKHhF+cGVql
	Yt/w2pB7vgrdZ6gsCHjTJfBL3p78FdaxNdkdvH5CtVYpMW5cHUfsXNCm4ojA+Ez/
	3fMA/NiTBGoO+HzEB3JBYpfEZEmIWr06zX9fuas8yKLtgzvSRDSXj+YViHnOAXAI
	bk1tDEjF9z/pApQccS+9796vQbvIrbEBEiL38RqkS+G+wQir0VothQeFQR0j8Hxh
	9hSpQfV550MQxrazTO7F37YG/LxfOsrXEWdwlDOQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnd5d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 11:58:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5697o0Jh013602;
	Wed, 9 Jul 2025 11:58:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkkysjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 11:58:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569BwKbw35914342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 11:58:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8BAA2004D;
	Wed,  9 Jul 2025 11:58:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B6F720043;
	Wed,  9 Jul 2025 11:58:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Jul 2025 11:58:20 +0000 (GMT)
Date: Wed, 9 Jul 2025 13:58:19 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <kees@kernel.org>, Akihiko Odaki <akihiko.odaki@daynix.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 17/23] s390/ptrace: Use USER_REGSET_NOTE_TYPE() to
 specify regset note names
Message-ID: <20250709115819.2052203Bc6-agordeev@linux.ibm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
 <20250701135616.29630-18-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701135616.29630-18-Dave.Martin@arm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686e5961 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=z4glEzOvAAAA:8
 a=-NsZcAWZZKZ1bNev53cA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-GUID: VM6ehRWDnWbw4T3e4r9waOE3AEN8zPyY
X-Proofpoint-ORIG-GUID: VM6ehRWDnWbw4T3e4r9waOE3AEN8zPyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEwNiBTYWx0ZWRfX7DpBeZ+tzApT 5C/26jd0RhV76vlAyRyk5qI9keDpp6ajISntt9lW2d6L/hFGFmHeSyd7wUUDgCKcCQr22nemyGj hYeovrL76RJp/5H4OH/OB6KWAaQwMa5nSVXdN6v7OZjJC47Q60N8Vh5kbAHsNv2OCgphRdOl/Ci
 mqWPgccGhtfJH4gFbyeYDOP9C/NNoet1Yhy9SUTEY59M8AA0hlJlFAdPZ2wBRk96zLa7pFBkf9u Z0YXP8QtESYN3q/s9lYUGRKe+fTkz4NYySsWuZ4aik2QiKMSL7fSf8xIdKkCpS8OysRdo6kmHuK q8e9b3N0PxoDUPFOeDh+nCnqnUzZuF2bAOfoy6Qs8A7z9HDQkOWesNh80m58jz6Vkro45nLBa/N
 v1FGeZyGPzFIRvx6Uctmne4Qaf1rx7spJHA9xIYAB6EOzzZVKqfGHjEI+PO7Ke8UG0X+tO6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 suspectscore=0
 mlxscore=100 priorityscore=1501 malwarescore=0 mlxlogscore=-999
 clxscore=1011 spamscore=100 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090106

On Tue, Jul 01, 2025 at 02:56:10PM +0100, Dave Martin wrote:
> Instead of having the core code guess the note name for each regset,
> use USER_REGSET_NOTE_TYPE() to pick the correct name from elf.h.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/ptrace.c | 42 +++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
