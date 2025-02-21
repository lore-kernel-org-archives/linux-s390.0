Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B482512DB;
	Fri, 21 Feb 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178471; cv=none; b=LlgozLlNAIYeYuorfA05sUL9Br9KGrIk/WjSsbkOl6RoIuxIcNU7wai/yEFdhw/1AihYk1kaCE+Hjl69qv/k0C5aTWhScv3A+ClHLTE0Z/z+2KxQgzHVQpcHiDWamFgoPl7kvc7hOy2yKu2Q8wByn+gq5KAGL1NERSec0FDAVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178471; c=relaxed/simple;
	bh=q5MJvVJuqUQh/mE/OeA9ua1qWPFbJQeP6jyr42YnnQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz0F3Bk6a21GHw6+X85r5VsNUTTbsdcIEtplaaU0Pr2+ydEuGqMsTHyfAvRusxYCaQxVkGa60yUhFjp5qLVXHh/Z3z7lt5yBNU9ZY4GhYPh6+AgVTUZ4HbcdZ+2prZJQbzg3mlvfjZTXAindOo1lrruYqik8tUN51i5g01d3Stw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=esNVt7/C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="esNVt7/C"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIMeh9029740;
	Fri, 21 Feb 2025 22:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZVayfxYo+3jaege4ZxLI6tXsJm660C
	ePAG7rqgEiJ7k=; b=esNVt7/CKssQsnR5wbpzZgro/DGUf6lbMyuSiPnqAWL1ca
	LdKpKmGAi1ItxXYID0YquFn834t+aILzD4Rd04SEo7lPR6c2WrITx93pfy7EN5xR
	XJkXLCJiCHJeqrWGTeTvOJyTIWtsqFG9oUtICi+6n5j9LtvG0oYoTrbrY3YIOCKS
	YHgIkAhhGtPlir0AjSjojNsV56W4PHzwmFa60R+s/1pjHU0dT8rOzZ5efecfYmSk
	kF4IkW0oTGttUyTACqxYsaOfrchJoM4ObQGiBhGirQ1kW+D7DJRqAk52Jfbqu/vp
	37corhQIodcmVLs6T5Ldz5K6P9SbOJIittN7NdWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xka8mxat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 22:54:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51LMsMSK032390;
	Fri, 21 Feb 2025 22:54:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xka8mxaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 22:54:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LMkSjN009683;
	Fri, 21 Feb 2025 22:54:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03yjj71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 22:54:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LMsH7542270984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 22:54:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC5F020040;
	Fri, 21 Feb 2025 22:54:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA8320043;
	Fri, 21 Feb 2025 22:54:17 +0000 (GMT)
Received: from localhost (unknown [9.171.80.218])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Feb 2025 22:54:17 +0000 (GMT)
Date: Fri, 21 Feb 2025 23:54:15 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] s390/tty: Fix a potential memory leak bug
Message-ID: <your-ad-here.call-01740178455-ext-7344@work.hours>
References: <20250218034104.2436469-1-haoxiang_li2024@163.com>
 <20250221151348.11661Dae-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221151348.11661Dae-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DE9G1AtDhvKP-s-M83gjw-gdVfungn1R
X-Proofpoint-ORIG-GUID: BGCON8Cm4yaKxTh96zSuZl3zsp_BOhRu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=463 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210153

On Fri, Feb 21, 2025 at 04:13:48PM +0100, Heiko Carstens wrote:
> On Tue, Feb 18, 2025 at 11:41:04AM +0800, Haoxiang Li wrote:
> > The check for get_zeroed_page() leads to a direct return
> > and overlooked the memory leak caused by loop allocation.
> > Add a free helper to free spaces allocated by get_zeroed_page().
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> >  drivers/s390/char/sclp_tty.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> Same here: no fixes and Cc stable.
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Applied, thank you!
