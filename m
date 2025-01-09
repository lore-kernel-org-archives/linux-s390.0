Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83A10A3E;
	Thu,  9 Jan 2025 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736410132; cv=none; b=hLNRdPHe/6GkFgKNKpgIPDgw7ZnBFbCAhOtKzVdKvTDDGx8nkZGMTYihDmGJY8GG0k7vSD4GIV33g3F+0Jg4IavgpQVl2XwUQ5qZs6riexrR9mxIusLgxTeUkLeJEvBcyTK2cV7MXgYbci30EiTlJnuksD0F3PpCrrVnzPFE9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736410132; c=relaxed/simple;
	bh=o4yEtcNVMOgYLoIF5l3nod1UNaP471pYQcOciahrPGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwdP1iOH8RfhsPle4tZH0Xu7CYFP+my5qES5l9I4F+tlgezHFgEgPJJ7qrZZNZOk+4/ft/7trCJBwdLLbfh2zRfqUQvh0CLPyWgKKljORcixJGdmIMva6QgS8Kggdv4naTAB9XX2sjpmtbvt28VEIofA0/KqNMsJQtuUuaLll6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RXiVmWjs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RXiVmWjs"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5093qYMP005342;
	Thu, 9 Jan 2025 08:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=t7jVA7gUFV8nKFnPRMMn6jD3jPlBdQ
	FcYfqooydXZjk=; b=RXiVmWjsGdK9RGU7o0Ibns9BD5fU+4HbpdDbNIylhyU6Oo
	L3I8a2/lkVWzwZtSjOSP2rSMNg9gmalPW9HpagMj3iFuuQCAF9NTlacFLUxJklVl
	tP4gN48UqiNueq62bCc1ksQ3BNsO2WyYJZOT6hNh5mnzAPclJkYBflIFqQrzt6dr
	Qw1QnsMQRjkfR6pIV0Alp9zgoaRqGif4/CWINq7yMZ8+DsNCrMos8OBBLENTavjb
	iLut5jk6A0+Hw2exwU574utIjwyzShqSr1wHaxOO6XKCFwPmIbkEeZvDv8wWlCXg
	OBntWzCH9eAybX4Agx/nTXv7cHdAdZ3qNIiXPFnQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xc8xts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 08:08:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50987u7p024676;
	Thu, 9 Jan 2025 08:08:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xc8xtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 08:08:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5097ju2H008851;
	Thu, 9 Jan 2025 08:08:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq04a1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 08:08:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50988gb712452238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 08:08:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5597820043;
	Thu,  9 Jan 2025 08:08:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA79B20040;
	Thu,  9 Jan 2025 08:08:41 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.27.187])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jan 2025 08:08:41 +0000 (GMT)
Date: Thu, 9 Jan 2025 09:08:40 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arch/s390: save_area_alloc default failure behavior
 changed to panic
Message-ID: <Z3+ECLf7LHQe+Mdq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250109033136.2845676-1-guoweikang.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109033136.2845676-1-guoweikang.kernel@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qa7FqO4BukFwIvguM1u5zT0yxgNqpVDg
X-Proofpoint-ORIG-GUID: dEKN7p7U_xs-QV3NF_qGAVjkApnzna6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=502 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090065

On Thu, Jan 09, 2025 at 11:31:36AM +0800, Guo Weikang wrote:

Hi Guo,

> Now with the memblock_alloc_or_panic interface, save_area_alloc no longer
> needs to handle panic itself.
> 
> Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> ---
>  arch/s390/kernel/crash_dump.c | 4 +---
>  arch/s390/kernel/numa.c       | 3 +--
>  arch/s390/kernel/smp.c        | 4 ----
>  3 files changed, 2 insertions(+), 9 deletions(-)

This patch is a follow-up to v7, but instead it needs to be part of v8.
I guess Andrew would refresh mm-everything (or whatever he finds appropriate)
with the new version.

@Andrew, please correct me if I am wroing.

Thanks!
