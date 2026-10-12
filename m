Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A236404D;
	Mon, 12 Oct 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811964; cv=none; b=pxBGqLlG9aPMa7RLIW2Jpa1pQ8XG97SrBISWZNsRQhz5S98tY8zXBajg7bKtLBDu8IbzQpa0YgbDlFBry8INzpxWUOkT0Y10vVpH/KEAFQD2oDYBhCfldBRckE7PcGgtERK+Yep/nf0Z1/JGlPwfNt5XnPRaKQkf8DM4n4iwS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811964; c=relaxed/simple;
	bh=+hPfEOyK8fl2qhRYaIeMO0BK+0eET/kXrnSd+kSFOb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lplsv+JrQ1Leb582mrglGfJw/vMWY5gLjrfhyluyGFyK/ZG6b6GSMmrsGT76lG83fXVl6dcIJoOqt7HJEoOf9gg5kndXdEdXM7jOX7vHujRibvnIOm+XMkSmkXiejBCZdh9iBuCaOjN8udn6Ht7upP1pr9lZmq2Bb5pKOD5p1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oTqu+yNn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oTqu+yNn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEC1V316408;
	Mon, 12 Oct 2026 13:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=n1MBGLXqk/qwR9nQ5nvMX0C1J/PE3U
	7TIZiUVVBz30w=; b=oTqu+yNn3cx2r/tqeEJ3dYPjtuGEqIoV+85MteyUCKyeXx
	w7kK6g46bAgFAK2PqDRydOeuZG2WjIkyawae0VaMVBq0HiQGH/P6YXIfgDGKF3L5
	CRuboeNVSOgUNGrN3fmpfoiRxV9xwpRCpsa9yUeh3w0jiPAfuggDiNuz6v1+Ss6V
	GSDHR7K5QRSL5GfIy4kDw4Iujb7t/GMONIM/8Y6mj88iUVXHosslvvjBwVI4E3Db
	nonUWL/Q3I7sajxqqIXK2iA21pleCx1OmyHjrBC6FZqec3Tm1f0KOw1HZEXZbtLd
	GFJ/q9jycKy0TwJh2Om1s+y9vKOQWW61SiGyXyIQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug94g2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:32:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4tRH1212027;
	Mon, 12 Oct 2026 13:32:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnbpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:32:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDWbcL42402058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:32:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ACEB20043;
	Mon, 12 Oct 2026 13:32:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 795D820040;
	Mon, 12 Oct 2026 13:32:36 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 13:32:36 +0000 (GMT)
Date: Mon, 12 Oct 2026 15:32:35 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 06/32] s390/tools: Generate bitmap of nullified program
 checks
Message-ID: <20261012133235.19350Eef-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-7-hca@linux.ibm.com>
 <84bf6d68-ae70-4f11-a617-349cee297170@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84bf6d68-ae70-4f11-a617-349cee297170@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acce17a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=jCOPR1J3i8HnHrzESZIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: LPbhxwzhWRM0pW6-4ZNw-F4pCGbMpjfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX16VBj+o4iMMC
 DHzeydewEEPAVHqA1EF+/NZcE3rGU4lII7dRgrqRVSRYEH8l+pdO23kItiTNEqIgS89gDMN52hK
 BfJl7zSUe+kx+jjOv566AhCk8H3kSJBLdpK/6aXEhFQ59hKVXUWhHOeYzQtdMyL5PjcMoZlmtD9
 wzk47ST4FNpBzb/yl3Xrk9Hq1b7NJOkV0OG4R+sr7uLJE4iAD35PM6xsoKA8wnj3NGK6geJe2be
 na2F0zbL7MuCHyWuXj+7ef/RzpoBU6oqkXwRaLd0lDGVMiNkC8AkmM8aqDFxCiWRQPYztzWli1+
 XlgfU6bM+L43mXbb9L62p3criAeJZUbQzkvVD2elKUOjZHVKsj13buHCMDEPRkhM3/QaS385S8F
 cpQkqewwN3BTpb5kQnveEceHjrJ/yb+p7QcbbT+ePjxrh4VADk3opO+f49/K+5OP+ztOWJCWyWy
 YNTzLGfE5T1vkjlVGbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX0DvwmBEagMfL
 m6n9N4exQCQX6W3NByz4UXjjrTJN4t7++VSGC1pKErWoiRiCXqSm3H5xJwTY5R5YborKsa0PqGW
 Sfy6mdUC9L5Fp1B9UzefZXrPRLzQFmg=
X-Proofpoint-ORIG-GUID: LPbhxwzhWRM0pW6-4ZNw-F4pCGbMpjfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120052

On Mon, Oct 12, 2026 at 02:50:22PM +0200, Ilya Leoshkevich wrote:
> > +static struct bitmap_def pgm_check_defs[] = {
> > +	{
> > +		.name = "PGM_CHECKS_NULLIFIED",
...
> Do we want Crypto-Operation Exception (0x119) here?

No, since it has been removed from the latest Principles of Operation
too.

See "Summary of Changes in Fifteenth Edition": "Since support for the
crypto facility has been deprecated for multiple machine genera-
tions, the definition for the crypto-operation exception has been
removed."

We never supported that exception in Linux, since our exception
handler masks the interruption code with 0x7f, which would remove that
bit anyway. I don't know what "multiple machine generations" above
means, but I guess this translates probably to decades :)
