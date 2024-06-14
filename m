Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE09196D8F;
	Fri, 14 Jun 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368801; cv=none; b=XpuVmds3q+sli4hl3zx6PlVbWn4HAs7AfIbz6eY9mtJkt3sAloB0vYtvQPM9XJbMpvyO8RYK+CSdEaJo6spob01klWz2YOCbKzyb3kaX/LFcsq8WSaB7f2TK9bALEajr4tDmbxuXnKW+sNXOhKSDZZ+OUpGTepHJg3aPLCQAb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368801; c=relaxed/simple;
	bh=ZLc0yPpliN5ipWg1U4qUS0H/B/YW0qMTnMAsbBcTLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fgid4BDK359oTGkqQ/4LQ6UluMwb1raa+DBcjXQxo5RpkhTbt4wK+TtLZaVc7F3ZCzLgJ8hpRaxZH9OXUXafTJx+8RWccOMVYdjZp9L0W/4OR8C3DySZJ/LjJuGSOI9250ZvrL6kKHJzVn6JkrkXu2JAOnap144lDpOmry26IaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qH5E5v2d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qH5E5v2d"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EC2uNN002257;
	Fri, 14 Jun 2024 12:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	VX3aciam6kqMjG8tdMnlKZNkMvaEskECdhcLJFjvzhA=; b=qH5E5v2dJFWsMHot
	ZpSnerqh8TauZS3HPat74R7e4G00wtSWoxOvdJ3/W0RjyBCcSBrO243xg9/hz7hC
	niIQ2ypabK/eG8UNHw6AdO4bcd7pm8EQoUaSx9QIYviCju1uhbxB+Zi3K2MO6viy
	6VArCQiVuw5fmP4xEE/rRUarY6i71QdeNuUyILBq1rWDZYu5Qz5Sg42XJ4q/YPOs
	7GW0ojSeLp82QU+yAzg9+euXAHTz/LcvdY0ZKGWrDRDZgC96Ik36CN5YxqHIB6H1
	+WF48ZqAVHVpe0DSzZu6zOi1otse6rBCfdNlOLzTBvBLegVWX6id0vk/tvggQl2i
	WQOwKQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrjtrghap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 12:39:56 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45ECdu3o025813;
	Fri, 14 Jun 2024 12:39:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrjtrghak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 12:39:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45ECXsTB003881;
	Fri, 14 Jun 2024 12:39:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mqhgn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 12:39:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45ECdn2n56492394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 12:39:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E4492004E;
	Fri, 14 Jun 2024 12:39:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B59920043;
	Fri, 14 Jun 2024 12:39:49 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 12:39:49 +0000 (GMT)
Date: Fri, 14 Jun 2024 14:39:47 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-doc@vger.kernel.org,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Sven
 Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] Documentation: Add "S390" to the swiotlb kernel
 parameter
Message-ID: <20240614143947.6384b673@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240614081438.553160-1-thuth@redhat.com>
References: <20240614081438.553160-1-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L3ZCK8s3FUgb_xX9nsmRbBbdijZvuXPQ
X-Proofpoint-GUID: rFe0PdVOAZd20twhdV7jPuhTp8oDRunT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_09,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=834
 clxscore=1011 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140085

On Fri, 14 Jun 2024 10:14:38 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The "swiotlb" kernel parameter is used on s390 for protected virt since
> commit 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
> and thus should be marked in kernel-parameters.txt accordingly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  PS: I wonder whether we could remove IA-64 nowadays...?
> 
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b600df82669d..423427bf6e49 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6548,7 +6548,7 @@
>  			This parameter controls use of the Protected
>  			Execution Facility on pSeries.
>  
> -	swiotlb=	[ARM,IA-64,PPC,MIPS,X86,EARLY]
> +	swiotlb=	[ARM,IA-64,PPC,MIPS,X86,S390,EARLY]
>  			Format: { <int> [,<int>] | force | noforce }
>  			<int> -- Number of I/O TLB slabs
>  			<int> -- Second integer after comma. Number of swiotlb

