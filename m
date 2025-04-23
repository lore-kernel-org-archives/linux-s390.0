Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16EC26AA99
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404856; cv=none; b=gVJc4vlEzSdw+D4rrcQg7/EXFVNhwPslM7q+fTodLSrdUrT54NPHYDuQv/i0lJwsfE1ZAa7cTztQtzJw+ZJ0QCJOC05QrrS0GnkIIagu2DfCCHohZnYJaGwPmEn+JWBR1vihfQtwMf0nVyuo9hA+ORwOD7x9xN6dwRDvtbsIffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404856; c=relaxed/simple;
	bh=SZT9JajVIJetXqLAKxafzRRMiR+/qU+C4ZW7jsM/D6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwyXXvEJrbjXMmZK1TDJhoQYoo/WLCLfe4XT1irpBQy9b6Hy8xIJhRY2Ki9yJsFGO16Rr+zSaT/3iEJ7vuGUgAINmP9W1rxLiqquqa5ql4/QOKoSN/oo/mQFQyaLk82qn1K2z1xD6brT14qeUeb75UH9EU1hP9iNctPTX8KN+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RzVeSK8t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RzVeSK8t"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fjlg007115;
	Wed, 23 Apr 2025 10:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SZT9JajVIJetXqLAKxafzRRMiR+/qU
	+C4ZW7jsM/D6Y=; b=RzVeSK8tNj8ArWdYCcZK/CJK1lSlRvw5LMUz5qVV2q+3wl
	8OSHT8qmewVSjZcXddNIakLzaJtIPRGgA6jvH6CC2KJjYwYlN2TKEy7yifqWAZ/C
	I6N1l28Vn/7/yrNMo+hLn0XC8R0DIJl1c3Iq9K8e6mpu9NYTVvfcAQkNelOYsxmr
	0GKcw8se1sbj12eSB6zXRR+E6+ldkfo7njo7nHCrCDCnaYaS50cL4m/Nly0aIxCU
	1HXtjLS9mAcLA2nHUTCp3iyWbwc3ALOw8nvGKAIFWc1PMuUHP0pwFGQ6znu9NYBY
	rDRBTJWVVg7I8CzTTVpaT68AqD2T9PehOxMm8v3w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnswwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:40:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6NdQ8008666;
	Wed, 23 Apr 2025 10:40:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxjm8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:40:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAelsD56951164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:40:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E164B20040;
	Wed, 23 Apr 2025 10:40:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9547020043;
	Wed, 23 Apr 2025 10:40:46 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Apr 2025 10:40:46 +0000 (GMT)
Date: Wed, 23 Apr 2025 12:40:45 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v7 00/25] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Message-ID: <20250423104045.8056D38-hca@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423101535.143137-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WEDZ9D4Jqb7dfVpCEZEBNh71Ga9rEbVO
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=6808c3b3 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=5Wwa1OfWjk28_BsrzmoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA3MyBTYWx0ZWRfX4u1t/CsOqyh6 qZj0uVObRn2Vw6wnll/CDndgxqE31YMc/Ss9VSLf8ffpmFCyzLFLKuigDP2qFsXyyfva/C1M4ps O971oBUm1U9/hMceBAdZE9JF0uNYA59BRTQBKXgDr79388q9YJzGKvmUEMJUJE182NaEhH63Y46
 dr9GY5qbyU5/w3s5lM5BkMklR+KQ56CHLkWQaqfSU0IsyVFplCKNHmHk/PhkRefw4tyowE/gdlJ qiAuorb+zQkVKcG56nQ9iEDalssPritiMSPKLBHEBsORxKFQEKCF/DvGcLuouxbzNRYf5Wrfvbu TvnXgYk5T4vl3HxJSTs++dKNii+SLn3w2Gywr77Iq59IaoQB0m/PhccQS/7GOb1Yd2vjfDSgT/9
 z3v2lqjaXiN3ANbhM278QlR/QBtX3ye0BAwWgPLe2p20cp0F0qP6Jw2KfZwFpybkU04oFeKs
X-Proofpoint-ORIG-GUID: WEDZ9D4Jqb7dfVpCEZEBNh71Ga9rEbVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=821 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230073

Hi Harald,

On Wed, Apr 23, 2025 at 12:15:09PM +0200, Harald Freudenberger wrote:
> The patch series starts bottom (AP bus) and goes up the call
> chain (PKEY). At any time in the patch stack it should compile.
> For easier review I tried to have one logic code change by
> each patch and thus keep the patches "small". For the upstream
> version I intend to fold them together into only a few commits.

What about the statement about "only a few commits"? I asked the same question
also for the previous series, but didn't get an answer, instead v7 appeared.
