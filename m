Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CAB488DA0;
	Tue, 22 Sep 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101395; cv=none; b=UpM66TvhWJUNe5r6nmckuel3iCf3nUWRpFESkRhu8n1VBe+SOH4Na5LQsI/bozfdpm1yFRYWOOcdeEmTLAda638eLLCX85He9Ce6phYMf4KFwtKvhnedMU/7We4qcuQRZZ30bPPPv/iZHOXD0UIuib5I2RYEPiKb+Ka7qOBGSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101395; c=relaxed/simple;
	bh=wNGJDeCmxIIrZU9lVVusChrYW2DlI08XhxkD4rOMgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYCsd6TDxOHu/pr3GiuZiRaATT1VZ/IeyQLkmpNVbbUsCb2wEqFcX9C2GNB7GGT1ogXp1bf5lpota7Z6o7/kcTqDFfMaxOi1GYXlPLJwIa/YHe6kbMlgBQBsw5GWI9pf6eev4HoNCmrXvWMPpa7M4yKuHuh57EE+GD1WEUgcuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T11iXN2o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T11iXN2o"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI6w341128971;
	Tue, 22 Sep 2026 18:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gfdR7ORVUJumurlwESUP5IHSYU1p+I
	eJ31U+9ZVOlR4=; b=T11iXN2oUetZ4bEssqHfXPZO6MeW7+HsV6LYasckRhiJ/i
	pxiI80o+1d6Eoxnz24spVPJmNGRrSz84PUHlxH7euCHVLc83SxXay9c5XgFXUcaX
	Jt+2gOQAKU0kxEgoFCp3OF30DYjjZmvkjMEpxEtVknfbtPzSw6Mqw/5MXhWUjnkW
	RbGr9fi4dtoZQc441WDHa+fCTCKYPwnuebEO+N/kZAX0CqAY1xLZoK2wZzD0iVNw
	eH5qZBTVgqdETUeWpV3+I/iAQMAbAhG7J1hwzLAgZUWFr9vWvl42Cv5ptgkch9gW
	UvyphQUTHHmvNEd54fVqS51iVhuJZQU0bQ5tkLTw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2fcuv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 18:23:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIHctB3240060;
	Tue, 22 Sep 2026 18:23:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gtvtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 18:23:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MIMuFJ6029626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 18:22:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D32932004B;
	Tue, 22 Sep 2026 18:22:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E21F20040;
	Tue, 22 Sep 2026 18:22:56 +0000 (GMT)
Received: from osiris (unknown [9.111.71.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Sep 2026 18:22:56 +0000 (GMT)
Date: Tue, 22 Sep 2026 20:22:55 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 00/11] s390: More this_cpu_*() changes
Message-ID: <20260922182255.26236Cc2-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <dc01ef2f-3ed9-4b25-ae5f-1bd317df27cb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc01ef2f-3ed9-4b25-ae5f-1bd317df27cb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R3Rm1nbfO4gltRVUTXODtSL29oCz_OMz
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2c787 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=_IjnK-qXvPJbhhBBUg8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI2NSBTYWx0ZWRfX+6vkDMfq2RGS
 2YzxSdoAZZrHvqgIs9aQI1T6zHOeNAJ17TiOclbjKaiG3YaLm3DmCpJtiMilHDTNCsvEQJadtqu
 GHEN/Kayz2sY7oOE/AWR6aDDl/BMTcJnJ9CgY6eElFKNDj0tkL3jlJtbgdaaREwVdzk1bt0kwDZ
 kFo/BbqAffZW2qPylW4Oe7U0aYfvK9/nfyC+LO0gShFoQ6BqyvMBxZnMkCMppdhVRJUwXTfz8xJ
 2G+Mu4vhmVzPVdt7m0Kfjc7w6lmkoL3PkjUo55D1s4Y5gR4qAyfTuwD0bXr4IKBI27gNHpyCXJt
 DoqKQrgw9vSfTjmFkS071t76NUIz0FR7nsBI0Mir9eSndNwlBAHt6nGilPECAb5da62mibCopMG
 ytOcaBkot5YWQdHk9TFz0XMVi7rNCHlEk09hCgKQtTmMytaNXZv9NdELz3ECXD1bdj9NAlCButo
 MgqjLPH3utrXJfHprTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI2NSBTYWx0ZWRfX+BQM/0j2giAe
 qSD67oDJXV41kOb4RMiJxlHS6z739h5DErSXwfHdUsrqnGnrJqvRoiK0ReV2Kv5+LqMLtAlNltx
 0/bWxbTb+sOsAyaSX5U75aDE0vX9kY8=
X-Proofpoint-GUID: R3Rm1nbfO4gltRVUTXODtSL29oCz_OMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220265

On Tue, Sep 22, 2026 at 05:37:14PM +0200, Mete Durlu wrote:
> On 21/09/2026 17:57, Heiko Carstens wrote:
> [..snip..]
> > The only non-trivial patch is the last one, which converts s390's
> > this_cpu_*() operations to use a similar scheme like Mark Rutland
> > provided it for arm64 [1]. This allows to simplify the irq entry and exit
> > path, however at the cost of slightly worse code for this_cpu_*()
> > operations.
...
> Hi all,
> 
> I did some benchmarking for this patch series.
> 
> Used a shared LPAR with 24 CPUs (12 cores w SMT2).
> 
> Base commit: f0100363d8c3 ("Merge tag 'xfs-fixes-7.3-rc5' of
> gitolite.kernel.org:/pub/scm/fs/xfs/xfs-linux")
> 
> Some of the benchmark runs show +-5% standard deviation which can
> be attributed to s390 being a virtualized system. Each run has been
> repeated five times to circumvent the effects of standard deviation.
> (In the odd case where baseline has -5% and patched run has +5%
> deviation, the comparison can show ~+10% improvements which is highly
> misleading).
> 
> Overall, the benchmarks do not show any real difference between baseline
> and patched kernels;

Mete, thanks a lot for running the benchmarks!

This confirms that we can move forward including the last patch of this series.
