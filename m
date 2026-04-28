Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8530DD11;
	Tue, 28 Apr 2026 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361813; cv=none; b=koYQE7jgQkrqnBTKgSDPs4bre07y+rucKQU30E4SnprfWbnOGzR+kXVXenz3dQ+4ko9zwiEXAK5q/ZGmwCAqvgSzhjSjzgX8v2bhHyT9E2Q1RPbIExmCHgu7Glr7t5MPPBTfN6uMqgpjIhbGWiZMfKf0kbGJcZVpJldKYEjkBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361813; c=relaxed/simple;
	bh=HWeOWAl+pWKGYzyrbQxD81mjJ/WJJUZNnSYnLw3qIMg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=FlW2ygTjY4h1t1GXKmOohXnxndTczs0awxtLplgS5RTEGxu+O2Jj7gFnTBgnHD1ywKtHVrB3go5bR2nawUQqF4AGvI6iFhtj1nUkTJVAlKTj7sDQTInYvNiWF8NCrtzIDVpncPiBn8+wIDjrywfdTYxZcQDPg3DExEKd1tp/uDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ctOOKiVK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ctOOKiVK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7EBWZ3232750;
	Tue, 28 Apr 2026 07:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HWeOWA
	l+pWKGYzyrbQxD81mjJ/WJJUZNnSYnLw3qIMg=; b=ctOOKiVKmHzHw8UEHEpwUF
	9oHap0Y6rp2q1LPeW7s3Z7slB+Wl6GplCelH60JjJ9TsgVFl3hmhj4D+n9yS4I4Y
	QGyBMgcV7QJ/AOcD9QdWOp655wGVQ9WwEPbi0r7KQh47+XDtMA5CUV2ZCPCCLfEV
	hZi8fY9DsaaaAjFhMy7zb/pMfLurPW4WD3sXChamyV1J66bMgEAfQXtQ5c//7nUU
	PxpUwwfq/iNMpIIL3VB0h74cj+rz93oTG7FiKy2c0/R8J32+e/dd0cThM3scdjGQ
	G49w262qCJ87/SZbWTtMBOPw/JgIFeI/6MELzSommhz6aJ6IsPAtcbjbaDUqt5/w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jke1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 07:36:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S7NhBn006577;
	Tue, 28 Apr 2026 07:36:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy8ewj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 07:36:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S7agoq56689058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 07:36:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC56020043;
	Tue, 28 Apr 2026 07:36:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BB8C2004E;
	Tue, 28 Apr 2026 07:36:42 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.4.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 07:36:42 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 09:36:42 +0200
Message-Id: <DI4M6BZGMT5A.3HTHW9ZYNHA0X@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <kvm@vger.kernel.org>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas Huth" <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 3/6] s390x: sclp: Check sclp byte
 before reading feature bits
From: "Nico Boehr" <nrb@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
 <20260423-vsie-stfle-fac-v4-3-32943fe43394@linux.ibm.com>
In-Reply-To: <20260423-vsie-stfle-fac-v4-3-32943fe43394@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2NiBTYWx0ZWRfX7IoJZnWkHirb
 zefA6gPt8fqCLzGrk4LODRH/73VOOz0Mtdz9xfYKKNNXWy68hUaDC51lSQR8wMTlyTsd4mV0Bmp
 K+vDCgUyyNW8eh8o04INp9iySvSBur4AaaZNOdiN7sYxIvkhxwkFHG9iQaPbLK73T/7K9UcjPrJ
 kGjhmzm/y6mX2Ys5FFhMb9ETWW7bMLcuoW8pKa+rXCosykymArn9ttQX6Pde3h77qmZMkVV4jIn
 C3hAEunpgaP1iwGCITNv3sCNgmics4E6JW6PNv+evyFMOjbZw9Ycdqyw1xwurSbPtKBdlxfPBUO
 hxbYTUixN5AFpkZ94MESSTAXL0mwQRNA3qIeRIAjW5veeBgo5b8hp0S+FTsdyXKB+3o60DMGQBg
 05rOSY3YJspi/pDRFksv47QxXMtiFxdHYKCMQTc4q9rKf77voFFySljs8rda4lc2WFuJiP/wf0l
 94b06f2NKmecggrCPVQ==
X-Proofpoint-GUID: -6UkYm0l-Oy_zCEnyByoslpnw4Bopz_k
X-Proofpoint-ORIG-GUID: -6UkYm0l-Oy_zCEnyByoslpnw4Bopz_k
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f0638f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=OjJgPJLet3IxckCSjGgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280066

On Thu Apr 23, 2026 at 4:26 PM CEST, Christoph Schlameuss wrote:
> Improve the readability and simplicity of the code in
> sclp_facilities_setup() by moving the check for availabity of feature bit=
s
> into sclp_feat_check().
>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>

