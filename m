Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5D13D8A4;
	Mon, 24 Jun 2024 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235777; cv=none; b=Wbi5Mgi39ekHfeM/9DmgJXSQCr04CGUxHoK70ffTa9wTUUCLxL3CNcgwfeT2UTBZVvQhI7k9hmkLaxEkcz5roncxj2w0MPb/oI6zfMGxnURlNgJv9G2rNvxmrhrBPk01hNbm812Sxrs+bgse4tyN9ag+1pjil514sTdq1iNQEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235777; c=relaxed/simple;
	bh=84vJ542JRtby8eCchV2tJXKQxGZbveqrrwFaZAic2IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcuFQnItHvYQKT+QBLsG6Rq/xIZE4uqqY4r0N761V9z1IIK1J97Xmo8n1GJSTaA8Y6Jx54bX5HQJlChAMsgMosv8D655ifT15l9wjZVyWUi3q9jzyAT0EqS9UOztEEQDlXMVjMR3azETRK8h15j9gPT3pcx+lq8M8RediXCNWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a24OML9u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a24OML9u"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ODMHOI008890;
	Mon, 24 Jun 2024 13:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=84vJ542JRtby8eCchV2tJXKQxGZ
	bveqrrwFaZAic2IM=; b=a24OML9ukaIOVAX9zS6D8aMn3mki+ODjECn3602zd7a
	T93Dh/3MDMgexWlzGOplIqWgT9ctvrKfKI+5ixKF3VhT78A5owYr4+IfLhmiC/63
	kwMu0fOOnYtEYHjOMXyNXV+os3uQl7y5criOWWXx09qHvjF873JlpboLlK6uUvrA
	9JvJ+Vi3fQeczoXQyrWApE4gshF/RmuQp+ygAUbbobtfRpACWKzv384gkoI6xTfr
	qj0p1zaB9Kit4C/oH+bADpBa2HKBn3VmqDcnOaDzTQ/dDvaNL56/TUTHGzDHzop3
	EHQw16AmN+W32xpTXBVDAloYUoezwUmMYLAkzibn3HA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy7ha8dg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 13:29:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OAgYxS020024;
	Mon, 24 Jun 2024 13:29:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5m8ph1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 13:29:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45ODTSWg47120892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 13:29:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 911D82004D;
	Mon, 24 Jun 2024 13:29:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F1520043;
	Mon, 24 Jun 2024 13:29:28 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.30.36])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Jun 2024 13:29:28 +0000 (GMT)
Date: Mon, 24 Jun 2024 15:29:26 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <Znl0trzTF4gaPraE@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NzvMGOYtXf5NnUPpdP14ajt31T0Sv2bE
X-Proofpoint-ORIG-GUID: NzvMGOYtXf5NnUPpdP14ajt31T0Sv2bE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_10,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=564 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240107

On Thu, Jun 20, 2024 at 04:34:15PM -0700, Omar Sandoval wrote:

Hi Omar!

Thank you for the report!

...
> Any ideas what's going on here?

Yes. I will look into it this week.

> Thanks!
> Omar

Thanks!
