Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA314D2BD;
	Fri,  3 Jan 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735913611; cv=none; b=Ga7TRl54/SIR2wObeKQ/AKpGeMp1ieJZnH8y4D+Vt09qVVmMHl1UHW0XvmXcSQ4kco9BVOM9CBNOqwaSJZdseC3W2FCz88waNepDdLwcSF0cuZ6xCzxiDbJVazlCcPjJWgg6PVeCeckoz5yFcp/eDRPhfpl34MzMrunsWPjuC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735913611; c=relaxed/simple;
	bh=WwbVzOJKG4pxu3QUdyfzlQlTDE6c7m0uYXJ52kNs1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBI+JCvtyZ9UvzN+VhawVAm6bATuRJOL5HRv8XvqJqq92cXyLN6D6jw8FcPF1rOoiPRhBO49po4LmgwP5cungkms0TDrYmW1aBcRq9hiYfzaLqecbCcF2bB7MbyTpZPiUW0CHDc8kOYIGFL0kh57eEHLqO9lNxOqFarWyInuHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mhaCYxu0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mhaCYxu0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503E6ZMx001227;
	Fri, 3 Jan 2025 14:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EaMiV8
	HKXTKDYuJGRqffHUSGej343nvMNRYWIVLyG/o=; b=mhaCYxu0u/cR/vqtMflKvA
	mGk/mW7LM5gWkKQoheUjp9j8DKzlXmuwoRB9qNYL8KEjXJ8o10jq90e8wT7MwKFY
	oc7FynXyhGlMpEPEN1+NUnLPJWyxeHC1aNIOcXD4BNy7SdzJatHwI6OviNdVSEqT
	KENhmxWOJ7fFKLUw841Xs02I8hxzoB3NAUEI8amjw9S2z+5Rw+IPXaZ65zAscdTw
	Vxj8iQ7L59efbtkAxblcRn7aQ2qwygh87H2TGoBwnkTJand7CtfJAnq2X5bPJSBY
	R8trL80D1iZyAlowo/5nSkBU+XDPxPSCToKkLCC+zHAqBK5ccg/ELkSeA0BHvFhQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43xhc500q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:13:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 503DPbVk027000;
	Fri, 3 Jan 2025 14:13:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43txc268bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:13:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 503EDOOT30605790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 14:13:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1FE52004E;
	Fri,  3 Jan 2025 14:13:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF2FB2004B;
	Fri,  3 Jan 2025 14:13:23 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.15.34])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jan 2025 14:13:23 +0000 (GMT)
Date: Fri, 3 Jan 2025 15:13:22 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] s390/sclp: Constify 'struct bin_attribute'
Message-ID: <Z3fwgmm7+2a21gY8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
 <20241211-sysfs-const-bin_attr-s390-v1-4-be01f66bfcf7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211-sysfs-const-bin_attr-s390-v1-4-be01f66bfcf7@weissschuh.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HJjrwkLa14MueH-BqYu2BJkd_Hc-qOkL
X-Proofpoint-ORIG-GUID: HJjrwkLa14MueH-BqYu2BJkd_Hc-qOkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=555 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030124

On Wed, Dec 11, 2024 at 06:54:42PM +0100, Thomas Weiﬂschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  drivers/s390/char/sclp_config.c | 4 ++--
>  drivers/s390/char/sclp_sd.c     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
