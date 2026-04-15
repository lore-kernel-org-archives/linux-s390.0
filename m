Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F88328B7B;
	Wed, 15 Apr 2026 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252856; cv=none; b=J3ZCOSy7dKDA6rwPMCm+YNWH51hBdR/cL+iHtf+B1w01WsYfeDn/1rHGTq72fwpAsnXwi1vC5oMm16dIKzF0mrqtZXxkQj8zu51+1NVmLL7Y0iw5PQm4fFE019UHEQVity289yd0YeTlmnWYLPQt6pYyiPPdTz8oPzd6NAdnCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252856; c=relaxed/simple;
	bh=OqnJBpLkNisGBd7AlCmpdJsQFg/quukx3UDEp7tJO4I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=M94e9EJdfCf3kYjHm89ZVVE7bViyss0BRNREjgtOA7wcsaFTUSSz29BjtV2VXO5megdmQeftTc+UuDpvOcoufHYF2ibozCqCas6M1jIYDWMDocfvVwOyVRXzDsV6fjgNvA41j181OYXKKLAsCLfKR/o5pmUqsoPY22IJfzdrXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XE77ZTXP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XE77ZTXP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ELOqpX1859859;
	Wed, 15 Apr 2026 11:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dbKsVQ
	SkiG/5f35I7+pe/0b7aszjCDlyT6sBaWxqhWw=; b=XE77ZTXPyWIMNMSaNHjv9n
	Q5+at0sAz7ASV1EpHIQG/0Cf2KNtTdIJBpHUFqMAzXtJhiEZLFevRS7v4pikxnod
	1lHU4RaGh1jKqXxEiUdDRX0MEKqlifkJhVIg5Bfhnj7/PHkx4V0F5MWfpxJ/PMJn
	QjNtzjXLJCqGGaUqYkXiNccKfG4cB85KFXOGxw1zAvmwSWzEU1tVrXYV3x8rt9Pe
	7uxIf11m7y/Eue9ShOQQpJwTSiS0gvQHEtswljGhdq1zho8qnUwzvuSwG6aFHFTX
	uvAe3pvIgviBroSc6CLYFyiW9JAJsAms96nBM2LzgzmEhD6khfIO6PGs2VqBv48Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pfb76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:34:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F8PnhS003557;
	Wed, 15 Apr 2026 11:34:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mne0tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:34:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FBY6cq30998976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 11:34:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E550720043;
	Wed, 15 Apr 2026 11:34:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A186E20040;
	Wed, 15 Apr 2026 11:34:05 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.91.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 11:34:05 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 13:34:05 +0200
Message-Id: <DHTP3011DZ4W.3HVEWE0UNIYTY@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/5] s390x: sclp: Add detection of
 alternate STFLE facilities
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas Huth" <thuth@redhat.com>, <kvm@vger.kernel.org>,
        "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
 <20260324-vsie-stfle-fac-v2-4-5e52be2e4081@linux.ibm.com>
In-Reply-To: <20260324-vsie-stfle-fac-v2-4-5e52be2e4081@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LCNCFU7FaMS7eVjd3aYDCAR44d9IM2MT
X-Proofpoint-ORIG-GUID: LCNCFU7FaMS7eVjd3aYDCAR44d9IM2MT
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69df77b2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=8cb4Q7LiNy3J1eJDIjsA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNCBTYWx0ZWRfX68nloXCgObir
 c6vMWF7VbonEM0gefSugOb0hUjwvb2QLV7kqlkMc5C821t1WzUxxuVW7dBlBdwE7eyQB+Y6lzsm
 tSH/Ne52Kp08UG3gsfgN2Km0kfKEOxXGEJg+RQgL47Zoy8rdwNiDaBsMqet3WzjRzqOBHGHZ/PM
 6HXn1bT77lbbysXCofBaeV5Tg39JRUiDL3U6NIoOExvDUGC4SWHn1TPDecf5DjrHJWQu/ZUI+QY
 1xjjN89ItC7c+eEh740YdIB/2pBZxltN8w/64di/XwpFhmP+MiRySaI01CMYAHYVt6KgtB9S1ej
 2tcZwiNyvbcVhokUXqWLgIEWrp08+aProahokMMv1rdmvY57Yl4zFr5g7Xyn0dXM+XTrg7GD8fk
 nyqeI1boayYFPQ/RPs3XXvt5Tznp/v/7FSsQsc/PFOY4G77vuPS83uuoCqTuOpLh3V6VRZ7SF+P
 VMZ/DJLDw4I6D2JOC4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150104

On Tue Mar 24, 2026 at 4:28 PM CET, Christoph Schlameuss wrote:
[...]
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index d624872cba608fcbbd0c482a25f091fe19475a43..77b2a5ec00d68ec7ee82da295=
f2f31c539b5c00c 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
[...]
>  	if (read_info->offset_cpu <=3D 134)
>  		return;
>  	sclp_facilities.has_diag318 =3D read_info->byte_134_diag318;
> +
> +	if (read_info->offset_cpu <=3D 139)
> +		return;
> +	sclp_facilities.has_astfleie2 =3D sclp_feat_check(139, SCLP_FEAT_139_BI=
T_ASTFLEIE2);

Help me understand which case is the odd one, the diag318 one where we acce=
ss
read_info directly or this one where we use sclp_feat_check()?

Or is there a particular reason to do it this way that I didn't see?
