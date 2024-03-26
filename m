Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93094839E2
	for <linux-s390@vger.kernel.org>; Tue, 26 Mar 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438903; cv=none; b=iWrsPmBzi09gdXSaDFnacuOZsKhC+lbL6sR5N11SRdzlnbaCCMXL94TMGmraH2tQiHHsbo1IjiRkyJ3nPHQjNxgrsIVVZ9yUNR6QyzNNmdJMU/GLedgyOxRxB0ljQ+lW1eVC5hGPQhl7VkBaU6HrzusdsnNLVv32r2NzX/Ii2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438903; c=relaxed/simple;
	bh=Jtqgs1GAm9bVxk9ytA+/IyqUWcT9g+BMckNgrBGGkzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohJtDAB4nRXW2q9OMjlNn0kij5pZUA+3Ag6N+4cvgzAo4mXSk5vHSeqUDHSmAXgn1h70of1YM9p0LpMzD3R8dN23QAV62CNXQrThRdCgnHj87qkvxMGUjjcw9BaCgo81p7flsgIdFpVA8LSlcWSYUlRnrY3AGCTWlVj5fvFDh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=izBNJNMo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="izBNJNMo"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q7KkJu027855;
	Tue, 26 Mar 2024 07:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=aVib63oZ5C95/6pumKZS6E53zWpKo4IcHONhpT4ylao=;
 b=izBNJNMoGm57+y2qvnSFA8MMlnFEijXd4fSKkmeN323uY8x2RJT3Bfc3o/8gENvRu3de
 Dd0uYls0sLO+ZoKwuBBegFDLy+L7CXMxR7MTooBaXG2YIxuBsuZPCpHrg010ev1ewnhR
 AFME49bnrq5vSSI0jOoLsnXd0wEYIbMf+RqLtkKiB42BjpSKA6Q//ZOUBugu8auMkWjo
 nx239x+ubYi+1RvKAqcpEU2tfS8B4pgUrMrKwGyShhktlY4T3mYm/2poWGceLrgDEXRp
 jiLVSP0DpW8kz64W3g5kc0rRvGXVQsLAlbWi95BbXRxtJjmBSdZ6Q9gZdRUUn+PR0E5e Eg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3svs01sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:41:36 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q6NHSi028685;
	Tue, 26 Mar 2024 07:41:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp6bv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:41:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42Q7fTvA49873382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 07:41:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E2A720043;
	Tue, 26 Mar 2024 07:41:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4988B2004B;
	Tue, 26 Mar 2024 07:41:29 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 Mar 2024 07:41:29 +0000 (GMT)
Date: Tue, 26 Mar 2024 08:41:27 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] Convert some gmap functions to use folios
Message-ID: <20240326074127.6078-B-hca@linux.ibm.com>
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
X-Proofpoint-GUID: ECitF8tZJg3tleEfMSFnyyf4Ico-0PV3
X-Proofpoint-ORIG-GUID: ECitF8tZJg3tleEfMSFnyyf4Ico-0PV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=722 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260052

On Fri, Mar 22, 2024 at 04:11:45PM +0000, Matthew Wilcox (Oracle) wrote:
> struct page is going to lose its refcount (someday) and as part of
> that page_ref_freeze() will go away.  s390's ultravisor is one of
> the few remaining places that uses it, so convert it over to folios.
> From previous interactions, I understand that ultravisor doesn't support
> large folios, so this simply declines to make large folios secure.
> I think you'd be better off splitting the folio if it is large, but
> that's something I'd rather leave to someone who can test it.
> 
> These patches do have the effect of making this more efficient; we lose
> at least five hidden calls to compound_head().
> 
> Matthew Wilcox (Oracle) (2):
>   s390: Convert make_page_secure to use a folio
>   s390: Convert gmap_make_secure to use a folio
> 
>  arch/s390/kernel/uv.c | 50 +++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)

Christian, Janosch, or Claudio, could you have a look at this please;
and provide an ACK if this is ok with you?
