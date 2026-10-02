Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799830DEBA;
	Fri,  2 Oct 2026 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944220; cv=none; b=g+fcVCZiwbtM1uqXON9iXNF29u6sbgQ6S+aVuC1IzOeR7JFWDvdPPz9ekg0Dtt9vKQpw0ZDLLhulhzYwoEj8+dTK1k8M8qPcg/vRrJI20d2iVOtS8UfCxyAc4soeCt8qFBlRzErq8mM1ytrCq8s3F86ZUse7svNUxVoiAxml264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944220; c=relaxed/simple;
	bh=qUoN7ELQKTOTirKRrn0e5k2TjJD4b+HQRqgkUF+c1fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PThgTXLq7G4DyVqCwpwSRH5WQy4lPRKddgIxOgtdcvd/1ADX3W/WmmOMkU8Pun8SKCjLr4uRQw0MGsDQsuSZu8rrIy6nThM2tmvD1sqvbhr34Q9heo4MDgo/+jxh5+iLktnD6BeRlGTHydHo7v+3yE+STpmr34RGAXT1BtbCCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LQ5CCHzE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LQ5CCHzE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692A5qvH3160566;
	Fri, 2 Oct 2026 12:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IP27naQafRFCKtnaqP+3h06dyv/hh8
	blkMGpcdoNUOU=; b=LQ5CCHzEh+C9pXlrzsU91wxcGH+5ulrz+T3oBgGeINR2v5
	PYOeg1RjGaf5tauFUaKf7k0lf+anKpKvW3S4r8PtjtCmXxwKgL4525X+j8n36LRk
	aEe1rGCfr6ugq+ta8QYc87pog0VCOzP/vRP6QGVwpWq8BvEC2NAuxPxdmCRHJgq7
	nrE4SxzXcWBPvVBdiJX7CUpresCdvvwxvX6htv3AvejyPwyvXu9CELLpJ0aF5ZIt
	K1kQP3FQ8g1xfH8ecFibkwKDFoBZmxUUuvU0xxaiIrjOEoyIy6Cw2BBFWD5iAsjs
	oCR+ITwQYhTZAiW1/lNss3OeGH9cHmH89BkOLOHg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4feqtkd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 12:30:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692A2Tcl2335439;
	Fri, 2 Oct 2026 12:30:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsjreg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 12:30:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692CU9Wf28508718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 12:30:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF20D20043;
	Fri,  2 Oct 2026 12:30:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 895CE20040;
	Fri,  2 Oct 2026 12:30:09 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Oct 2026 12:30:09 +0000 (GMT)
Date: Fri, 2 Oct 2026 14:30:08 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <4ee1e4e6-4ecb-4fec-a481-c4f2236eb514-agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
 <20260824104048.11040Cdc-hca@linux.ibm.com>
 <b66a61a4-a532-44ba-a1c6-26f02193fb05-agordeev@linux.ibm.com>
 <20261001082143.23106A21-hca@linux.ibm.com>
 <15c64970-d54e-4b8f-96f6-50c021079a94-agordeev@linux.ibm.com>
 <20261001154117.23106Da3-hca@linux.ibm.com>
 <20261002084315.21787Ba6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002084315.21787Ba6-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abfa3d6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=bLWW0i0dwBbJnIBF-2cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0OCBTYWx0ZWRfX7RnYetFSSEIx
 wpqVm/IrnUEY5C2fgABcIk9Te7ob3SotikBDvg1coinJOCfv9Qfvpd8lURzGrP8WrGcYNa+j7qf
 FVGPvEwbxl2r/Q9iA6mmrjzoIhmRKmk=
X-Proofpoint-ORIG-GUID: xHiclTGYKBP7O7nDjmVOh4hlN__ELI1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0OCBTYWx0ZWRfXwytMGQg8vIEM
 4yip4Bs04yYfo9INyCYwKPcTh3piGH9HIpegL9lSdM4BaKOb62tPPWSh+vdNbHdB7AL+JeQXOTL
 ZNd+XAeW7L0zc0c5EnwMYwv9OA/SOEteRm0QXv+GxoeaN8RQ5XqOD9C0NxP4iRS7BJvFQ1fiqhq
 6/+aguB8WZHSp+gsUDn3nRFhYmb1uGWA/RTxiR1oyDs1T8J7MuUI8DzF+9paUEovig7Q69KELEQ
 bzAKzyPk9IVX0+c7Kcl6QapmwqP0tcOwLHepzmsN7gWk3kSRN3WMc9iAwFyTLiFdwHa/V7yemOU
 7K/bLhEdqtuAgdJ8nHaFp3+85DI3zT0spApuzkFLqBB1knFeYOzjGSMTbxjGteFk4O2Ff8nMFc4
 VQ+AxVIKac+GwJvOOeeiaxIGCDO6RN/O9N3xi0y+MvHFP2jWIoghOj0fIyoV3QgH/8Ftmvpq8Jo
 0OcIqn6F8xa9NiDobBA==
X-Proofpoint-GUID: pWRTe5PpEKDMeNbbBBdXZ2uzDWYlbNeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020048

On Fri, Oct 02, 2026 at 10:43:15AM +0200, Heiko Carstens wrote:
> > > Good point. But still, do you think it worth dropping the KASAN check?
> > 
> > KASAN check for lowcore? I don't think we care - this is initialized to zero
> > anyway, so what could go wrong? Also given how frequently these operations are
> > used, yes, please drop KASAN checks.
> 
> Of course you could still add an explicit KASAN/KCSAN check by adding an
> instrument_read() call (see e.g. s390's fpu-insn.h, which has plenty of them).
> 
> But why do you think that would be helpful for a lowcore field, where it is
> known that is initialized to zero? What am I missing?

Nothing. I am going to adopt all your suggestions into the new version.

Thanks!
