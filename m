Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6D21FF2C
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595249; cv=none; b=ke1hQMEozM6Xfm2CqP/sjSWvv+u8miqWDkGTn11/B1qy28OCfNsn+sqrlud1UxHaDLLjG8GHMEIOCZK/DiLoAUoWqxbhnc4UPVshU8xcSrbVOiI6OvA7pPodUdGfPILzi5v78/m2wl6XdLVqE0QTX+bhHBX/Cj9CjkfgQ9gLsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595249; c=relaxed/simple;
	bh=c/54Xbyg6+RjF2A2X1CaEcOEtfVxD69R6P/HWsx0ras=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKLyNllkZ2F/IojC4fmKaye3S+kaw+DU5KrCPOyz2BOxfp8B2K7dbg4THABN7Pc1mf7bRrwDapH5ZJWeiHvjfXMLw695HVD7PxYVhtlbdD8cSpEkn31XcgHIqfVkQomFCDZqzRDWjgQPLqdhD/iEyLS/i2LSnkXSdg23ztK7Xyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JUd6Z3Dh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JUd6Z3Dh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA4QxU027488
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 15:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3XgmEgtW/ADLpxBiTJpfM2FUBzAaAX
	sD8+O0qOkLXB8=; b=JUd6Z3DhTiObwDo2OrA1CZgb1rHgH6JWPfPk72PuYkJ/Gy
	X0K1fkFcXJzfsJxhW3SljrkW8DPjT+hyoBDicZXBjKaYLT4GXglULcGS5EBWK+js
	yQFoFep8VvK1oSVurIQyniFsigigs23JYK9k+PPZMST5V7nAZIyZZFQsc3peAZeJ
	zR28fkGe5h4/OsYpVAHdNOUVv/HCL7AA4GKMoUcsbkktv/A0+yLUBmoI9C94a3GS
	SOE8U/WdrhYSSXczwbRjLt/dkCdTGWDsl+usTwwHmhlglsgfaatpjjFEne5Yq+ke
	XKzTXt95v6hO+NnlbIfG5KLfL7h2HzTfdb9qjD+Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688ajsge1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 15:34:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCkSc3005852
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 15:34:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxnv3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 15:34:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PFY2hj48169454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:34:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68D2C20043;
	Fri, 25 Apr 2025 15:34:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D7072004D;
	Fri, 25 Apr 2025 15:34:02 +0000 (GMT)
Received: from osiris (unknown [9.111.13.86])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Apr 2025 15:34:01 +0000 (GMT)
Date: Fri, 25 Apr 2025 17:34:00 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        seiden@linux.ibm.com
Subject: Re: [PATCH] fixup! s390/zcrypt: Rework cca findcard() implementation
 and callers
Message-ID: <20250425153400.7180Ga7-hca@linux.ibm.com>
References: <20250425143947.31249-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425143947.31249-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwNyBTYWx0ZWRfXzJTH/oJTWO20 VClzB6SdRQzFZXF6q0moG6lAOF/mb6LUFwbiqzLWbVA8Qhwf5+UfGyWYsI0nHLKgEBqIXnIJxPR +OGog6OIemUTuGjZ3qSVHOcYShip5t9/WGgDt8FoBeoMF0cAkZkEsQvwYVkhlT7EiONeEtujfRS
 NxsLZDx2spJ8dHmgeSzlWM9J4mP8o1P2MjKTBHaNCBNtcV5roftddB68DenvGYtxm6X4TwMxLYT F2zLmV8F3MtE2h2LX9MYurjIRQxeOi6cisvorL28OXHYNP6AFz8OoHsMkD8OTlc8YDem4r1VpkM i/9mHYAtUMBENu8DdKktHOtTOyp00MrjCHbDWWuKvmNJjiM/w+5ychPNhKpIb7MGBSl8Fp35UoX
 nKOCFcOz34IfTFZ40Qzzfq6cv1pd2gocuDIZLDSDzhizRCX5Q98CiCmJTGgcvWdlKzw1eQwn
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=680bab6f cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=EXrDrPNrueq3q3SAUfYA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: ul6QH3SXIIDQv--GnxnF2j-GuqvHb3Iw
X-Proofpoint-ORIG-GUID: ul6QH3SXIIDQv--GnxnF2j-GuqvHb3Iw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=510
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250107

On Fri, Apr 25, 2025 at 04:39:47PM +0200, Harald Freudenberger wrote:
> Ci run of the night showed that a CCA secure key which maches
> to an old MK on the HSM is not correctly verified. The code
> builds up an array with a given apqn array with a fixed arraysize
> and calls findcard2() for the CURRENT MK which fails as expected.
> So next attempt is made with trying to match the OLD MK with same
> apqn array and same arraysize variable. But the previous call hat
> set this arraysize variable to 0 and so the 2nd invocation finds
> a valid apqn but the arraysize variable tells there is no space
> in the array. Fixed and tested.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reported-by: Ingo Franzki ifranzki@linux.ibm.com
> ---
>  drivers/s390/crypto/pkey_cca.c | 2 ++
>  1 file changed, 2 insertions(+)

Merged into your previous patch. Thanks!
