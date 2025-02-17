Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B9321B199;
	Mon, 17 Feb 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809007; cv=none; b=LQNrTXAAOPoTmtBi4LZCYjMHSlRrY5CdOCq+842V17wwF0zYXDt0lmLowewqH1Qw/JLADY9hx7u2Bn7tZRNcYxlAWodw2trCRRI+l7GQazAolslgTH5R0fljXgg8Vq5PChi+Tyw79FEPhW5zYDR4v0q9gnMa6X59ZFxkr1RC3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809007; c=relaxed/simple;
	bh=AmPIqb6W/RQ7sHHTzck54ZnImJBud6fFxyIB8YUgVN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNPGicxdW35afs1kSOFny8PH4uJYs8SYF8jiE3ltZKTCv82K352h9O8tE3OdYvRblgjlJ/9/tTdI5n6jMs/oo8pCUdC2tbGXe98A9K6PgZypjlCj5cpuzdNxN5YBla9sv1uQ2gtlbO6b4e7cKan/hmmio6A5yNUaEHw3SZxk0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SmcMMC50; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SmcMMC50"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HCLeBH015205;
	Mon, 17 Feb 2025 16:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cgteneJ0Vus2miKd8v5KmTdHzgw8Ru
	6KKzLJdtIKJ90=; b=SmcMMC50GW0v9OwZB0zHSyNxYtV7XERIK6Jt2KhuDdPOQD
	wRZvedse+dPfk10XGrprDqkl8MVrb6NhjaUKlBvPlmQyiwzBwWnzmV3COYPh0l66
	iDaDG69s58FPUFEdNpNfZaxTt3E+8qEdF/aw7BBEKdL9N0Ry9OMJqmnDf6jy0FeK
	dvCk5IpnVbB81Qe9Bs9Likl4TsXoVN+EthPvRd8nugRZRPt4RfkUk1ygUTp/rsJ5
	elWkIfPm3PqjYfoqU/1nXa7jeVvzX2AcI1Exfkc96hwOrGncNVXW4hvQ8XpCq98u
	xSYNXW0JbrIFJpidHUmBWjo1RarIUF5rpAaNd79g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uu69c07q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 16:16:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51HFtE3i032581;
	Mon, 17 Feb 2025 16:16:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uu69c07j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 16:16:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51HEOjKx013259;
	Mon, 17 Feb 2025 16:16:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7fken1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 16:16:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51HGGdKW51511758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 16:16:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A60520043;
	Mon, 17 Feb 2025 16:16:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D188820040;
	Mon, 17 Feb 2025 16:16:38 +0000 (GMT)
Received: from osiris (unknown [9.171.53.224])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Feb 2025 16:16:38 +0000 (GMT)
Date: Mon, 17 Feb 2025 17:16:37 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schwidefsky@de.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: Add check for get_zeroed_page()
Message-ID: <20250217161637.21424Ce0-hca@linux.ibm.com>
References: <20250217153146.2372134-1-haoxiang_li2024@163.com>
 <20250217160117.21424B3d-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217160117.21424B3d-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: usbjZRp83svHyQjJRBvcKteDeGxxMZg6
X-Proofpoint-ORIG-GUID: V3XVaIvsNwwoLAuwNN3QD1XP3BNLikx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=645
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170132

On Mon, Feb 17, 2025 at 05:01:17PM +0100, Heiko Carstens wrote:
> On Mon, Feb 17, 2025 at 11:31:46PM +0800, Haoxiang Li wrote:
> > diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
> > index e5d947c763ea..7447076b1ec1 100644
> > --- a/drivers/s390/char/sclp_con.c
> > +++ b/drivers/s390/char/sclp_con.c
> > @@ -282,6 +282,8 @@ sclp_console_init(void)
> >  	/* Allocate pages for output buffering */
> >  	for (i = 0; i < sclp_console_pages; i++) {
> >  		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
> > +		if (!page)
> > +			return -ENOMEM;
> >  		list_add_tail(page, &sclp_con_pages);
> 
> We can add this check, however if this early allocation would fail a
> null pointer dereference would be the last problem we would have to
> think about.
> 
> Anyway:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Wait, I take that back. Now I think I remember why I didn't add error
handling back then: the above exit would also indicate a potential
memory leak, since this is a loop allocating several pages; so all
already allocated pages must be freed, which would ask for even more
completely pointless error handling.

This is very early code where any allocation failure would lead to a
crash in any case. So either do the full exercise or we leave the code
as it is.
