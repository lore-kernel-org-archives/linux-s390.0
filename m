Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A4226CF6;
	Thu,  2 Oct 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427259; cv=none; b=g3IzZGUTwWVZgXO3nyy0h0PTgad0Gd/HwPyaskBvelANYnCFuY2ymc20/KMvpMR2xkdAMAbdmOygoPQWsicN+Z96PAo5YPndIGqBfYoI2b8BgrF2RjtzqG+L/sx9gHvT6tsUcXQbL6qBOz/FxCCRdAgQTlhRvRKbAvJRd4714Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427259; c=relaxed/simple;
	bh=CPeoqTjqy6nP4elJfgOIrR4zGQpTaZU6B7vuptyr3gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju1VK/eHa04m6Ht0Fxy2DEJ3yfwWMdzkg1P1cmu8SQT2XWEswiYCWKMNeqyR1PNujzdT+yXCP5txdhTuF7jxWhzltiS37emGtsUm5WFe01zD99kuFCAFtr7E0vWHRRhOmWcrNvIBmM9tClqUngAWU3yFknp7XQ2IDsalqw/uR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CWzllgmv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CWzllgmv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592C7Wpq026684;
	Thu, 2 Oct 2025 17:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EtYvrtTdEEG1tP8X4nPoVg80Cbh1KA
	ZmY01nL30CINI=; b=CWzllgmvY9z6QIVLDVBsfXg3wtrTrd5JUvW6KV7FJmlQFu
	I2E06Mrl4QyubseAXsmkJt9LjncW0Ur7dD52umKNlywhbbQklvSyO36hoRe2lPN+
	pq0CGp4FgF2fnZi2thm4UYuwCTIsJUZkinHpUgsLtR0q7Emek9XYKeVEwv+a9qqI
	h6HzFD7M2J/QfnwEqHuCGGvtRuzGH+F+X0sKvLb+65qwXSxd2YbeL3O1S/VkQUPw
	0RO/eFZY9PmRDCJGWhO9VgdRkyoaCChdGESMKEFGn56TZz0fFbKE2NJMk7tzxLFZ
	PtAoiO4GzeKF37DHFYfi23zvcMDlFL+F5VT9GJlw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7kuq3ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 17:47:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592FsGBw003926;
	Thu, 2 Oct 2025 17:47:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmy7adr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 17:47:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592HlTeY25100854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 17:47:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A11620043;
	Thu,  2 Oct 2025 17:47:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C50EE20040;
	Thu,  2 Oct 2025 17:47:28 +0000 (GMT)
Received: from osiris (unknown [9.111.48.99])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Oct 2025 17:47:28 +0000 (GMT)
Date: Thu, 2 Oct 2025 19:47:27 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <kees@kernel.org>
Cc: Josephine Pfeiffer <hi@josie.lol>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/sysinfo: Replace sprintf with snprintf for buffer
 safety
Message-ID: <20251002174727.12242Ae2-hca@linux.ibm.com>
References: <20251001174104.192486-1-hi@josie.lol>
 <20251002074821.7570A92-hca@linux.ibm.com>
 <202510020942.9BBB100C6@keescook>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510020942.9BBB100C6@keescook>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68debab6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=d4GQpDbzUz-uSDgubVMA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Dhq22xoqk4lpR73UX_5VepCS1XIrxpBn
X-Proofpoint-ORIG-GUID: Dhq22xoqk4lpR73UX_5VepCS1XIrxpBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX18qHYWNp6lzX
 H7BwBAH42FKBuAIyMsr1cheVjdq40YoDGo/2hFwtoGGsMnqNX0c1zqCVNGhwzUJfuG7z2U6KyR8
 /VYwSIHSTsScVo5V3b12/cWDeX54F52d+UODQBOltUUHR2aWVJ3dCgRO26vS6u27e9InjzHdT4b
 OVless1ZTkTPGHnxAQxhB+rYwvPtTABNz5YIfSAlRn0RD9fV0/ZKBCA/KJeItRIKuVAoHTAzRum
 rzTyS96aqF5IMWki0tOLukVFJ9YzQv5NzIJmRFP/2tG02PYIDsYspNXaI+v1jMLf2r9GyF3Iyb1
 M2Om/xdgCfkxWWkQclLv7VTMflhPTluPfH+2TOCsf3fUPpjDuti0vQ/ScaBTAd10uyDWemB5+fB
 cXXHGZv7vDcOQd4N7p4yGcU5DWxdPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Thu, Oct 02, 2025 at 10:20:35AM -0700, Kees Cook wrote:
> On Thu, Oct 02, 2025 at 09:48:21AM +0200, Heiko Carstens wrote:
> > On Wed, Oct 01, 2025 at 07:41:04PM +0200, Josephine Pfeiffer wrote:
> > > -		sprintf(link_to, "15_1_%d", topology_mnest_limit());
> > > +		snprintf(link_to, sizeof(link_to), "15_1_%d", topology_mnest_limit());
> > 
> > [Adding Kees]
> > 
> > I don't think that patches like this will make the world a better
> 
> topology_mnest_limit() returns u8, so length will never be >3, so the
> link_to is already sized to the max possible needed size. In this case
> the existing code is provably _currently_ safe. If the return type of
> topology_mnest_limit() ever changed, though, it would be a problem. For
> that reason, I would argue that in the interests of defensiveness, the
> change is good. For more discoverable robustness, you could write it as:
> 
> WARN_ON(snprintf(link_to, sizeof(link_to), "15_1_%d",
> 		 topology_mnest_limit()) >= sizeof(link_to))
> 
> But that starts to get pretty ugly.

If you take the context into account: the returned value of
topology_mnest_limit() cannot be larger than 6, but that's
not obvious for anybody not familiar with the code.

So taking your feedback into account I guess I will apply
this and similar patches, even though it seems to be quite
pointless. :)

> Yeah, it should be possible. I actually thought CONFIG_FORTIFY_SOURCE
> already covered sprintf, but it doesn't yet. Totally untested, and
> requires renaming the existing sprintf to __sprintf:
> 
> #define sprintf(dst, fmt...)					\
> 	__builtin_choose_expr(__is_array(dst),			\
> 			      snprintf(dst, sizeof(dst), fmt),	\
> 			      __sprintf(dst, fmt))
> 
> The return values between sprintf and snprintf should be the same,
> though there is a potential behavioral difference in that dst contents
> will be terminated now, so any "silent" overflows that happened to work
> before (e.g. writing the \0 just past the end of a buffer into padding)
> will suddenly change. Making this kind of global change could lead to a
> number of hard-to-find bugs.

Ok, agreed, there is all kind of odd code around, so it is probably not a
good idea to do such a global change.

> tl;dr: I think it's worth switching to snprintf (or scnprintf) where
> possible to make an explicit choice about what the destination buffer
> is expected to contain in the case of an overflow. Using sprintf leaves
> it potentially ambiguous.

Thank you for taking the time to look into this!
