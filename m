Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18F8BEE
	for <linux-s390@vger.kernel.org>; Fri, 21 Mar 2025 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547991; cv=none; b=XcEczuutsHcdIXfV/rELLUqfrBCjIBTF7E2t98qOa6ackYsPw3LLyWJi5fvgWJ1oHAAKM/KYjli2T7skaGNB3xPKudY2poPfhc9cN20MSQARaPgTtxjTUJ8mu04xa3qYT2IrjZOG3rtrbmXdNUsxSwft/TTeFS0mUpkW1GUkrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547991; c=relaxed/simple;
	bh=dOS5xjbUuQ3IReOsYMwr0Lh5ateniUx9E+mhynNiV4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mc6CmGGtqdcj/7ortR01uOeLudW4zZqnFfWvvQsIk+zWg3loNo/JKrwrGvcRwEEYF6g+IQAiD9gFb2P3cmalQPlzyP2zByzm7zVanekHtytuK+UBJiBbBOs75E/VFSX0B2WsgFVTbY8Yi66O1MRPDRiOyNj9Y/PwpJoox89qx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y3tEvQ1R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y3tEvQ1R"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L3jp8Z032083;
	Fri, 21 Mar 2025 09:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o3TeH4
	o8DonQu3laMSPzTUvFmkMD6iAJTnh/DFHxpLg=; b=Y3tEvQ1Rz2Vghr7HedCErE
	eq9gbjkh5KC3edMVq1LqzE1+wspfN6dBkj1nD5bwKnEScL7LfEA4YYEeUTF30Xkx
	bcNmuJDEiE8fh9hEAfdCwUMwb4QWApFrV+ZY+LeHlUZ6Xgk25FLLExpxOyrSADQr
	LOTpgh5CsCVJ3zqqeuLEw+FZ7Q0BwhAWp+emFvRVmUoIpZtaOfiAv22z3flvxDEa
	WMwX6lTFzv2gRkyWLGWVez6gWWt2mGC+QRqClYn+KLTsPm9PtPhaJnTyUhTK3NIx
	SkwPLa4Clgd1AqYkkxj6cf3fdlb7iYeRIxBPTFs2QqkMMpd2jNIuKezGBR3kbH2g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45h0g9s8b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 09:06:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4tRc9023196;
	Fri, 21 Mar 2025 09:06:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3m4b35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 09:06:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52L96NVa52691206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 09:06:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CB932004B;
	Fri, 21 Mar 2025 09:06:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A36BD20040;
	Fri, 21 Mar 2025 09:06:22 +0000 (GMT)
Received: from [9.171.68.130] (unknown [9.171.68.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Mar 2025 09:06:22 +0000 (GMT)
Message-ID: <ae951102-8fb7-451b-b1df-1b3dbc15d25c@linux.ibm.com>
Date: Fri, 21 Mar 2025 10:06:22 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] s390/pkey: Rework EP11 pkey handler to use stack
 for small memory allocs
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-19-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-19-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Tn0A1J1OzQwbtdfON7a-nxZwv4jqCMgz
X-Proofpoint-GUID: Tn0A1J1OzQwbtdfON7a-nxZwv4jqCMgz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=967 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503210065

On 04/03/2025 18:21, Harald Freudenberger wrote:
> There have been some places in the EP11 handler code where relatively
> small amounts of memory have been allocated an freed at the end
> of the function. This code has been reworked to use the stack instead.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

