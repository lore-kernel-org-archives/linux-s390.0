Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202301494B2;
	Tue, 22 Oct 2024 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585549; cv=none; b=odJKO97eDYJEV09quB/lM1j1n9MEnG43sGt2hmcjRWRYQh/HOSwIzeIzZLm58ErBIBXOpv/cC3K5Ib5mhOb+VKIy+gCwm7QtrlHT9dUCWFah/TOtHCdkKes0nolA4J4NcFUEJX/pxa4DW/ldDqVmo09jCc5FqNynhS3v/Tlg0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585549; c=relaxed/simple;
	bh=7xT3ZfRxS+Ea0dW5I5mtoD+/BVwN+LslvFuvS4EnjPs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=gDpdC5hgbEnHqFM2/qIv1CcwZaJSar9XwFUHij0CPiX55RvXbF+EvNdSGV+rORfnp+S9+RtgRT8tTnjDWa0kEewFpMc6WDf3Bn8IYt2uiTywrZfkDWVICcBPimP1M4GrjUdAIy/Ghb7oYa62YzrkIByx1LKSdOAokxmr+44CWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VsHBy0Kl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VsHBy0Kl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HCWx029534;
	Tue, 22 Oct 2024 08:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TOThjF
	53vl7D1D0h5+W6guVI3ubmW5wlSXTEoDXMR4U=; b=VsHBy0Klel8i8Ocd+T/xpO
	UYcAap3Q6da5qlQrwhNAx2MaXZ9QeR+Hz0cfOiCCk8ETmEcVIRAn3E+uf+5hQ4R8
	IKy0m68yS9ONP3iwj50l0U1H5rPnFli0CsGANTH8EuCxsGB899ZB5oewrEa/OByw
	OvnYDhz/Rs0nGyb2AkTYdsjitBfdaR2lGsxIZBiul2XJWkCyns8wb/74UEI31FKI
	9P36jCHhgFdpfsKT9iyCcKr3RmBxCKXhZbQhYWx4/5j+XHEesupH85zK3LdoABwR
	pAxaWVkpf3qezaD4MLom77b+2DovZCvr3hQGLuCaJE8sMDtCrp7Riz/vU4kUpYsw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5eucxaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 08:25:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49M44utI026425;
	Tue, 22 Oct 2024 08:25:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cq3sahxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 08:25:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49M8Pgic52756926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 08:25:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B17AC20049;
	Tue, 22 Oct 2024 08:25:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80B9C20040;
	Tue, 22 Oct 2024 08:25:42 +0000 (GMT)
Received: from darkmoore (unknown [9.171.78.143])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 08:25:42 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Oct 2024 10:25:37 +0200
Message-Id: <D526WIRSO9IK.DBBSW7DNWR0@linux.ibm.com>
Cc: "Ingo Franzki" <ifranzki@linux.ibm.com>,
        "Harald Freudenberger"
 <freude@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio
 Imbrenda" <imbrenda@linux.ibm.com>
To: "Steffen Eiden" <seiden@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] s390/uv: Retrieve UV secrets support
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.18.2
References: <20241018091516.2167885-1-seiden@linux.ibm.com>
 <20241018091516.2167885-3-seiden@linux.ibm.com>
In-Reply-To: <20241018091516.2167885-3-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IVpROmBhXEWOjPJDG-vSKc2yd8nkBRCc
X-Proofpoint-ORIG-GUID: IVpROmBhXEWOjPJDG-vSKc2yd8nkBRCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=384 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220052

On Fri Oct 18, 2024 at 11:15 AM CEST, Steffen Eiden wrote:
> Provide a kernel API to retrieve secrets from the UV secret store.
> Add two new functions:
> * `uv_get_secret_metadata` - get metadata for a given secret identifier
> * `uv_retrieve_secret` - get the secret value for the secret index
>
> With those two functions one can extract the secret for a given secret
> id, if the secret is retrievable.
>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/include/asm/uv.h | 135 ++++++++++++++++++++++++++++++++++++-
>  arch/s390/kernel/uv.c      | 129 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 261 insertions(+), 3 deletions(-)

[...]

