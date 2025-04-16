Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56C1AA1E0
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795531; cv=none; b=dCYxsgU6YL3KVuLO0SV2D0dhsNKyc3z2czHfsP+es6W2tnkIWRfw0ACaMx/8DTOT+ak/2kr/F39XHZ1cAEIGfJgNHYYNVAfC4KUqYdAh4N+NxLOzPN6c0hwctg6nKHNPaIN+o6ur4a5MFgiHiDvD0t9gTiuaTUWlhA/B0u8cgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795531; c=relaxed/simple;
	bh=eP2yHe13abY8vEIo6vMdKQy/JKQ6AZXskRf/z0QygAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPsKSikZHBDjLPmsoKYHT65G/2Bw3YNGnypzD6g70bMFZuHadkjmmJD+MhAVCI3eKvlKQIsd/MIBMYgYwY8OXDZE5T0t75ZK8/WE/gk4al1Qh6tKb1WT52KtwzgEpXbqLdco03UTh7p/MFT0Ae9YFLisNXoU8fsEBG7o3MYjEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IshzupTD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IshzupTD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G7bVoP020371;
	Wed, 16 Apr 2025 09:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZJEQyD
	YN/JKrFISZJkghOAfTLpRsHJ8deO3moeW8rQ8=; b=IshzupTDtQ77L7G086kMuE
	DJevQD7RIb42xaBq+BRSs/D334JqC94lw5w3P8jJnx5QIJxug/my3XOTAiseW5dU
	U4nxYIApTKbrSm/25znSzVWtqbpvP8moRut6iuddtUUdHhbSnzOZRvAPch1NtQ6B
	Lr8jBq/IG1iqOMGZI4qKL5krH7RfRKaZUIIYRME35cp8bxIk8AUm6Vy+H2Szw+BA
	ZPGOen/SAVgKumwfr/jdrTRpxK6j/cRRsPheP99YTXfcbOzxJTuEmn02N4Z6JRkf
	H6Bsodgi4o/9Wm7z2wG124Mi8fjAjGq5EyFPNQHNEeCyUL+a1D6aGyzJmr/ImD9w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461nwq5m2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:25:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8e7k7016689;
	Wed, 16 Apr 2025 09:25:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46057277dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:25:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G9PLUh36503880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:25:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9967A20043;
	Wed, 16 Apr 2025 09:25:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1857B2004E;
	Wed, 16 Apr 2025 09:25:21 +0000 (GMT)
Received: from [9.171.38.231] (unknown [9.171.38.231])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 09:25:21 +0000 (GMT)
Message-ID: <3661692c-46f7-4138-83e5-2d8b01f8da54@linux.ibm.com>
Date: Wed, 16 Apr 2025 11:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/25] s390/uv: Remove uv_get_secret_metadata function
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com
References: <20250415142438.118474-1-freude@linux.ibm.com>
 <20250415142438.118474-24-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250415142438.118474-24-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AwzTnRhNBW10yJue6X2fDIdz8-LsOJDh
X-Proofpoint-GUID: AwzTnRhNBW10yJue6X2fDIdz8-LsOJDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=717 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160073

On 15/04/2025 16:24, Harald Freudenberger wrote:
> The uv_get_secret_metadata() in-kernel function was only
> offered and used by the pkey uv handler. Remove it as there
> is no customer any more.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Suggested-by: Steffen Eiden <seiden@linux.ibm.com>

Suggested-by: should be the first tag. See Documentation/process/maintainer-tip.rst, Ordering of commit tags.
Acked-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

