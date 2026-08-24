Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB9E3E3C53
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553882; cv=none; b=jZda8BgkxKj7DBsKEDgflv1yrhF8NbYoQyhu/j7duw4EflXyc/wh0oQSXSHTboFcc5YNPPvCMR5HdP7hpAxerfjGxskyz2SBubOIH6uvdsak+XNvaenLw052d9NejWKf7oFB1UsEILEDk3/zX7LFpoU3ex7+R9s79VYeLl+/y5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553882; c=relaxed/simple;
	bh=pDAwiqH8IpdbDS1zcEvbIew3zKpm0MWDRzxekOI0H4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6Rjs07IJJsP+rJE2MX4MruJ75b9ONzNKAlGOvWHxQcOxZ2DGRIcLy6D8904MOLxGcoXaN12zDVpe8QmMwONb/7PyNvsN9c/ReKq1yh3ZvCftsSE85JyTWF++LnoEl25+SXwlnvEAkhgRIljCMSGjlb12LgfUB5UmbAn+WCzyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JthkXNUx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JthkXNUx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5W8763284357
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 06:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wWlYVAWYqUJIBZbYSme0Hd1JqZDn+e
	oWVeK02Fl8uVU=; b=JthkXNUxHdFIObrGQAPzplnUcrh3cPPeflcMkRC1/bTz0D
	tdIGLnaWjKWmU/UT2dPvXU5f0GnYHnP7rE6wm67JOWG27jw2wtYG9AA8n2SjQBWj
	iNHAyLB1+PEigi92+aVaMyr1byDmLi/gAihFbzqymbGd1EbRO0JSfX8AZY4orTou
	9xyIrBqhBixgi7Uk+g9BBd7l3OY1/hwL2CavYNbo4BqODz6h6O4o66MIpiwKSTAy
	m29KvonxHv8pSi4oPxgsvulFpq8NsYPz0n4eJPNoiWo6h/oEEBf5vBcYRdvcMTZR
	FIhKzz2+I1+0oaTddw7/kuK/wFx7OTcQcKxZB2Iw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqfjxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 06:44:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O6fGtl016621
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 06:44:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pvked-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 06:44:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O6iZAP32375082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 06:44:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE3FF2004B;
	Mon, 24 Aug 2026 06:44:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B21120043;
	Mon, 24 Aug 2026 06:44:35 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Aug 2026 06:44:35 +0000 (GMT)
Date: Mon, 24 Aug 2026 08:44:34 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH] s390/diag324: Preserve -EBUSY return code
Message-ID: <ttk9hea@ub.hpns>
References: <20260811142306.4032721-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811142306.4032721-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uHwq_2zsVsM4u063GKbRr1NORAB92j4h
X-Proofpoint-ORIG-GUID: uHwq_2zsVsM4u063GKbRr1NORAB92j4h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1NiBTYWx0ZWRfXxDTDTMl8zOVE
 YGbD90q2ql+WC/i49LuGE4e4x4ThEZzDHxGoNT3RcEGKtHawe4zEvuwrPDiaseohEmBtaJIs6YP
 uzr5gyYlEh7PE6v72oIQUPyHobpHQLmO9B3px9VlhsSAQYLGWznSPDFF9pvVsCQnmcDAwWfQq8y
 qANKFTMJoeM3vsPqJr9PF8AUjxwcmNGSFs4bMXfiQX4BoGCVdqqcn2G//6aPUoo8dMvqMON1DR0
 SfZRdTmZlqCrV4eAlgRIXxcF8E6V+6JFtqF/8NQeHHLAtQMS6naJHrvgubpfV+Mv7kGaQOC4na3
 1WE7eD+oEkSVLoeh8drAYXZrwc1V/dXYsFgrkiGsKr4W291FyUBl0YzMT99r/Qo7FQcGJCMI00K
 2T8OYmKYvfzv35ew2Z/UOBmPtf/B0QMZdAwEFa2yC59A7TWuEXPtcqML7MnJ5kpQIQirIZSmgSo
 D1I5DhiXzlP8rR8UYnw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8be858 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KPRq9Xze4Kf-ZWUkMK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1NiBTYWx0ZWRfX/4oXOfn8DcwV
 ldyXT4WrnHfjx+5HOnJdOmzeCfdCk1xDODHwNXQnxKcEjAmPXbM6nVlyJmMsp/yaf3m+dCTKSF0
 /kpmszaORpiDOFgDiEAJFaVyIXKAU78=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240056

On Tue, Aug 11, 2026 at 04:23:06PM +0200, Sumanth Korikkar wrote:
> When diag324 reports -EBUSY, the error code is
> overwritten by the result of copy_to_user() and put_user(). As a result,
> the ioctl may incorrectly return success instead of -EBUSY.
> 
> Preserve the original diag324 return code and only return -EFAULT when
> copying data to userspace fails.
> 
> Fixes: 90e6f191e1ee ("s390/diag324: Retrieve power readings via diag 0x324")
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  arch/s390/kernel/diag/diag324.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thank you!
