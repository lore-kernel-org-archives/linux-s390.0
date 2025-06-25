Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BED2BD011;
	Wed, 25 Jun 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843922; cv=none; b=Fyh6J+PwYKPH4w37DwHQkycGMfWyD3ig1VFMUga5quLPscbdf/4sQt03qK0d9DHy7b34Q/96eOiumNPjlwUYGn/rYQBNgR460Rb+JiQIJpSD71jXfldNr9JccivV5zCZFw8gd1lpK+hV2MM+UlKtlm77rvnOZV0krsBu86puw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843922; c=relaxed/simple;
	bh=8WdkpHh9ihGxDLz1l3NF+mD7rcsSpB/4RzlTSLNQQgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZTt6EMRuKnMEomNtaIdE4pxvHpyrOmHoA9wxjvMaseXL7ht0zNPT26iuX1u9br+eLNSVVPa5MuXXg9NzzBoRgDCQOBLmO4pqTE4QERcRs5gOgd7cdExQsEmZvCdcsRhN5ykUu7fH0L9bvfVt5EN/QtNLJcXK1Eiv0VPoZt+MIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oYb6ahlJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oYb6ahlJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P2h1iK029075;
	Wed, 25 Jun 2025 09:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pW+mWi87HkS2sbIpDcichjdcRzMO14
	+ztmmlTG3x5nU=; b=oYb6ahlJunQv6zxmgWbY0FacUt6QNm9xJoL8Wff0jdv9ef
	C7F6Q942tzbIJhPHZFQnRfPxF7Bww9YHOIZ5BxYAfyijc5T0+k40laQ6EjY71MLv
	qWpBngUIytL0VFpNM7YXQ9sIWAriaBMWLmoQ7JUjVYxoHmqVqpVyptLGxm7TDXnX
	xL/2b6dvJVQ8RpYP98TTfjWn6H29i5OlHhfyiTyenhIW6QmHghKCn6D1fgku5rII
	zDVOLMFYS99VCWurP3Gu1zCZkojXFNrXClvQys7jQ1VMBcSHOww/0WMwYj97nWRR
	zifStx9mNpHjc7W4YiCZ65yFue59rVIZexUrwslg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme1eb6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:31:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P7YWkP014723;
	Wed, 25 Jun 2025 09:31:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2ga3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:31:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55P9VqCH44499408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 09:31:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C18E20049;
	Wed, 25 Jun 2025 09:31:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4423220040;
	Wed, 25 Jun 2025 09:31:52 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Jun 2025 09:31:52 +0000 (GMT)
Date: Wed, 25 Jun 2025 11:31:50 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] bugs/s390: Fix compile error with old gcc versions
Message-ID: <20250625093150.7485A0e-hca@linux.ibm.com>
References: <20250617135042.1878068-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617135042.1878068-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685bc20d cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=gleN7Cury3K8distblQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: P-VPh-kXSaVvALZUE4udkEr2-dv12pnm
X-Proofpoint-ORIG-GUID: P-VPh-kXSaVvALZUE4udkEr2-dv12pnm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2OSBTYWx0ZWRfX0rHDKHvjFhKI CrsMHIaO2gRYSntwOKapPQ7wrhS/oYODvyKE/H6gAIpIKzL7B9ySEkabw0SfyDK9vEz+Jfcnuic VLyYcpZgReEj0r7N+R7Syl0twyuu+9UmUrjxjv009zAvu/ngRbtZH83JCoLehtsNc4SoxK9O8U8
 n3AUuvvUrBxtZA1kgwvVdAyD/golXpGtjpHAhbaBTEMtad0FOzmO4o01G86onK+y+DVMUQgZgu8 WN6f1CQurMoe646wV5ieSA7p4rOv1KRE5qC88mUZay6Q9yHlw/NaIM6B6aWjY1NJAgJkeBttd4G 6KZRGPumQpNhMyiGXWatR6a9+hnwmt7xtEsh/bQE8EoxghhxvJZvGFxbuWtAyOR//IEx7DNyuEs
 XzvuYgukG9WkXEhflbcGSR8VR3RwWpLc0PT36u9IOYMCY6Q7uOX0wZypa/on2OR9io0OXJHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=694 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250069

Hi Ingo,

> As reported by Naresh and Anders old gcc variants cannot handle
> strings as input operands for inline assemblies. Rewrite the s390
> generic bug support very similar to arm64 and loongarch to fix this.
> 
> Also use the opportunity to drop the rather pointless s390 specific
> WARN_ON() implementation.
> 
> Ingo, I think the two patches should also go via the core/bugs branch
> of the tip repository.

You might have missed this, but this was directed to you :)
