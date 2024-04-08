Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115513FD83
	for <linux-s390@vger.kernel.org>; Mon,  8 Apr 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589690; cv=none; b=ScOt8HkQkqdv/eLeRh10AdYIJDsCzNSN+tVI2GbMiaJfLskMP/aNpNCN2l2LB/Pd1W/b5FSaUj7XPDxJGUBmdpZCko418b6OGyHLD3TaUTUCrgarTyUEQjCf0hU6bu4w9nSnFCEBPtr3B3Fd0soRoznc09WwSwvXUKn/0UkIfmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589690; c=relaxed/simple;
	bh=HZ+2lU3vbSrUInA4ieXj9LDbHMQU2kQ7gffQ7dRi6+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krguRxTPb3Dt6/zxXAMx19GsKKhYMTVOUoV6fpA/5g5rDLCiVa8pY3KeL0i4O+tQATiruCspY6kepS3TKDU+lArpCVMBizvgXDiF1pwxnNTtPbV0dAVXsGF/WMGuHHqRMZqZYfDw48apwd3hWq8AJJOSSbWdMcGm8xQLKGOHkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E1l/j09W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E1l/j09W"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438ETwre005862;
	Mon, 8 Apr 2024 15:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+yF76t2t4YTRq26mWRUrtFjak8ZWr+J3ajO9+1D48zI=;
 b=E1l/j09WI4R1U5ZF7nbjKyt5qvjwDnJqoXCWUVk2PI33KDv1kuZw8wFpLrXJUf8rxZM0
 vJWMX1qHxch/EzHs9V9S/DGkAIGuYCLK7bvNFdO5fFVLmpWcpOKUPg5hYNmGGtZVxPcx
 pGBAg08xlC4pp0LlwykJcy1THmn6buHcEFOEASJLjMwZdqRKEyZ2qRIfieR8LtTZXkxc
 ih1QjF/hA0OfruTkGd89GaynReXPqYP+zdK36yp74m0FEvYyX3W1C0bgRkVzkvGgTbAT
 uIufvou8jCHnPIQ6Ml+hhS6/eieovi3HkbyXtOaPM+qGEymVm2CAwVUOIoj8fXrIL0e0 6w== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xchwur6h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 15:21:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 438DAxhZ021511;
	Mon, 8 Apr 2024 15:21:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbjxkgfvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 15:21:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438FKuRY9306436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 15:20:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC9EB2004D;
	Mon,  8 Apr 2024 15:20:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B4482004B;
	Mon,  8 Apr 2024 15:20:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 15:20:56 +0000 (GMT)
Date: Mon, 8 Apr 2024 17:20:55 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] Convert some gmap functions to use folios
Message-ID: <ZhQLV7nVuNFP/F5w@tuxmaker.boeblingen.de.ibm.com>
References: <20240322161149.2327518-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322161149.2327518-1-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 86pQLLvrwsc2Oh1FsuwbVcylQWO_gvei
X-Proofpoint-GUID: 86pQLLvrwsc2Oh1FsuwbVcylQWO_gvei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_13,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=638 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080119

On Fri, Mar 22, 2024 at 04:11:45PM +0000, Matthew Wilcox (Oracle) wrote:
...
> Matthew Wilcox (Oracle) (2):
>   s390: Convert make_page_secure to use a folio
>   s390: Convert gmap_make_secure to use a folio
> 
>  arch/s390/kernel/uv.c | 50 +++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)

Applied, thanks!
