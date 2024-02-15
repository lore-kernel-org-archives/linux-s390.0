Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2B129A70
	for <linux-s390@vger.kernel.org>; Thu, 15 Feb 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995893; cv=none; b=hUnkYORrdi6qfP2jUzj/zzA1kEi/y/GkPt8UuiwHynP3qZM9fwTGAh8wCM+CmFmkdKr9NLLAeRuznJ5ImafvqjKRssDRofYG49dK79BSiwoSJHxtwxKun4u1xQM1gIb73igbr+lDHprkOgXaJSdVmm74FE5vraPmUs2FZK97kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995893; c=relaxed/simple;
	bh=zf945T+d6bRAWA0DpJtVzjywXUajRL0wHzfXnpaGcyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf7/BdKnxPZ5EaA+lMZXOWYACtzxOuXbVGEtuNme1zW6zMKRK9Q3PFjE7bAE2gL+OOeoyClQV/U7t5atujRl8mJrU4aac6spdqsFuPe4XdcqSP9iSRCiTZTKsJIz+EBfgdtR6UIAAxfe+V8sgsX48GB/3JymIS42wWIqqCNVH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CPjnd/v9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CPjnd/v9"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FBCUCY026375;
	Thu, 15 Feb 2024 11:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5YuObdz1zfAg2mVrqT8bou807owxpqnQdDdJi28X9VI=;
 b=CPjnd/v91XX6XmMe2ZrNnWXKvSKSHgJxcI4Ua4wkMRlDBx5lDA6qQnEdkiJxPYd2W1TH
 6+hoZbHyEbMb9N7o7Vi12uWneUO5eWxBwSATRdlmWEA4Iratc7ApK0W6ZLVoCMiY5cYM
 kSVXpqQq/0zQXbahQvGzjujgFmI5w12mYik8evy95JRgUdgoCMMidNNEZEt1oFZKvV7Y
 ovyqH/FFit5GGz6ZHXSS2ydRe03uA8xuyUvw//RVZdbEtORtXpDARlVHp9WxRr6f32HC
 X0/9PrzJRJNbHtCYoG43eOda8OagQuxsnfiXnK3p9gJ+N9LY5z7SRs6mfiRovVVFtOrk zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9hhh04fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 11:18:05 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FBGFMA007456;
	Thu, 15 Feb 2024 11:18:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9hhh04fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 11:18:05 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41F9FMd5009728;
	Thu, 15 Feb 2024 10:51:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p633pym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:51:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FAp1cw20972068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 10:51:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 904C920043;
	Thu, 15 Feb 2024 10:51:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B0AA20040;
	Thu, 15 Feb 2024 10:51:01 +0000 (GMT)
Received: from localhost (unknown [9.171.10.232])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 10:51:01 +0000 (GMT)
Date: Thu, 15 Feb 2024 11:50:59 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        hca@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH 2/4] s390: Add relocs tool
Message-ID: <your-ad-here.call-01707994259-ext-9124@work.hours>
References: <20240213104707.673053-1-sumanthk@linux.ibm.com>
 <20240213104707.673053-3-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213104707.673053-3-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HLPeDeOjekU0irw8KVT7KJ9j575kOalv
X-Proofpoint-ORIG-GUID: fAQht12W_od6MKXy6-5AWT9G7WoQur8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=746 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150089

On Tue, Feb 13, 2024 at 11:47:05AM +0100, Sumanth Korikkar wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> This 'relocs' tool is copied from the x86 version, ported for s390, and
> greatly simplified to remove unnecessary features.
> 
> It reads vmlinux and outputs assembly to create a .vmlinux.relocs_64
> section which contains the offsets of all R_390_64 relocations which
> apply to allocatable sections.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/s390/tools/.gitignore |   1 +
>  arch/s390/tools/Makefile   |   5 +
>  arch/s390/tools/relocs.c   | 390 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 396 insertions(+)
>  create mode 100644 arch/s390/tools/relocs.c

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
