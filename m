Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D19155A24;
	Tue,  8 Oct 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378081; cv=none; b=JtniT4G/Ycc/yw1nMsWOJXai2IZrHvkVUXMNgiGrYvmQZV4s8XinzkdIfnHC0VauDfz4+8DS0hZtbn8dUgJRambJVWXJqWk5iq14BjIE1KXnBnHvdykSS8uv7PKgEw2YfVTUTu6NLGKLfSA8+UiF5XHsni2TFC5IAUjszGAH9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378081; c=relaxed/simple;
	bh=s3/Gf2LD5AM+aMm6o3W8oZQ8KHOanKgHJodCQAXYdWc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=juS/+LIMikYKnf6Y6FB22BGPELjZxJ6w3RehvDWyVsHhd8fhwdD3M2JEwhK7ERjZCcB5xpoKetLAbR/BG6NNbhdYP82VHiDdXI+jviU9KC7jHXYZ9PnwSy+K6bwl9ZZiHbpR3GQhf+kBYOI5Jf7ZfifdwYWxwjyB1+9FbfrcnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ThOZQGQQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ThOZQGQQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4986q3wg013757;
	Tue, 8 Oct 2024 09:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:cc:to:subject:from:references:in-reply-to; s=pp1;
	 bh=qkoyihaqa2JWVsF/KsNCOtt/7LyD/TrQQ7EQI3tcy1s=; b=ThOZQGQQwuJt
	FjOK9iD2STTfUpNHPJ+6dWEBjgXNjQ6Ctym7E7QbWRHUsQxyMSo4sZaZ53vfFw6p
	EWIlvI2gYeiReuSPmv+M9ts97hmaVRZ6L2GhFi5uujivDe0bXrtxFcX75RieGHTh
	7SyvvQYU6YLameIOjyAMluSOG4YAqFQcLXRaMvYWLJenSZuSbqRkbfwldVxy66au
	rK+J/TFepjUoSV592H0xG+3WW9dSQ+H5xY1qMdmEcScrWnPaUJdLgwaVNWpKKLjo
	FxHUeXJQajfMt4Y2k/UaQ26MxCOcSEEFcV9759bTvkr4EKaEfiZ3KwmtOD2co5Le
	C6LEaU0BOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424yu20ndj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 09:01:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4988tEb2013784;
	Tue, 8 Oct 2024 09:01:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fss3dxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 09:01:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49891EZn35652264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 09:01:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7043B20043;
	Tue,  8 Oct 2024 09:01:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A0EF20040;
	Tue,  8 Oct 2024 09:01:14 +0000 (GMT)
Received: from darkmoore (unknown [9.171.23.149])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 09:01:14 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 11:01:08 +0200
Message-Id: <D4QAW3IAOUEK.13NW9TWTW4540@linux.ibm.com>
Cc: "Ingo Franzki" <ifranzki@linux.ibm.com>,
        "Harald Freudenberger"
 <freude@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio
 Imbrenda" <imbrenda@linux.ibm.com>
To: "Steffen Eiden" <seiden@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] s390/uvdevice: Add List Secrets Ext IOCTL
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.18.2
References: <20241002160532.2425734-1-seiden@linux.ibm.com>
 <20241002160532.2425734-6-seiden@linux.ibm.com>
In-Reply-To: <20241002160532.2425734-6-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hrAC5wcLyI2oLq7BLYj1IptpWP-wGwLc
X-Proofpoint-ORIG-GUID: hrAC5wcLyI2oLq7BLYj1IptpWP-wGwLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_06,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=471 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080056

On Wed Oct 2, 2024 at 6:05 PM CEST, Steffen Eiden wrote:
> Add an extended List Secrets IOCTL. In contrast to the first list IOCTL
> this accepts an index as the first two bytes of the provided page as an
> input. This index is then taken as the index offset for the list UVC to
> receive later entries for the list.
>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/include/uapi/asm/uvdevice.h |  4 ++
>  drivers/s390/char/uvdevice.c          | 96 ++++++++++++++++++++-------
>  2 files changed, 75 insertions(+), 25 deletions(-)

[...]
