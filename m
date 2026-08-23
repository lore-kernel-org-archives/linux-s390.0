Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F9238D54
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787520095; cv=none; b=e1Anyv49XjOGpDFXe+mOSsnCiy+NjaUiquhYXAbUV5nDMqIt3v2bE5AvBgqD/L5A5kd1y2tIyuXhOi0VUvQT6dn0zKqAymHuuAicv27YPPCefGhKDVW/F6jPf/z32Yw9mKL6fUvobVUrwHjzwcQUnqNx3hcUvig+nt350SMTM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787520095; c=relaxed/simple;
	bh=UVhzmJVrifscwAY2H7CsQF7ifXk3pNDXpaPnJCj6+/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQWmDAaEh0bDDAHI9mwLbHIYOWCn4zyYohLcRwbIZqeCWiWZl1RtXGb/NnHlt5t06H9ZbfL6PjnVmvPhasVmEpc2U5d5w89+r6UeoeJinXoiCgFEq7caGriPlHTxAXVXgwld3ke7waSj+SqyXJuBus0fELl05xIIwJ0kmO8tug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iX74YnGQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iX74YnGQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NGWWdl3491094
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 21:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZXDu6Uail4I6TDuc1J+dTWhcD67//P
	bjbeSuVoXB8wU=; b=iX74YnGQIuUmgKrmxguB3OCoVQsgaeqL1G/lu+dDxC4N5K
	W+TRhhGOF8/KITdKNAhm6LPKBbRVO3EKYEXaBgUOrHwFwckMOqLJRaLSt10w0kJ+
	owz7VOVcDe7D5EaiReiKwkKspE5MhXrypzCSsX4k9pmQuZ1niFm4lv1NVUH2km5/
	j80Ctim2Ngq31U0NE62YcJKSvdjpzV+uY+zbq7fNtCFMGH3wL3RpYERgzIqRgZYk
	03BbjROv0ZE/BjZASS8F50f5WYR4FsBi2BkmPV+2o4wN9Inhw83kt97HEzWxCOU4
	F9Hc7gsBPN0q6no3xiro4I7QHZq+46tPmiCFUT0w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716he29f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 21:21:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67NLBOAP027185
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 21:21:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvtrx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 21:21:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67NLLSmJ43778406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Aug 2026 21:21:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D3BD20043;
	Sun, 23 Aug 2026 21:21:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A90120040;
	Sun, 23 Aug 2026 21:21:28 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 23 Aug 2026 21:21:27 +0000 (GMT)
Date: Sun, 23 Aug 2026 23:21:26 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Subject: Re: [PATCH v2 0/1] s390/zcrypt: Validate length information in reply
Message-ID: <ttk8rbq@ub.hpns>
References: <20260820155003.945837-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820155003.945837-1-dengler@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE5MyBTYWx0ZWRfXzT501bE+TMWb
 hXH1xBN9/aouZMNlBm5AAtqIQnC3gphfc2/NkWBuz4gRWtnvxnMUgWGeYbGO1e1auJRWqFtUB/p
 CNQwi09a8SvGNcYPwAYrcMc3Q9SPq2M=
X-Proofpoint-GUID: sBBBz8I3ftNclo_yDCBUmiS-I0TYDRlg
X-Proofpoint-ORIG-GUID: sBBBz8I3ftNclo_yDCBUmiS-I0TYDRlg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE5MyBTYWx0ZWRfX2sFWPrqKqvtj
 KX7aFrBihYW0stcAo4EZwjnbKdYTVxPgSeYIZol9LijQJGc8chfgXyPiBg5986U7W+G6SHTzgj5
 BAVfBjBIlPLWRywrDNfu9EEH54API/P07YA1KK5c17W+7Jg4Key048yW27PVH60UI/xKH9NOiht
 vPdxFhnssoCjVDziPEr1NnpYzq45it8RaJ8yE24Rx9CTiEpu9+R2JQ7ImOsXUvntAheffx0e4IY
 BX9IQD9LcIj+ylFkWR5UzLNuc2Y2BzL9I/n8yc8qOHEWrV8Fr628gyrJWfOg10v8FMwtkEI3Gj9
 rt0cPGUSqlBCPz9eHD4UZgKgE+PerIvCC6tV6PgET0eR7xeCNAytMp/BoT4dD6zc9aNxQx6JFx5
 km6RhLfiuzTDG3emZ3S22wPlIs/0fqmvstNDk3EEZbmJ53g7Q807mJFUhH3Pe9kTp4aSijd3WxT
 pehekB7jgD2jHMP2VLw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8b645c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=DpPGP8gEltH2EoM89x8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230193

On Thu, Aug 20, 2026 at 05:50:02PM +0200, Holger Dengler wrote:
> This series contains adds validation of a length information in a
> hardware reply, to prevent buffer over-read/over-write in case of a
> broken/modified replies.
> 
> Changes since v1:
> - fix subject line in cover-letter
> - fix typo
> - pick R-b
> 
> This series applies on-top of Linus' master branch.
> 
> Holger Dengler (1):
>   s390/zcrypt: Validate length in reply before using it
> 
>  drivers/s390/crypto/zcrypt_ccamisc.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Applied, thank you!
