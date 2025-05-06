Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E52836B0;
	Tue,  6 May 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544345; cv=none; b=Azs7CPPTkDywgmFbhfZkH12hXfWtmZGfr8ZeMoS21QKME9U7mUWKD3l6zm8nH/YZXEPw7gG7z0FABNt7GU0ogxiWr0ikHArNgnDn4oCgbplYFknOJWID40b1G6UCRNuW0CXO1kkFt1ZCpxgZInbpSuJSwd+UQnjGOVEV0Dobs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544345; c=relaxed/simple;
	bh=yrcWGN0FRR1RmFwO80UnVdv0ehhWHreiwjWlwco00OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkU+vkjc6RDf8zXldefxomDAwxYuuodVgYkqg0gBfDM227RvogToERAzNIotp/OijTwYCTXPalLuzCbkQoXEsedgXI9JMyJ0Y1/xLrPvh8xv+GO0r/NFWpGiQYDLFkD8YlUVp8sbPFt4R+kK05jfkhNbCJVADSvofb9jk2gvkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f7ILB3WN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f7ILB3WN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546A44ax010338;
	Tue, 6 May 2025 15:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yrcWGN0FRR1RmFwO80UnVdv0ehhWHr
	eiwjWlwco00OY=; b=f7ILB3WNRIzo9hd43jsqZAwatPJlbhU1jzT+0eF0M9lnlu
	hoZUg4hGNIGtI8wKByG4L9qxJgy9ASWdTUGsEYG6q8dpQCG8LON1sxXi8czycARy
	UumqE/qHZOgDKhNenGXti/fbgIZiUD1nqX9OuNy1JzLlccq9gmLbchMdYX8jM8l4
	B2gSs0jntSWMlD036/s9Zmb5xNVFEXWl73doP46gKvmO02G3laDkFqlswnkS4w8K
	CdApbYavPQXN5iEjHQoNtMN9F98HWzVcK7jQBx09GZpPycPjAuSkf0e0MxHaeTt7
	iznvv4fA0x6ul8cN45gjSh4klcgmR0m23gjFks2Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgbj9k71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 15:12:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 546F9YA4027233;
	Tue, 6 May 2025 15:12:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgbj9k6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 15:12:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 546Clukk025798;
	Tue, 6 May 2025 15:12:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuyv7vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 15:12:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 546FCDAb51577334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 15:12:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32AC120043;
	Tue,  6 May 2025 15:12:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED0A820040;
	Tue,  6 May 2025 15:12:12 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 May 2025 15:12:12 +0000 (GMT)
Date: Tue, 6 May 2025 17:12:11 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 0/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aBomyzXY9LK9+B6B@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1746541531.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746541531.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Flo7NbBOtUBXTZo_5Gpx1aOjUuybx3zX
X-Proofpoint-GUID: 69YYGADS6fH5-LuvTenpw2Dg75BsPUia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0NiBTYWx0ZWRfX/X6drwUxPPFI wPjp8DsQhNGJMfga0vYSpVzRYC936Loz+CkS8LmgXtCjGdpwTaTQgmK8nn/Lwhm25c58ldAcaTO NVVyKdh4YPYswJ90hhPJWq4y7kZ3qgOtmG5FBkOeK5yjLTPut7cRrgzAkmBwO1iKi8z7++DzsaH
 XnPE9ApE9NAGkG4hj8VW+xj+jWWYczMGC8LtDryXpSrs74qdxiIohE1swH6ehzte4nCNoux2OGs tPrLI33d4xDfsu9Vte+IBZzObJrqvlGlSK9MpzJP+P6wbbfy4v2H2pWbctrI79YhRFpiZOJKB9s APsv7zqH/cHbn0agWiQh9jXdWVippB0lh2QywrZpY/AYZrSRNn0frtpsJ7pRPzHLZZPnuiVjSJ7
 g6/T9zzOsgB/q2g69FQazs2MIn75IM+hkyTIXce/jFSSYO4gQ+B4zn6IoqTYg/aq/LM5l31k
X-Authority-Analysis: v=2.4 cv=FJcbx/os c=1 sm=1 tr=0 ts=681a26d1 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=yOTKoNjM66L08_-4LxgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=401 phishscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060146

On Tue, May 06, 2025 at 04:34:32PM +0200, Alexander Gordeev wrote:

Self-NACK based on comments to v3.
